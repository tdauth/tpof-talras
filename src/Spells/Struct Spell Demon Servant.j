/// Necromancer
library StructSpellsSpellDemonServant requires Asl, StructGameClasses, StructGameSpell

	struct SpellDemonServant extends Spell
		public static constant integer abilityId = 'A1CZ'
		public static constant integer favouriteAbilityId = 'A037'
		public static constant integer classSelectionAbilityId = 'A1K7'
		public static constant integer classSelectionGrimoireAbilityId = 'A1K8'
		public static constant integer maxLevel = 5
		private trigger m_summonTrigger
		private unit m_servant /// There can only be one servant at once.

		private static method triggerConditionSummon takes nothing returns boolean
			local thistype this = DmdfHashTable.global().handleInteger(GetTriggeringTrigger(), 0)

			if (GetSummoningUnit() == this.character().unit() and (GetUnitTypeId(GetSummonedUnit()) == 'n00P' or GetUnitTypeId(GetSummonedUnit()) == 'n03S' or GetUnitTypeId(GetSummonedUnit()) == 'n03T' or GetUnitTypeId(GetSummonedUnit()) == 'n03U' or GetUnitTypeId(GetSummonedUnit()) == 'n03V')) then
				if (this.m_servant != null and not IsUnitDeadBJ(this.m_servant)) then
					call KillUnit(this.m_servant)
				endif

				set this.m_servant = GetSummonedUnit()
				debug call Print("New demon servant: " + GetUnitName(this.m_servant))
			endif

			return false
		endmethod

		public static method create takes Character character returns thistype
			local thistype this = thistype.createWithoutTriggers(character, Classes.necromancer(), Spell.spellTypeNormal, thistype.maxLevel, thistype.abilityId, thistype.favouriteAbilityId)
			call this.addGrimoireEntry('A1K7', 'A1K8')
			call this.addGrimoireEntry('A023', 'A0I2')
			call this.addGrimoireEntry('A0HY', 'A0I3')
			call this.addGrimoireEntry('A0HZ', 'A0I4')
			call this.addGrimoireEntry('A0I0', 'A0I5')
			call this.addGrimoireEntry('A0I1', 'A0I6')

			set this.m_summonTrigger = CreateTrigger()
			call TriggerRegisterAnyUnitEventBJ(this.m_summonTrigger, EVENT_PLAYER_UNIT_SUMMON)
			call TriggerAddCondition(this.m_summonTrigger, Condition(function thistype.triggerConditionSummon))
			call DmdfHashTable.global().setHandleInteger(this.m_summonTrigger, 0, this)

			return this
		endmethod

		public method onDestroy takes nothing returns nothing
			call DmdfHashTable.global().destroyTrigger(this.m_summonTrigger)
			set this.m_summonTrigger = null
		endmethod
	endstruct

endlibrary