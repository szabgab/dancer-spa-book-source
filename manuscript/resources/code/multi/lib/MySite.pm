package MySite;
use Dancer2;

get '/' => sub {
    return 'Hello World from module';
};

1;
