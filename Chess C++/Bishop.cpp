#include "Bishop.h"

Bishop::Bishop(Player* player, int row, int col, Board* brd)
	:Piece(player, 'b', row, col, brd)
{
}

bool Bishop::isLegalMove(int row, int col) const
{

	if (row == _row || col == _col)  //if dest is not diagonal
		return false;

	if (abs(_row - row) == abs(_col - col)) //if diagonally aligned
		return Piece::isWayFree(row, col); //check if way is free  -asset this return chhange

	return false;
}

Bishop::~Bishop()
{
}


