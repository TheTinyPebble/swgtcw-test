/*
 * CreateClientPathMessage.h
 *
 *  Created on: Nov 20, 2008
 *      Author: swgemu
 */

#ifndef CREATECLIENTPATHMESSAGE_H_
#define CREATECLIENTPATHMESSAGE_H_

class CreateClientPathMessage : public BaseMessage {
	int coordinateCount;
public:
   CreateClientPathMessage() : BaseMessage() {

	    coordinateCount = 0;

		insertShort(0x05);
		insertInt(0x71957628);  // CRC

		insertInt(0); //Coordinate Count.

   }

   void addCoordinate(float x, float z, float y) {
			insertFloat(x); //Float PosX
	   		insertFloat(y); //Float PosZ
	   		insertFloat(z); //Float PosY
	   		updateCount();
   }

   void updateCount() {
	   insertInt(7, coordinateCount++);
   }


};

#endif /* CREATECLIENTPATHMESSAGE_H_ */
