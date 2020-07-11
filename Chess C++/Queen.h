#pragma once
#include "Board.h"
#include "Piece.h"


class Player;
class Queen : public Piece
{
public:
	Queen(Player* player, int row, int col, Board* brd);
	Queen() = delete;
	virtual bool isLegalMove(int, int) const;
	~Queen();
private:

};