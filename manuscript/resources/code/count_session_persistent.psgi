use Dancer2;
set session => 'YAML';

get '/' => sub {
    my $count = session('counter') // 0;
    $count++;
    session (counter => $count );
    return $count;
};


__PACKAGE__->to_app;
