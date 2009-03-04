--Copyright (C) 2007 <SWGEmu>
 
--This File is part of Core3.
 
--This program is free software; you can redistribute 
--it and/or modify it under the terms of the GNU Lesser 
--General Public License as published by the Free Software
--Foundation; either version 2 of the License, 
--or (at your option) any later version.
 
--This program is distributed in the hope that it will be useful, 
--but WITHOUT ANY WARRANTY; without even the implied warranty of 
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
--See the GNU Lesser General Public License for
--more details.
 
--You should have received a copy of the GNU Lesser General 
--Public License along with this program; if not, write to
--the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
 
--Linking Engine3 statically or dynamically with other modules 
--is making a combined work based on Engine3. 
--Thus, the terms and conditions of the GNU Lesser General Public License 
--cover the whole combination.
 
--In addition, as a special exception, the copyright holders of Engine3 
--give you permission to combine Engine3 program with free software 
--programs or libraries that are released under the GNU LGPL and with 
--code included in the standard release of Core3 under the GNU LGPL 
--license (or modified versions of such code, with unchanged license). 
--You may copy and distribute such a system following the terms of the 
--GNU LGPL for Engine3 and the licenses of the other code concerned, 
--provided that you include the source code of that other code when 
--and as the GNU LGPL requires distribution of source code.
 
--Note that people who make modified versions of Engine3 are not obligated 
--to grant this special exception for their modified versions; 
--it is their choice whether to do so. The GNU Lesser General Public License 
--gives permission to release a modified version without this exception; 
--this exception also makes it possible to release a modified version 
--which carries forward this exception.

--Corellia
if (PLANET_ID == 0) then
 RunCreatureFile("spawns/corellia/staticSpawns.lua") 
 ---
 RunCreatureFile("spawns/corellia/citys/coronet.lua")  
 RunCreatureFile("spawns/corellia/citys/belaVista.lua") 
 RunCreatureFile("spawns/corellia/citys/doaba.lua") 
 RunCreatureFile("spawns/corellia/citys/korVella.lua") 
 RunCreatureFile("spawns/corellia/citys/tyrena.lua") 
 RunCreatureFile("spawns/corellia/citys/vreniIsland.lua") 
 RunCreatureFile("spawns/corellia/citys/theater.lua")
 ---
 RunCreatureFile("spawns/corellia/dungeons/afarathuCave.lua")
 RunCreatureFile("spawns/corellia/dungeons/drallCave.lua")
 RunCreatureFile("spawns/corellia/dungeons/lordNyaxCult.lua")
 RunCreatureFile("spawns/corellia/dungeons/rogueCorsecBase.lua")
 RunCreatureFile("spawns/corellia/dungeons/rebelHideout.lua")
 RunCreatureFile("spawns/corellia/dungeons/imperialStronghold.lua") 
end

--Dantooine
if (PLANET_ID == 1) then
 RunCreatureFile("spawns/dantooine/staticSpawns.lua")
 RunCreatureFile("spawns/dantooine/jediSpawns.lua") 
 RunCreatureFile("spawns/dantooine/abandonedRebel.lua")  
 
 RunCreatureFile("spawns/dantooine/citys/imperialOutpost.lua")
 RunCreatureFile("spawns/dantooine/citys/miningOutpost.lua")
 RunCreatureFile("spawns/dantooine/citys/pirateOutpost.lua")
 
 RunCreatureFile("spawns/dantooine/dungeons/forceCrystalHuntersCave.lua")
 RunCreatureFile("spawns/dantooine/dungeons/jantaCave.lua")
 RunCreatureFile("spawns/dantooine/dungeons/kungaCave.lua")
 RunCreatureFile("spawns/dantooine/dungeons/MokkCave.lua")
 RunCreatureFile("spawns/dantooine/dungeons/dantariMokkVillage.lua") 
end

--Dathomir
if (PLANET_ID == 2) then
 RunCreatureFile("spawns/dathomir/staticSpawns.lua")
 RunCreatureFile("spawns/dathomir/nightsisterLaborCamp.lua")
 RunCreatureFile("spawns/dathomir/nightsisters.lua")
 RunCreatureFile("spawns/dathomir/singingmtnclan.lua")
 RunCreatureFile("spawns/dathomir/rancorCave.lua")
 RunCreatureFile("spawns/dathomir/nightsisterStronghold.lua")
 RunCreatureFile("spawns/dathomir/nsVsSmcPoi.lua")
 RunCreatureFile("spawns/dathomir/imperialPrison.lua") 
 RunCreatureFile("spawns/dathomir/sarlaacPit.lua")  
 RunCreatureFile("spawns/dathomir/citys/scienceOutpost.lua") 
 RunCreatureFile("spawns/dathomir/citys/tradeOutpost.lua")  
end


--Endor
if (PLANET_ID == 3) then
RunCreatureFile("spawns/endor/staticSpawns.lua")
--
RunCreatureFile("spawns/endor/citys/researchOutpost.lua")
RunCreatureFile("spawns/endor/citys/smugglersOutpost.lua")
--
RunCreatureFile("spawns/endor/dungeons/jindaCave.lua")
RunCreatureFile("spawns/endor/dungeons/korgaCave.lua")
RunCreatureFile("spawns/endor/dungeons/marauderStronghold.lua")
RunCreatureFile("spawns/endor/dungeons/deathWatchBunker.lua")
end

--Lok
if (PLANET_ID == 4) then
RunCreatureFile("spawns/lok/staticSpawns.lua")
RunCreatureFile("spawns/lok/citys/nymsStronghold.lua")
RunCreatureFile("spawns/lok/kimoTown.lua")
RunCreatureFile("spawns/lok/canyonCorsairStronghold.lua")
RunCreatureFile("spawns/lok/gurkKingLair.lua")
RunCreatureFile("spawns/lok/imperialOutpost.lua")
RunCreatureFile("spawns/lok/dungeons/droidDungeon.lua")
end

--Naboo
if (PLANET_ID == 5) then
 RunCreatureFile("spawns/naboo/staticSpawns.lua")
 RunCreatureFile("spawns/naboo/weaponDevelopmentFacility.lua") 
 --
 RunCreatureFile("spawns/naboo/citys/deejaPeak.lua") 
 RunCreatureFile("spawns/naboo/citys/emperorRetreat.lua")
 RunCreatureFile("spawns/naboo/citys/kaadara.lua") 
 RunCreatureFile("spawns/naboo/citys/keren.lua") 
 RunCreatureFile("spawns/naboo/citys/lakeRetreat.lua") 
 RunCreatureFile("spawns/naboo/citys/moenia.lua") 
 RunCreatureFile("spawns/naboo/citys/theed.lua")  
 --
 RunCreatureFile("spawns/naboo/dungeons/narglatchCave.lua") 
 RunCreatureFile("spawns/naboo/dungeons/veermokCave.lua") 
end

--Rori
if (PLANET_ID == 6) then
RunCreatureFile("spawns/rori/staticSpawns.lua")
--
RunCreatureFile("spawns/rori/citys/narmale.lua")
--
RunCreatureFile("spawns/rori/dungeons/facilityHyperDrive.lua")
end

--Talus
if (PLANET_ID == 7) then
RunCreatureFile("spawns/talus/staticSpawns.lua")
--
RunCreatureFile("spawns/talus/citys/dearic.lua")
RunCreatureFile("spawns/talus/citys/narshal.lua")
--
RunCreatureFile("spawns/talus/poi/lostVillageOfDurbin.lua")
--
RunCreatureFile("spawns/talus/dungeons/aakuanChampionsCave.lua")
end

--Tatooine
if (PLANET_ID == 8) then
 RunCreatureFile("spawns/tatooine/staticSpawns.lua")
 --  
 RunCreatureFile("spawns/tatooine/citys/jabbapalace.lua") 
 RunCreatureFile("spawns/tatooine/citys/anchorhead.lua") 
 RunCreatureFile("spawns/tatooine/citys/bestine.lua") 
 RunCreatureFile("spawns/tatooine/citys/mosEisley.lua") 
 RunCreatureFile("spawns/tatooine/citys/mosEntha.lua") 
 RunCreatureFile("spawns/tatooine/citys/mosEspa.lua") 
 RunCreatureFile("spawns/tatooine/citys/wayfar.lua") 
 --
 RunCreatureFile("spawns/tatooine/ancientKraytDragonSkeleton.lua")
 RunCreatureFile("spawns/tatooine/kraytGraveyard.lua")
 RunCreatureFile("spawns/tatooine/wreckedSandCrawler.lua")
 --
 RunCreatureFile("spawns/tatooine/dungeons/forttusken.lua")
 RunCreatureFile("spawns/tatooine/dungeons/squillcavern.lua")
 RunCreatureFile("spawns/tatooine/dungeons/hutthideout.lua")
 RunCreatureFile("spawns/tatooine/dungeons/tuskenBunker.lua")
 RunCreatureFile("spawns/tatooine/dungeons/tuskenVillage.lua") 
 RunCreatureFile("spawns/tatooine/dungeons/beetlecave.lua")
end

--Yavin 4
if (PLANET_ID == 9) then
RunCreatureFile("spawns/yavin4/staticSpawns.lua")
--
RunCreatureFile("spawns/yavin4/citys/imperialFortress.lua")
RunCreatureFile("spawns/yavin4/citys/laborOutpost.lua")
RunCreatureFile("spawns/yavin4/citys/miningOutpost.lua")
--
RunCreatureFile("spawns/yavin4/dungeons/geoCave.lua")
RunCreatureFile("spawns/yavin4/dungeons/woolamanderPalace.lua")
RunCreatureFile("spawns/yavin4/dungeons/blueleafTemple.lua")
end

--Corellian Corvette
if (PLANET_ID == 31) then
--RunCreatureFile("spawns/space/corellianCorvette/imperialCorellianCorvette.lua")
end
