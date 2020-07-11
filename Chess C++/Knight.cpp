#include "Knight.h"

Knight::Knight(Player* player, int row, int col, Board* brd)
	:Piece(player, 'n', row, col, brd)
{
}

bool Knight::isLegalMove(int row, int col) const
{
	return ((abs(row - _row) == 1 && abs(col - _col) == 2)
		|| (abs(row - _row) == 2 && abs(col - _col) == 1)) ? true : false;


	//return (Piece::isWayFree(row, col)); //check if way is free  -asset this return chhange

}

Knight::~Knight()
{
}

