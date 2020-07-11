#include "Board.h"
#include "Player.h"
#include "Piece.h"
#include "Rook.h"
#include "King.h"
#include "NullPiece.h"
#include "Queen.h"
#include "Bishop.h"
#include "Knight.h"
#include "Pawn.h"

Board::Board(Player* p1, Player* p2)
{
	initBoard(p1, p2);
}

Board::~Board()
{
	for (int i = 0; i < BOARD_SIZE; i++)
	{
		for (int j = 0; j < BOARD_SIZE; j++)
		{
			delete _brd[i][j];
		}
	}
	delete _player1,_player2,_brd;
}

void Board::initBoard(Player* p1, Player* p2)
{
	_lastPiece = nullptr;
	_boardString = "QKRRNNBBPPPPPPPP################################ppppppppqkrrnnbb1";
	
	int si = 0;
	Player* currP = nullptr;
	for (int i = 0; i < BOARD_SIZE; i++) //initialize board
	{
		for (int j = 0; j < BOARD_SIZE; j++)
		{
			if (si > -1 && si < 16)		//decide which player current pieces belongs to
				currP = p1;
			else if (si > 15 && si < 48)
				currP = nullptr;
			else
				currP = p2;
			
			initPiece(currP, i, j, _boardString[si]);	//init new piece

			si++;
		}
	}
}

void Board::crownThePawn(int dstRow, int dstCol) //crown pawn when reach behined enemy lines
{
	Piece* curr = (_brd[dstRow][dstCol]);
	Queen* newQueen = new Queen(curr->getPlayer(), dstRow, dstCol, this);
	_brd[dstRow][dstCol] = newQueen;
	delete curr;
}

void Board::initPiece(Player* player, int row, int col, char c) //instantiate piece accordingly
{
	if (c == 'k' || c == 'K')
	{
		player->setKing(new King(player, row, col, this));
		_brd[row][col] = (Piece*)player->getKing();
	}
	else if (c == 'r' || c == 'R')
	{
		_brd[row][col] = (Piece*) new Rook(player, row, col, this);
	}
	else if (c == 'b' || c == 'B')
	{
		_brd[row][col] = (Piece*) new Bishop(player, row, col, this);
	}
	else if (c == 'q' || c == 'Q')
	{
		_brd[row][col] = (Piece*) new Queen(player, row, col, this);
	}
	else if (c == 'n' || c == 'N')
	{
		_brd[row][col] = (Piece*) new Knight(player, row, col, this);
	}
	else if (c == 'p' || c == 'P')
	{
		_brd[row][col] = (Piece*) new Pawn(player, row, col, this);
	}
	else
	{
		_brd[row][col] = (Piece*) new NullPiece(row, col);
	}
}



void Board::print() const		//print board in console - for control purpuses
{
	cout << "   ";
	for (int i = 0; i < BOARD_SIZE; i++)
		cout << (char)('a' + i) << " ";
	cout << "\n\n";

	for (int i = 0; i < BOARD_SIZE; i++) 
	{
		char c = (BOARD_SIZE - i) + '0';
		cout << c << "  ";

		for (int j = 0; j < BOARD_SIZE; j++)
		{
			cout << _brd[i][j]->getSign() << " ";
		}

		cout << " " << ((char)(BOARD_SIZE - i + '0'));
		cout << endl;

	}

	cout << "\n   ";
	for (int i = 0; i < BOARD_SIZE; i++)
		cout << (char)('a' + i) << " ";;
}

void Board::getString(char res[]) const //return initial string, for board set up
{
	for (int i = 0; i < BOARD_SIZE*2+1; i++)
		res[i] = _boardString[i];

		res[BOARD_SIZE * 2 + 1] = '\0';
}
 
bool Board::isPieceOfPlayer(int row, int col, Player* pl) const  //determines if piece blongs to player pl
{ 

	return (pl == _brd[row][col]->getPlayer()) ? true : false; 
}

bool Board::tryMove(int srcRow, int srcCol, int dstRow, int dstCol) const
{
	return _brd[srcRow][srcCol]->isLegalMove(dstRow, dstCol); //assert this	
}

Piece** Board::getBoard() const
{
	return (Piece * *)(_brd); 
}

void Board::Move(int srcRow, int srcCol, int dstRow, int dstCol)
{
	if (_lastPiece)
		_lastPiece = nullptr; // destroy previous last piece 

	Pawn* pawn = dynamic_cast<Pawn*>(_brd[srcRow][srcCol]); //if pawn - cancel 2steps after one turn
	if (pawn != NULL)
		pawn->setDoubleStep();

	_lastPiece = _brd[dstRow][dstCol];				//save dstPiece
	saveLastData(srcRow, srcCol, dstRow, dstCol);	//save last data

	Piece* srcPiece = _brd[srcRow][srcCol];
	Piece* dstPiece = _brd[dstRow][dstCol];

	if (dstPiece->getSign() == '#')						//if dst is nullpiece replace addresses
		eatNullPiece(srcPiece, dstPiece, srcRow, srcCol, dstRow, dstCol);
	else											    // if dst is rival, it will now get eaten
		eatRivalPiece(srcRow, srcCol, dstRow, dstCol);
}

void Board::saveLastData(int srcRow, int srcCol, int dstRow, int dstCol) //saves last data
{
	_lastSrcRow = srcRow;
	_lastSrcCol = srcCol;
	_lastDstRow = dstRow;
	_lastDstCol = dstCol;
}

void Board::eatNullPiece(Piece* srcPiece, Piece* dstPiece, int srcRow, int srcCol, int dstRow, int dstCol)
{
	srcPiece->setPosition(dstRow, dstCol);	//change internal row and col
	dstPiece->setPosition(srcRow, srcCol);
	std::swap(_brd[srcRow][srcCol], _brd[dstRow][dstCol]);	//change board ptr
}

void Board::eatRivalPiece(int srcRow, int srcCol, int dstRow, int dstCol) //case of eating rival piece
{
	_brd[dstRow][dstCol] = _brd[srcRow][srcCol];			//move src ptr to dst			
	_brd[srcRow][srcCol]->setPosition(dstRow, dstCol);		//change internal position
	_brd[srcRow][srcCol] = new NullPiece(srcRow, srcCol);	//build new src null ptr
}


void Board::delLastPieceIfGarbage()
{
	if (_lastPiece->getSign() != '#')
		_lastPiece->~Piece(); // destructs when changes turn - if _lastpiece is rival  (if nullPiece only pointers had changed so no reason for deletion
}


void Board::undoLastMove()
{

	if (_brd[_lastSrcRow][_lastSrcCol] == _lastPiece) //if player did not eat rival - just change pointers and internal positions
	{
		_brd[_lastDstRow][_lastDstCol]->setPosition(_lastSrcRow, _lastSrcCol);
		_lastPiece->setPosition(_lastDstRow, _lastDstCol);
		std::swap(_brd[_lastSrcRow][_lastSrcCol], _brd[_lastDstRow][_lastDstCol]);	//change board ptr
	}
	else		//if player eat rival
	{												
		delete _brd[_lastSrcRow][_lastSrcCol];
		_brd[_lastSrcRow][_lastSrcCol] = _brd[_lastDstRow][_lastDstCol];
		_brd[_lastSrcRow][_lastSrcCol]->setPosition(_lastSrcRow, _lastSrcCol);
		_brd[_lastDstRow][_lastDstCol] = _lastPiece;
	}

}


