package MySite;
use Dancer2;

get '/' => sub {
    template 'index';
};

1;
