package MySite;
use Dancer2;

get '/' => sub {
    template 'index' => { title => 'Hello World' };
};

get '/other' => sub {
    return template 'other' => {
        title => 'Other World',
        name  => 'Foo Bar',
    };
};

1;
