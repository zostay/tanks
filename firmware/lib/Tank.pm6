use v6;

use Tank::RootMount;

unit class Tank:ver<0.0.0>:auth<github:zostay>;

has Supply $.stop-signal;
has Promise $.quit .= new;

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
    say "Configuring signal handlers.";
    self.setup-signal-handlers;
}

method got-signal($s) {
    say "Received $s";
}

method shutdown($op) {
}

method run() {
    react {
        # We have various UDP packet signals
        whenever $.cnc.Supply {
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
