package TicTacToe;
use Dancer2;

my $width = 3;
my $height = 4;

any '/' => sub {
    my $board = session('board');
    my $turn = session('turn');
    if (not $board) {
        $board = [
            ['x', 'o', ''],
            ['', 'x', 'o'],
            ['o', '', ''],
            ['', '', ''],
        ];
    }
    if (not $turn) {
        $turn = 'x';
    }

    my $sbt = body_parameters->get('sbt');
    if ($sbt) {
        my ($row, $col) = split /,/, $sbt;
        $board->[$row][$col] = $turn;
        $turn = $turn eq 'x' ? 'o' : 'x';
    }
    session('turn' => $turn);
    session('board' => $board);

    return template 'index' => {
        board => $board,
    }
};

get '/start' => sub {
};

1;
