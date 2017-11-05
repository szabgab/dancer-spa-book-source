package MySite;
use Dancer2;

get '/' => sub {
    return template 'index';
};

post '/calc' => sub {
    my $x = body_parameters->{'a'};
    my $y = body_parameters->{'b'};
    my $result = $x / $y;
    return qq{<a href="/">main</a> $x / $y = $result};
};

get '/old-page' => sub {
    redirect '/';
};

1;

