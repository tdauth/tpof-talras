# The Power of Fire: Talras

Warcraft III: Reforged multiplayer funmap influenced by games like Diablo II and Gothic II combining hack and slay with dialog based decisions. 
This is a 6 player map in which you play together against the AI completing quests, leveling, buying items, looting stuff and end the game with a big final battle.
It contains cutscenes, voice acted dialogues and all basic RPG elements and systems.
It tries to capture a darker look like Gothic II and Diablo II and several elements of those games.
The lore has been written for this modification and Talras is the castle which you enter in the beginning.

## Play the Map

* [Discord Server](https://discord.gg/nNPg6SqdMy)
* [Official download on HiveWorkshop](https://www.hiveworkshop.com/threads/the-power-of-fire-talras-1-0.334326/)
* [Current development version](./talras1.0.w3x)

## Install German Voice Recordings

Read [the instructions](./Sound/README.md) on how to install the German voice recordings.

## Features

* 8 custom classes with different custom spells.
* Cutscenes.
* Great voice acting from German people ([HoerTalk.de](https://www.hoer-talk.de/threads/beendet-rollenspiel-mod-sucht-sprecher.22379/)).
* Dialogues with NPCs.
* 5 Professions which allow crafting items using materials from the map.
* Custom bases per player at hero level 30.
* NPC routines.
* NPC fellows with shared control.
* Automatic hero revival at revival shrines.
* Arena system with PvP support.
* Automatic creep respawns.
* Automatic item respawns.
* Fair bounty, XP and item distribution from creep kills and completing quests.
* AOS-like PvP area.
* Class repick.
* Equipment system with visible items, melee and range weapons.
* Backpack system with stacking items and without custom GUI which can be used during the battle.
* Up to 15 different spells at once.
* Custom skill system with 2 skill points per level and without custom GUI which can be used during the battle.
* Shop markers.
* Blood effects.
* Many custom quests which can be completed by every player once.
* Big coop battles.
* Big hidden dungeons.
* Automatic tree transparency to get a better view from above.
* Emotes with chat commands.
* German translation of dialogues.

## Upcoming Features

* Interiors.
* More content: quests, items, spells, creeps, dungeons.

## Videos

* [This is a more professional Let's Play by Faelon Stimmspiel](https://www.youtube.com/watch?v=uTruE__ia8A&list=PLiUdDzmlSLTQl7a16tASao2Z50EcwJx_G).
* [This Let's Play](https://www.youtube.com/watch?v=z1mLXBc3jRE&list=PLmfeGbBvSVGCRbNKSk3QOh1v09h6YFyxU) was made by me to test the whole modification once.
* [This list](https://www.youtube.com/watch?v=u5YKdMws0tQ&list=PLmfeGbBvSVGCDyp2bHGmHrhdJWN9TQLCn) contains many videos about the modification.
* There was [a presentation at the Ludification of Technology](https://www.youtube.com/watch?v=5hKgrxsNEKI&list=PLmfeGbBvSVGAtuvYlXykmbaPMaTIxkuRX) of the modification (see [slides](./doc/presentation.pdf)).

## Development Setup

The map's code is based on multiple vJass code files which are part of this repository.
You have to customize the import path in the custom map script:

```
//! import "C:\\Users\\XXX\\Documents\\Projekte\\dmdf\\src\\Import Dmdf.j"
//! import "C:\\Users\\XXX\\Documents\\Projekte\\dmdf\\src\\Talras/Import.j"
```

and save the map with vJass enabled.
Using the debug mode should enable multiple debugging messages.

### Custom Tilesets

[TalrasTerrainMapping.ods](./TalrasTerrainMapping.ods) contains some mappings from the original custom tileset textures.

### vJass

The code is written in vJass. During the development I made [a list of feature requests for vJass](./doc/vJass Suggestions.txt).

## History

This map is based on my Warcraft III: Frozen Throne modification [The Power of Fire](https://github.com/tdauth/dmdf) which completely alterated the game and could be played as multiplayer map or singleplayer campaign.
It was also released on the [ModDB](https://www.moddb.com/mods/warcraft-iii-the-power-of-fire) and presented to the German community.
I started translating it into English except for the voice acting.
Due to the changes from Warcraft III: Reforged I decided to publish the project as standalone multiplayer funmap.
Originally, this map ended and another map had to be started to continue the journey.
In the singleplayer campaign the hero was stored and restored and you could travel back just like in the Bonus Campaign from Warcraft III.
However, I prefer the multiplayer feature over a singleplayer campaign with map transitions.
Hence, I will try to improve this standalone map.

## Lore

There is lots of lore around the story.
One of the biggest is the German book [The Master](./doc/Planung/Hintergrunddefinition/Mythen/Bücher/Band%201%20-%20Der%20Meister.odt).
It contains a whole story about the Demon Lord Gardonar who is the master behind the attacks.
There is lots of other material in the [planning](./doc/Planung) folder mostly written in German.

## Credits

Core team:

* Baradé: Creator, idea, dialogues, terrain, quests, coding.
* Deranor: Terrain and testing.
* Jojo: Testing.
* Sardor: Models, classes, spells, balancing and other content.

Voice Actors:

* [HoerTalk.de](https://www.hoer-talk.de/threads/beendet-rollenspiel-mod-sucht-sprecher.22379/): Voice acting.
* Rainer: Narrator.
* Jan Langer: Dago
* jam: Wigberht
* jam: Baldar
* Dennis Prasetyo: Haldar
* Dennis Prasetyo: Ferdinand
* wer.n wilke: Ricman
* VitaLee: Haid
* Birgit Arnold: Sisgard
* Ian: Wieland
* Jenleo: Irmina
* Clemens Weichard: Heimrich
* Gunnar Isbrecht: Markward
* Zuli: Guntrich
* AnniGam: Ursula
* Avalarion: Schafshirte
* Kerstin R.: Dragon Slayer
* Jens: Kuno
* Stephanie Preis: Tanka
* Jan J. Münter: Carsten
* jonasclick: Lothar
* Heinrich-Stefan N.: Manfred
* Marco R.: Einar
* Benkenfilm: Trommon
* Benkenfilm: Brogo
* Benkenfilm: Deranor the Terrible
* Benkenfilm: Sisgard's Master
* Benkenfilm: Orc Leader
* Martin B.: Björn
* Daniel Spieker: Tobias
* Frank \"Waschbär\" Keiler: Osman
* Synchron: Tellborn
* Feluxus: Agihard
* Tania: Mathilda
* Alex: Fulco
* Alex: Dararos
* Ani: Mother
* Melianea: Gotlinde
* Eric: Wotan

Further support:

* WaterKnight: Tests
* Frotty: Models and Tests
* Clemens Weichard: Custom Let's Play

Music:

* Kevin MacLeod (incompetech.com): PippinTheHunchback

Tools and Systems:

* Vexorian: JassHelper/vJass, Wc3mapoptimizer, functions and systems, partly implemented partly for ideas
* PitzerMike: JassNewGenPack
* Pipedream: Grimoire
* SFilip: TESH
* Opossum: 3rd person camera system

Models:

* Born2Modificate: Many real texture models.
* xXm0RpH3usXX: Many real texture models from his project Neratia.
* Kitabatake: [Hell Campaign Screen](https://www.hiveworkshop.com/threads/hell-campaign-screen.121022/#resource-26801)
* Graber: [Villager 255 Animations](https://www.hiveworkshop.com/threads/villager-255-animations.192204/)
* Talavaj: [HybrisFactory - Multiple packages of realtexture models and textures](http://www.hiveworkshop.com/threads/hybrisfactory-terraining-and-mapping-resources.238310/)
* Sellenisko: [Vrykul Race Pack](http://www.hiveworkshop.com/threads/vrykul-race-pack.241083/)
* JoySoy: [The Mage](https://www.hiveworkshop.com/threads/the-mage.293180/)
* Sunchips: [RedApple](https://www.hiveworkshop.com/threads/redapple.223180/)
* Kitabatake: [Nordic Warrior](https://www.hiveworkshop.com/threads/nordic-warrior.88724/)

Icons:

* olofmoleman: BTNDeer.blp
* Stanakin Skywalker: BTNDuck.blp
* Tenebrae: BTNDunkelelf.blp
* Werewulf: BTNBestie.blp
* bboy-tiger-: BTNBestienhaeputling.blp
* TDR: BTNSchattenefreet.blp
* dickxunder: BTNZauberin.blp
* Norinrad: BTNZwergenkrieger.blp
* Elenai: BTNBotschafterin.blp, BTNKoeniglicherKleriker.blp
* Michael Peppers: BTNGeistlicheSchwertkaempferin.blp
* Eagle XI: [BTNVrykulWorker](https://www.hiveworkshop.com/threads/btnvrykulworker.272398/)

User Interface:

* unwirklich: [Demon UI](http://www.wc3c.net/showthread.php?t=93713)