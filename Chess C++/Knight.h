#pragma once
#include "Board.h"
#include "Piece.h"
class Player;


class Knight : public Piece
{
public:
	Knight(Player* player, int row, int col, Board* brd);
	Knight() = delete;
	virtual bool isLegalMove(int, int) const;
	~Knight();
private:

};