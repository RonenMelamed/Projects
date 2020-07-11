#pragma once
#include "Board.h"
#include "Piece.h"


class Player;
class Rook : public Piece
{
public:
	Rook(Player* player, int row, int col, Board* brd);
	Rook() = delete;
	virtual bool isLegalMove(int, int) const;
	~Rook();
private:

};