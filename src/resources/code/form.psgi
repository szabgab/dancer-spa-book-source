use Dancer2;

get '/' => sub {
    return q{
       <form name="echo" method="POST" action="/echo">
          <table>
           <tr><td>Text</td>      <td><input name="oneliner"></td></tr>
           <tr><td>Password</td>  <td><input type="password" name="password"></td></tr>
           <tr><td>Languages</td> <td><select name="languages" multiple>
                                        <option value="perl">Perl</option>
                                        <option value="python">Python</option>
                                        <option value="ruby">Ruby</option>
                                        <option value="java">Java</option>
                                        <option value="javascript">JavaScript</option>
                                      </select>
                                   </td></tr>
           <tr><td>Gender (radio)</td> <td>
                                           <input type="radio" name="gender" value="female"> Female<br>
                                           <input type="radio" name="gender" value="male"> Male<br>
                                           <input type="radio" name="gender" value="other"> Other<br>
                                        </td></tr>
           <tr><td>Vehicle (checkbox)</td> <td>
                                            <input type="checkbox" name="vehicle" value="bike"> Bike<br>
                                            <input type="checkbox" name="vehicle" value="car"> Car<br>
                                            <input type="checkbox" name="vehicle" value="horse"> Horse<br>
                                        </td></tr>
           <tr><td>Email (email)</td>   <td><input type="email" name="email"></td></tr>
           <tr><td>(submit)</td> <td><input type="submit" value="Send"></td></tr>
          </table>
       </form>
    }
};

post '/echo' => sub {
    my $oneliner = body_parameters->get('oneliner') // '';
    my $password = body_parameters->get('password') // '';
    my @languages = body_parameters->get_all('languages');
    my $gender = body_parameters->get('gender') // '';
    my @vehicle = body_parameters->get_all('vehicle');
    my $email = body_parameters->get('email') // '';

    my $lang = join ',', @languages;
    my $vehi = join ',', @vehicle;
    return qq{
       <table>
          <tr><td>Oneliner:</td><td>$oneliner</td></tr>
          <tr><td>Password:</td><td>$password</td></tr>
          <tr><td>Languages:</td><td>$lang</td></tr>
          <tr><td>Gender:</td><td>$gender</td></tr>
          <tr><td>Vehicle:</td><td>$vehi</td></tr>
          <tr><td>Email:</td><td>$email</td></tr>
       </table>
    };
};


__PACKAGE__->to_app;

