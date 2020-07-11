#pragma once
#include <vector>
#include "Board.h"
class King;
class Player

{
public:
	Player(bool isWhite);
	Player(bool isWhite, bool isUp);
	~Player();
	void setKing(King*);
	King* getKing() const;
	bool isWhite() const;
	bool isGoingUp() const;
private:
	King* _myKing;
	bool _isWhite;
	bool _isGoingUp;
};

