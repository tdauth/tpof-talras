library StructMapVideosVideoRecruitTheHighElf requires Asl, StructGameGame, StructMapQuestsQuestWar

	struct VideoRecruitTheHighElf extends AVideo
		private integer m_actorDragonSlayer
		private integer m_actorWorker
		private integer m_actorManfred
		// Place Manfred's dog. Otherwise he might block the way to the high elf.
		private integer m_actorManfredsDog
		private integer m_actorGuntrich
		private integer m_actorHeimrich
		private integer m_actorMarkward
		private integer m_actorFerdinand

		public stub method onInitAction takes nothing returns nothing
			call Game.initVideoSettings(this)
			call SetTimeOfDay(12.0)
			// TODO Music

			set this.m_actorDragonSlayer = this.saveUnitActor(Npcs.dragonSlayer())
			call SetUnitPositionRect(this.unitActor(this.m_actorDragonSlayer), gg_rct_video_recruit_the_high_elf_dragon_slayer)

			call SetUnitPositionRect(this.actor(), gg_rct_video_recruit_the_high_elf_character)

			call SetUnitFacingToFaceUnit(this.actor(), this.unitActor(this.m_actorDragonSlayer))
			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorDragonSlayer), this.actor())

			set this.m_actorWorker = this.saveUnitActor(gg_unit_n02J_0159)
			call SetUnitPositionRect(this.unitActor(this.m_actorWorker), gg_rct_waypoint_menial_3)
			call SetUnitFacing(this.unitActor(this.m_actorWorker), 210.68)
			call SetUnitAnimation(this.unitActor(this.m_actorWorker), "Stand Work")

			set this.m_actorManfred = this.saveUnitActor(Npcs.manfred())
			call SetUnitPositionRect(this.unitActor(this.m_actorManfred), gg_rct_video_recruit_the_high_elf_manfred)

			set this.m_actorManfredsDog = this.saveUnitActor(Npcs.manfredsDog())
			call SetUnitPositionRect(this.unitActor(this.m_actorManfredsDog), gg_rct_video_recruit_the_high_elf_manfreds_dog)

			set this.m_actorGuntrich = this.saveUnitActor(Npcs.guntrich())
			call SetUnitPositionRect(this.unitActor(this.m_actorGuntrich), gg_rct_video_recruit_the_high_elf_guntrich)

			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorManfred), this.unitActor(this.m_actorGuntrich))
			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorManfredsDog), this.unitActor(this.m_actorGuntrich))
			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorGuntrich), this.unitActor(this.m_actorManfred))

			set this.m_actorHeimrich = this.saveUnitActor(Npcs.heimrich())
			call SetUnitPositionRect(this.unitActor(this.m_actorHeimrich), gg_rct_video_recruit_the_high_elf_heimrich)

			set this.m_actorMarkward = this.saveUnitActor(Npcs.markward())
			call SetUnitPositionRect(this.unitActor(this.m_actorMarkward), gg_rct_video_recruit_the_high_elf_markward)

			set this.m_actorFerdinand = this.saveUnitActor(Npcs.ferdinand())
			call SetUnitPositionRect(this.unitActor(this.m_actorFerdinand), gg_rct_video_recruit_the_high_elf_ferdinand)

			call CameraSetupApplyForceDuration(gg_cam_recruit_the_high_elf_initial_view, true, 0.0)

			call IssueRectOrder(this.actor(), "move", gg_rct_video_recruit_the_high_elf_character_target)
		endmethod

		public stub method onPlayAction takes nothing returns nothing
			call FixVideoCamera(gg_cam_recruit_the_high_elf_initial_view)

			loop
				exitwhen (RectContainsUnit(gg_rct_video_recruit_the_high_elf_character_target,  this.actor()))
				if (wait(1.0)) then
					return
				endif
			endloop

			call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 2.0, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 100.00, 100.00, 100.00, 0.0)
			call TriggerSleepAction(2.50)
			call CameraSetupApplyForceDuration(gg_cam_recruit_the_high_elf_talk_view, true, 0.0)
			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorDragonSlayer), this.actor()) // update facing
			call SetUnitFacingToFaceUnit(this.actor(), this.unitActor(this.m_actorDragonSlayer))
			call TriggerSleepAction(0.50)
			call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 2.0, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 100.00, 100.00, 100.00, 0.0)


			if (wait(2.5)) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Sieh an, wie schnell wir uns wieder sehen. Was habt Ihr mir zu berichten, Mensch? Habt Ihr etwa schon wieder eine Heldentat vollbracht?", "Look how quickly we meet again. What do you have to tell me, man? Have you already done a heroic act again?"), gg_snd_DragonSlayerRecruitTheHighElf1)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf1))) then
				return
			endif

			call TransmissionFromUnit(this.actor(), tre("Der Herzog ben??tigt eure Hilfe.", "The duke needs your help."), null)

			if (wait(GetSimpleTransmissionDuration(null))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Der Herzog Heimrich von Talras? Meine Hilfe? Wie kommt er zu diesem Schluss? Er kennt weder mich noch meine Absichten.", "The duke Heimrich of Talras? My help? How does he come to this conclusion? He neither knows me nor my intentions."), gg_snd_DragonSlayerRecruitTheHighElf2)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf2))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Habt Ihr ihm bereits von unserer Metzelei berichtet und will er mich nun vorladen, damit ich Rechenschaft ablege?", "Have you already told him of our massacre and does he want to summon me now to account?"), gg_snd_DragonSlayerRecruitTheHighElf3)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf3))) then
				return
			endif

			call CameraSetupApplyForceDuration(gg_cam_recruit_the_high_elf_character_view, true, 0.0)

			if (wait(1.0)) then
				return
			endif

			call TransmissionFromUnit(this.actor(), tre("Nein, nichts davon. Er braucht mehr Verb??ndete im Kampf gegen die Orks und Dunkelelfen. Der K??nig schickt ihm keine Hilfe.", "No, nothing of it. He needs more allies in the fight against the Orcs and Dark Elves. The king does not help him."), null)

			if (wait(GetSimpleTransmissionDuration(null))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Der K??nig? Das sieht ihm ??hnlich. Dararos, der K??nig der Hochelfen bestimmt praktisch ??ber dieses K??nigreich Mittillant.", "The king? This fits to him. Dararos, the king of the High Elves, practically decides what happens in this kingdom Mittillant."), gg_snd_DragonSlayerRecruitTheHighElf4)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf4))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Er behandelt es als w??re es eine seiner zahlreichen Provinzen. Der K??nig der Menschen ist schwach. Er wei?? nicht wie er auf einen bevorstehenden Krieg reagieren soll.", "He treats it if it were one of his numerous provinces. The king of men is weak. He does not know how to react to an imminent war."), gg_snd_DragonSlayerRecruitTheHighElf5)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf5))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Doch wie sollte ich dem Herzog von Nutzen sein. Mein Auftrag ist erf??llt und bald kehre ich in unsere Hauptstadt zur??ck und erstatte K??nig Dararos Bericht.", "But how should I benefit the duke? My commission is fulfilled and soon I return to our capital and report to king Dararos."), gg_snd_DragonSlayerRecruitTheHighElf6)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf6))) then
				return
			endif

			call TransmissionFromUnit(this.actor(), tre("Heimrich f??rchtet den baldigen Einmarsch der Orks und Dunkelelfen. Wenn sein K??nig ihm keine Unterst??tzung schickt, wird Talras bald in der Hand des Feindes sein.", "Heimrich fears the early arrival of the Orcs and Dark Elves. If his king does not give him any support, Talras will soon be in the hands of the enemy."), null)

			if (wait(GetSimpleTransmissionDuration(null))) then
				return
			endif

			call TransmissionFromUnit(this.actor(), tre("K??nnt ihr nicht Unterst??tzung von eurer Heimat fordern?", "Can't yo uask for support from your homeland?"), null)

			if (wait(GetSimpleTransmissionDuration(null))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("In der Tat. Diese Burg w??rde einem ganzen Heer nicht lange Stand halten. Die Menschen hier sind freundlich zu mir. Es w??rde mir ganz und gar missfallen sie im Stich zu lassen.", "Indeed. This castle would not last long to a whole army. The people here are friendly to me. It wouldn't be alright to let them down."), gg_snd_DragonSlayerRecruitTheHighElf7)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf7))) then
				return
			endif

			call CameraSetupApplyForceDuration(gg_cam_recruit_the_high_elf_from_behind, true, 0.0)

			if (wait(1.0)) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Ich selbst habe jedoch keinen gro??en Einfluss auf meinen K??nig, genauso wenig wie Heimrich auf den seinen. Was ich euch anbieten kann ist jedoch meine eigene Hilfe hier und jetzt.", "But I myself don't have great influence on my king, nor does Heimrich has on his own. What I can offer you, however, is my own help here and now."), gg_snd_DragonSlayerRecruitTheHighElf8)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf8))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Auch kann ich zumindest versuchen in meiner Heimat Hilfe zu ersuchen. Ihr habt mir geholfen Deranor den Schrecklichen zu besiegen! Ihr solltet in meiner Heimat als Helden gefeiert werden.", "I can also try to get help in my homeland. You helped me to defeat Deranor the Terrible! You should be celebrated in my homeland as heroes."), gg_snd_DragonSlayerRecruitTheHighElf9)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf9))) then
				return
			endif

			call TransmissionFromUnit(this.actor(), tre("So kommt mit zum Herzog und erz??hlt ihm davon!", "So come to the duke and tell him about it!"), null)

			if (wait(GetSimpleTransmissionDuration(null))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Nun gut, lasst uns keine Zeit mehr verlieren.", "WEll, let's not waste any more time."), null)

			if (wait(GetSimpleTransmissionDuration(null))) then
				return
			endif

			call CinematicFadeBJ(bj_CINEFADETYPE_FADEOUT, 2.0, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 100.00, 100.00, 100.00, 0.0)
			call TriggerSleepAction(2.50)
			call CameraSetupApplyForceDuration(gg_cam_recruit_the_high_elf_castle_view, true, 0.0)
			call SetUnitX(this.actor(), GetRectCenterX(gg_rct_video_recruit_the_high_elf_character_in_castle))
			call SetUnitY(this.actor(), GetRectCenterY(gg_rct_video_recruit_the_high_elf_character_in_castle))

			call SetUnitX(this.unitActor(this.m_actorDragonSlayer), GetRectCenterX(gg_rct_video_recruit_the_high_elf_dragon_slayer_in_castle))
			call SetUnitY(this.unitActor(this.m_actorDragonSlayer), GetRectCenterY(gg_rct_video_recruit_the_high_elf_dragon_slayer_in_castle))

			call SetUnitFacingToFaceUnit(this.actor(), this.unitActor(this.m_actorHeimrich))
			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorDragonSlayer), this.unitActor(this.m_actorHeimrich))

			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorHeimrich), this.unitActor(this.m_actorDragonSlayer))
			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorMarkward), this.unitActor(this.m_actorDragonSlayer))
			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorFerdinand), this.unitActor(this.m_actorDragonSlayer))

			call TriggerSleepAction(0.50)
			call CinematicFadeBJ(bj_CINEFADETYPE_FADEIN, 2.0, "ReplaceableTextures\\CameraMasks\\Black_mask.blp", 100.00, 100.00, 100.00, 0.0)


			if (wait(2.5)) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorHeimrich), tre("Ich gr????e Euch Hochelfin, seid willkommen in meiner Burg Talras.", "I greet you High Elf, welcome to my castle Talras."), gg_snd_Heimrich20)

			if (wait(GetSimpleTransmissionDuration(gg_snd_Heimrich20))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Habt Dank werter Herzog. Es ist mir eine Ehre.", "Thank yo dear duke. I'm honoured."), gg_snd_DragonSlayerRecruitTheHighElf10)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf10))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorHeimrich), tre("Ich hoffe sie denkt nichts Falsches von uns. Keineswegs wollen wir sie ausnutzen, doch bleibt uns in dieser schwierigen Zeit nichts anderes mehr ??brig.", "I hope she does not think anything wrong. We do not want to take advantage of her, but in this difficult time nothing else remains for us."), gg_snd_Heimrich21)

			if (wait(GetSimpleTransmissionDuration(gg_snd_Heimrich21))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorDragonSlayer), tre("Ich verstehe Eure Lage durchaus. Noch heute werde ich ein Schreiben an meine Heimat verfassen und um Hilfe bitten. Eure Gef??hrten hier haben mir treue Dienste erwiesen. Nie w??rde ich ihnen einen Wunsch verwehren.", "I understand your situation. Just today, I will write a letter to my homeland and ask for help. Your companions here have shown me faithful service. I would never deny them a wish."), gg_snd_DragonSlayerRecruitTheHighElf11)

			if (wait(GetSimpleTransmissionDuration(gg_snd_DragonSlayerRecruitTheHighElf11))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorHeimrich), tre("Nun gut, habt Dank! Ritter Markward wird alles weitere mit ihr besprechen.", "Well, thanks! Knight Markward will discuss everything else with her."), gg_snd_Heimrich22)

			if (wait(GetSimpleTransmissionDuration(gg_snd_Heimrich22))) then
				return
			endif

			call IssueRectOrder(this.unitActor(this.m_actorHeimrich), "move", gg_rct_video_recruit_the_high_elf_heimrich_target)

			if (wait(2.0)) then
				return
			endif

			call CameraSetupApplyForceDuration(gg_cam_recruit_the_high_elf_character_view_castle, true, 0.0)

			if (wait(1.0)) then
				return
			endif

			// TODO check if the actor is morphed
			call SetUnitAnimationByIndex(this.actor(), 4)

			if (wait(4.5)) then
				return
			endif

			call SetUnitFacingToFaceUnit(this.actor(), this.unitActor(this.m_actorMarkward))
			call SetUnitFacingToFaceUnit(this.unitActor(this.m_actorDragonSlayer), this.unitActor(this.m_actorMarkward))
			call CameraSetupApplyForceDuration(gg_cam_recruit_the_high_elf_castle_view, true, 0.0)

			if (wait(2.0)) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorMarkward), tre("Wir haben mit Hilfe der Nordm??nner das Lager der Orks und Dunkelelfen besetzt. Sogar Dorfbewohner haben sich kampfbereit gemacht um auf eigene Faust gegen die Feinde vorzugehen.", "We have occupied the camp of the Orcs and Dark Elves with the help of the Northmen. Even villagers have made themselves ready to attack the enemy on their own."), gg_snd_Markward39)

			if (wait(GetSimpleTransmissionDuration(gg_snd_Markward39))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorMarkward), tre("Wir m??ssen den Kampfgeist der M??nner und die Gunst der Stunde nutzen bevor es zu sp??t ist.", "We must use the fighting spirit of the men and the favor of the hour before it is too late."), gg_snd_Markward40)

			if (wait(GetSimpleTransmissionDuration(gg_snd_Markward40))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorMarkward), tre("Unser Plan sieht vor das eroberte Lager zu befestigen und einen starken Vorposten zu errichten, der die Feinde solange wie m??glich aufhalten wird.", "Our plan is to secure the conquered camp and build a strong outpost, which will stop the enemy as long as possible."), gg_snd_Markward41)

			if (wait(GetSimpleTransmissionDuration(gg_snd_Markward41))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorMarkward), tre("Zun??chst m??sst ihr dazu das Lager mit Waffen, Nahrung und Holz versorgen. Danach sollten Fallen vor den Mauern aufgestellt werden. Au??erdem m??ssen mehr kriegstaugliche Leute auf dem Bauernhof rekrutiert werden.", "First of all you have to provide the camp with weapons, food and wood. After this, traps should be placed in the front of the walls. In addition, more warlike people must be recruited from the farm."), gg_snd_Markward42)

			if (wait(GetSimpleTransmissionDuration(gg_snd_Markward42))) then
				return
			endif

			call TransmissionFromUnit(this.unitActor(this.m_actorMarkward), tre("Selbstverst??ndlich wird der Herzog euch f??r eure Dienste wieder entsprechend entlohnen. Viel Gl??ck!", "Of course the duke will reward you for your services. Good luck!"), gg_snd_Markward43)

			if (wait(GetSimpleTransmissionDuration(gg_snd_Markward43))) then
				return
			endif

			call this.stop()
		endmethod

		public stub method onStopAction takes nothing returns nothing
			call Game.resetVideoSettings()
			call QuestWar.quest().enable()
		endmethod

		private static method create takes nothing returns thistype
			local thistype this = thistype.allocate(true)
			call this.setActorOwner(MapSettings.neutralPassivePlayer())

			return this
		endmethod

		implement Video
	endstruct

endlibrary
