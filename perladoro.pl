#!/usr/bin/perl

use strict;
use warnings;

use Time::HiRes;
use Term::ANSIColor;

user constant POMO_TIME => 25 * 60;

my $infinite = 0;
my $signal;

if ($ARGV[0] eq '-i') {
    $infinite = 1;
}

do {
    Time::HiRes->settimer($signal, POMO_TIME);
} while ($infinite)
