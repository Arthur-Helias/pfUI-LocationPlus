PFLP_VERSION = "1.2.2"

pfUI:RegisterModule("locationplus", "vanilla:tbc", function()
    local font = C.panel.use_unitfonts == "1" and pfUI.font_unit or pfUI.font_default
    local fontSize = C.panel.use_unitfonts == "1" and C.global.font_unit_size or C.global.font_size

    if not pfUI_config.locplus then
        pfUI_config.locplus = {}
    end

    local backgroundTransparency = nil

    if pfUI_config.locplus.enabletransparent == "1" then
        backgroundTransparency = 0.85
    end


    -- ======================================
    -- ==   Central Zone Name Root Frame   ==
    -- ======================================
    local lpRootFrame = CreateFrame("Button", "CentralZoneFrame", UIParent)

    lpRootFrame.GetZoneStatus = function(_, currentRealZone)
        if not currentRealZone then
            return
        end

        if IsInInstance() then
            return
        end

        if not DBLocPlus.ZONES[currentRealZone] then
            return
        end

        return DBLocPlus.ZONES[currentRealZone][5]
    end

    lpRootFrame.GetZoneData = function(_, currentRealZone)
        if not currentRealZone then
            return
        end

        local locationType = IsInInstance() and DBLocPlus.INSTANCES or DBLocPlus.ZONES
        local zoneName = currentRealZone

        if not locationType[zoneName] then
            zoneName = GetMinimapZoneText()
        end

        if not locationType[zoneName] then
            locationType = not IsInInstance() and DBLocPlus.INSTANCES or DBLocPlus.ZONES
        end

        if not locationType[zoneName] then
            return
        end

        return zoneName, locationType, locationType[currentRealZone][3], locationType[currentRealZone][4]
    end

    lpRootFrame.GetZoneLevelRange = function(_, currentRealZone)
        local zone, locationType = lpRootFrame:GetZoneData(currentRealZone)

        if not zone or not locationType then
            return "|cff808080(??)|r"
        end

        local currentRealZoneMinLevel = locationType[zone][1]
        local currentRealZoneMaxLevel = locationType[zone][2]
        local rangeDifficultyColor = LibLocPlus:GetZoneColor(
            UnitLevel("player"),
            currentRealZoneMinLevel,
            currentRealZoneMaxLevel
        )

        local currentZoneLevelRange = rangeDifficultyColor .. "(" .. currentRealZoneMinLevel
        if currentRealZoneMinLevel ~= currentRealZoneMaxLevel then
            currentZoneLevelRange = currentZoneLevelRange .. "-" .. currentRealZoneMaxLevel
        end

        return currentZoneLevelRange .. ")|r"
    end

    lpRootFrame.GetRecommendedContent = function(_, currentRealZone)
        local recommendedZones = {}
        local recommendedInstances = {}
        local playerLevel = UnitLevel("player")
        local playerFaction = UnitFactionGroup("player")

        for name, data in pairs(DBLocPlus.ZONES) do
            local minLevel = data[1]
            local maxLevel = data[2]
            local averageLevel = floor((maxLevel - minLevel) / 2) + minLevel
            local levelDiff = averageLevel - playerLevel
            local zoneFaction = data[5]
            local isCity = data[6]
            local isValidZone = true

            if name == PFLP_MOONGLADE or name == PFLP_BLACKROCKMOUNTAIN or (zoneFaction and zoneFaction ~= "Contested" and zoneFaction ~= playerFaction) or isCity then
                isValidZone = false
            end

            if isValidZone and levelDiff > -8 and levelDiff <= 4 and name ~= currentRealZone then
                local color = LibLocPlus:GetZoneColor(playerLevel, minLevel, maxLevel)
                local levelRangeText = color .. minLevel .. (minLevel ~= maxLevel and "-" .. maxLevel or "") .. "|r"
                table.insert(recommendedZones, { name, levelRangeText, minLevel, maxLevel })
            end
        end

        for name, data in pairs(DBLocPlus.INSTANCES) do
            local minLevel = data[1]
            local maxLevel = data[2]
            local averageLevel = floor((maxLevel - minLevel) / 2) + minLevel
            local levelDiff = averageLevel - playerLevel

            if levelDiff > -8 and levelDiff <= 4 and name ~= currentRealZone then
                local color = LibLocPlus:GetZoneColor(playerLevel, minLevel, maxLevel)
                local levelRangeText = color .. minLevel .. (minLevel ~= maxLevel and "-" .. maxLevel or "") .. "|r"
                local displayName = name ..
                    " |cffcccccc[" .. data[6] .. "]|r" .. (data[5] == "Raid" and " |cffffaaaaRaid|r" or "")
                table.insert(recommendedInstances, { displayName, levelRangeText, minLevel, maxLevel })
            end
        end

        table.sort(recommendedZones, function(a, b)
            if a[3] == b[3] then return a[1] < b[1] end
            return a[3] < b[3]
        end)

        table.sort(recommendedInstances, function(a, b)
            if a[3] == b[3] then return a[1] < b[1] end
            return a[3] < b[3]
        end)

        local combined = {}

        for _, entry in ipairs(recommendedZones) do
            table.insert(combined, { entry[1], entry[2], entry[3], entry[4], "zone" })
        end

        for _, entry in ipairs(recommendedInstances) do
            table.insert(combined, { entry[1], entry[2], entry[3], entry[4], "instance" })
        end

        table.sort(combined, function(a, b)
            if a[3] == b[3] then return a[1] < b[1] end
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
                table.insert(recommendedInstances, { entry[1], entry[2], entry[3], entry[4] })
            end
        end

        return recommendedZones, recommendedInstances
    end

    lpRootFrame.Refresh = function()
        local currentRealZone = GetRealZoneText()

        if not currentRealZone then
            lpRootFrame.text:SetText("Unknown mysterious zone!")
            return
        end

        local currentRealZoneLevelRange = lpRootFrame:GetZoneLevelRange(currentRealZone)

        local finalText = GetMinimapZoneText()

        if pfUI_config.locplus.coloredstatuslocation == "1" then
            local status = lpRootFrame:GetZoneStatus(currentRealZone)
            if status then
                finalText = LibLocPlus:GetStatusColor(status, UnitFactionGroup("player")) .. finalText .. "|r"
            end
        end

        if currentRealZoneLevelRange then
            finalText = finalText .. " " .. currentRealZoneLevelRange
        end

        lpRootFrame.text:SetText(finalText)
    end

    lpRootFrame.CreateTooltip = function()
        local realZone, _, continent, fishingLevel = lpRootFrame:GetZoneData(GetRealZoneText())

        if not realZone then
            return
        end

        local zoneLevelRange = lpRootFrame:GetZoneLevelRange(realZone)
        local status = lpRootFrame:GetZoneStatus(realZone)
        local playerHasFishing = false
        local playerFishingLevel = 0

        for i = 1, GetNumSkillLines() do
            local skillName, _, _, rank, _, modifier = GetSkillLineInfo(i)
            if skillName == PFLP_FISHING then
                playerHasFishing = true
                playerFishingLevel = rank + modifier
                break
            end
        end

        if zoneLevelRange then
            zoneLevelRange = string.gsub(zoneLevelRange, "[%(%)]", "")
        end

        if not continent then
            continent = "Unknown"
        end

        GameTooltip:ClearLines()
        GameTooltip_SetDefaultAnchor(GameTooltip, lpRootFrame)
        GameTooltip:AddLine("|cff555555Zone Information")
        GameTooltip:AddDoubleLine("Zone", "|cffffffff" .. realZone)
        GameTooltip:AddDoubleLine("Continent", "|cffffffff" .. continent)
        if status then
            GameTooltip:AddDoubleLine("Status",
                LibLocPlus:GetStatusColor(status, UnitFactionGroup("player")) .. status)
        end
        GameTooltip:AddDoubleLine("Level Range", zoneLevelRange)

        if fishingLevel and fishingLevel ~= 0 and playerHasFishing then
            local color = (playerFishingLevel >= fishingLevel) and "|cff40bd40" or "|cffdb2121"
            GameTooltip:AddDoubleLine("Fishing", color .. fishingLevel)
        end

        if pfUI_config.locplus.enablerecommendedzones == "1" or pfUI_config.locplus.enablerecommendedinstances == "1" then
            local recZones, recInstances = lpRootFrame:GetRecommendedContent(realZone)

            if pfUI_config.locplus.enablerecommendedzones == "1" and recZones and table.getn(recZones) > 0 then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("|cffffffffRecommended Zones:|r")
                for _, entry in ipairs(recZones) do
                    GameTooltip:AddDoubleLine(entry[1], entry[2])
                end
            end

            if pfUI_config.locplus.enablerecommendedinstances == "1" and recInstances and table.getn(recInstances) > 0 then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("|cffffffffRecommended Instances:|r")
                for _, entry in ipairs(recInstances) do
                    GameTooltip:AddDoubleLine(entry[1], entry[2])
                end
            end
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine("Left Click", "|cffffffff" .. "Toggle World Map")
        GameTooltip:AddDoubleLine("Shift-Click", "|cffffffff" .. "Toggle Datatext Panels")
        GameTooltip:AddDoubleLine("Ctrl-Click", "|cffffffff" .. "Toggle Settings")
        GameTooltip:Show()
    end

    lpRootFrame.GetCoordinates = function()
        local x, y = GetPlayerMapPosition("player")
        if x ~= 0 and y ~= 0 then
            return round(x * 100, 1), round(y * 100, 1)
        else
            return "--", "--"
        end
    end

    lpRootFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    lpRootFrame:RegisterEvent("MINIMAP_ZONE_CHANGED")
    lpRootFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    lpRootFrame:SetScript("OnClick", function()
        if IsShiftKeyDown() and arg1 == "LeftButton" then
            local left = _G["lpLeftDataPanel"]
            local right = _G["lpRightDataPanel"]

            local isAnyShown = (left and left:IsShown()) or (right and right:IsShown())

            if isAnyShown then
                if left then left:Hide() end
                if right then right:Hide() end
            else
                if left and pfUI_config.locplus.leftdatapanelenable == "1" then
                    left:Show()
                end
                if right and pfUI_config.locplus.rightdatapanelenable == "1" then
                    right:Show()
                end
            end
            return
        end

        if IsControlKeyDown() and arg1 == "LeftButton" then
            if not pfUI.gui then
                return
            end

            if pfUI.gui:IsShown() then
                pfUI.gui:Hide()
                return
            else
                pfUI.gui:Show()
            end

            if not pfUI.gui.frames["Thirdparty"] then
                return
            end

            pfUI.gui.frames["Thirdparty"]:Click()

            if not pfUI.gui.frames["Thirdparty"]["Location Plus"] then
                return
            end

            pfUI.gui.frames["Thirdparty"]["Location Plus"]:Click()

            return
        end

        if arg1 == "LeftButton" then
            if WorldMapFrame:IsShown() then
                WorldMapFrame:Hide()
            else
                WorldMapFrame:Show()
            end
        end
    end)
    lpRootFrame:SetScript("OnEnter", function()
        lpRootFrame:CreateTooltip()
    end)
    lpRootFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    lpRootFrame:SetScript("OnEvent", function()
        lpRootFrame:Refresh()
    end)
    lpRootFrame:SetScript("OnUpdate", function()
        if pfUI_config.locplus.enableincombat ~= "1" and UnitAffectingCombat("player") then
            EnableAutohide(lpRootFrame, 0.1, true)
            return
        end

        if pfUI_config.locplus.enableininstance ~= "1" and IsInInstance() then
            EnableAutohide(lpRootFrame, 0.1, true)
            return
        end

        DisableAutohide(lpRootFrame)
    end)

    lpRootFrame:SetPoint("TOP", 0, -4)
    lpRootFrame:SetHeight(pfUI_config.locplus.locationframeheight or fontSize + 6)
    lpRootFrame:SetWidth(pfUI_config.locplus.locationframewidth or 270)
    lpRootFrame.text = lpRootFrame:CreateFontString("CentralZoneFrameText", "LOW", "GameFontNormal")
    lpRootFrame.text:SetFont(font, fontSize, "OUTLINE")
    lpRootFrame.text:SetFontObject(GameFontWhite)
    lpRootFrame.text:SetAllPoints(lpRootFrame)
    lpRootFrame.text:SetJustifyH("CENTER")

    CreateBackdrop(lpRootFrame, nil, nil, backgroundTransparency)

    if pfUI_config.locplus.enableshadow == "1" then
        CreateBackdropShadow(lpRootFrame)
    end

    UpdateMovable(lpRootFrame)


    -- =================================
    -- ==   Left X Coordinate Frame   ==
    -- =================================
    local lpXCoordinate = CreateFrame("Frame", "lpXCoordinate", lpRootFrame)
    lpXCoordinate:RegisterEvent("PLAYER_ENTERING_WORLD")
    lpXCoordinate:SetScript("OnEvent", function()
        if pfUI_config.locplus.leftcoordinateframeenable ~= "1" then
            lpXCoordinate:Hide()
            return
        end
    end)
    lpXCoordinate:SetScript("OnUpdate", function()
        if (this.tick or 0) > GetTime() then
            return
        end
        this.tick = GetTime() + .5

        local x = lpRootFrame:GetCoordinates()
        lpXCoordinate.text:SetText(x)
    end)
    lpXCoordinate:SetPoint("LEFT", -((pfUI_config.locplus.leftcoordinateframewidth or fontSize + 16) + 6), 0)
    lpXCoordinate:SetHeight(pfUI_config.locplus.leftcoordinateframeheight or fontSize + 2)
    lpXCoordinate:SetWidth(pfUI_config.locplus.leftcoordinateframewidth or fontSize + 16)
    lpXCoordinate.text = lpXCoordinate:CreateFontString("lpXCoordinateText", "LOW", "GameFontNormal")
    lpXCoordinate.text:SetFont(font, fontSize, "OUTLINE")
    lpXCoordinate.text:SetFontObject(GameFontWhite)
    lpXCoordinate.text:SetAllPoints(lpXCoordinate)
    lpXCoordinate.text:SetJustifyH("CENTER")

    CreateBackdrop(lpXCoordinate, nil, nil, backgroundTransparency)

    if pfUI_config.locplus.enableshadow == "1" then
        CreateBackdropShadow(lpXCoordinate)
    end


    -- ==================================
    -- ==   Right Y Coordinate Frame   ==
    -- ==================================
    local lpYCoordinate = CreateFrame("Frame", "lpYCoordinate", lpRootFrame)
    lpYCoordinate:RegisterEvent("PLAYER_ENTERING_WORLD")
    lpYCoordinate:SetScript("OnEvent", function()
        if pfUI_config.locplus.rightcoordinateframeenable ~= "1" then
            lpYCoordinate:Hide()
            return
        end
    end)
    lpYCoordinate:SetScript("OnUpdate", function()
        if (this.tick or 0) > GetTime() then
            return
        end
        this.tick = GetTime() + .5

        local _, y = lpRootFrame:GetCoordinates()
        lpYCoordinate.text:SetText(y)
    end)
    lpYCoordinate:SetPoint("RIGHT", (pfUI_config.locplus.rightcoordinateframewidth or fontSize + 16) + 6, 0)
    lpYCoordinate:SetHeight(pfUI_config.locplus.rightcoordinateframeheight or fontSize + 2)
    lpYCoordinate:SetWidth(pfUI_config.locplus.rightcoordinateframewidth or fontSize + 16)
    lpYCoordinate.text = lpYCoordinate:CreateFontString("lpYCoordinateText", "LOW", "GameFontNormal")
    lpYCoordinate.text:SetFont(font, fontSize, "OUTLINE")
    lpYCoordinate.text:SetFontObject(GameFontWhite)
    lpYCoordinate.text:SetAllPoints(lpYCoordinate)
    lpYCoordinate.text:SetJustifyH("CENTER")

    CreateBackdrop(lpYCoordinate, nil, nil, backgroundTransparency)

    if pfUI_config.locplus.enableshadow == "1" then
        CreateBackdropShadow(lpYCoordinate)
    end


    -- ===================================
    -- ==   Left Datatext Panel Frame   ==
    -- ===================================
    local lpLeftDataPanelParent = lpXCoordinate

    if pfUI_config.locplus.leftcoordinateframeenable ~= "1" then
        lpLeftDataPanelParent = lpRootFrame
    end

    local lpLeftDataPanel = CreateFrame("Button", "lpLeftDataPanel", lpLeftDataPanelParent)
    lpLeftDataPanel:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    lpLeftDataPanel:RegisterEvent("PLAYER_ENTERING_WORLD")
    lpLeftDataPanel:SetScript("OnEvent", function()
        if pfUI_config.locplus.leftdatapanelenable ~= "1" then
            lpLeftDataPanel:Hide()
            return
        end
    end)
    lpLeftDataPanel:SetPoint("LEFT", -((pfUI_config.locplus.leftdatapanelwidth or 100) + 6), 0)
    lpLeftDataPanel:SetHeight(pfUI_config.locplus.leftdatapanelheight or fontSize + 2)
    lpLeftDataPanel:SetWidth(pfUI_config.locplus.leftdatapanelwidth or 100)
    lpLeftDataPanel.text = lpLeftDataPanel:CreateFontString("lpLeftDataPanelText", "LOW", "GameFontNormal")
    lpLeftDataPanel.text:SetFont(font, fontSize, "OUTLINE")
    lpLeftDataPanel.text:SetFontObject(GameFontWhite)
    lpLeftDataPanel.text:SetAllPoints(lpLeftDataPanel)
    lpLeftDataPanel.text:SetJustifyH("CENTER")

    CreateBackdrop(lpLeftDataPanel, nil, nil, backgroundTransparency)

    if pfUI_config.locplus.enableshadow == "1" then
        CreateBackdropShadow(lpLeftDataPanel)
    end


    -- ====================================
    -- ==   Right Datatext Panel Frame   ==
    -- ====================================
    local lpRightDataPanelParent = lpYCoordinate

    if pfUI_config.locplus.rightcoordinateframeenable ~= "1" then
        lpRightDataPanelParent = lpRootFrame
    end

    local lpRightDataPanel = CreateFrame("Button", "lpRightDataPanel", lpRightDataPanelParent)
    lpLeftDataPanel:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    lpRightDataPanel:RegisterEvent("PLAYER_ENTERING_WORLD")
    lpRightDataPanel:SetScript("OnEvent", function()
        if pfUI_config.locplus.rightdatapanelenable ~= "1" then
            lpRightDataPanel:Hide()
            return
        end
    end)
    lpRightDataPanel:SetPoint("RIGHT", (pfUI_config.locplus.rightdatapanelwidth or 100) + 6, 0)
    lpRightDataPanel:SetHeight(pfUI_config.locplus.rightdatapanelheight or fontSize + 2)
    lpRightDataPanel:SetWidth(pfUI_config.locplus.rightdatapanelwidth or 100)
    lpRightDataPanel.text = lpRightDataPanel:CreateFontString("lpRightDataPanelText", "LOW", "GameFontNormal")
    lpRightDataPanel.text:SetFont(font, fontSize, "OUTLINE")
    lpRightDataPanel.text:SetFontObject(GameFontWhite)
    lpRightDataPanel.text:SetAllPoints(lpRightDataPanel)
    lpRightDataPanel.text:SetJustifyH("CENTER")

    CreateBackdrop(lpRightDataPanel, nil, nil, backgroundTransparency)

    if pfUI_config.locplus.enableshadow == "1" then
        CreateBackdropShadow(lpRightDataPanel)
    end

    if pfUI.panel and pfUI.panel.OutputPanel then
        local hook_OutputPanel = pfUI.panel.OutputPanel
        pfUI.panel.OutputPanel = function(self, entry, value, tooltip, func)
            hook_OutputPanel(self, entry, value, tooltip, func)

            if pfUI_config.locplus.leftdatapanelenable == "1" and entry == pfUI_config.locplus.leftdatapaneldatatext then
                if lpLeftDataPanel:IsShown() then
                    lpLeftDataPanel.text:SetText(value)

                    if lpLeftDataPanel.setup ~= entry then
                        lpLeftDataPanel:SetScript("OnEnter", tooltip)
                        lpLeftDataPanel:SetScript("OnLeave", function() GameTooltip:Hide() end)
                        lpLeftDataPanel:SetScript("OnClick", func)
                        lpLeftDataPanel.setup = entry
                    end
                end
            end

            if pfUI_config.locplus.rightdatapanelenable == "1" and entry == pfUI_config.locplus.rightdatapaneldatatext then
                if lpRightDataPanel:IsShown() then
                    lpRightDataPanel.text:SetText(value)

                    if lpRightDataPanel.setup ~= entry then
                        lpRightDataPanel:SetScript("OnEnter", tooltip)
                        lpRightDataPanel:SetScript("OnLeave", function() GameTooltip:Hide() end)
                        lpRightDataPanel:SetScript("OnClick", func)
                        lpRightDataPanel.setup = entry
                    end
                end
            end
        end
    end

    LocationPlus = lpRootFrame
end)
