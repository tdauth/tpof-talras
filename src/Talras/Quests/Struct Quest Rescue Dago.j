library StructMapQuestsQuestRescueDago requires Asl, StructMapMapFellows, StructMapMapNpcs, StructMapTalksTalkDago

	struct QuestAreaRescueDago extends QuestArea

		public stub method onStart takes nothing returns nothing
			local integer i
			call VideoRescueDago0.video.evaluate().play()
			call waitForVideo(Game.videoWaitInterval)
			call QuestRescueDago.quest.evaluate().enable.evaluate()
			set i = 0
			loop
				exitwhen (i == MapSettings.maxPlayers())
				call SmartCameraPanWithZForPlayer(Player(i), GetRectCenterX(gg_rct_quest_rescue_dago_camera_view), GetRectCenterY(gg_rct_quest_rescue_dago_camera_view), 0.0, 0.0)
				set i = i + 1
			endloop
		endmethod

		public static method create takes rect whichRect returns thistype
			return thistype.allocate(whichRect, true)
		endmethod
	endstruct

	struct QuestRescueDago extends SharedQuest
		private static constant real rectRange = 500.0
		private timer m_timer
		private QuestAreaRescueDago m_questArea
		private real m_dagosMoveSpeed = 0.0

		public stub method enable takes nothing returns boolean
			return super.enableUntil(1)
		endmethod

		private method stateEventFailed takes trigger whichTrigger returns nothing
			call TriggerRegisterUnitEvent(whichTrigger, Npcs.dago(), EVENT_UNIT_DEATH)
		endmethod

		private method stateActionFailed takes nothing returns nothing
			call Fellows.dago().reset() // prevent the hero icon from being permanently shown
			call Fellows.dago().destroy()
			call ACharacter.displayMessageToAll(ACharacter.messageTypeError, tre("Dago wurde getötet!", "Dago has been killed!"))
			call this.displayState()
		endmethod

		private method stateActionCompleted takes nothing returns nothing
			call this.displayState()
		endmethod

		private static method stateEventCompleted0 takes AQuestItem questItem, trigger usedTrigger returns nothing
			call TriggerRegisterUnitEvent(usedTrigger, gg_unit_n008_0083, EVENT_UNIT_DEATH)
			call TriggerRegisterUnitEvent(usedTrigger, gg_unit_n008_0027, EVENT_UNIT_DEATH)
		endmethod

		private static method stateConditionCompleted0 takes AQuestItem questItem returns boolean
			return (GetTriggerUnit() == gg_unit_n008_0083 and IsUnitDeadBJ(gg_unit_n008_0027)) or (GetTriggerUnit() == gg_unit_n008_0027 and IsUnitDeadBJ(gg_unit_n008_0083))
		endmethod

		private static method timerFunctionMove takes nothing returns nothing
			if (GetUnitCurrentOrder(Npcs.dago()) != OrderId("move")) then
				if (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_0), GetRectCenterY(gg_rct_waypoint_dago_0), thistype.rectRange)) then
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_1), GetRectCenterY(gg_rct_waypoint_dago_1))
				elseif (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_1), GetRectCenterY(gg_rct_waypoint_dago_1), thistype.rectRange)) then
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_2), GetRectCenterY(gg_rct_waypoint_dago_2))
				elseif (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_2), GetRectCenterY(gg_rct_waypoint_dago_2), thistype.rectRange)) then
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_3), GetRectCenterY(gg_rct_waypoint_dago_3))
				elseif (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_3), GetRectCenterY(gg_rct_waypoint_dago_3), thistype.rectRange)) then
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_4), GetRectCenterY(gg_rct_waypoint_dago_4))
				else
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_0), GetRectCenterY(gg_rct_waypoint_dago_0))
				endif
			endif
		endmethod

		private static method stateActionCompleted0 takes AQuestItem questItem returns nothing
			local thistype this = thistype(questItem.quest())
			local integer i = 0
			call VideoRescueDago1.video.evaluate().play()
			call waitForVideo(Game.videoWaitInterval)
			// make sure dago starts at the correct position
			call SetUnitX(Npcs.dago(), GetRectCenterX(gg_rct_quest_rescue_dago_dagos_position))
			call SetUnitY(Npcs.dago(), GetRectCenterY(gg_rct_quest_rescue_dago_dagos_position))
			set i = 0
			loop
				exitwhen (i == MapSettings.maxPlayers())
				call SmartCameraPanWithZForPlayer(Player(i), GetRectCenterX(gg_rct_quest_rescue_dago_camera_view), GetRectCenterY(gg_rct_quest_rescue_dago_camera_view), 0.0, 0.0)
				call UnitShareVision(Npcs.dago(), Player(i), true)
				set i = i + 1
			endloop
			set this.m_dagosMoveSpeed = GetUnitMoveSpeed(Npcs.dago())
			call SetUnitMoveSpeed(Npcs.dago(), 180.0) // slow him down that the characters can easily follow him
			call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_0), GetRectCenterY(gg_rct_waypoint_dago_0))
			/*
			 * This timer makes sure that Dago keeps on moving even if he is blocked by units. Otherwise the quest will never be completed.
			 */
			call TimerStart(this.m_timer, 10.0, true, function thistype.timerFunctionMove)
			call questItem.quest().questItem(1).enable()
		endmethod

		private static method stateEventCompleted1 takes AQuestItem questItem, trigger usedTrigger returns nothing
			call TriggerRegisterEnterRectSimple(usedTrigger, gg_rct_waypoint_dago_0)
			call TriggerRegisterEnterRectSimple(usedTrigger, gg_rct_waypoint_dago_1)
			call TriggerRegisterEnterRectSimple(usedTrigger, gg_rct_waypoint_dago_2)
			call TriggerRegisterEnterRectSimple(usedTrigger, gg_rct_waypoint_dago_3)
			call TriggerRegisterEnterRectSimple(usedTrigger, gg_rct_waypoint_dago_4)
		endmethod

		private static method stateConditionCompleted1 takes AQuestItem questItem returns boolean
			local thistype this = thistype(questItem.quest())
			local unit enteringUnit = GetEnteringUnit()
			local integer i
			debug call Print("Checking Rescue Dago state condition!")
			if (enteringUnit == Npcs.dago()) then
				if (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_0), GetRectCenterY(gg_rct_waypoint_dago_0), thistype.rectRange)) then
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_1), GetRectCenterY(gg_rct_waypoint_dago_1))
				elseif (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_1), GetRectCenterY(gg_rct_waypoint_dago_1), thistype.rectRange)) then
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_2), GetRectCenterY(gg_rct_waypoint_dago_2))
				elseif (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_2), GetRectCenterY(gg_rct_waypoint_dago_2), thistype.rectRange)) then
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_3), GetRectCenterY(gg_rct_waypoint_dago_3))
					call TransmissionFromUnitWithName(Npcs.dago(), tre("Dago", "Dago"), tre("Wir sind fast da.", "We are almost there."), gg_snd_DagoRescueDago6)
				elseif (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_3), GetRectCenterY(gg_rct_waypoint_dago_3), thistype.rectRange)) then
					call IssuePointOrder(Npcs.dago(), "move", GetRectCenterX(gg_rct_waypoint_dago_4), GetRectCenterY(gg_rct_waypoint_dago_4))
				elseif (IsUnitInRangeXY(Npcs.dago(), GetRectCenterX(gg_rct_waypoint_dago_4), GetRectCenterY(gg_rct_waypoint_dago_4), thistype.rectRange)) then

					call SetUnitFacing(Npcs.dago(), 265.0)
					call SetUnitMoveSpeed(Npcs.dago(), this.m_dagosMoveSpeed)
					call TransmissionFromUnitWithName(Npcs.dago(), tre("Dago", "Dago"), tre("So, wenn ihr dem Weg folgt, kommt ihr zum Burgtor. Ich komme später nach, aber jetzt muss ich noch ein paar Pilze in der Umgebung sammeln. Für den Herzog versteht sich.", "Fine, if you follow the way you reach the castle's gate. I will join you later but now I have to collect some mushrooms in the area. For the duke of course."), gg_snd_DagoRescueDago7)
					call TalkDago.initTalk()
					call PauseTimer(this.m_timer)
					call DestroyTimer(this.m_timer)
					set this.m_timer = null

					set i = 0
					loop
						exitwhen (i == MapSettings.maxPlayers())
						call UnitShareVision(Npcs.dago(), Player(i), false)
						set i = i + 1
					endloop

					return true
				endif
			endif
			return false
		endmethod

		private static method create takes nothing returns thistype
			local thistype this = thistype.allocate(tre("Rettet Dago!", "Rescue Dago!"))
			local AQuestItem questItem = 0
			set this.m_timer = CreateTimer()
			call this.setIconPath("ReplaceableTextures\\CommandButtons\\BTNAttentaeter.tga")
			call this.setDescription(tre("Dago wird vor einer Höhle von zwei Bären angegriffen. Ihr müsst ihm zu Hilfe eilen.", "Dago is being attacked by two bears in front of a cage. You must help him."))

			call this.setStateEvent(thistype.stateFailed, thistype.stateEventFailed)
			call this.setStateAction(thistype.stateFailed, thistype.stateActionFailed)
			call this.setStateAction(thistype.stateCompleted, thistype.stateActionCompleted)
			// item 0
			set questItem = AQuestItem.create(this, tre("Helft Dago die Bären zu töten.", "Help Dago to kill the bears."))
			call questItem.setPing(true)
			call questItem.setPingUnit(Npcs.dago())
			call questItem.setPingColour(100.0, 100.0, 100.0)
			call questItem.setStateEvent(thistype.stateCompleted, thistype.stateEventCompleted0)
			call questItem.setStateCondition(thistype.stateCompleted, thistype.stateConditionCompleted0)
			call questItem.setStateAction(thistype.stateCompleted, thistype.stateActionCompleted0)
			// item 1
			set questItem = AQuestItem.create(this, tre("Folgt Dago zum Burgeingang.", "Follow Dago to the castle's gate."))
			call questItem.setPing(true)
			call questItem.setPingUnit(Npcs.dago())
			call questItem.setPingColour(100.0, 100.0, 100.0)
			call questItem.setStateEvent(thistype.stateCompleted, thistype.stateEventCompleted1)
			call questItem.setStateCondition(thistype.stateCompleted, thistype.stateConditionCompleted1)

			set this.m_questArea = QuestAreaRescueDago.create(gg_rct_quest_rescue_dago_enable)

			return this
		endmethod

		implement Quest
	endstruct

endlibrary