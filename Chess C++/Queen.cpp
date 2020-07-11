#include "Queen.h"

Queen::Queen(Player* player, int row, int col, Board* brd)
	:Piece(player, 'q', row, col, brd)
{
	_row = row;
	_col = col;
	_player = player;
	_brd = brd;
}

bool Queen::isLegalMove(int row, int col) const
{
	if ((row != _row && col != _col) && (abs(_row - row) != abs(_col - col)))  //if not in a straight line or diagonal return false
		return false;

	return (Piece::isWayFree(row, col)); 
}

Queen::~Queen()
{
}


