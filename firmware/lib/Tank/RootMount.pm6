use v6;

unit class Tank::RootMount;

has IO::Path $.root = "/".IO;

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
