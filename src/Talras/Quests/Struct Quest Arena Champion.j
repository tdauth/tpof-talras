library StructMapQuestsQuestArenaChampion requires Asl, Game, StructMapMapNpcs

	struct QuestArenaChampion extends AQuest

		public stub method enable takes nothing returns boolean
			local Character character = Character(this.character())
			call character.options().missions().addMission('A1UR', 'A1V3', this)
			return super.enableUntil(0)
		endmethod

		private static method create takes Character character returns thistype
			local thistype this = thistype.allocate(character, tre("Arenameister", "Arena Champion"))
			local AQuestItem questItem = 0
			call this.setIconPath("ReplaceableTextures\\CommandButtons\\BTNSteelMelee.blp")
			call this.setDescription(tre("Agihard gibt jedem, der es schafft mindestens fünf Gegner in seiner Arena zu besiegen, eine besondere Belohnung.", "Agihard gives to everyone who manages to defeat at least five opponents in his arena, a special reward."))
			call this.setReward(thistype.rewardExperience, 200)
			call this.setReward(thistype.rewardGold, 60)
			// item 0
			set questItem = AQuestItem.create(this, tre("Besiege mindestens fünf Gegner in der Arena.", "Defeat at least five opponents in the arena."))
			call questItem.setPing(true)
			call questItem.setPingCoordinatesFromRect(gg_rct_arena_0)
			call questItem.setPingColour(100.0, 100.0, 100.0)
			// item 1
			set questItem = AQuestItem.create(this, tre("Berichte Agihard von deinem Erfolg.", "Report to Agihard about your success."))
			call questItem.setPing(true)
			call questItem.setPingUnit(Npcs.agihard())
			call questItem.setPingColour(100.0, 100.0, 100.0)
			return this
		endmethod

		implement CharacterQuest
	endstruct

endlibrary