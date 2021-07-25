library StructMapQuestsQuestThePaedophilliacCleric requires Asl, StructGameCharacter

	struct QuestThePaedophilliacCleric extends AQuest

		public stub method enable takes nothing returns boolean
			return super.enable()
		endmethod

		private static method create takes ACharacter character returns thistype
			local thistype this = thistype.allocate(character, tre("Der pädophile Kleriker", "The Pedophile Cleric"))
			local AQuestItem questItem = 0
			call this.setIconPath("ReplaceableTextures\\CommandButtons\\BTNVillagerKid.blp")
			call this.setDescription(tre("Osman, der Burgkleriker, war wohl von deiner überaus menschlichen Art nicht so ganz begeistert. Er will sich beim Herzog über dich beschweren, was nicht unbedingt gute Folgen für dich hätte, da du ja sozusagen für ihn arbeiten möchtest.", "Osman, the castle cleric was probably not so thrilled by your very human kind. He wants to complain about you at the duke which has not necessarily good consequences for you, since you would like to work for the duke."))
			// item 0
			set questItem = AQuestItem.create(this, tre("Schwärze Osman beim Herzog an.", "Blacken Osman's name with the duke."))
			//call questItem.setPing(true)
			//call questItem.setPingUnit(gg_unit_n00Q_0028)
			//call questItem.setPingColour(100.0, 100.0, 100.0)
			// item 1
			set questItem = AQuestItem.create(this, tre("Ärgere Osman damit.", "Annoy Osman with it."))
			call questItem.setPing(true)
			call questItem.setPingUnit(gg_unit_n00R_0101)
			call questItem.setPingColour(100.0, 100.0, 100.0)

			return this
		endmethod

		implement CharacterQuest
	endstruct

endlibrary