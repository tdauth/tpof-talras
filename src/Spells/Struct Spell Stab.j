// Knight
library StructSpellsSpellStab requires Asl, StructGameClasses, StructGameSpell

	/// Fügt dem angewählten Ziel X Punkte Schaden zu.
	struct SpellStab extends Spell
		public static constant integer abilityId = 'A027'
		public static constant integer favouriteAbilityId = 'A041'
		public static constant integer classSelectionAbilityId = 'A1O1'
		public static constant integer classSelectionGrimoireAbilityId = 'A1O2'
		public static constant integer maxLevel = 5
		private static constant real damageFactor = 80.0

		private method action takes nothing returns nothing
			local real damage = this.level() * thistype.damageFactor
			call UnitDamageTargetBJ(this.character().unit(), GetSpellTargetUnit(), damage, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
			call Spell.showDamageTextTag(GetSpellTargetUnit(), damage)
		endmethod

		public static method create takes ACharacter character returns thistype
			local thistype this = thistype.createWithEvent(character, Classes.knight(), Spell.spellTypeNormal, thistype.maxLevel, thistype.abilityId, thistype.favouriteAbilityId, 0, 0, thistype.action, EVENT_PLAYER_UNIT_SPELL_EFFECT) // if the event channel is used, the cooldown and mana costs are ignored if UnitDamageTargetBJ() kills the target

			call this.addGrimoireEntry('A1O1', 'A1O2')
			call this.addGrimoireEntry('A0Y2', 'A0Y7')
			call this.addGrimoireEntry('A0Y3', 'A0Y8')
			call this.addGrimoireEntry('A0Y4', 'A0Y9')
			call this.addGrimoireEntry('A0Y5', 'A0YA')
			call this.addGrimoireEntry('A0Y6', 'A0YB')

			return this
		endmethod
	endstruct

endlibrary
