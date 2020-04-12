use v6;

unit class Tank::RootMount;

has IO::Path $.root = "/".IO;

subset Writability of Str where 'ro' | 'rw';

method remount(Writability:D $how --> True) {
    run 'mount', '-o', "remount,$how", $.root;

    if $how eq 'ro' && !self.is-mounted-ro {
        die "unable to remount $.root mount read-only";
    }

    if $how eq 'rw' && self.is-mounted-ro {
        die "unable to remount $.root mount read-write";
    }

    True
}

method is-mounted-ro(--> Bool:D) {
    my $p = run 'mount', :out;
    for $p.lines -> $mtab-line {
        my ($dev, $, $path, $, $type, $opts) = $mtab-line.split(' ');
        next unless $path eq $.root;

        my %opts := set($opts.comb(/<[a..z 0..9 = %]>+/));
        return False if 'rw' ∈ %opts;
        return True if 'ro' ∈ %opts;
        last;
    }

    die "Unable to determine read-only status of $.root mount";
}
