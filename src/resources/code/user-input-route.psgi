use Dancer2;

get '/' => sub {
    return q{
       <a href="/echo/Foo Bar/foo@bar.com">click</a>
    }
};

get '/echo/:fullname/:email' => sub {
    my $fullname = route_parameters->get('fullname') // '';
    my $email    = route_parameters->get('email') // '';

    return qq{
       <table>
          <tr><td>Full name:</td><td>$fullname</td></tr>
          <tr><td>Email:</td><td>$email</td></tr>
       </table>
    };
};


__PACKAGE__->to_app;
