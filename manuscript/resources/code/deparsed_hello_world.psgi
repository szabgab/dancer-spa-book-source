sub Stream::Buffered::print;
sub Stream::Buffered::size;
sub Stream::Buffered::rewind;
use Dancer2;
use warnings;
use strict;
get('/', sub {
    return 'Hello World';
}
);
'main'->to_app;
