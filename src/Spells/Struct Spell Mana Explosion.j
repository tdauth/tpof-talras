/// Wizard
library StructSpellsSpellManaExplosion requires Asl, StructGameClasses, StructGameSpell

	/// Entzieht einem Gegner bis zu X Mana, fügt ihm Schaden in doppelter Höhe zu und überträgt es auf den Zauberer.
	struct SpellManaExplosion extends Spell
		public static constant integer abilityId = 'A08H'
		public static constant integer favouriteAbilityId = 'A08P'
		public static constant integer classSelectionAbilityId = 'A1M9'
		public static constant integer classSelectionGrimoireAbilityId = 'A1MA'
		public static constant integer maxLevel = 5
		/// \todo Add buff.
		private static constant integer buffId = 0
		private static constant real manaStartValue = 40.0
		private static constant real manaLevelValue = 40.0

		private method condition takes nothing returns boolean
			local boolean result = GetUnitState(GetSpellTargetUnit(), UNIT_STATE_MAX_MANA) > 0
			if (not result) then
				call this.character().displayMessage(ACharacter.messageTypeError, tre("Ziel benötigt Mana.", "Target needs mana."))
			endif
			return result
		endmethod

		private method action takes nothing returns nothing
			local unit caster = this.character().unit()
			local unit target = GetSpellTargetUnit()
			local ADynamicLightning dynamicLightning = ADynamicLightning.create(null, "DRAM", caster, target)
			local effect casterEffect = AddSpellEffectTargetById(thistype.abilityId, EFFECT_TYPE_CASTER, caster, "chest")
			local effect targetEffect = AddSpellEffectTargetById(thistype.abilityId, EFFECT_TYPE_TARGET, caster, "chest")
			local real mana
			if (not AUnitSpell.enemyTargetLoopCondition(target)) then
				set mana = RMinBJ(thistype.manaStartValue + this.level() * thistype.manaLevelValue, GetUnitState(target, UNIT_STATE_MANA))
				call SetUnitState(target, UNIT_STATE_MANA, GetUnitState(target, UNIT_STATE_MANA) - mana)
				call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + mana)
				set mana = mana * 2
				call UnitDamageTargetBJ(caster, target, mana, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
				call ShowBashTextTagForPlayer(null, GetUnitX(target), GetUnitY(target), R2I(mana))
			endif
			set caster = null
			set target = null
			call dynamicLightning.destroy()
			call DestroyEffect(casterEffect)
			set casterEffect = null
			call DestroyEffect(targetEffect)
			set targetEffect = null
		endmethod

		public static method create takes Character character returns thistype
			local thistype this = thistype.createWithEvent(character, Classes.wizard(), Spell.spellTypeNormal, thistype.maxLevel, thistype.abilityId, thistype.favouriteAbilityId, 0, thistype.condition, thistype.action, EVENT_PLAYER_UNIT_SPELL_EFFECT) // if the event channel is used, the cooldown and mana costs are ignored if UnitDamageTargetBJ() kills the target
			call this.addGrimoireEntry('A1M9', 'A1MA')
			call this.addGrimoireEntry('A0AN', 'A0B2')
			call this.addGrimoireEntry('A0AO', 'A0B3')
			call this.addGrimoireEntry('A0AZ', 'A0B4')
			call this.addGrimoireEntry('A0B0', 'A0B5')
			call this.addGrimoireEntry('A0B1', 'A0B6')
			return this
		endmethod
	endstruct

endlibrary