/// Necromancer
library StructSpellsSpellDeathHerald requires Asl, StructGameClasses, StructGameSpell

	/**
	 * Grundfähigkeit: Todesbote - Passiv. Der Nekromant beschwört alle X Sekunden den Kadaver eines Zombies. Es können maximal Y beschworene Kadaver transportiert werden.
	 */
	struct SpellDeathHerald extends Spell
		public static constant integer abilityId = 'A0VK'
		public static constant integer favouriteAbilityId = 'A08G'
		public static constant integer classSelectionAbilityId = 'A1K3'
		public static constant integer classSelectionGrimoireAbilityId = 'A1K4'
		public static constant integer maxLevel = 1

		public static method create takes Character character returns thistype
			local thistype this = thistype.createWithoutTriggers(character, Classes.necromancer(), Spell.spellTypeDefault, thistype.maxLevel, thistype.abilityId, thistype.favouriteAbilityId)

			call this.addGrimoireEntry('A1K3', 'A1K4')
			call this.addGrimoireEntry('A0X6', 'A0X7')

			return this
		endmethod
	endstruct

endlibrary