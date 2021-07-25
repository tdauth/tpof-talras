# The Power of Fire: Talras

Warcraft III: Reforged muliplayer funmap influenced by games like Diablo II and Gothic II combining hack and slay with dialog based decisions. 
This is a 6 player map in which you play together against the AI completing quests, leveling, buying items, looting stuff and end the game with a big final battle.
It contains cutscenes, voice acted dialogues and all basic RPG elements and systems.
It tries to capture a darker look like Gothic II and Diablog II and several elements of those games.
The lore has been written for this modification and Talras is the castle which you enter in the beginning.

## Download

[talras1.0.w3x](./talras1.0.w3x)

## Features

* 8 custom classes with different custom spells.
* Cutscenes.
* Great voice acting from German people ([HoerTalk.de](https://www.hoer-talk.de/)).
* Dialogues with NPCs.
* 5 Professions which allow crafting items using materials from the map.
* Custom bases per player at hero level 30.
* NPC routines.
* NPC fellows with shared control.
* Automatic hero revival at revival shrines.
* Arena system.
* Automatic creep respawns.
* Automatic item respawns.
* Fair distribution bounty and XP system from creep kills and completing quests.
* AOS-like PvP area.
* Class repick.
* Equipment system with visible items.
* Backpack system with stacking items and without custom GUI which can be used during the battle.
* Up to 15 different spells at once.
* Custom skill system with 2 skill points per level and without custom GUI which can be used during the battle.
* Shop markers.
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

* [This list](https://www.youtube.com/watch?v=u5YKdMws0tQ&list=PLmfeGbBvSVGCDyp2bHGmHrhdJWN9TQLCn) contains many videos about the modification.
* [This Let's Play](https://www.youtube.com/watch?v=z1mLXBc3jRE&list=PLmfeGbBvSVGCRbNKSk3QOh1v09h6YFyxU) was made by me to test the whole modification once.
* [This is a more professional Let's Play by Faelon Stimmspiel](https://www.youtube.com/watch?v=uTruE__ia8A&list=PLiUdDzmlSLTQl7a16tASao2Z50EcwJx_G).
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
One of the biggest is the German book [The Master](./doc/Planung/Hintergrunddefinition/Mythen/Bücher/Band 1 - Der Meister.odt).
It contains a whole story about the Demon Lord Gardonar who is the master behind the attacks.
There is lots of other material in the [planning](./doc/Planung) folder mostly written in German.

## Credits

* Baradé: Creator (idea, dialogues, terrain, quests, coding).
* Deranor: Terrain and testing.
* Jojo: Testing.
* [HoerTalk.de](https://www.hoer-talk.de/): Voice acting.