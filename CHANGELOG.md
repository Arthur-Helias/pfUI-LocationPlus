# pfUI-LocationPlus Changelog

All changes to this project will be documented in this file.

## [1.4.7] - 2026-03-19

### Changed

- Changed the availability of the phases on Ambershire for Emerald Sanctum, BWL and Onyxia's Lair
- Changed the availability of the phases on Tel Abim for Timbermaw Hold
- Changed the availability of the phases on Nordaanar for Timbermaw Hold

## [1.4.6] - 2026-03-19

### Fixed

- Fixed Onixya's Lair entrance not being found

## [1.4.5] - 2026-03-17

### Fixed

- Fixed Blackfathom Deeps' entrance not being found

## [1.4.4] - 2026-03-17

### Fixed

- Fixed Crescent Grove not being found

## [1.4.3] - 2026-03-17

### Fixed

- Fixed the entrance of Wailing Carverns not being found

## [1.4.2] - 2026-03-17

### Fixed

- Fixed zones not being found when entering or exiting instances in some cases

## [1.4.1] - 2026-03-15

### Fixed

- Fixed Karazhan Crypts not not being found

## [1.4.0] - 2026-03-15

### Added

- Added Moonwhisper Coast
- Added Windhorn Canyon
- Added Frostmane Hollow
- Added Timbermaw Hold

## [1.3.6] - 2026-03-12

### Changed

- Changed Emerald Sanctum level range from 58-60 to 60-60

## [1.3.5] - 2026-03-07

### Fixed

- Fixed Scarlet Monastery Armory and Scarlet Monastery weird interaction bug
- Fixed Scarlet Monastery Armory not being found (again)

## [1.3.4] - 2026-03-07

### Fixed

- Fixed Scarlet Monastery not being found
- Fixed Scarlet Monastery Graveyard not being found
- Fixed Scarlet Monastery Library not being found
- Fixed Scarlet Monastery Armory not being found
- Fixed Scarlet Monastery Cathedral not being found

## [1.3.3] - 2026-03-06

### Fixed

- Fixed Caverns of Time not being found

## [1.3.2] - 2026-03-04

### Added

- Added zone level range color to the tooltip line for Level Range

## [1.3.1] - 2026-03-04

### Fixed

- Fixed Black Morass not being found

## [1.3.0] - 2026-03-02

### Added

- Added TurtleWoW-only flags to zones/instances to avoid recommendations on non-TurtleWoW servers
- Added phase-based instance recommendation for TurtleWoW's realms Nordanaar, Tel'Abim, and Ambershire
- Added improvements to the instance recommendation system to sort the content based on instance size and instance type
- Added full localization, albeit while still using LLMs

### Changed

- Changed most of the function declarations from `pfUI-locplus.lua` to `liblocplus.lua`
- Changed version global variable from `PFLP_VERSION` to `PFLP_VERSION_MAJOR`, `PFLP_VERSION_MINOR`, and `PFLP_VERSION_PATCH`
- Changed most of the code structure to improve maintainability and reduce duplicates

### Fixed

- Fixed the right datatext panel not registering mouse clicks

## [1.2.5] - 2026-02-25

### Fixed

- Fixed Dire Maul not being found

## [1.2.4] - 2026-02-25

### Fixed

- Fixed nil values being passed around when they shouldn't

## [1.2.3] - 2026-02-25

### Fixed

- Fixed Blackrock Spire not being found
- Fixed the module also being registered for TBC

## [1.2.2] - 2026-02-22

### Added

- Added version global variable `PFLP_VERSION`

### Fixed

- Fixed Blackrock Mountain not being found

## [1.2.1] - 2026-02-21

### Fixed

- Fixed Sunken Temple not being found
- Fixed LBRS being categorized as 10-man

## [1.2] - 2026-02-17

### Added

- Added setting for zone name coloring on the central frame based on faction status

## [1.1.2] - 2026-02-16

### Fixed

- Fixed dungeon entrance (Maraudon, Zul'Farrak) in the world not displaying level range and information

## [1.1.1] - 2026-02-13

### Changed

- Changed config creation functions from global to local

## [1.1] - 2026-02-13

### Added

- Added ctrl-click registering on the location frame to toggle the addon's settings
- Added a limit of 16 total recommendation (zones and instances) to prevent reaching maximum tooltip length

## [1.0] - 2026-02-13

Initial release
