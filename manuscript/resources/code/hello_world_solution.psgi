use Dancer2;
 
get '/' => sub {
    return 'Hello World <a href="/about">About</a>';
};

get '/about' => sub {
    return 'By Gabor Szabo <a href="/">main</a>';
};
 
__PACKAGE__->to_app;
