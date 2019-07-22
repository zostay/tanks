use v6;

unit class Tank:ver<0.0.0>:auth<github:zostay>;

has Supply $.stop-signal;
has Promise $.quit .= new;

method setup-signal-handlers() {
    $!stop-signal = signal(SIGQUIT, SIGINT);
}

method boot() {
    say "Configuring signal handlers.";
    self.setup-signal-handlers;
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
