# pfUI Location Plus

An external module for pFUI inspired by [LocationPlus by Benik](https://github.com/Benik/LocationPlus) that adds a location panel, two coordinate frames, and two datatext panels. Most features from this addon can be configured!  

## Features

- A configurable location panel showing your current zone and level range.
- Two coordinate frames.
- Two datatext panels to show information such as FPS, latency, gear durability or any other datatexts.
- Lots of settings such as position, size, transparency, features, and more!
- Tooltip with extended zone information and content recommendation when hovering the location panel.

## Screenshots

<img width="921" height="87" alt="image" src="https://github.com/user-attachments/assets/28fe81d8-d2d1-4f59-af79-3fb4d6be4feb" /><br>
*The frames with transparency enabled.*<br><br><br>
<img width="921" height="87" alt="image" src="https://github.com/user-attachments/assets/47741cc4-921d-43ca-9cdf-8b7bfaa4d2ae" /><br>
*The frames with transparency disabled and with matching height.*<br><br><br>
<img width="552" height="720" alt="tooltip" src="https://github.com/user-attachments/assets/51ed8901-7e6f-4737-901d-4d78a89d3432" /><br>
*The zone information tooltip with both zones and instances recommendation enabled.*<br><br><br>
<img width="687" height="1446" alt="options" src="https://github.com/user-attachments/assets/4ae46d5a-5fcc-4b83-bbea-baba40fd0408" /><br>
*Some of the available settings*

## Installation

This addon requires [pfUI](https://github.com/shagu/pfUI) or one of its maintained forks, like [me0wg4ming's fork](https://github.com/me0wg4ming/pfUI). Make sure to download one of them first.

### Turtle WoW Launcher (**Recommended**)

1. Open the Turtle WoW Launcher and navigate to the `ADDONS` tab at the top.
2. Press the `Add new addon` button and paste the following URL into the field: `https://github.com/Arthur-Helias/pfUI-LocationPlus.git`.
3. Enable the addon from the addons menu on the character selection screen.

### Manual installation

1. Download the [latest version](https://github.com/Arthur-Helias/pfUI-LocationPlus/archive/refs/heads/master.zip) of the addon.
2. Extract the archive.
3. Rename the folder from "pfUI-locplus-master" to "pfUI-locplus".
4. Copy the renamed folder into `WoW-Directory\Interface\AddOns`.
5. Enable the addon from the addons menu on the character selection screen.

## Known Issues

None so far. Please report any issues you encounter through the `Issues` tab on this repository. Feel free to make a PR if you wish to contribute to this addon!

## Compatibility

This addon was designed and tested for TurtleWoW. It should be compatible with any 1.12 client that does not add or modify zones.  
This addon is compatible with [the original pfUI by Shagu](https://github.com/shagu/pfUI), but also its actively maintained forks such as [me0wg4ming's](https://github.com/me0wg4ming/pfUI).  
Due to the lack of zone's IDs related API in 1.12 (as far as I'm aware), WoW clients using any other language than English might encounter issues. If any such issues arise, please feel free to report it through the `Issues` tab on this repository.

## Addon Recommendations

Here are a few other addons that improve pfUI or other parts of the game and do not conflict with this addon:

- [pfUI-MoreDatatexts](https://github.com/Arthur-Helias/pfUI-MoreDatatexts) - Another module for pfUI that adds extra datatexts usable in the added panels from this addon.
- [pfUI-addonskinner](https://github.com/jrc13245/pfUI-addonskinner) - Another module for pfUI that skins other addons to match the style of pfUI.
- [pfUI-bettertotems](https://github.com/Bombg/pfUI-bettertotems) - Another module for pfUI that improves the totem module.
- [ZonesLevel](https://github.com/Arthur-Helias/ZonesLevel) - Adds zones level range to your world map.

## Extra Notes

No code was copied from [Benik's original Location Plus](https://github.com/Benik/LocationPlus). I've simply recreated to the best of my ability the features of the original addon through screenshots and gameplay.

## Credits

[Walter Bennet](https://github.com/Arthur-Helias) - Addon creation  
[Benik](https://github.com/Benik) - Original LocationPlus for ElvUI  
[Shagu](https://github.com/shagu) - pfUI  
[Bombg](https://github.com/Bombg) - Code inspiration from pfUI-bettertotems
