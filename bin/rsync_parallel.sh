#!/bin/zsh
set -e

# Usage:
#   rsync_parallel [--parallel=N] [rsync args...]
# 
# Options:
#   --parallel=N	Use N parallel processes for transfer. Defaults to 10.
#
# Notes:
#   * Does not properly handle filenames with embedded newlines.
#   * Use with ssh-keys. Lots of password prompts will get very annoying.
#   * be a little careful with the options you pass through to rsync. Normal
#     ones will work, you might want to test weird options upfront.
#

if [[ "$1" == --parallel=* ]]; then
	PARALLEL="${1##*=}"
	shift
else
	PARALLEL=10
fi
echo "Using up to $PARALLEL processes for transfer." >&2

typeset -a RSYNCBYTES	# an array to count the number of bytes each rsync child has been requested to transfer

TMPDIR=$(mktemp -d)	# will exit due to set -e if this fails
trap "rm -rf $TMPDIR" EXIT

# The only way to obtain the exit statuses from the rsync processes is to write it into tempfiles :(
function worker() {
	set +e	# rsync might fail, but we want to continue
	trap "rm $TMPDIR/worker${i}.pid" EXIT
	echo $$ >$TMPDIR/worker${i}.pid
	# avoid one worker pulling a directory while another pulls its contents by specifying --dirs and --no-r
	rsync $@ --files-from=- --dirs --no-r
	ret=$?
	echo $ret >$TMPDIR/worker${i}.status
}

# spawn rsync children, each reading the list of files it should transfer from stdin.
for i in {1..$PARALLEL}; do
	eval exec \{rsync$i\}\>\>\(worker \$\@\)
	RSYNCBYTES[$i]=0
done

# The file list we'll obtain below will be piped into this load-balancing
# function that chooses which rsync child to pass the incoming filename to.
# It chooses the one with the fewest bytes allocated to it so far.
function balance() {
	local sortme	# an array we'll sort to obtain the number of the rsync process with the fewest bytes assigned to it
	local i
	while read size name; do
		unset sortme
		for i in {1..$PARALLEL}; do
			sortme=($sortme "$RSYNCBYTES[$i] $i")
		done
		myrsync=${${=${(n)sortme}}[2]}	# "leastbytes leastindex 2ndleastbytes 2ndleastindex ..."
		eval echo \"\$name\" \>\&\$rsync$myrsync
		((RSYNCBYTES[$myrsync]+=$size))
	done
}

# obtain file list ("length filename" tuples, one per line). This will break
# on weird filenames with e.g.  embedded newlines.  It would probably be
# possible to code around that using a \0 separator but I'm not aiming for
# perfection here.
rsync $@ --out-format="%l %n" --no-v --dry-run | balance

set +e
for i in {1..$PARALLEL}; do
	eval exec \{rsync$i\}\>\&\-
done

zmodload zsh/zselect

GLOBAL_EXIT_STATUS=0
typeset -a WORKER_STATUS
cd "$TMPDIR"
echo "Waiting for workers to exit." >&2
for i in {1..$PARALLEL}; do
	while [[ -e worker${i}.pid ]]; do
		zselect -t 100	# wait 1s (avoid calling external /bin/sleep in the loop)
	done
	if [[ -r worker${i}.status ]]; then
		WORKER_STATUS[$i]=$(cat worker${i}.status)
		if [[ $WORKER_STATUS[$i] -gt 0 ]]; then
			echo ERROR: worker $i exited with error $WORKER_STATUS[$i] >&2
		fi
	else
		WORKER_STATUS[$i]=127
		echo "ERROR: worker $i exited unexpectedly/abnormally; assuming exit status 127." >&2
	fi
	((GLOBAL_EXIT_STATUS+=$WORKER_STATUS[$i]))
done
exit $GLOBAL_EXIT_STATUS
