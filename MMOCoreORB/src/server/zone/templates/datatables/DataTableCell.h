/*
 * DataTableCell.h
 *
 *  Created on: Feb 11, 2011
 *      Author: crush
 */

#ifndef DATATABLECELL_H_
#define DATATABLECELL_H_

#include "engine/engine.h"

class DataTableCell {
public:
	DataTableCell() {
	}

	virtual void parse(Chunk* chunk) = 0;

	virtual void getValue(String& out) {
		out = "";
	}

	virtual void getValue(float& out) {
		out = 0.f;
	}

	virtual void getValue(int& out) {
		out = 0;
	}

	virtual void getValue(uint32& out) {
		out = 0;
	}

	virtual void getValue(bool& out) {
		out = false;
	}

	virtual byte getType() = 0;

	virtual String toString() = 0;
};

class DataTableCellString : public DataTableCell {
	String value;

public:
	DataTableCellString() {
	}

	void parse(Chunk* chunk) {
		chunk->readString(value);
	}

	void getValue(String& out) {
		out = value;
	}

	byte getType() {
		return 's';
	}

	String toString() {
		return value;
	}
};

class DataTableCellInt : public DataTableCell {
	int value;

public:
	DataTableCellInt() {
		value = 0;
	}

	void parse(Chunk* chunk) {
		value = chunk->readSignedInt();
	}

	void getValue(int& out) {
		out = value;
	}

	byte getType() {
		return 'i';
	}

	String toString() {
		return String::valueOf(value);
	}
};

class DataTableCellHex : public DataTableCell {
	uint32 value;

public:
	DataTableCellHex() {
		value = 0;
	}

	void parse(Chunk* chunk) {
		value = chunk->readInt();
	}

	void getValue(uint32& out) {
		out = value;
	}

	byte getType() {
		return 'h';
	}

	String toString() {
		return String::valueOf(value);
	}
};

class DataTableCellFloat : public DataTableCell {
	float value;

public:
	DataTableCellFloat() {
		value = 0.f;
	}

	void parse(Chunk* chunk) {
		value = chunk->readFloat();
	}

	void getValue(float& out) {
		out = value;
	}

	byte getType() {
		return 'f';
	}

	String toString() {
		return String::valueOf(value);
	}
};

class DataTableCellBinary : public DataTableCell {
	bool value;

public:
	DataTableCellBinary() {
		value = false;
	}

	void parse(Chunk* chunk) {
		value = (bool) chunk->readInt();
	}

	void getValue(bool& out) {
		out = value;
	}

	byte getType() {
		return 'b';
	}

	String toString() {
		return String::valueOf(value);
	}
};

#endif /* DATATABLECELL_H_ */
