use v6;

unit class Tank:ver<0.0.0>:auth<github:zostay>;

has Supply $.stop-signal;
has Promise $.quit .= new;

has Supplier $.messages .= new;

has $!cnc;
method cnc(--> IO::Socket::Async) {
    $!cnc //= IO::Socket::Async.bind-udp('0.0.0.0', 10101);
}

method setup-signal-handlers() {
    $!stop-signal = Supply.merge(
        signal(SIGQUIT),
        signal(SIGINT),
    );
}

method boot() {
    say "TankOS v{self.^ver()} booting... ";

    say "Configuring signal handlers.";

    self.setup-signal-handlers;

    say "Boot Sequence: COMPLETE";
}

method shutdown($op) {
}

method got-signal($s) {
    start { $.messages.emit: "Received: $s" }
}

method activate(Str:D $system --> True) {
    start { $.messages.emit: "$system: ACTIVE" }
}

method say(*@_ --> True) {
    start { $.messages.emit: @_.join('') }
}

method run() {
    say "Initiating final startup... ";

    react {
        # Thisis the thing that outputs to the screen
        whenever $.messages.Supply { .say }

        self.activate: "Message Queue";

        # We have various UDP packet signals
        whenever $.cnc.Supply {
            when 'reboot' { $.quit.keep('reboot') }
            when 'quit'   { $.quit.keep('halt') }
        }

        self.activate: "Command and Control System";

        # Stop signals cause quitting
        whenever $.stop-signal -> $s {
            self.got-signal($s);
            $.quit.keep('halt');
        }

        self.activate: "Signal Listeners";

        # Do any required shutdown work and exit.
        whenever $.quit -> $op {
            self.shutdown($op);
            done;
        }

        self.activate: "Finalizer";

        self.say: "Tank systems are ONLINE. Ready to rock and roll.";
    }

    say "Game Over, man! Game over!";
}
