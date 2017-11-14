use Plack::Builder;
use FindBin;

use lib "$FindBin::Bin/../lib";
use MySite;

builder {
    mount '/' => MySite->to_app;
};
