#pragma once
#include "Board.h"
#include "Piece.h"


class Player;
class Bishop : public Piece
{
public:
	Bishop(Player* player, int row, int col, Board* brd);
	Bishop() = delete;
	virtual bool isLegalMove(int, int) const;
	~Bishop();
private:

};