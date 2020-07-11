#pragma once
#include <string>
#include <iostream>
using namespace std;

#define BOARD_SIZE 8
#define INITIAL_STR_SIZE 66


class Player;
class Piece;
class NullPiece;
class King;
class Rook;
class Queen;
class Bishop;
class Knight;
class Pawn;
class Board
{
public:
	//Piece* temp();
	Board(Player* p1, Player* p2);
	Board() = delete;
	~Board();
	void initBoard(Player* p1, Player* p2);
	void print() const;
	void getString(char res[]) const;
	bool isPieceOfPlayer(int row, int col, Player* pl) const;
	bool tryMove(int srcRow, int srcCol, int dstRow, int dstCol) const;
	Piece** getBoard() const;
	void Move(int srcRow, int srcCol, int dstRow, int dstCol);
	void undoLastMove();
	void initPiece(Player* player, int row, int col, char c);
	void saveLastData(int, int, int, int);
	void eatNullPiece(Piece*, Piece*, int, int, int, int);
	void eatRivalPiece(int, int, int, int);
	void delLastPieceIfGarbage();
	void crownThePawn(int dstRow, int dstCol);
private:
	Piece* _brd[BOARD_SIZE][BOARD_SIZE];
	Player* _player1;
	Player* _player2;
	int _lastSrcRow;
	int _lastSrcCol;
	int _lastDstRow;
	int _lastDstCol;
	Piece* _lastPiece;
	string _boardString;
};