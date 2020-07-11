#include "King.h"
King::King(Player* player, int row, int col, Board* brd)
	:Piece(player, 'k', row, col, brd)
{
}

bool King::isLegalMove(int row, int col) const
{
	if (abs(row - _row) > 1 || abs(col - _col) > 1) //king way of move
		return false;

	return Piece::isWayFree(row, col);  
}

bool King::isChess() 
{
	Piece** matBoard = (_brd->getBoard());
	Piece* currPiece = nullptr;

	for (int i = 0; i < BOARD_SIZE; i++)				//iterate all board, check if rival can make legal move to king
	{
		for (int j = 0; j < BOARD_SIZE; j++)
		{
			currPiece = *(matBoard + i * BOARD_SIZE + j);

			if ((currPiece->getPlayer()) == _player || (currPiece->getSign() == '#')) //if same player or nullpiece, move to next player
				continue;

			if (currPiece->isLegalMove(_row, _col))		//if rival can make legal move to king 
				return true;
		}
	}
	return false;
}
