LibLocPlus = LibLocPlus or {}

local NonLocalizedStatus = {
    [DBLocPlus.Status.Alliance] = "Alliance",
    [DBLocPlus.Status.Horde] = "Horde",
    [DBLocPlus.Status.Contested] = "Contested",
}

-- There are other vanilla realms outside of TWoW; add them here and in the database when found
local function GetRealmPhase(realmName)
    if realmName == "Nordanaar" then
        return DBLocPlus.PhaseTWOWNordanaar
    end

    if realmName == "Tel'Abim" then
        return DBLocPlus.PhaseTWOWTelAbim
    end

    if realmName == "Ambershire" then
        return DBLocPlus.PhaseTWOWAmbershire
    end

    return nil
end

-- Taken from pfUI by Shagu
local function IsPlayingOnTurtleWoW()
    if not TargetHPText or not TargetHPPercText then
        return false
    end

    return true
end

local function CalcLevelDiff(minLevel, maxLevel, playerLevel)
    return (floor((maxLevel - minLevel) / 2) + minLevel) - playerLevel
end

local function BuildRecommendationLevelRangeText(minLevel, maxLevel)
    local color = LibLocPlus:GetZoneLevelRangeColor(minLevel, maxLevel)
    local range = minLevel ~= maxLevel and (minLevel .. "-" .. maxLevel) or tostring(minLevel)

    return color .. range .. "|r"
end

LibLocPlus.Colors = {
    Red = "|cffdb2121",
    LightRed = "|cffffaaaa",
    Orange = "|cffff8040",
    Yellow = "|cffffff00",
    Green = "|cff40bd40",
    Gray = "|cff808080",
    LightGray = "|cffcccccc",
    DarkGray = "|cff555555",
    White = "|cffffffff",
}

function LibLocPlus:GetZoneInformation(realZoneName)
    local information = DBLocPlus.ZONES[realZoneName]

    if not information then
        for _, info in pairs(DBLocPlus.INSTANCES) do
            if info[9] == realZoneName then
                information = info
                break
            end
        end
    end

    if not information then
        return nil
    end

    return {
        MinLevelRange = information[1],
        MaxLevelRange = information[2],
        Continent = information[3],
        FishingLevelRequirement = information[4],
        Status = information[5],
        IsCity = information[6],
        IsRecommendable = information[7],
        IsTurtleWoWOnly = information[8],
        RealZoneName = information[9],
    }
end

function LibLocPlus:GetInstanceInformation(realZoneName)
    local information = DBLocPlus.INSTANCES[realZoneName]

    if not information then
        for _, info in pairs(DBLocPlus.INSTANCES) do
            if info[9] == realZoneName then
                information = info
                
                break
            end
        end
    end

    if not information then
        return nil
    end

    return {
        MinLevelRange = information[1],
        MaxLevelRange = information[2],
        Continent = information[3],
        InstanceType = information[4],
        InstanceSize = information[5],
        IsRecommendable = information[6],
        PhaseLocked = information[7],
        IsTurtleWoWOnly = information[8],
        RealZoneName = information[9],
    }
end

function LibLocPlus:GetZoneLevelRangeColor(zoneMin, zoneMax)
    local averageLevel = floor((zoneMax - zoneMin) / 2) + zoneMin
    local levelDiff = averageLevel - UnitLevel("player")
    local color = LibLocPlus.Colors.White

    if levelDiff > 4 then
        color = LibLocPlus.Colors.Red
    elseif levelDiff > 2 then
        color = LibLocPlus.Colors.Orange
    elseif levelDiff > -3 then
        color = LibLocPlus.Colors.Yellow
    elseif levelDiff > -12 then
        color = LibLocPlus.Colors.Green
    else
        color = LibLocPlus.Colors.Gray
    end

    return color
end

function LibLocPlus:GetColorFromZoneStatus(zoneStatus)
    local playerFaction = UnitFactionGroup("player")

    if playerFaction == NonLocalizedStatus[zoneStatus] then
        return LibLocPlus.Colors.Green
    elseif zoneStatus == DBLocPlus.Status.Contested then
        return LibLocPlus.Colors.Yellow
    else
        return LibLocPlus.Colors.Red
    end
end

function LibLocPlus:GetZoneLevelRangeText(minLevel, maxLevel)
    local currentZoneLevelRange = LibLocPlus:GetZoneLevelRangeColor(minLevel, maxLevel) .. "(" .. minLevel

    if minLevel ~= maxLevel then
        currentZoneLevelRange = currentZoneLevelRange .. "-" .. maxLevel
    end

    return currentZoneLevelRange .. ")|r"
end

function LibLocPlus:GetCoordinates()
    local x, y = GetPlayerMapPosition("player")

    if x ~= 0 and y ~= 0 then
        return pfUI.api.round(x * 100, 1), pfUI.api.round(y * 100, 1)
    else
        return "--", "--"
    end
end

function LibLocPlus:IsPlayerFisherman()
    for i = 1, GetNumSkillLines() do
        local skillName, _, _, level, _, modifier = GetSkillLineInfo(i)

        if skillName == PFLP_SKILL_FISHING then
            return true, level + modifier
        end
    end

    return false, nil
end

function LibLocPlus:GetRecommendedContent(realZoneName)
    local recommendedZones = {}
    local recommendedInstances = {}
    local playerLevel = UnitLevel("player")
    local playerFaction = UnitFactionGroup("player")
    local realmPhase = GetRealmPhase(GetRealmName())
    local isPlayingOnTurtleWoW = IsPlayingOnTurtleWoW()

    -- Zones
    for name, _ in pairs(DBLocPlus.ZONES) do
        local zoneInformation = LibLocPlus:GetZoneInformation(name)

        if zoneInformation then
            local zoneName = name
            local isValidZone = true
            local levelDiff = CalcLevelDiff(zoneInformation.MinLevelRange, zoneInformation.MaxLevelRange, playerLevel)

            if not zoneInformation.IsRecommendable then
                isValidZone = false
            end

            if zoneInformation.Status ~= DBLocPlus.Status.Contested and NonLocalizedStatus[zoneInformation.Status] ~= playerFaction then
                isValidZone = false
            end

            if not isPlayingOnTurtleWoW and zoneInformation.IsTurtleWoWOnly then
                isValidZone = false
            end

            if isValidZone and levelDiff > -8 and levelDiff <= 4 and (zoneInformation.RealZoneName or zoneName) ~= realZoneName then
                local levelRangeText = BuildRecommendationLevelRangeText(zoneInformation.MinLevelRange,
                    zoneInformation.MaxLevelRange)

                if zoneInformation.DisplayName then
                    zoneName = zoneInformation.DisplayName
                end

                table.insert(recommendedZones,
                    { zoneName, levelRangeText, zoneInformation.MinLevelRange, zoneInformation.MaxLevelRange })
            end
        end
    end

    -- Instances
    for name, _ in pairs(DBLocPlus.INSTANCES) do
        local instanceInformation = LibLocPlus:GetInstanceInformation(name)

        if instanceInformation then
            local instanceName = name
            local isValidInstance = true
            local levelDiff = CalcLevelDiff(instanceInformation.MinLevelRange, instanceInformation.MaxLevelRange,
                playerLevel)

            if not instanceInformation.IsRecommendable then
                isValidInstance = false
            end

            if not isPlayingOnTurtleWoW and instanceInformation.IsTurtleWoWOnly then
                isValidInstance = false
            end

            if realmPhase and realmPhase[instanceInformation.PhaseLocked] == false then
                isValidInstance = false
            end

            if isValidInstance and levelDiff > -8 and levelDiff <= 4 and (instanceInformation.RealZoneName or instanceName) ~= realZoneName then
                local levelRangeText = BuildRecommendationLevelRangeText(instanceInformation.MinLevelRange,
                    instanceInformation.MaxLevelRange)

                if instanceInformation.DisplayName then
                    instanceName = instanceInformation.DisplayName
                end

                local displayName = instanceName ..
                    " " ..
                    LibLocPlus.Colors.LightGray ..
                    "[" ..
                    instanceInformation.InstanceSize ..
                    "]|r" ..
                    (instanceInformation.InstanceType == DBLocPlus.InstanceType.Raid and " " .. LibLocPlus.Colors.LightRed .. DBLocPlus.InstanceType.Raid .. "|r" or "")

                local isRaid = instanceInformation.InstanceType == DBLocPlus.InstanceType.Raid

                table.insert(recommendedInstances,
                    { displayName, levelRangeText, instanceInformation.MinLevelRange, instanceInformation.MaxLevelRange,
                        isRaid, instanceInformation.InstanceSize })
            end
        end
    end

    table.sort(recommendedZones, function(a, b)
        if a[3] == b[3] then
            return a[1] < b[1]
        end

        return a[3] < b[3]
    end)

    local combined = {}

    for _, entry in ipairs(recommendedZones) do
        table.insert(combined, { entry[1], entry[2], entry[3], entry[4], "zone" })
    end

    for _, entry in ipairs(recommendedInstances) do
        table.insert(combined, { entry[1], entry[2], entry[3], entry[4], "instance", entry[5], entry[6] })
    end

    table.sort(combined, function(a, b)
        if a[3] == b[3] then
            return a[1] < b[1]
        end

        return a[3] < b[3]
    end)

    while table.getn(combined) > 16 do
        local removeIndex = 1

        if playerLevel == 60 then
            for i = 2, table.getn(combined) do
                local current = combined[i]
                local selected = combined[removeIndex]
                local currentIsInstance = current[5] == "instance"
                local selectedIsInstance = selected[5] == "instance"
                local betterToRemove = false

                if currentIsInstance and not selectedIsInstance then
                    betterToRemove = false
                elseif not currentIsInstance and selectedIsInstance then
                    betterToRemove = true
                else
                    if current[3] < selected[3] then
                        betterToRemove = true
                    end
                end

                if betterToRemove then
                    removeIndex = i
                end
            end
        else
            for i = 2, table.getn(combined) do
                local current = combined[i]
                local selected = combined[removeIndex]

                if current[3] < selected[3] then
                    removeIndex = i
                end
            end
        end

        table.remove(combined, removeIndex)
    end

    recommendedZones = {}
    recommendedInstances = {}

    for _, entry in ipairs(combined) do
        if entry[5] == "zone" then
            table.insert(recommendedZones, { entry[1], entry[2], entry[3], entry[4] })
        else
            table.insert(recommendedInstances, { entry[1], entry[2], entry[3], entry[4], entry[6], entry[7] })
        end
    end

    table.sort(recommendedInstances, function(a, b)
        local aIsRaid = a[5] == true
        local bIsRaid = b[5] == true

        if aIsRaid ~= bIsRaid then
            return not aIsRaid
        end

        local _, _, aMatch = string.find(a[6] or "", "^(%d+)")
        local _, _, bMatch = string.find(b[6] or "", "^(%d+)")
        local aSize = tonumber(aMatch) or 0
        local bSize = tonumber(bMatch) or 0

        if aSize ~= bSize then
            return aSize < bSize
        end

        if a[3] ~= b[3] then
            return a[3] < b[3]
        end

        return a[1] < b[1]
    end)

    return recommendedZones, recommendedInstances
end
