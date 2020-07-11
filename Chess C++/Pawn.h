#pragma once
#include "Board.h"
#include "Piece.h"


class Player;
class Pawn : public Piece
{
public:
	Pawn(Player* player, int row, int col, Board* brd);
	Pawn() = delete;
	virtual bool isLegalMove(int, int) const;
	void setDoubleStep();
	~Pawn();
private:
	bool _doubleStep;
};