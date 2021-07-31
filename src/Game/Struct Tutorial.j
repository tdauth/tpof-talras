library StructGameTutorial requires Asl, StructGameCharacter, StructGameGame, StructGameSpawnPoint

	/**
	 * \brief Provides some functionality which helps players to find their way through the game.
	 * It shows a message when a players character enables a shrine the first time.
	 * Usually there's one Tutorial instance per character which can be accessed via \ref Character#tutorial().
	 * All provided infos can be disabled via \ref setEnabled().
	 */
	struct Tutorial
		// dynamic members
		private boolean m_isEnabled
		// construction members
		private Character m_character
		// members
		private boolean m_hasEnteredShrine
		private trigger m_killTrigger

		public method setEnabled takes boolean enabled returns nothing
			set this.m_isEnabled = enabled
		endmethod

		public method isEnabled takes nothing returns boolean
			return this.m_isEnabled
		endmethod

		public method character takes nothing returns Character
			return this.m_character
		endmethod

		public method hasEnteredShrine takes nothing returns boolean
			return this.m_hasEnteredShrine
		endmethod

		public method showShrineInfo takes nothing returns nothing
			call this.m_character.displayHint(Format(tre("Schreine dienen der Wiederbelebung Ihres Charakters. Sobald Ihr Charakter stirbt, wird er nach einer Dauer von %1% Sekunden an seinem aktivierten Schrein wiederbelebt. Es kann immer nur ein Schrein aktiviert sein. Ein Schrein wird aktiviert, indem der Charakter dessen näheres Umfeld betritt. Dabei wird der zuvor aktivierte Schrein automatisch deaktiviert.", "Shrines serve the revival of your character. As soon as your character dies he will be revived automatically after a duration of %1% seconds at his enabled shrine. There can only be one shrine activated at once. A shrine is being activated when the character enters its near surroundings. Here, the previously activated shrine is disabled automatically.")).i(R2I(MapSettings.revivalTime())).result())
			set this.m_hasEnteredShrine = true
		endmethod

		private static method triggerConditionKill takes nothing returns boolean
			local thistype this = DmdfHashTable.global().handleInteger(GetTriggeringTrigger(), 0)
			return GetKillingUnit() == this.character().unit() and this.isEnabled() and MapSettings.playerGivesXP(GetOwningPlayer(GetTriggerUnit())) and GameExperience.unitTypeIdGivesXp(GetUnitTypeId(GetTriggerUnit()))
		endmethod

		private static method triggerActionKill takes nothing returns nothing
			local thistype this = DmdfHashTable.global().handleInteger(GetTriggeringTrigger(), 0)
			call DisableTrigger(GetTriggeringTrigger())
			call this.character().displayHint(tre("Immer wenn Ihr Charakter einen Unhold tötet, erhalten alle Charaktere gleichmäßig viel Erfahrung und Beute für diesen.", "Whenever your character kills a creep all characters gain equally much experience and bounty for him."))
			set this.m_killTrigger = null
			call DestroyTrigger(GetTriggeringTrigger())
		endmethod

		public static method create takes Character character returns thistype
			local thistype this = thistype.allocate()
			// dynamic members
			set this.m_isEnabled = false
			// construction members
			set this.m_character = character
			// members
			set this.m_hasEnteredShrine = false

			call this.setEnabled(false)

			/*
			 * This trigger shows information about XP and bounty share of killing enemies.
			 */
			if (not Game.restoreCharacters.evaluate()) then
				set this.m_killTrigger = CreateTrigger()
				call TriggerRegisterAnyUnitEventBJ(this.m_killTrigger, EVENT_PLAYER_UNIT_DEATH)
				call TriggerAddCondition(this.m_killTrigger, Condition(function thistype.triggerConditionKill))
				call TriggerAddAction(this.m_killTrigger, function thistype.triggerActionKill)
				call DmdfHashTable.global().setHandleInteger(this.m_killTrigger, 0, this)
			else
				set this.m_killTrigger = null
			endif

			return this
		endmethod

		public method onDestroy takes nothing returns nothing
			// members
			if (this.m_killTrigger != null) then
				call DmdfHashTable.global().destroyTrigger(this.m_killTrigger)
				set this.m_killTrigger = null
			endif
		endmethod

		private static method onInit takes nothing returns nothing
			local quest whichQuest = null
			local questitem questItem = null
			/*
			 * Hint quest entries:
			 */
			 set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Die Macht des Feuers", "The Power of Fire"))
			call QuestSetDescription(whichQuest, tre("Die Macht des Feuers ist eine Rollenspielmodifikation für Warcraft III: The Frozen Throne. Sie spielen einen einzelnen Charakter, erledigen Aufträge, töten Unholde und versuchen die gemeinsamen Aufträge zu absolvieren, um das Spiel erfolgreich zu beenden. Die Modifikation kann sowohl im Einzel- als auch im Mehrspieler gespielt werden. Andere Spieler benötigen dabei jedoch ebenfalls die Modifikation auf ihrem Computer.", "The Power of Fire is a roleplay game modification for Warcraft III: The Frozen Throne. You play a single character, complete missions, kill creeps and try to solve the shared missions to end the game successfully. The modification can be played in singleplayer as well as in multiplayer. For that other players require the modification as well on their computer."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNFire.blp")

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Optionen", "Options"))
			call QuestSetDescription(whichQuest, tre("Das Ausrufezeichen in der linken oberen Ecke erlaubt Ihnen, in die Optionen zu gelangen. Hier können diverse Einstellungen vorgenommen werden.", "The exclamation mark in the left top corner allows you to get to the options. Here you can make different settings."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNTalktoMe.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Das Untermenü \"Aufträge\" erlaubt die Auswahl der Zielpunkte von Aufträgen.", "The submenu \"Missions\" allows the selection of target points of missions."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Das Untermenü \"Dungeons\" erlaubt die Kameraansicht eines Dungeons.", "The submenu \"Dungeons\" allows you to view a dungeon."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Das Untermenü \"Kamera\" erlaubt das Ändern der Kameraansicht.", "The submenu \"Camera\" allows changing the camera view."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Chat-Befehle", "Chat Commands"))
			call QuestSetDescription(whichQuest, tre("Die obigen Befehle können im Chat verwendet werden.", "The commands at the top can be used in the chat."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("\"-repick\" erlaubt die Wahl einer anderen Klasse.", "\"-repick\" allows the selection of a different class."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("\"-save\" erlaubt das Speichern des Charakters.", "\"-save\" allows the storage of the character."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("\"-load <Save-Code>\" erlaubt das Laden eines Charakters.", "\"-load <save code>\" allows the loading of a character."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("\"-history n\" zeigt die n letzten Spielnachrichten an (standardmäßig fünf).", "\"-history n\" shows the recent n game messages (by default five)."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("\"-clear\" leert den Bildschirm von Spielnachrichten.", "\"-clear\" clears the screen from game messages."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("\"-admin\" zeigt den Administrator an.", "\"-admin\" shows the admin."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Admin-Befehle", "Admin Commands"))
			call QuestSetDescription(whichQuest, tre("Spieler 1 ist der Administrator. Falls Spieler 1 nicht spielt, ist der nächste menschliche Spieler der Administrator. Der Administrator kann die obigen Befehle verwenden.", "Player 1 is the admin. If player 1 does not play the next human player is admin. The admin can use the commands above."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNControlMagic.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("\"-unlock\": Macht alle ausgewählten Charaktere wieder beweglich.", "\"-unlock\": Makes the selected character movable again."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("\"-kick <Spielername/Spielernummer>\": Kickt den Spieler aus dem Spiel.", "\"-kick <player name/player number>\": Kicks the player from the game."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Emotes", "Emotes"))
			call QuestSetDescription(whichQuest, tre("Emotes erlauben das Ausdrücken bestimmter Emotionen durch eine Animation Ihres Charakters.", "Emotes allow expressing certain emotions by an animation of your character."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-dance\"")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-pray\"")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-magic\"")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-jump\"")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-sleep\"")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-sport\"")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-victory\"")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-cross\"")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, "\"-surrender\"")

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Klassen", "Classes"))
			call QuestSetDescription(whichQuest, tre("Die Klasse Ihres Charakters muss zu Beginn des Spiels gewählt werden. Sie bestimmt, welche Zauber Ihr Charakter erlernen kann und welche Attributwerte Ihr Charakter besitzt. Außerdem hat die Klasse Einfluss auf Gespräche Ihres Charakters mit anderen Personen. Die Klasse kann dennoch mit \"-repick\" neu bestimmt werden.", "The class of your character has to be chosen in the beginning of the game. It defines which spells your character can learn and which attribute values your character has. Besides the class has influence on conversations of your character with other persons. However the class can be defined newly with \"-repick\"."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNVillagerMan.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Kleriker: Heil- und Schutzzauber", "Cleric: Healing and protection spells"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Nekromant: Beschwörungs- und Schadenszauber", "Necromancer: Summon and damage spells"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Druide: Heil- und Verwandlungszauber", "Druid: Healing and transformation spells"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Ritter: Auren und Kampfzauber", "Knight: Auras and combat spells"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Drachentöter: Kampf- und Beutezauber", "Dragon Slayer: Combat and bounty spells"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Waldläufer: Fernkampfzauber", "Ranger: Range combat spells"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Elementarmagier: Schadenszauber", "Elemental Mage: Damage spells"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Zauberer: Manazauber", "Wizard: Mana spells"))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Aufträge", "Missions"))
			call QuestSetDescription(whichQuest, tre("Aufträge im Spiel bestehen aus einem oder mehreren Zielen, die allesamt erfüllt werden müssen. Aufträge geben meist Belohnungen wie zusätzliche Erfahrungspunkte, Goldmünzen oder Gegenstände. Gemeinsame Aufträge müssen von allen Spielern gemeinsam erledigt werden, um die Handlung des Spiels voranzubringen. Eigene Aufträge können optional von jedem Spieler einzeln erledigt werden, um zusätzliche Belohnungen zu erhalten.", "Missions in the game consists of one or several objectives which has to be solved alltogether. Missions mostly give rewards like additional experience points, gold coins or items. Shared missions have to be solved by all players together to continue the plot of the game. Own missions can be solved optionally by each player to get additional rewards."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNSpellBookBLS.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("In den Spieloptionen links oben können im Untermenü \"Aufträge\" die Ziel-Orte von Aufträgen angezeigt werden.", "In the game options in the left top target locations of missions can be shown in the sub menu \"Missions\"."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Gemeinsame Aufträge müssen von allen Spielern gemeinsam erledigt werden.", "Shared missions must be completed together."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Eigene Aufträge kann jeder Spieler für sich selbst erledigen (optional).", "Custom missions can be solved by every player himself (optionally)."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Gegenstände", "Items"))
			call QuestSetDescription(whichQuest, tre("Gegenstände können vom Boden eingesammelt, von Läden gekauft, als Belohnung für einen Auftrag erhalten oder von einem anderen Charakter erhalten werden. Wird ein Gegenstand von einem Unhold für einen Spieler fallen gelassen, so gehört er diesem Spieler. Dies ist durch die Farbe des Gegenstandes gekennzeichnet. In diesem Fall kann nur der Charakter des Spielers den Gegenstand einsammeln.", "Items can be picked up from the ground, bought from stores, received as a reward for a mission or obtained from another character. If an item is dropped from a creep for a player, it belongs to this player. THis is indicated by the color of the item. In this case, only the character of the player can pick up the item."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Gegenstände können im Rucksack des Charakters verstaut werden.", "Items can be moved into the character's backpack."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Gegenstände können mit RM auf den Gegenstand und LM auf den Laden verkauft werden (alle Aufladungen).", "Items can be sold with RM and LM on the store (all charges)."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Manche Gegenstände können mit RM auf den Gegenstand und LM auf den selben Gegenstand ausgerüstet werden.", "Some items can be equipped with RM on the item and LM on the same item."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Wichtige Gegenstände für Aufträge können weder zerstört noch verkauft werden.", "Important items can neither be destroyed nor sold."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Ausrüstung", "Equipment"))
			call QuestSetDescription(whichQuest, tre("Es gibt fünf verschiede Ausrüstungstypen. Von jedem Typ bis auf Amulett/Ring kann genau ein Gegenstand angelegt werden. Es können bis zu zwei Amulette/Ringe getragen werden.", "There is five different equipment types. Of each type except amulet/ring exactly one item can be equipped. Up to two amulets/rings can be carried."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNHelmutPurple.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("RM auf Gegenstand und LM auf denselben Gegenstand verschiebt den Gegenstand in den Rucksack.", "RM on item and LM on the same item moves the item in the backpack."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Ausrüstungstypen: Helm, Rüstung, Erstwaffe, Zweitwaffe, Amulett/Ring.", "Equipment types: helmet, armour, primary weapon, secondary weapon, amulet/ring."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Rucksack", "Backpack"))
			call QuestSetDescription(whichQuest, tre("Mit der Rucksackfähigkeit kann der Rucksack geöffnet werden. Es werden vier Gegenstände pro Tasche angezeigt. Die angezeigte Tasche kann gewechselt werden, indem man auf einen der beiden Taschengegenstände klickt.", "With the backpack ability the backpack can be open. Four items per bag will be shown. The shown bag can be changed by clicking on one of the two bag items."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNINV_Misc_Bag_07.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("RM auf Gegenstand und LM auf denselben Gegenstand rüstet den Gegenstand aus.", "RM on item and LM on the same item equips the item."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("RM auf Gegenstand und LM auf anderen Gegenstand stapelt oder vertauscht die Gegenstände.", "RM on item and LM on another item stacks or swaps the items."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("RM auf Gegenstand und LM auf den Boden legt eine Ladung des Gegenstands ab.", "RM on item and LM on the ground drops one charge of the item."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("RM auf Gegenstand und LM auf anderen Charakter gibt dem anderen eine Ladung des Gegenstands.", "RM on item and LM on another character gives one charge of the item to the other."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("RM auf Gegenstand und LM auf das vierte dauerhaft freie Slot legt den Gegenstand mit allen Ladungen ab.", "RM on item and LM on the fourth permanently empty slot drops the item with all charges."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("RM auf Gegenstand und LM auf einen Taschengegenstand verschiebt den Gegenstand in eine andere Tasche.", "RM on item and LM on a bag item moves the item to another bag."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Wiederbelebungs-Schreine", "Revival Shrines"))
			call QuestSetDescription(whichQuest, Format(tre("Schreine dienen der Wiederbelebung des Charakters. Es kann immer nur ein Schrein aktiviert werden. An diesem Schrein wird der Charakter nach %1% Sekunden wiederbelebt, wenn er gestorben ist. Den aktiven Schrein erreicht man über das Symbol links unten oder mit F8. Zu allen erkundeten Schreinen kann sich der Charakter mit Hilfe der Spruchrolle des Totenreichs teleportieren.", "Shrines are for the revival of the character. There can only be one shrine activated all the time. At this shrine the character will be revived after %1% seconds when he died. The active shrine can be reached over the symbol at the left bottom or by F8. The character can teleport himself to all discovered shrines by using the Scroll of the Realm of the Dead.")).i(R2I(MapSettings.revivalTime())).result())
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNResStone.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Die magische Rune der Wiederbelebungsschreine ermöglicht den Teleport zu einem erkundeten Schrein.", "The Magical Rune of the Revival Shrines allows teleporting to a discovered shrine."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Der magische Stein der Ahnen ermöglicht den Teleport zu einem erkundeten Schrein mit Verbündeten.", "The Magical Stone of the Ancestors allows teleporting to a discovered shrine together with allies."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Gespräche mit Personen", "Conversations with Persons"))
			call QuestSetDescription(whichQuest, tre("Einige computergesteuerte Personen im Spiel bieten Gespräche an. Sie werden mit einer Sprechblase über ihrem Kopf markiert. Befindet sich der Charakter in der Nähe einer Person und ist der Charakter ausgewählt, so kann man mit einem Linksklick die entsprechende Person auswählen und mit einem Linksklick auf \"Person ansprechen\" ein Gespräch mit der Person beginnen. Einzelne Sätze können während des Gesprächs mit Escape übersprungen werden.", "Some Computer controlled persons in the game provide conversations. They are marked with a speech bubble over their head. Is a character near to a person and is the character selected you can select the corresponding person with a left click and start a conversation with the person by a left click on \"Speak to person\". Separate sentences can be skipped by Escape during the conversation."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNTalking2.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Einzelne Sätze können mit Escape übersprungen werden.", "Single sentences can be skipped with Escape."))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Ein Linksklick auf eine Person mit Sprechblase und auf \"Person ansprechen\" ermöglicht ein Gespräch.", "A left click on a person with a speech bubble and on \"Speak to Person\" makes a conversation possible."))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Händler", "Merchants"))
			call QuestSetDescription(whichQuest, tre("Einige der computergesteuerte Personen verkaufen Waren an einem Stand. Andere verkaufen Waren aus ihrer Kiste. An den Ständen und Kisten können eigene Gegenstände für ihren Wert in Goldmünzen verkauft werden. Dazu muss ein Gegenstand mit einem Rechtsklick ausgewählt und mit einem Linksklick auf dem entsprechenden Stand oder der entsprechenden Kiste platziert werden.", "Some Computer controlled persons sell goods at a stall. Others sell goods from their box. At stalls and boxes own items can be selled for their value in gold coins. For this an item must be selected with a right click and be placed with a left click on the corresponding stall or the corresponding box."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNMerchant.blp")

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Erfahrung", "Experience"))
			call QuestSetDescription(whichQuest, Format(tre("Die maximale Stufe ist %1%. Auf Stufe %2% und Stufe %3% kann jeweils eine Ultimate-Fähigkeit erlernt werden. Erfahrung vom Töten von Unholden wird gleichmäßig auf alle Charaktere in der gesamten Karte verteilt. Aufträge geben weitaus mehr Erfahrung als das Töten von Unholden.", "The maximum level is %1%. At level %2% and level %3% each there can be learned an ultimate ability. Experience from killing of creeps will be distributed equally to the characters in the whole map. Quests give much more experience than the killing of creeps.")).i(MapSettings.maxLevel()).i(Grimoire.ultimate0Level).i(Grimoire.ultimate1Level).result())
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNStatUp.blp")

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Goldmünzen", "Gold Coins"))
			call QuestSetDescription(whichQuest, tre("Goldmünzen erhält man für Aufträge und das Töten von Unholden. Die Goldmünzen durch das Töten von Unholden werden gleichmäßig an alle Charaktere auf der gesamten Karte verteilt. Aufträge geben weitaus mehr Goldmünzen als das Töten von Unholden.", "Gold coins are gained for quests and the killing of creeps. The gold coins gained by the killing of creeps will be distributed equally to all characters on the whole map. Quests give much more gold coins than the killing of creeps."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Goldmünzen für Unholde: Unholdstufe * 2", "Gold coins for creeps: Creep level"))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Zauber", "Spells"))
			call QuestSetDescription(whichQuest, tre("Jede Klasse besitzt 15 verschiedene Zauber sowie die Fähigkeit \"Attribut-Bonus\". Diese können im Einheitenmenü \"Zauber erlernen\" des Charakters erlernt werden. Einen Grundzauber dessen Stufe stets eins ist und der von Anfang erlernt wurde. Zwei Ultimativ-Zauber mit einer Stufe, die auf Stufe 12 und auf Stufe 25 erlernt werden können und zwölf gewöhnliche Zauber mit jeweils fünf Stufen. Das Erhöhen der Stufe eines Zaubers kostet einen Zauberpunkt. Pro Stufe erhält ein Charakter zwei Zauberpunkte. Er startet jedoch mit bereits drei Zauberpunkten. Zauberstufen können jederzeit wieder zurückgesetzt werden.", "Each class has 15 different spells as well as the ability \"Attribute Bonus\". They can be learned in the unit menu \"Learn spells\" of the character. One basic spell of which the level is always one and which is learned from the beginning. Two ultimate spells with one level which can be learned at level 12 and level 25 and twelve usual spells with five levels each. Increasing the level of a spell costs one skill point. Per level a character gains two skill points. Yet he starts with already three skill points. Spell levels can be always be reset."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNSpellBook.blp")

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Berufe", "Professions"))
			call QuestSetDescription(whichQuest, tre("Um bestimmte Gegenstände herzustellen, können Bücher mit Rezepten oder Plänen erworben werden. Darin befindet sich eine Liste der herstellbaren Gegenstände. Jeder Gegenstand benötigt Rohstoffe, die sich im Rucksack befinden müssen, damit der Gegenstand hergestellt werden kann.", "To craft specific items books with receipts or plans can be acquired. They contain a list of craftable items. Each item requires resources which has to be in the backpack that the item can be crafted."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNSpellBookBLS.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Buch der Tränke", "Book of Potions"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Buch der Schmiedekunst", "Book of Forging"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Buch der Magie", "Book of Magic"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Buch der Jagd", "Book of Hunting"))
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, tre("Buch der Dämonologie", "Book of Demonology"))

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Stützpunkte", "Bases"))
			call QuestSetDescription(whichQuest, tre("Jeder Spieler kann einen einzigen Stützpunkt errichten. Der Stützpunkt ist ein Gebäude, das abhängig von der Klasse des Spielercharakters ist. Um einen Stützpunkt zu errichten, muss ein entsprechender Bauplan bei einem Baumeister gekauft werden.", "Each player can construct one single base. The base is a building which is dependant on the class of the player character. To construct a base a corresponding construction plan has to be purchased from a builder."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNTinyCastle.blp")
			set questItem = QuestCreateItem(whichQuest)
			call QuestItemSetDescription(questItem, Format(tre("Benötigte Stufe für einen Stützpunkt: %1%", "Required level for a base: %1%")).i(Buildings.requiredLevel).result())

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Mitwirkende", "Credits"))
			call QuestSetDescription(whichQuest, tre("Gehen Sie in die Optionen links oben und klicken Sie auf \"Mitwirkende\".", "Go to the options in the top left and click on \"Credits\"."))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNBerserk.blp")

			set whichQuest = CreateQuest()
			call QuestSetTitle(whichQuest, tre("Kontakt", "Contact"))
			call QuestSetDescription(whichQuest, tre("Hive: https://www.hiveworkshop.com/threads/the-power-of-fire-talras-1-0.334326\nWebsite: https://github.com/tdauth/tpof-talras", "Hive: https://www.hiveworkshop.com/threads/the-power-of-fire-talras-1-0.334326\nWebsite: https://github.com/tdauth/tpof-talras"))
			call QuestSetIconPath(whichQuest, "ReplaceableTextures\\CommandButtons\\BTNPossession.blp")

		endmethod

		/**
		 * Prints a hint message to all players which have the tip system enabled.
		 * \param tip The tip message which is printed on the screen.
		 */
		public static method printTip takes string tip returns nothing
			local Character character = 0
			local integer i = 0
			loop
				exitwhen (i == MapSettings.maxPlayers())
				set character = Character(Character.playerCharacter(Player(i)))
				if (character.tutorial().isEnabled()) then
					call character.displayHint(tip)
				endif
				set i = i + 1
			endloop
		endmethod
	endstruct

endlibrary