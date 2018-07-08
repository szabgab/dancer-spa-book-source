package MySite;
use Dancer2;

get '/' => sub {
    return 'Hello World from module <a href="/other">Other page</a>';
};

get '/other' => sub {
    return 'Other page';
};


1;
