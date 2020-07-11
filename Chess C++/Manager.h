#pragma once
#include "Board.h"
#include "Player.h"
#include "Pipe.h"
using namespace std;
class Manager
{
public:
	Manager(Pipe&);
	Manager()=delete;
	~Manager();
	int playMove(string move);
	void playGame();

private:
	Player* _player1;
	Player* _player2;
	Player* _currPlayer;
	Player* _otherPlayer;
	Board* _brd;
	Pipe _pipe;

	bool isValidMove(int) const;
	void changeTurn();
};

