#include "Rook.h"

Rook::Rook(Player* player, int row, int col, Board* brd)
	:Piece(player, 'r', row, col, brd)
{
	_row = row;
	_col = col;
	_player = player;
	_brd = brd;
}

bool Rook::isLegalMove(int row, int col) const
{
	if (row != _row && col != _col)  //if not in a straight line
		return false;

	return (Piece::isWayFree(row, col));
}

Rook::~Rook()
{
}

