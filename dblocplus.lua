DBLocPlus = DBLocPlus or {}

DBLocPlus.Phase = {
    MC = PFLP_PHASE_MOLTENCORE,
    DM = PFLP_PHASE_DIREMAUL,
    OL = PFLP_PHASE_ONYXIALAIR,
    BWL = PFLP_PHASE_BLACKWINGLAIR,
    ZG = PFLP_PHASE_ZULGURUB,
    ES = PFLP_PHASE_EMERALDSANCTUM,
    AQ = PFLP_PHASE_AHNQIRAJ,
    Naxx = PFLP_PHASE_NAXXRAMAS,
    Kara = PFLP_PHASE_TOWEROFKARAZHAN,
    TH = PFLP_PHASE_TIMBERMAWHOLD,
}

DBLocPlus.Continent = {
    EK = PFLP_CONTINENT_EASTERNKINGDOMS,
    KLMDR = PFLP_CONTINENT_KALIMDOR,
}

DBLocPlus.Status = {
    Alliance = PFLP_STATUS_ALLIANCE,
    Horde = PFLP_STATUS_HORDE,
    Contested = PFLP_STATUS_CONTESTED,
}

DBLocPlus.InstanceType = {
    Dungeon = PFLP_INSTANCETYPE_DUNGEON,
    Raid = PFLP_INSTANCETYPE_RAID,
}

DBLocPlus.InstanceSize = {
    FiveMan = PFLP_INSTANCESIZE_5MAN,
    TenMan = PFLP_INSTANCESIZE_10MAN,
    TwentyMan = PFLP_INSTANCESIZE_20MAN,
    FortyMan = PFLP_INSTANCESIZE_40MAN,
}


-- ============================================
-- ==   Realm Phases Content Unlock Tables   ==
-- ============================================

local DP = DBLocPlus.Phase

DBLocPlus.PhaseTWOWNordanaar = {
    [DP.MC] = true,
    [DP.DM] = true,
    [DP.OL] = true,
    [DP.BWL] = true,
    [DP.ZG] = true,
    [DP.ES] = true,
    [DP.AQ] = true,
    [DP.Naxx] = true,
    [DP.Kara] = true,
    [DP.TH] = false,
}

DBLocPlus.PhaseTWOWTelAbim = {
    [DP.MC] = true,
    [DP.DM] = true,
    [DP.OL] = true,
    [DP.BWL] = true,
    [DP.ZG] = true,
    [DP.ES] = true,
    [DP.AQ] = true,
    [DP.Naxx] = true,
    [DP.Kara] = true,
    [DP.TH] = false,
}

DBLocPlus.PhaseTWOWAmbershire = {
    [DP.MC] = true,
    [DP.DM] = true,
    [DP.OL] = false,
    [DP.BWL] = false,
    [DP.ZG] = true,
    [DP.ES] = false,
    [DP.AQ] = false,
    [DP.Naxx] = false,
    [DP.Kara] = false,
    [DP.TH] = false,
}


-- ================================================
-- ==   Zones And Instances Information Tables   ==
-- ================================================

local DC = DBLocPlus.Continent
local DS = DBLocPlus.Status

-- /!\ The fishing level requirements for Turtle WoW's added zones are based on their player level range. The information could be inaccurate. Feel free to make a PR if you do possess accurate data.
-- [zoneNameLocalized] = { minLevelRange, maxLevelRange, continentLocalized, fishingLevelRequirement, statusLocalized, isCity, isRecommendable, isTurtleWoWOnly, realZoneNameForDisplayNameLocalized }
DBLocPlus.ZONES = {
    [PFLP_REALZONENAME_ALAHTHALAS] = { 1, 10, DC.EK, 1, DS.Alliance, true, false, true, nil },
    [PFLP_REALZONENAME_ALTERACMOUNTAINS] = { 30, 40, DC.EK, 150, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_ARATHIHIGHLANDS] = { 30, 40, DC.EK, 150, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_ASHENVALE] = { 18, 30, DC.KLMDR, 75, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_AZSHARA] = { 45, 55, DC.KLMDR, 200, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_BADLANDS] = { 35, 45, DC.EK, 175, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_BALOR] = { 29, 34, DC.EK, 145, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_BLACKROCKMOUNTAIN] = { 50, 58, DC.EK, 0, DS.Contested, false, false, false, nil },
    [PFLP_REALZONENAME_BLACKSTONEISLAND] = { 1, 10, DC.KLMDR, 1, DS.Horde, false, true, true, nil },
    [PFLP_REALZONENAME_BLASTEDLANDS] = { 45, 55, DC.EK, 235, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_BURNINGSTEPPES] = { 50, 58, DC.EK, 240, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_CAVERNSOFTIME] = { 60, 60, DC.KLMDR, 0, DS.Contested, false, false, true, nil },
    [PFLP_REALZONENAME_DARKSHORE] = { 10, 20, DC.KLMDR, 50, DS.Alliance, false, true, false, nil },
    [PFLP_REALZONENAME_DARNASSUS] = { 1, 10, DC.KLMDR, 1, DS.Alliance, true, false, false, nil },
    [PFLP_REALZONENAME_DEADWINDPASS] = { 55, 60, DC.EK, 290, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_DESOLACE] = { 30, 40, DC.KLMDR, 100, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_DUNMOROGH] = { 1, 10, DC.EK, 1, DS.Alliance, false, true, false, nil },
    [PFLP_REALZONENAME_DUROTAR] = { 1, 10, DC.KLMDR, 1, DS.Horde, false, true, false, nil },
    [PFLP_REALZONENAME_DUSKWOOD] = { 18, 30, DC.EK, 95, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_DUSTWALLOWMARSH] = { 35, 45, DC.KLMDR, 150, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_EASTERNPLAGUELANDS] = { 53, 60, DC.EK, 265, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_ELWYNNFOREST] = { 1, 10, DC.EK, 1, DS.Alliance, false, true, false, nil },
    [PFLP_REALZONENAME_FELWOOD] = { 48, 55, DC.KLMDR, 175, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_FERALAS] = { 40, 50, DC.KLMDR, 150, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_GILLIJIMSISLE] = { 48, 53, DC.EK, 225, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_GILNEAS] = { 39, 46, DC.EK, 200, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_GRIMREACHES] = { 33, 38, DC.EK, 165, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_HILLSBRADFOOTHILLS] = { 20, 30, DC.EK, 100, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_HYJAL] = { 58, 60, DC.KLMDR, 290, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_IRONFORGE] = { 1, 10, DC.EK, 0, DS.Alliance, true, false, false, nil },
    [PFLP_REALZONENAME_LAPIDISISLE] = { 48, 53, DC.EK, 225, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_LOCHMODAN] = { 10, 20, DC.EK, 50, DS.Alliance, false, true, false, nil },
    [PFLP_REALZONENAME_MOONGLADE] = { 1, 60, DC.KLMDR, 205, DS.Contested, false, false, false, nil },
    [PFLP_REALZONENAME_MULGORE] = { 1, 10, DC.KLMDR, 1, DS.Horde, false, true, false, nil },
    [PFLP_REALZONENAME_NORTHWIND] = { 28, 34, DC.EK, 140, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_ORGRIMMAR] = { 1, 10, DC.KLMDR, 1, DS.Horde, true, false, false, nil },
    [PFLP_REALZONENAME_REDRIDGEMOUNTAINS] = { 15, 25, DC.EK, 80, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_SCARLETENCLAVE] = { 55, 60, DC.EK, 280, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_SCARLETMONASTERY] = { 30, 45, DC.EK, 0, DS.Contested, false, false, false, nil },
    [PFLP_REALZONENAME_SEARINGGORGE] = { 43, 50, DC.EK, 0, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_SILITHUS] = { 55, 60, DC.KLMDR, 0, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_SILVERPINEFOREST] = { 10, 20, DC.EK, 50, DS.Horde, false, true, false, nil },
    [PFLP_REALZONENAME_STONETALONMOUNTAINS] = { 15, 27, DC.KLMDR, 75, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_STORMWINDCITY] = { 1, 10, DC.EK, 1, DS.Alliance, true, false, false, nil },
    [PFLP_REALZONENAME_STRANGLETHORNVALE] = { 30, 45, DC.EK, 150, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_SWAMPOFSORROWS] = { 35, 45, DC.EK, 175, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_TANARIS] = { 40, 50, DC.KLMDR, 225, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_TELABIM] = { 54, 60, DC.KLMDR, 270, DS.Contested, false, true, true, nil },
    [PFLP_REALZONENAME_TELDRASSIL] = { 1, 10, DC.KLMDR, 1, DS.Alliance, false, true, false, nil },
    [PFLP_REALZONENAME_THALASSIANHIGHLANDS] = { 1, 10, DC.EK, 1, DS.Alliance, false, true, true, nil },
    [PFLP_REALZONENAME_THEBARRENS] = { 10, 25, DC.KLMDR, 50, DS.Horde, false, true, false, nil },
    [PFLP_REALZONENAME_THEHINTERLANDS] = { 40, 50, DC.EK, 200, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_THOUSANDNEEDLES] = { 25, 35, DC.KLMDR, 75, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_THUNDERBLUFF] = { 1, 10, DC.KLMDR, 1, DS.Horde, true, false, false, nil },
    [PFLP_REALZONENAME_TIRISFALGLADES] = { 1, 10, DC.EK, 1, DS.Horde, false, true, false, nil },
    [PFLP_REALZONENAME_UNDERCITY] = { 1, 10, DC.EK, 1, DS.Horde, true, false, false, nil },
    [PFLP_REALZONENAME_UNGOROCRATER] = { 48, 55, DC.KLMDR, 225, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_WESTERNPLAGUELANDS] = { 51, 58, DC.EK, 255, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_WESTFALL] = { 10, 20, DC.EK, 50, DS.Alliance, false, true, false, nil },
    [PFLP_REALZONENAME_WETLANDS] = { 20, 30, DC.EK, 105, DS.Contested, false, true, false, nil },
    [PFLP_REALZONENAME_WINTERSPRING] = { 55, 60, DC.KLMDR, 250, DS.Contested, false, true, false, nil },
}

local DIT = DBLocPlus.InstanceType
local DIS = DBLocPlus.InstanceSize

-- [instanceNameLocalized] = { minLevelRange, maxLevelRange, continentLocalized, instanceTypeLocalized, instanceSizeLocalized, isRecommendable, phaseLocked, isTurtleWoWOnly, realZoneNameForDisplayNameLocalized }
DBLocPlus.INSTANCES = {
    [PFLP_REALZONENAME_BLACKFATHOMDEEPS] = { 22, 31, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_BLACKMORASS] = { 60, 60, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, true, nil },
    [PFLP_REALZONENAME_BLACKROCKDEPTHS] = { 50, 60, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_BLACKWINGLAIR] = { 60, 60, DC.EK, DIT.Raid, DIS.FortyMan, true, DP.BWL, false, nil },
    [PFLP_DISPLAYNAME_DIREMAULEAST] = { 55, 60, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, DP.DM, false, PFLP_REALZONENAME_DIREMAULEAST },
    [PFLP_DISPLAYNAME_DIREMAULNORTH] = { 57, 60, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, DP.DM, false, PFLP_REALZONENAME_DIREMAULNORTH },
    [PFLP_DISPLAYNAME_DIREMAULWEST] = { 57, 60, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, DP.DM, false, PFLP_REALZONENAME_DIREMAULWEST },
    [PFLP_REALZONENAME_DRAGONMAWRETREAT] = { 26, 35, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, true, nil },
    [PFLP_REALZONENAME_EMERALDSANCTUM] = { 58, 60, DC.KLMDR, DIT.Raid, DIS.FortyMan, true, DP.ES, true, nil },
    [PFLP_REALZONENAME_GILNEASCITY] = { 43, 52, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, true, nil },
    [PFLP_REALZONENAME_GNOMEREGAN] = { 28, 37, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_HATEFORGEQUARRY] = { 51, 60, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, true, nil },
    [PFLP_REALZONENAME_KARAZHANCRYPT] = { 58, 60, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, true, nil },
    [PFLP_DISPLAYNAME_LOWERBLACKROCKSPIRE] = { 55, 60, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, PFLP_REALZONENAME_LOWERBLACKROCKSPIRE },
    [PFLP_REALZONENAME_LOWERKARAZHANHALLS] = { 60, 60, DC.EK, DIT.Dungeon, DIS.TenMan, true, nil, false, nil },
    [PFLP_REALZONENAME_MARAUDON] = { 43, 54, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_MOLTENCORE] = { 60, 60, DC.EK, DIT.Raid, DIS.FortyMan, true, DP.MC, false, nil },
    [PFLP_REALZONENAME_NAXXRAMAS] = { 60, 60, DC.EK, DIT.Raid, DIS.FortyMan, true, DP.Naxx, false, nil },
    [PFLP_REALZONENAME_ONYXIASLAIR] = { 60, 60, DC.KLMDR, DIT.Raid, DIS.FortyMan, true, DP.OL, false, nil },
    [PFLP_REALZONENAME_RAGEFIRECHASM] = { 13, 19, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_RAZORFENDOWNS] = { 35, 44, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_RAZORFENKRAUL] = { 29, 36, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_RUINSOFAHNQIRAJ] = { 60, 60, DC.KLMDR, DIT.Raid, DIS.TwentyMan, true, DP.AQ, false, nil },
    [PFLP_REALZONENAME_SCARLETMONASTERYARMORY] = { 34, 42, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_SCARLETMONASTERYCATHEDRAL] = { 35, 45, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_SCARLETMONASTERYGRAVEYARD] = { 30, 37, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_SCARLETMONASTERYLIBRARY] = { 32, 40, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_SCHOLOMANCE] = { 58, 60, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_SHADOWFANGKEEP] = { 20, 28, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_STORMWINDVAULT] = { 60, 60, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, true, nil },
    [PFLP_REALZONENAME_STORMWROUGHTRUINS] = { 32, 44, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, true, nil },
    [PFLP_REALZONENAME_STRATHOLME] = { 58, 60, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_SUNKENTEMPLE] = { 49, 58, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_TEMPLEOFAHNQIRAJ] = { 60, 60, DC.KLMDR, DIT.Raid, DIS.FortyMan, true, DP.AQ, false, nil },
    [PFLP_REALZONENAME_THECRESCENTGROVE] = { 32, 39, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, true, nil },
    [PFLP_REALZONENAME_THEDEADMINES] = { 16, 24, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_THESTOCKADE] = { 23, 32, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_TOWEROFKARAZHAN] = { 60, 60, DC.EK, DIT.Raid, DIS.FortyMan, true, DP.Kara, true, nil },
    [PFLP_REALZONENAME_ULDAMAN] = { 41, 50, DC.EK, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_DISPLAYNAME_UPPERBLACKROCKSPIRE] = { 60, 60, DC.EK, DIT.Dungeon, DIS.TenMan, true, nil, false, PFLP_REALZONENAME_UPPERBLACKROCKSPIRE },
    [PFLP_REALZONENAME_WAILINGCAVERNS] = { 16, 25, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_ZULFARRAK] = { 42, 51, DC.KLMDR, DIT.Dungeon, DIS.FiveMan, true, nil, false, nil },
    [PFLP_REALZONENAME_ZULGURUB] = { 60, 60, DC.EK, DIT.Raid, DIS.TwentyMan, true, DP.ZG, false, nil },
}
