#pragma once
#include "Board.h"
#include "Piece.h"
#include "Player.h"


class King : public Piece
{
public:
	King(Player* player, int row, int col, Board* brd);
	//King() = delete;

	virtual bool isLegalMove(int, int) const;
	bool isChess();

private:

};