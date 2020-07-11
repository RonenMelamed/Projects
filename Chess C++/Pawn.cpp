#include "Pawn.h"

Pawn::Pawn(Player* player, int row, int col, Board* brd)
	:Piece(player, 'p', row, col, brd), _doubleStep(true)
{
}

bool Pawn::isLegalMove(int row, int col) const
{
	Piece** matBoard = _brd->getBoard();
	Piece* nextPiece = *(matBoard + row * BOARD_SIZE + _col); //check this memory accsess

	int  isUpBit = Piece::_player->isGoingUp() ? 1 : -1;	  //determine up or down move (p1/p2)
	int stepsNum =( (isUpBit * _row - isUpBit * row) );		  //determine one or two steps

	if ((stepsNum < 0) || (stepsNum == 2 && !_doubleStep)) //if doubleStep not allowed
		return false;
	
	if ((col == _col) && stepsNum <= 2)							//if one/two step forward
		return (nextPiece->getSign() != '#') ? false : true;    //if next player is enemy return false

	return ((abs(col - _col) == 1) && (isUpBit * row == (isUpBit * _row - 1))) ? true : false; //if one step diagonally			
}



void Pawn::setDoubleStep()
{
	_doubleStep = false;
}



Pawn::~Pawn()
{
}

