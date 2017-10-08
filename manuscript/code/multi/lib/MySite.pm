package MySite;
use Dancer2;

get '/' => sub {
    return 'Hello World <a href="/api/hello">API</a>';
};

1;
