library ModuleQuestsQuest requires Asl

	/// Considers death units (spawn points) and continues searching for the first one with unit type id \p unitTypeId of spawn point \p spawnPoint with an 1 second interval.
	function setQuestItemPingByUnitTypeId takes AAbstractQuest whichQuest, ASpawnPoint spawnPoint, integer unitTypeId returns nothing
		local unit whichUnit = spawnPoint.firstUnitOfType(unitTypeId)
		if (whichUnit == null) then
			call whichQuest.setPing(false)
			call TriggerSleepAction(1.0)
			call setQuestItemPingByUnitTypeId.execute(whichQuest, spawnPoint, unitTypeId) // continue searching
		else
			call whichQuest.setPing(true)
			call whichQuest.setPingUnit(whichUnit)
			call whichQuest.setPingColour(100.0, 100.0, 100.0)
		endif
	endfunction

	/**
	 * \brief Shared quests have to be completed by all players together. They are indicated by a special prefix in the quest log.
	 *
	 * \note The option hero icon lists all shared quests. When the player clicks on a quest symbol the camera is moved to the current quest location. This feature helps the player to know where he has to move his character to.
	 */
	struct SharedQuest extends AQuest

		// Because vJass is shit sometimes, we need to reimplement all stub methods here. Otherwise super won't work in derived structs.

		public stub method enable takes nothing returns boolean
			return super.enable()
		endmethod

		public stub method disable takes nothing returns boolean
			return super.disable()
		endmethod

		public stub method distributeRewards takes nothing returns nothing
			call super.distributeRewards()
		endmethod

		public static method create takes string title returns thistype
			return thistype.allocate(0, Format(tre("Gemeinsamer Auftrag: %1%", "Shared Mission: %1%")).s(title).result())
		endmethod
	endstruct

	module Quest
		private static thistype m_quest = 0

		public static method initQuest takes nothing returns nothing
			set thistype.m_quest = thistype.create()
			// use the required quest column for information only
			call thistype.m_quest.setIsRequired(false)
		endmethod

		public static method quest takes nothing returns thistype
			return thistype.m_quest
		endmethod
	endmodule

endlibrary