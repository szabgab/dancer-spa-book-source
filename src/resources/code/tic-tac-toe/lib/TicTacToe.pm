package TicTacToe;
use Dancer2;

my $width = 3;
my $height = 4;
my @board = (
    ['x', 'o', ''],
    ['', 'x', 'o'],
    ['o', '', ''],
    ['', '', ''],
);


get '/' => sub {
    return template 'index' => {
        board => \@board,
    }
};

post '/' => sub {
    my $sbt = body_parameters->get('sbt');
    return $sbt if $sbt;
    return 'non';
};

1;
