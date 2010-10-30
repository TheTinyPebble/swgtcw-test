/*
Copyright (C) 2007 <SWGEmu>

This File is part of Core3.

This program is free software; you can redistribute
it and/or modify it under the terms of the GNU Lesser
General Public License as published by the Free Software
Foundation; either version 2 of the License,
or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for
more details.

You should have received a copy of the GNU Lesser General
Public License along with this program; if not, write to
the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

Linking Engine3 statically or dynamically with other modules
is making a combined work based on Engine3.
Thus, the terms and conditions of the GNU Lesser General Public License
cover the whole combination.

In addition, as a special exception, the copyright holders of Engine3
give you permission to combine Engine3 program with free software
programs or libraries that are released under the GNU LGPL and with
code included in the standard release of Core3 under the GNU LGPL
license (or modified versions of such code, with unchanged license).
You may copy and distribute such a system following the terms of the
GNU LGPL for Engine3 and the licenses of the other code concerned,
provided that you include the source code of that other code when
and as the GNU LGPL requires distribution of source code.

Note that people who make modified versions of Engine3 are not obligated
to grant this special exception for their modified versions;
it is their choice whether to do so. The GNU Lesser General Public License
gives permission to release a modified version without this exception;
this exception also makes it possible to release a modified version
which carries forward this exception.
*/

#ifndef SUIWINDOWTYPE_H_
#define SUIWINDOWTYPE_H_

class SuiWindowType {
public:
	//This window type can be sent when you don't need to handle a callback.
	static const uint16 NONE = 0;

	//Cloning 1 - 10
	static const uint16 CLONE_REQUEST = 1;
	static const uint16 CLONE_CONFIRM = 2;

	//Entertaining 11 - 20
	static const uint16 MUSIC_START = 11;
	static const uint16 MUSIC_CHANGE = 12;
	static const uint16 DANCING_START = 13;
	static const uint16 DANCING_CHANGE = 14;

	//Guilds 21 - 50
	static const uint16 GUILD_CREATE_NAME = 21;
	static const uint16 GUILD_CREATE_ABBREV = 22;
	static const uint16 GUILD_SPONSOR = 23;
	static const uint16 GUILD_ACCEPT_SPONSORSHIP = 24;
	static const uint16 GUILD_LIST_SPONSORED = 25;
	static const uint16 GUILD_CHANGE_NAME = 26;
	static const uint16 GUILD_CHANGE_ABBREV = 27;
	static const uint16 GUILD_INFORMATION = 28;
	static const uint16 GUILD_DISBAND = 29;
	static const uint16 GUILD_MEMBER_OPTIONS = 30;
	static const uint16 GUILD_MEMBER_REMOVE = 31;
	static const uint16 GUILD_MEMBER_PERMISSIONS = 32;
	static const uint16 GUILD_TRANSFER_LEADER = 33;
	static const uint16 GUILD_TRANSFER_LEADER_CONFIRM = 34;

	//Tickets 51 - 60
	static const uint16 TICKET_PURCHASE_MESSAGE = 51;
	static const uint16 TICKET_COLLECTOR_RESPONSES = 52;

	//Color Pickers 61 - 70
	static const uint16 COLOR_PICKER1 = 61;
	static const uint16 COLOR_PICKER2 = 62;

	//Bank 71 - 80
	static const uint16 BANK_TRANSFER = 71;
	static const uint16 BANK_TIP_CONFIRM = 72;

	//Resource 81 - 90
	static const uint16 FREE_RESOURCE = 81;
	static const uint16 GIVE_FREE_RESOURCE = 82;

	//Factory 91 - 100
	static const uint16 FACTORY_SCHEMATIC2BUTTON = 91;
	static const uint16 FACTORY_SCHEMATIC3BUTTON = 92;
	static const uint16 FACTORY_INGREDIENTS = 93;

	//Insurance 101 - 110
	static const uint16 INSURANCE_MENU = 101;
	static const uint16 INSURANCE_CONFIRM_ALL = 102;

	//City 111 - 140
	static const uint16 CITY_CREATE = 111;
	static const uint16 CITY_ENABLE_ZONING = 112;
	static const uint16 CITY_SET_NAME = 113;
	static const uint16 CITY_MILITIA = 114;
	static const uint16 CITY_ADD_MILITIA = 115;

	//Structure 141 - 170
	static const uint16 STRUCTURE_STATUS = 141;
	static const uint16 STRUCTURE_DESTROY_CODE = 142;
	static const uint16 STRUCTURE_DESTROY_CONFIRM = 143;
	static const uint16 STRUCTURE_MANAGE_MAINTENANCE = 144;
	static const uint16 STRUCTURE_ADD_ENERGY = 145;

	//Admin 171 - 220
	static const uint16 ADMIN_COMMANDS = 171;
	static const uint16 ADMIN_BANLIST = 172;
	static const uint16 ADMIN_ACCOUNTINFO = 173;
	static const uint16 ADMIN_PLAYERINFO = 174;

	//Teach 221 - 230
	static const uint16 TEACH_SKILL = 221;
	static const uint16 TEACH_PLAYER = 222;
	static const uint16 TEACH_DENY = 223;

	//Survey Tool 231 - 240
	static const uint16 SURVEY_TOOL_RANGE = 231;
	static const uint16 SURVEY_TOOL_CONCENTRATED_MINIGAME = 232;
	static const uint16 SURVEY_TOOL_CONCENTRATED_MINIGAME2 = 233;

	//Sample 241 - 250
	static const uint16 SAMPLE_RADIOACTIVE_CONFIRM = 241;

	//Slicing 251 - 260
	static const uint16 SLICING_MENU = 251;

	//Gambling 261 - 270
	static const uint16 GAMBLING_ROULETTE = 261;
	static const uint16 GAMBLING_SLOT = 262;
	static const uint16 GAMBLING_SLOT_PAYOUT = 263;

	//Fishing 271 - 280
	static const uint16 FISHING = 271;

	//Junk Dealer 281 - 290
	static const uint16 JUNK_DEALER_SELL_LIST = 281;

	//Medic 291 - 300
	static const uint16 MEDIC_CONSENT = 291;
	static const uint16 MEDIC_DIAGNOSE = 292;

	//MOTD 301 - 310
	static const uint16 MOTD = 301;
	static const uint16 MOTD_SET = 302;

	//Character Builder 311 - 320
	static const uint16 CHARACTER_BUILDER_LIST = 311;


	//Miscellaneous 1000+
	static const uint16 OBJECT_NAME = 1000;
	static const uint16 COMMAND_FIND = 1001;
};

#endif /*SuiWindowType_H_*/
