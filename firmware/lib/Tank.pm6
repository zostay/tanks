use v6;

unit class Tank:ver<0.0.0>:auth<github:zostay>;

has Supply $.stop-signal;
has Promise $.quit .= new;

method setup-signal-handlers() {
    $!stop-signal = signal(SIGQUIT, SIGINT);
}

method check-root-mount() {
    my $mount = Tank::RootMount.new;
    if $mount.is-mounted-ro {
        say "Root is mounted read-only.";
    }
    else {
        die "Cannot boot, root is mounted read-write. This should be corrected immediately.";
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

method shutdown() {
}

method run() {
    react {

        # Stop signals cause quitting
        whenever $.stop-signal -> $s {
            self.got-signal($s);
            $.quit.keep;
        }

        # Do any required shutdown work and exit.
        whenever $.quit {
            self.shutdown;
            done;
        }
    }
}
