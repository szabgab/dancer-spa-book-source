use Dancer2;
use Path::Tiny qw(path);

get '/' => sub {
    my $path = __FILE__ . '.txt';
    my $count = 0;
    if (-e $path) {
        $count = path($path)->slurp;
    }
    $count++;
    path($path)->spew($count);
    return $count;
};


__PACKAGE__->to_app;
