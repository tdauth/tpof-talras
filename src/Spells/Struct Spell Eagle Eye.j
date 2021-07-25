library StructSpellsSpellEagleEye requires Asl, StructGameClasses, StructGameSpell

	/// Passiv. Der Waldläufer hat eine X%ige Chance, doppelten Schaden anzurichten.
	struct SpellEagleEye extends Spell
		public static constant integer abilityId = 'A068'
		public static constant integer favouriteAbilityId = 'A069'
		public static constant integer classSelectionAbilityId = 'A1KB'
		public static constant integer classSelectionGrimoireAbilityId = 'A1KC'
		public static constant integer maxLevel = 5

		public static method create takes Character character returns thistype
			local thistype this = thistype.createWithoutTriggers(character, Classes.ranger(), Spell.spellTypeNormal, thistype.maxLevel, thistype.abilityId, thistype.favouriteAbilityId)
			call this.addGrimoireEntry('A1KB', 'A1KC')
			call this.addGrimoireEntry('A0YC', 'A0YH')
			call this.addGrimoireEntry('A0YD', 'A0YI')
			call this.addGrimoireEntry('A0YE', 'A0YJ')
			call this.addGrimoireEntry('A0YF', 'A0YK')
			call this.addGrimoireEntry('A0YG', 'A0YL')

			call this.setIsPassive(true)

			return this
		endmethod
	endstruct

endlibrary