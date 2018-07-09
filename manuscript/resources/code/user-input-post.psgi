use Dancer2;

get '/' => sub {
    return q{
       <form name="echo" method="POST" action="/echo">
           Fullname: <input name="fullname">
           Email: <input name="email">
           <input type="submit" value="Send">
       </form>
    }
};

post '/echo' => sub {
    my $fullname = body_parameters->get('fullname') // '';
    my $email    = body_parameters->get('email') // '';

    return qq{
       <table>
          <tr><td>Full name:</td><td>$fullname</td></tr>
          <tr><td>Email:</td><td>$email</td></tr>
       </table>
    };
};


__PACKAGE__->to_app;
