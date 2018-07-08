use v5.14;
use Dancer2;

set content_type => 'application/json';

get '/' => sub {
  debug "Hello World";
  return to_json config;
};

start;
