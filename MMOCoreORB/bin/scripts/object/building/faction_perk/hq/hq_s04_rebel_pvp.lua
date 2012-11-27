--Copyright (C) 2010 <SWGEmu>


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


object_building_faction_perk_hq_hq_s04_rebel_pvp = object_building_faction_perk_hq_shared_hq_s04_rebel_pvp:new {
		lotSize = 0,
		faction = "rebel",
		pvpFaction = "rebel",
		maintenanceCost = 5,
		baseMaintenanceRate = 5,
		dataObjectComponent = "DestructibleBuildingDataComponent",
		allowedZones = {"dantooine", "naboo", "rori","tatooine"},
		constructionMarker = "object/building/player/construction/construction_player_house_generic_medium_style_01.iff",
		length = 7,
		width = 6,
			childObjects = {

			{templateFile = "object/tangible/terminal/terminal_hq_rebel.iff", x = 0, z = 0, y = -6, ox = 0, oy = 0, oz = 0, ow = 1, cellid = 3, containmentType = -1 },
			
			--{templateFile = "object/installation/turret/turret_block_med.iff", x=0, z=0, y=0, ox=0, oy=0, oz=0, ow=1, cell=-1, containmenttype=-1},
			-- left side columns
			
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=-5.5, z=0, y=30.75, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- left column 1
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=-12.5, z=0, y=26.75, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- left column 2
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=-19.5, z=0, y=22.75, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- left column 3
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=-19.5, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- left column 4
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=-11.5, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- left column 5
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=-3.5, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- left column 6

			-- right columns
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=5.5, z=0, y=30.75, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- right column 1
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=12.5, z=0, y=26.75, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- right column 2
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=19.5, z=0, y=22.75, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- right column 3
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=19.5, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- right column 4
		    {templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=11.5, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- right column 5
			{templateFile = "object/static/structure/military/military_column_med_rebel_style_01.iff", x=3.5, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1}, -- right column 6

			
			-- new walls test
			
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=-5.5, z=0, y=34.75, ox=0, oy=-.7, oz=0, ow=.7, cellid=-1, containmentType=-1}, -- left wall 2
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=5.5, z=0, y=34.75, ox=0, oy=-.7, oz=0, ow=.7, cellid=-1, containmentType=-1}, 
			
			
			-- wall 2
			{templateFile = "object/static/structure/military/military_wall_med_rebl_16_style_01.iff", x=-12.5, z=0, y=26.75, oy=-.27, oz=0, ow=.965, cellid=-1, containmentType=-1}, -- left wall 2
			{templateFile = "object/static/structure/military/military_wall_med_rebl_16_style_01.iff", x=12.5, z=0, y=26.75, oy=.27, oz=0, ow=.965, cellid=-1, containmentType=-1}, 
			
			-- wall 3
			{templateFile = "object/static/structure/military/military_wall_med_rebl_32_style_01.iff", x=-19.5, z=0, y=6.75, ox=0, oy=.711424, oz=0, ow=-.702763, cellid=-1, containmentType=-1}, -- left wall 3
			{templateFile = "object/static/structure/military/military_wall_med_rebl_32_style_01.iff", x=19.5, z=0, y=6.75, ox=0, oy=-.711424, oz=0, ow=-.702763, cellid=-1, containmentType=-1}, -- right wall 3
			
			-- back walls
			{templateFile = "object/static/structure/military/military_wall_med_rebl_16_style_01.iff", x=-11.5, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1},
			{templateFile = "object/static/structure/military/military_wall_med_rebl_16_style_01.iff", x=11.5, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1},
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=0, z=0, y=-9.25, ox=0, oy=-0, oz=0, ow=1, cellid=-1, containmentType=-1},
			
			
			
			--[[ DO NOT DELETE
			TEMP WAlls may need angled walls for turrets
			-- wall 4
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=-19.5, z=0, y=10.75, ox=0, oy=-.7, oz=0, ow=.7, cellid=-1, containmentType=-1}, -- left wall 4
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=19.5, z=0, y=10.75, ox=0, oy=-.7, oz=0, ow=.7, cellid=-1, containmentType=-1}, -- right wall 4
										
			-- wall 4
			{templateFile = "object/static/structure/military/military_wall_med_rebl_16_style_01.iff", x=-18, z=0, y=8.75, ox=0, oy=.7, oz=0, ow=.7, cellid=-1, containmentType=-1}, -- left wall 4
			{templateFile = "object/static/structure/military/military_wall_med_rebl_16_style_01.iff", x=18, z=0, y=8.75, ox=0, oy=.7, oz=0, ow=.7, cellid=-1, containmentType=-1}, 
		
			-- wall 5
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=15, z=0, y=-2, oy=-.4, oz=0, ow=.9, cellid=-1, containmentType=-1},-- right wall 5	
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=-15, z=0, y=-2, ox=0, oy=.4, oz=0, ow=.9, cellid=-1, containmentType=-1}, -- left wall 5
			
			-- wall 6
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=15, z=0, y=-8.5, ox=0, oy=.4, oz=0, ow=.9, cellid=-1, containmentType=-1}, -- right wall 6
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=-15, z=0, y=-8.5, ox=0, oy=-.4, oz=0, ow=.9, cellid=-1, containmentType=-1}, -- left wall 6
			
			-- wall 7 changed
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=15, z=0, y=-14.5, oy=-.4, oz=0, ow=.9, cellid=-1, containmentType=-1},-- right wall 7	
			{templateFile = "object/static/structure/military/military_wall_med_rebl_style_01.iff", x=-15, z=0, y=-14.5, ox=0, oy=.4, oz=0, ow=.9, cellid=-1, containmentType=-1}, -- left wall 7
			]]--
		
			{templateFile = "object/tangible/terminal/terminal_hq_rebel.iff", x = .38, z = .25, y = 1.75, ox = 0, oy = 0, oz = 0, ow = 1, cellid = 2, containmentType = -1 },
			{templateFile = "object/tangible/hq_destructible/power_regulator.iff", x = 12, z = -11.5, y = -21, ox = 0, oy = .69, oz = 0, ow = .68, cellid = 10, containmentType = -1 },
			 {templateFile = "object/tangible/hq_destructible/override_terminal.iff", x = 18.25, z = -13.75, y = 8.5, ox = 0, oy = .75, oz = 0, ow = -.5, cellid = 9, containmentType = -1 },
			 {templateFile = "object/tangible/hq_destructible/security_terminal.iff", x = -5.5, z = -13.75, y = 7.5, ox = 0, oy = 1, oz = 0, ow = 0, cellid = 7, containmentType = -1 },
			 {templateFile = "object/tangible/hq_destructible/uplink_terminal.iff", x = 1, z = -6.75, y = -5.75, ow = .7, ox =0, oz = 0, oy = .7, cellid = 5, containmentType = -1},
			
		},


}

ObjectTemplates:addTemplate(object_building_faction_perk_hq_hq_s04_rebel_pvp, "object/building/faction_perk/hq/hq_s04_rebel_pvp.iff")
