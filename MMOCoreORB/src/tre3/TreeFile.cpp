/*
 * TreeFile.cpp
 *
 *  Created on: Apr 6, 2011
 *      Author: crush
 */

#include "TreeFile.h"
//#include "TreeFileRecord.h"
#include "TreeArchive.h"

TreeFile::TreeFile(TreeArchive* archive) {
	version = 0;
	treeArchive = archive;
}

TreeFile::~TreeFile() {

}

void TreeFile::read(const String& path) {
	setLoggingName("TreeFile " + path);
	setLogging(true);

	filePath = path;

	File* file = new File(path);

	FileInputStream fileStream(file);

	if (!file->exists()) {
		error("File does not exist.");
		return;
	}

	readHeader(fileStream);

	if (file != NULL)
		delete file;
}

void TreeFile::readHeader(FileInputStream& fileStream) {
	uint32 fileType = 0;
	fileStream.read((byte*) &fileType, 4);

	if (fileType != 'TREE') {
		error("File is not a valid Tree file.");
		return;
	}

	fileStream.read((byte*) &version, 4);

	//TODO: Perhaps this switch can be refactored.
	switch (version) {
	case '0005':
	{
		uint32 buffer = 0;

		fileStream.read((byte*) &totalRecords, 4);
		fileStream.read((byte*) &dataOffset, 4);

		//info("Found records: " + String::valueOf(totalRecords));
		//info("Data offset at " + String::valueOf(dataOffset));

		//Setup the file block.
		fileStream.read((byte*) &buffer, 4);
		fileBlock.setCompressionType(buffer);
		fileStream.read((byte*) &buffer, 4);
		fileBlock.setCompressedSize(buffer);
		fileBlock.setUncompressedSize(TreeDataBlock::SIZE * totalRecords);

		//Setup the name block.
		fileStream.read((byte*) &buffer, 4);
		nameBlock.setCompressionType(buffer);
		fileStream.read((byte*) &buffer, 4);
		nameBlock.setCompressedSize(buffer);
		fileStream.read((byte*) &buffer, 4);
		nameBlock.setUncompressedSize(buffer);
	}
		break;
	case '0006': //Apparently, the header information is insignificant in this version?
		fileStream.skip(28);
		break;
	default:
		error("Unknown Tree version: " + String::valueOf(version));
	}

	readFileBlock(fileStream);
	readNameBlock(fileStream);
	readMD5Sums(fileStream);
}

void TreeFile::readFileBlock(FileInputStream& fileStream) {
	fileStream.skip(dataOffset - 36);
	fileBlock.uncompress(fileStream);

	//Load the records.
	uint32 bufferOffset = 0;
	for (int i = 0; i < totalRecords; ++i) {
		TreeFileRecord* tfr = new TreeFileRecord();
		tfr->setTreeFilePath(filePath);
		bufferOffset += tfr->readFromBuffer(fileBlock.getUncompressedData() + bufferOffset);

		records.add(tfr);
	}
}

void TreeFile::readNameBlock(FileInputStream& fileStream) {
	nameBlock.uncompress(fileStream);

	for (int i = 0; i < totalRecords; ++i) {
		TreeFileRecord* record = records.get(i);

		if (treeArchive != NULL)
			treeArchive->addRecord(nameBlock.getUncompressedData() + record->getNameOffset(), record);
	}
}

void TreeFile::readMD5Sums(FileInputStream& fileStream) {
	for (int i = 0; i < totalRecords; ++i) {
		TreeFileRecord* record = records.get(i);

		byte md5[16];
		fileStream.read(md5, 16);

		record->setMD5Sum(md5);
	}
}
