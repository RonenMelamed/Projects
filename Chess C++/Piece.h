#pragma once

//#include "Player.h"
#include <math.h>
#include "Board.h"
#include "Player.h"


class Player;
class Piece

{
public:
	char getSign() const;
	Player* getPlayer() const;
	virtual bool isLegalMove(int, int) const = 0;
	void setPosition(int row, int col);
	Piece(Player*, char sign, int row, int col, Board* board);
	Piece() = delete;
	virtual ~Piece();

private:
	char _sign;

protected:
	Player* _player; // not reference because can be null

	int _startRow;
	int _startCol;
	int _row;
	int _col;
	Board* _brd;

	bool isWayFree(int dstRow, int dstCol) const;
};