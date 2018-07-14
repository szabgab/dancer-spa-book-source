package TicTacToe;
use Dancer2;

my $width = 3;
my $height = 4;

get '/' => sub {
    return template 'index';
};

any '/play' => sub {
    my $board = session('board');
    my $turn = session('turn');
    if (not $board or not $turn) {
        return q{Not started yet <a href="/start">start</a>};
    }

    my $sbt = body_parameters->get('sbt');
    if ($sbt) {
        my ($row, $col) = split /,/, $sbt;
        $board->[$row][$col] = $turn;
        $turn = $turn eq 'x' ? 'o' : 'x';
    }
    session('turn' => $turn);
    session('board' => $board);

    return template 'board' => {
        board => $board,
        turn  => $turn,
    }
};

get '/start' => sub {
    my $board = [];
    for my $h (0 .. $height-1) {
        push @$board, [ ('') x $width ];
    }
    my $turn = 'x';
    session('turn' => $turn);
    session('board' => $board);

    return template 'board' => {
        board => $board,
        turn  => $turn,
    }
};

1;
