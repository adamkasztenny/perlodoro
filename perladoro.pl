#!/usr/bin/perl

use strict;
use warnings;

use Time::HiRes qw (setitimer ITIMER_REAL clock);
use Term::ANSIColor;
use POSIX qw(pause);

use constant POMO_TIME => 25 * 60;
my $elapsed = 0;
my $start = clock();

clear_screen();

# thanks to https://www.febo.com/pages/perl_alarm_code/
$SIG{ALRM} = sub { print $start - clock(), "\n" };
setitimer(ITIMER_REAL, 1, 1);

while ($elapsed < POMO_TIME) {
    pause;
    clear_screen();
    $elapsed++;
}

# thanks to http://stackoverflow.com/questions/197933/whats-the-best-way-to-clear-the-screen-in-perl
sub clear_screen {
    print "\033[2J";
    print "\033[0;0H";
}
