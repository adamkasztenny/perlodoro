#!/usr/bin/perl

use strict;
use warnings;

use Time::HiRes qw (setitimer ITIMER_REAL clock);
use Term::ANSIColor;
use POSIX qw(pause);

use constant POMO_TIME => 25 * 60;
use constant BREAK_TIME => 5 * 60;
use constant BELL => chr(7);

my $elapsed = 0;
my $infinite = shift;

clear_screen();
pomo_loop();

sub pomo_loop {
    do {
        timer(POMO_TIME, "Pomo");
        print BELL;
        timer(BREAK_TIME, "Break");
        print BELL;
    } while ($infinite);
}

sub timer {
    my $time = shift;
    my $message = shift;

    # thanks to https://www.febo.com/pages/perl_alarm_code/
    # and to http://www.perlmonks.org/?node_id=101511
    $SIG{ALRM} = sub { printf "$message time remaining: %d:%d \n", (gmtime $time - $elapsed)[1, 0] };
    setitimer(ITIMER_REAL, 1, 1);

    while ($elapsed < $time) {
        pause;
        clear_screen();
        $elapsed++;
    }
}

# thanks to http://stackoverflow.com/questions/197933/whats-the-best-way-to-clear-the-screen-in-perl
sub clear_screen {
    print "\033[2J";
    print "\033[0;0H";
}
