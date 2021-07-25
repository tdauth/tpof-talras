/// Elemental Mage
library StructSpellsSpellMastery requires Asl, StructGameClasses, StructGameSpell

	/// Passiv. Der Elementarmagier regeneriert alle 60 Sekunden X Mana.
	struct SpellMastery extends Spell
		public static constant integer abilityId = 'A01F'
		public static constant integer favouriteAbilityId = 'A034'
		public static constant integer classSelectionAbilityId = 'A1MH'
		public static constant integer classSelectionGrimoireAbilityId = 'A1MI'
		public static constant integer maxLevel = 5
		private static constant real interval = 10.0 //constant, does not change per level.
		private static constant real manaLevelValue = 0.05 //changes per level.
		private static sound whichSound
		private timer m_effectTimer

		private static method timerFunction takes nothing returns nothing
			local timer expiredTimer = GetExpiredTimer()
			local thistype this = DmdfHashTable.global().handleInteger(expiredTimer, 0)
			local unit caster = null
			local real mana = 0.0
			local effect spellEffect = null
			if (this.level() > 0) then
				set caster = this.character().unit()
				if (GetUnitState(caster, UNIT_STATE_MANA) < GetUnitState(caster, UNIT_STATE_MAX_MANA)) then
					set mana = GetUnitState(caster, UNIT_STATE_MAX_MANA) * this.level() * thistype.manaLevelValue
					if (mana > 0) then
						call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + mana)
						if (not IsUnitHidden(caster)) then
							call PlaySoundOnUnitBJ(thistype.whichSound, 40.0, caster)
							set spellEffect = AddSpellEffectTargetById(thistype.abilityId, EFFECT_TYPE_TARGET, caster, "chest")
							call Spell.showManaTextTag(caster, mana)
							call DestroyEffect(spellEffect)
							set spellEffect = null
						endif
					endif
				endif
				set caster = null
			endif
			set expiredTimer = null
		endmethod

		public static method create takes Character character returns thistype
			local thistype this = thistype.createWithoutTriggers(character, Classes.elementalMage(), Spell.spellTypeNormal, thistype.maxLevel, thistype.abilityId, thistype.favouriteAbilityId)
			set this.m_effectTimer = CreateTimer()
			call TimerStart(this.m_effectTimer, thistype.interval, true, function thistype.timerFunction)
			call DmdfHashTable.global().setHandleInteger(this.m_effectTimer, 0, this)
			call this.addGrimoireEntry('A1MH', 'A1MI')
			call this.addGrimoireEntry('A11I', 'A11N')
			call this.addGrimoireEntry('A11J', 'A11O')
			call this.addGrimoireEntry('A11K', 'A11P')
			call this.addGrimoireEntry('A11L', 'A11Q')
			call this.addGrimoireEntry('A11M', 'A11R')

			call this.setIsPassive(true)

			return this
		endmethod

		public method onDestroy takes nothing returns nothing
			call PauseTimer(this.m_effectTimer)
			call DmdfHashTable.global().destroyTimer(this.m_effectTimer)
			set this.m_effectTimer = null
		endmethod

		private static method onInit takes nothing returns nothing
			set thistype.whichSound = CreateSound("Abilities\\Spells\\Items\\AIma\\ManaPotion.wav", false, false, true, 12700, 12700, "")
		endmethod
	endstruct

endlibrary