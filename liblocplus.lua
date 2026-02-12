LibLocPlus = LibLocPlus or {}

function LibLocPlus:GetZoneColor(playerLevel, zoneMin, zoneMax)
    local averageLevel = floor((zoneMax - zoneMin) / 2) + zoneMin
    local levelDiff = averageLevel - playerLevel
    local color = ""

    if levelDiff > 4 then
        color = "|cffdb2121"
    elseif levelDiff > 2 then
        color = "|cffff8040"
    elseif levelDiff > -3 then
        color = "|cffffff00"
    elseif levelDiff > -12 then
        color = "|cff40bd40"
    else
        color = "|cff808080"
    end

    if zoneMin == zoneMax then
        color = "|cffff8040"
    end

    return color
end

function LibLocPlus:GetStatusColor(status, playerFaction)
    if playerFaction == status then
        return "|cff40bd40"
    elseif status == "Contested" then
        return "|cffffff00"
    else
        return "|cffdb2121"
    end
end
