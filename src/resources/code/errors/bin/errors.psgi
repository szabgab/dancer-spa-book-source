use strict;
use warnings;
use Plack::Builder;
use FindBin;

use lib "$FindBin::Bin/../lib";
use MyAPI;
use MySite;

builder {
    mount '/api' => MyAPI->to_app;
    mount '/'    => MySite->to_app;
};
