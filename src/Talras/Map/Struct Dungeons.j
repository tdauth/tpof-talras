library StructMapMapDungeons requires Asl, StructGameDungeon

	struct Dungeons
		private static Dungeon m_dornheim
		private static Dungeon m_wotansHouse
		private static Dungeon m_wotansSecondFloor
		private static Dungeon m_wotansBigHouse
		private static Dungeon m_talras
		private static Dungeon m_drumCave
		private static Dungeon m_crypt
		

		public static method init takes nothing returns nothing
			set thistype.m_dornheim = Dungeon.create(tre("Dornheim", "Dornheim"), gg_rct_area_playable, gg_rct_area_playable)
			call thistype.m_dornheim.setEnterTrigger(true)
			set thistype.m_wotansHouse = Dungeon.create(tre("Wotans Haus", "Wotan's House"), gg_rct_wotans_house, gg_rct_wotans_house)
			call thistype.m_wotansHouse.setEnterTrigger(true)
			call thistype.m_wotansHouse.setCameraSetup(gg_cam_wotans_house)
			set thistype.m_wotansSecondFloor = Dungeon.create(tre("Wotans Haus Zweiter Stock", "Wotan's House Second Floor"), gg_rct_wotans_house_second_floor, gg_rct_wotans_house_second_floor)
			call thistype.m_wotansSecondFloor.setEnterTrigger(true)
			call thistype.m_wotansSecondFloor.setCameraSetup(gg_cam_wotans_house_second_floor)

			set thistype.m_wotansBigHouse = Dungeon.create(tre("Wotans Dorfhalle", "Wotan's Village Hall"), gg_rct_wotans_big_house, gg_rct_wotans_big_house)
			call thistype.m_wotansBigHouse.setEnterTrigger(true)
			call thistype.m_wotansBigHouse.setCameraSetup(gg_cam_wotans_big_house)
		
			set thistype.m_talras = Dungeon.create(tre("Talras", "Talras"), gg_rct_area_playable, gg_rct_area_playable_view)
			set thistype.m_drumCave = Dungeon.create(tre("Trommelhöhle", "Drum Cave"), gg_rct_area_aos, gg_rct_area_aos_view)
			set thistype.m_crypt = Dungeon.create(tre("Gruft", "Crypt"), gg_rct_area_tomb, gg_rct_area_tomb_view)
		endmethod

		public static method addSpellbookAbilities takes nothing returns nothing
			call DungeonSpellbook.addDungeonToAll('A1U0', 'A1U3', thistype.m_talras)
			call DungeonSpellbook.addDungeonToAll('A1U1', 'A1U5', thistype.m_drumCave)
			call DungeonSpellbook.addDungeonToAll('A1U2', 'A1U4', thistype.m_crypt)
		endmethod
		
		public static method dornheim takes nothing returns Dungeon
			return thistype.m_dornheim
		endmethod

		public static method talras takes nothing returns Dungeon
			return thistype.m_talras
		endmethod

		public static method drumCave takes nothing returns Dungeon
			return thistype.m_drumCave
		endmethod

		public static method crypt takes nothing returns Dungeon
			return thistype.m_crypt
		endmethod
	endstruct

endlibrary