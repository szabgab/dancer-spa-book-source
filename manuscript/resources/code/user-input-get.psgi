use Dancer2;

get '/' => sub {
    return q{
       <form name="echo" method="GET" action="/echo">
           Fullname: <input name="fullname">
           Email: <input name="email">
           <input type="submit" value="Send">
       </form>
    }
};

get '/echo' => sub {
    my $fullname = query_parameters->get('fullname') // '';
    my $email    = query_parameters->get('email') // '';

    return qq{
       <table>
          <tr><td>Full name:</td><td>$fullname</td></tr>
          <tr><td>Email:</td><td>$email</td></tr>
       </table>
    };
};


__PACKAGE__->to_app;
