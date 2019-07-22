#!/usr/bin/env perl6
use v6;

use Tank;

sub MAIN() {
    my Tank $tank .= new;

    say "TankOS v$tank.^ver() booting... ";

    $tank.boot;

    say "Boot up sequence is complete.";

    say "Ready to rock and roll.";

    $tank.run;

    say "Good-bye.";
}
