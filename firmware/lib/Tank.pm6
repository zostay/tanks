use v6;

unit class Tank:ver<0.0.0>:auth<github:zostay>;

has Supply $.stop-signal;
has Promise $.quit .= new;

has $!cnc;
method cnc(--> IO::Socket::Async) {
    $!cnc //= IO::Socket::Async.bind-udp('0.0.0.0', 10101);
}

method setup-signal-handlers() {
    $!stop-signal = signal(SIGQUIT, SIGINT);
}

method check-root-mount() {
    my $mount = Tank::RootMount.new;
    if $mount.is-mounted-ro {
        say "Root is mounted read-only.";
    }
    else {
        die "Cannot boot, root is mounted read-write. Please fix.";
    }
}

method boot() {
    say "Configuring signal handlers.";
    self.setup-signal-handlers;

    say "Checking root mount options.";
    self.check-root-mount;
}

method got-signal($s) {
    say "Received $s";
}

method shutdown($op) {
}

method run() {
    react {
        # We have various UDP packet signals
        whenever $.cnd.Supply {
            when 'reboot' { $.quit.keep('reboot') }
            when 'quit'   { $.quit.keep('halt') }
        }

        # Stop signals cause quitting
        whenever $.stop-signal -> $s {
            self.got-signal($s);
            $.quit.keep('halt');
        }

        # Do any required shutdown work and exit.
        whenever $.quit -> $op {
            self.shutdown($op);
            done;
        }
    }
}
