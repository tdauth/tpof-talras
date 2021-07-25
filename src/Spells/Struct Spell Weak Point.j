/// Dragon Slayer
library StructSpellsSpellWeakPoint requires Asl, StructGameClasses, StructGameSpell

	/// Passiv. Der Drachentöter hat eine Chance von X%, doppelten Schaden zuzufügen.
	struct SpellWeakPoint extends Spell
		public static constant integer abilityId = 'A06Y'
		public static constant integer favouriteAbilityId = 'A06Z'
		public static constant integer classSelectionAbilityId = 'A1OL'
		public static constant integer classSelectionGrimoireAbilityId = 'A1OM'
		public static constant integer maxLevel = 5

		public static method create takes Character character returns thistype
			local thistype this = thistype.createWithoutTriggers(character, Classes.dragonSlayer(), thistype.spellTypeNormal, thistype.maxLevel, thistype.abilityId, thistype.favouriteAbilityId)
			call this.addGrimoireEntry('A1OL', 'A1OM')
			call this.addGrimoireEntry('A0SS', 'A0SX')
			call this.addGrimoireEntry('A0ST', 'A0SY')
			call this.addGrimoireEntry('A0SU', 'A0SZ')
			call this.addGrimoireEntry('A0SV', 'A0T0')
			call this.addGrimoireEntry('A0SW', 'A0T1')

			call this.setIsPassive(true)

			return this
		endmethod
	endstruct

endlibrary