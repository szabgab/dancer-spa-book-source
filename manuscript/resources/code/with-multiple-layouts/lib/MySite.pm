package MySite;
use Dancer2;

get '/' => sub {
    template 'index' => {
        title => 'Hello World',
    };
};

get '/other' => sub {
    return template 'other' => {
        title => 'Other World',
        name  => 'Foo Bar',
    };
};

get '/landing/ad1' => sub {
    return template 'ad1', {
        title => 'AD1 Landing Page',
        code  => 'ad1',
    }, {
        layout => 'landing'
    };
};

get '/landing/ad2' => sub {
    return template 'ad2', {
        title => 'AD2 Landing Page',
        code  => 'ad2',
    }, {
        layout => 'landing'
    };
};

1;
