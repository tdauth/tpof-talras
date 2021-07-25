/// No class
library StructSpellsSpellCowNova requires Asl, StructGameClasses, StructGameSpell

	struct SpellCowNova extends ASpell
		public static constant integer abilityId = 'A031'
		private static sound m_sound

		/// @todo Replace by static method, vJass bug.
		private static method alignAction takes unit usedUnit returns nothing
			local player owner = GetOwningPlayer(usedUnit)
			local integer i
			local AGroup targets = AGroup.create()
			call targets.addUnitsInRange(GetUnitX(usedUnit), GetUnitY(usedUnit), 600.0, null)
			// DAMAGE!!!!
			set i = 0
			loop
				exitwhen (i == targets.units().size())
				if (IsUnitEnemy(targets.units()[i], owner)) then
					call UnitDamageTargetBJ(usedUnit, targets.units()[i], 200.0, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL)
				endif
				set i = i + 1
			endloop
			call targets.destroy()
			// DAMAGE!!!!
			call ExplodeUnitBJ(usedUnit)
			set owner = null
		endmethod

		/// Erzeugt im Umkreis springende Kühe, die dumm sind.
		private method action takes nothing returns nothing
			local unit caster = this.character().unit()
			local player owner = GetOwningPlayer(caster)
			local unit cow
			local real i = 360.0
			loop
				exitwhen (i < 0.0)
				set cow = CreateUnit(owner, 'n000', GetUnitPolarProjectionX(caster, i, 300.0), GetUnitPolarProjectionY(caster, i, 300.0), i)
				call AJump.create(cow, 1100.0, GetUnitPolarProjectionX(caster, i, 600.0), GetUnitPolarProjectionY(caster, i, 600.0), thistype.alignAction, 100.0)
				call ShowGeneralFadingTextTagForPlayer(owner, tre("MUH!", "MOO!"), GetUnitX(cow), GetUnitY(cow), 255, 255, 255, 255)
				call PlaySoundOnUnitBJ(thistype.m_sound, 100.0, cow)
				set cow = null
				set i = i - 30.0
			endloop
			set caster = null
			set owner = null
		endmethod

		public static method create takes ACharacter character returns thistype
			return thistype.allocate(character, thistype.abilityId, 0, 0, thistype.action, EVENT_PLAYER_UNIT_SPELL_CHANNEL, false, true)
		endmethod

		private static method onInit takes nothing returns nothing
			set thistype.m_sound = CreateSound("Sound\\Spells\\CowNova\\Cow.wav", false, false, true, 12700, 12700, "")
			call SetSoundChannel(thistype.m_sound, GetHandleId(SOUND_VOLUMEGROUP_SPELLS))
		endmethod
	endstruct

endlibrary