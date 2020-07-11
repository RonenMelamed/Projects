#pragma once
#include "Piece.h"


class Player;
class NullPiece : public Piece
{
public:
	NullPiece(int row, int col);
	NullPiece() = delete;

	virtual bool isLegalMove(int, int) const;
private:
};