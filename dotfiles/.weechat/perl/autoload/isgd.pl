#
# Copyright (C) 2011-2013  stfn <stfnmd@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

#
# Development is currently hosted at
# https://github.com/stfnm/weechat-scripts
#

use strict;
use warnings;
use CGI;

my %SCRIPT = (
	name => 'isgd',
	author => 'stfn <stfnmd@gmail.com>',
	version => '0.5',
	license => 'GPL3',
	desc => 'Shorten URLs with is.gd on demand or automatically',
	opt => 'plugins.var.perl',
);
my %OPTIONS_DEFAULT = (
	'color' => ['white', 'Color used for printing shortened URLs'],
	'auto' => ['off', 'Shorten all incoming URLs automatically'],
);
my %OPTIONS = ();
my $SHORTENER_URL = "http://is.gd/create.php?format=simple&url=";
my $SHORTENER_BASE = "http://is.gd/";
my $TIMEOUT = 30 * 1000;
my (%LOOKUP, %CACHE);

weechat::register($SCRIPT{"name"}, $SCRIPT{"author"}, $SCRIPT{"version"}, $SCRIPT{"license"}, $SCRIPT{"desc"}, "", "");
weechat::hook_print("", "", "", 1, "print_cb", "");
weechat::hook_command($SCRIPT{"name"}, $SCRIPT{"desc"},
	"[-o] [<URL...>|<number>|<partial expr>]\n",
	"          -o: send shortened URL to current buffer as input\n" .
	"         URL: URL to shorten (multiple URLs may be given)\n" .
	"      number: shorten up to n last found URLs in current buffer\n" .
	"partial expr: shorten last found URL in current buffer which matches the given partial expression\n" .
	"\nWithout any URL arguments, the last found URL in the current buffer will be shortened.\n\n" .
	"Examples:\n" .
	"  /isgd\n" .
	"  /isgd http://google.de\n" .
	"  /isgd -o http://slashdot.org/\n" .
	"  /isgd 3\n" .
	"  /isgd youtube",
	"", "command_cb", "");

init_config();

#
# Catch printed messages
#
sub print_cb
{
	my ($data, $buffer, $date, $tags, $displayed, $highlight, $prefix, $message) = @_;
	my @URLs;

	if ($OPTIONS{auto} ne "on" || $tags =~ /\bno_log\b/) {
		return weechat::WEECHAT_RC_OK;
	}

	# Find URLs
	@URLs = grep_urls($message);

	# Process all found URLs
	shorten_urls(\@URLs, $buffer);

	return weechat::WEECHAT_RC_OK;
}

#
# /isgd
#
sub command_cb
{
	my ($data, $buffer, $args) = @_;
	my $send = 0;
	my @URLs;

	# Check for command switch
	if ($args =~ /^-o/) {
		$args =~ s/^-o//;
		$send = 1;
	}

	# If URLs were provided in command arguments, shorten them
	@URLs = grep_urls($args);

	# Otherwise search backwards in lines of current buffer
	if (@URLs == 0) {
		# <number>
		my $count = 0;
		$count = $1 if ($args =~ /^(\d+)$/);

		# <partial expr>
		my $match = "";
		$match = $1 if ($count == 0 && $args =~ /^(\S+)$/);

		my $infolist = weechat::infolist_get("buffer_lines", $buffer, "");
		$count = 1 if ($count == 0);
		while (weechat::infolist_prev($infolist) == 1) {
			my $message = weechat::infolist_string($infolist, "message");
			my $tags = weechat::infolist_string($infolist, "tags");
			foreach (grep_urls($message)) {
				my $url = $_;
				if ($match eq "" || $url =~ /\Q$match\E/i) {
					push(@URLs, $url) unless ($tags =~ /\bno_log\b/);
				}
			}
			last if (@URLs >= $count);
		}
		weechat::infolist_free($infolist);
	}

	# Now process all found URLs
	shorten_urls(\@URLs, $buffer, $send);

	return weechat::WEECHAT_RC_OK;
}

#
# Shortens a list of URLs
#
sub shorten_urls($$$)
{
	my @URLs = @{$_[0]};
	my $buffer = $_[1];
	my $send = $_[2];

	foreach (@URLs) {
		my $url = $_;
		my $cmd = "url:$SHORTENER_URL" . CGI::escape($url);
		$LOOKUP{$cmd} = $url;

		if (my $url_short = $CACHE{$cmd}) {
			if ($send) {
				weechat::command($buffer, $url_short);
			} else {
				print_url($buffer, $url_short, $url);
			}
		} else {
			weechat::hook_process($cmd, $TIMEOUT, $send ? "url_send_cb" : "url_cb", $buffer);
		}
	}
}

sub url_cb
{
	my ($data, $command, $return_code, $out, $err) = @_;
	my $buffer = $data;
	my $url_short = $out;

	if ($return_code == 0 && $url_short) {
		$CACHE{$command} = $url_short;
		print_url($buffer, $url_short, $LOOKUP{$command});
	}

	return weechat::WEECHAT_RC_OK;
}

sub url_send_cb
{
	my ($data, $command, $return_code, $out, $err) = @_;
	my $buffer = $data;
	my $url_short = $out;

	if ($return_code == 0 && $url_short) {
		$CACHE{$command} = $url_short;
		weechat::command($buffer, $url_short);
	}

	return weechat::WEECHAT_RC_OK;
}

sub grep_urls($)
{
	my $str = $_[0];
	my @urls;
	while ($str =~ m{(https?://\S+)}gi) {
		push(@urls, $1) unless ($1 =~ /^\Q$SHORTENER_BASE\E/);
	}
	return @urls;
}

sub print_url($$$)
{
	my ($buffer, $url_short, $cmd) = @_;
	my $domain = "";
	$domain = $1 if ($cmd =~  m{^https?://([^/]+)}gi);
	weechat::print_date_tags($buffer, 0, "no_log", weechat::color($OPTIONS{color}) . "$url_short ($domain)");
}

#
# Handle config stuff
#
sub init_config
{
	weechat::hook_config("$SCRIPT{'opt'}.$SCRIPT{'name'}.*", "config_cb", "");
	my $version = weechat::info_get("version_number", "") || 0;
	foreach my $option (keys %OPTIONS_DEFAULT) {
		if (!weechat::config_is_set_plugin($option)) {
			weechat::config_set_plugin($option, $OPTIONS_DEFAULT{$option}[0]);
			$OPTIONS{$option} = $OPTIONS_DEFAULT{$option}[0];
		} else {
			$OPTIONS{$option} = weechat::config_get_plugin($option);
		}
		if ($version >= 0x00030500) {
			weechat::config_set_desc_plugin($option, $OPTIONS_DEFAULT{$option}[1]." (default: \"".$OPTIONS_DEFAULT{$option}[0]."\")");
		}
	}
}

sub config_cb
{
	my ($pointer, $name, $value) = @_;
	$name = substr($name, length("$SCRIPT{opt}.$SCRIPT{name}."), length($name));
	$OPTIONS{$name} = $value;
	return weechat::WEECHAT_RC_OK;
}
