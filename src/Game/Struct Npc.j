library StructGameNpc requires Asl

	/**
	 * \brief NPCs may have routines, talks and are marked with texttag of their name.
	 */
	struct Npc
		private unit m_unit
		private texttag m_textTag
		private static AIntegerList m_allNpcs = 0
		// TODO max player number
		private static boolean array m_isTextTagShown[8]
		
		public method show takes player whichPlayer returns nothing
			call ShowTextTagForPlayer(whichPlayer, m_textTag, true)
		endmethod
		
		public method hide takes player whichPlayer returns nothing
			call ShowTextTagForPlayer(whichPlayer, m_textTag, false)
		endmethod

		public static method create takes unit whichUnit returns thistype
			local thistype this = thistype.allocate()
			set this.m_unit = whichUnit
			if (IsUnitType(whichUnit, UNIT_TYPE_HERO)) then
				set this.m_textTag = CreateTextTagUnitBJ(Format(tre("%2% %1%", "%2% %1%")).s(GetHeroProperName(whichUnit)).s(GetUnitName(whichUnit)).result(), whichUnit, 0, 10, 100, 100, 100, 0)
			else
				set this.m_textTag = CreateTextTagUnitBJ(GetUnitName(whichUnit), whichUnit, 0, 10, 100, 100, 100, 0)
			endif
			call DmdfHashTable.global().setHandleInteger(whichUnit, DMDF_HASHTABLE_KEY_NPC, this)
			call thistype.m_allNpcs.pushBack(this)
			return this
		endmethod

		public method onDestroy takes nothing returns nothing
			call DmdfHashTable.global().removeHandleInteger(this.m_unit, DMDF_HASHTABLE_KEY_NPC)
		endmethod
		
		public static method showAll takes nothing returns nothing
			local AIntegerListIterator iterator = thistype.m_allNpcs.begin()
			local integer i = 0
			loop
				exitwhen (not iterator.isValid())
				set i = 0
				loop
					exitwhen (i == MapSettings.maxPlayers())
					if (thistype.m_isTextTagShown[i]) then
						call Npc(iterator.data()).show(Player(i))
					else
						call Npc(iterator.data()).hide(Player(i))
					endif
					set i = i + 1
				endloop
				call iterator.next()
			endloop
			call iterator.destroy()
		endmethod
		
		public static method hideAll takes nothing returns nothing
			local AIntegerListIterator iterator = thistype.m_allNpcs.begin()
			local integer i = 0
			loop
				exitwhen (not iterator.isValid())
				set i = 0
				loop
					exitwhen (i == MapSettings.maxPlayers())
					call Npc(iterator.data()).hide(Player(i))
					set i = i + 1
				endloop
				call iterator.next()
			endloop
			call iterator.destroy()
		endmethod
		
		public static method showAllToPlayer takes player whichPlayer returns nothing
			local AIntegerListIterator iterator = thistype.m_allNpcs.begin()
			loop
				exitwhen (not iterator.isValid())
				if (thistype.m_isTextTagShown[GetPlayerId(whichPlayer)]) then
					call Npc(iterator.data()).show(whichPlayer)
				endif
				call iterator.next()
			endloop
			call iterator.destroy()
		endmethod
		
		public static method hideAllFromPlayer takes player whichPlayer returns nothing
			local AIntegerListIterator iterator = thistype.m_allNpcs.begin()
			loop
				exitwhen (not iterator.isValid())
				call Npc(iterator.data()).hide(whichPlayer)
				call iterator.next()
			endloop
			call iterator.destroy()
		endmethod
		
		public static method setVisibleForPlayer takes player whichPlayer, boolean visible returns nothing
			set thistype.m_isTextTagShown[GetPlayerId(whichPlayer)] = visible
			if (visible) then
				call thistype.showAllToPlayer(whichPlayer)
			else
				call thistype.hideAllFromPlayer(whichPlayer)
			endif
		endmethod
		
		public static method isVisibleToPlayer takes player whichPlayer returns boolean
			return thistype.m_isTextTagShown[GetPlayerId(whichPlayer)]
		endmethod
		
		public static method init takes nothing returns nothing
			local integer i
			set thistype.m_allNpcs = AIntegerList.create()
			set i = 0
			loop
				exitwhen (i == MapSettings.maxPlayers())
				set thistype.m_isTextTagShown[i] = true
				set i = i + 1
			endloop
		endmethod
	endstruct

endlibrary