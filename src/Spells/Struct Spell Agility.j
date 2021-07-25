/// Ranger
library StructSpellsSpellAgility requires Asl, StructGameClasses, StructGameSpell

	/// Passiv. Der Waldläufer weicht Angriffen mit einer X %igen Chance aus.
	struct SpellAgility extends Spell
		public static constant integer abilityId = 'A06O'
		public static constant integer favouriteAbilityId = 'A06P'
		public static constant integer classSelectionAbilityId = 'A01B'
		public static constant integer classSelectionGrimoireAbilityId = 'A01O'
		public static constant integer maxLevel = 5

		public static method create takes Character character returns thistype
			local thistype this = thistype.createWithoutTriggers(character, Classes.ranger(), Spell.spellTypeNormal, thistype.maxLevel, thistype.abilityId, thistype.favouriteAbilityId)
			call this.addGrimoireEntry('A01B', 'A01O')
			call this.addGrimoireEntry('A0YM', 'A0YR')
			call this.addGrimoireEntry('A0YN', 'A0YS')
			call this.addGrimoireEntry('A0YO', 'A0YT')
			call this.addGrimoireEntry('A0YP', 'A0YU')
			call this.addGrimoireEntry('A0YQ', 'A0YV')

			call this.setIsPassive(true)

			return this
		endmethod
	endstruct

endlibrary