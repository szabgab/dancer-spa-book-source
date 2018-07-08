use Plack::Builder;
use FindBin;

use lib "$FindBin::Bin/../lib";
use MySite;
use MyAPI;

builder {
    mount '/api' => MyAPI->to_app;
    mount '/'    => MySite->to_app;
};
