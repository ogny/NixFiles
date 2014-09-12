#!/usr/bin/env bash
# usage: <command> | pastebin [+|++|+++]
#
# (none): paste expires in 10 minutes
# +:      paste expires in 1 hour
# ++:     paste expires in 1 day
# +++:    paste expires in 1 months

HOST='pastebin.com'

# cleanup
trap 'rm -f $TEMPFILE' EXIT

# get expiration from command line
declare -A EXPIRE_DATES=([0]=10M [+]=1H [++]=1D [+++]=1M)
EXPIRATION=${EXPIRE_DATES[${1:-0}]:-${EXPIRE_DATES[0]}}

# show prompt message in interactive mode only
if [ -t 0 ] ; then
    echo '# Write your paste (Ctrl-C to abort and Ctrl-D to submit):'
fi

# fill the paste
TEMPFILE=$(tempfile)
cat > $TEMPFILE

# retrieve the token
echo '# Loading...'
TOKEN=$(curl -s $HOST | \
    sed -n 's/^.*input name="post_key" value="\(.*\)" type="hidden".*$/\1/p')

# submit the paste
echo "# http://$HOST"\
$(curl -s "$HOST/post.php" \
    -D - \
    -F 'submit_hidden=submit_hidden' \
    -F "post_key=$TOKEN" \
    -F 'paste_format=1' \
    -F "paste_expire_date=$EXPIRATION" \
    -F 'paste_private=1' \
    -F "paste_code=<$TEMPFILE;type=text/plain" \
| awk '/^location: / { print $2 }')
