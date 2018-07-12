use Dancer2;

my $count = 0;

get '/' => sub {
    $count++;
    return $count;
};


__PACKAGE__->to_app;
