# The Clone Wars #

## What is The Clone Wars? ##

Star Wars Galaxies The Clone Wars is an emulated version of the MMORPG Star Wars Galaxies based off of the open source Core3 code created by the SWGEmu team. We are fully AGPL compliant and have all of our work listed within this repo as per the agreement with SWGEmu. If you would like to install your own server with Core3 on it, please read the instructions below. Our credits for the Clone Wars server can be found at the bottom of this page.

# SWGEmu Core3 #

## What is SWGEmu? ##

Star Wars Galaxies was a massively multi-player online role playing game introduced by Sony Online Entertainment in the year 2003 and shut down in 2011.
It is this game the SWGEmu project focuses to recreate at a specific milestone referred to as Pre-CU, or Pre-Combat Upgrade. The Combat Upgrade was a set of game changes which radically changed the game-play, to the dislike of thousands of players. These changes led to the founding of this project, in an attempt to "recreate" the game as it was during the Pre-CU era.
At SWGEmu, Emulator refers to the software the SWGEmu team is building. This Emulator is meant to imitate Sony Online Entertainment's server-side software, which hosted the galaxies of Star Wars Galaxies during the Pre-CU era.

#### How to build ####

##### Dependencies #####
  * CMake 3.1.0 or higher
  * BerkeleyDB 5.3
  * MySQL Client and Server
  * OpenSSL libraries
  * pthreads
  * Lua 5.3 libraries
  * Zlib libraries
  * g++ 5+
  * engine3
  * java jre 1.7+

### Debian 9+ or Ubuntu 16.04+ ###
  * Install dependencies

        sudo apt install build-essential libmysqlclient-dev liblua5.3-dev libdb5.3-dev libssl-dev cmake git default-jre libssl-dev git
  * Clone core3 repository somewhere  (~/git)

        mkdir -p ~/git
        cd ~/git
        git clone http://review.swgemu.com/Core3
  * Build Core3 with 8 threads

        cd MMOCoreORB
        make -j8
  * Import sql database

        mysql -h<MYSQLHOST> -u<MYSQLUSER> -p<MYSQLPASSWORD> < sql/swgemu.sql

### How to Run ###
    cd ~/git/Core3/MMOCoreORB/bin
    ./core3

### License ###
    Copyright (C) 2017 SWGEmu

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

For more information, see https://review.swgemu.com.

## Clone Wars Credits and Thanks ##

A big thank you to everyone who has helped make Clone Wars a reality and also to the members of the SWGEmu community who also share their work for the benefit of others. Thank you and full credit to the following people:

  * SWGEmu - Core3 usage and the reason we are all here today.
  * ModTheGalaxy - ModTheGalaxy tres including all of the CU and NGE items/content.
  * Holocron Team - Being helpful and providing guidance when needed.
  * Aftermath - Aftermath base code work via the public repo.
  * Tatwi - Legend of Hondo vendor merchant logic.
  * Timbab - Jawa Toolbox usage.
  * Halyn - Sitting through hours of us DMing him questions and being a huge help with multiple things.
  * TheTinyPebble - Custom Armour system originally created for the Sentinels Republic server.
  * Deztia, Slight, Sallorn, Fanta and Eawah - Testing help during Clone Wars development.
  * Empire in Flames server - Useful Newsnet terminal mod.
  * Infinity server - CA/AAs working with skirts, Covert Hat, Clothes breaking on 0 condition, RegrantSkills Command and the SEA Removal Tool.
  * Sentinels Republic server - Healing Battle Fatigue in a Ranger Camp.
  * Reckoning server - City Mail spam bug fix & increased badge limit.
  * Progor - Relics of Corbantis open source launcher base and DiscordBot.
  * Tyclo - Sentinels Republic open source launcher base, based on the RoC launcher listed above.
  * Phoenix - LUA Attribute Component.
  * Liakhara - Gas Recycler implementation.