PFLP_VERSION_MAJOR = "1"
PFLP_VERSION_MINOR = "3"
PFLP_VERSION_PATCH = "2"

pfUI:RegisterModule("locationplus", "vanilla", function()
    local font = C.panel.use_unitfonts == "1" and pfUI.font_unit or pfUI.font_default
    local fontSize = C.panel.use_unitfonts == "1" and C.global.font_unit_size or C.global.font_size

    if not pfUI_config.locplus then
        pfUI_config.locplus = {}
    end

    local backgroundTransparency = nil

    if pfUI_config.locplus.enabletransparent == "1" then
        backgroundTransparency = 0.85
    end

    local shadow = pfUI_config.locplus.enableshadow


    -- =================
    -- ==   Helpers   ==
    -- =================

    local function ApplyPanelStyling(frame, textName)
        frame.text = frame:CreateFontString(textName, "LOW", "GameFontNormal")
        frame.text:SetFont(font, fontSize, "OUTLINE")
        frame.text:SetFontObject(GameFontWhite)
        frame.text:SetAllPoints(frame)
        frame.text:SetJustifyH("CENTER")

        pfUI.api.CreateBackdrop(frame, nil, nil, backgroundTransparency)

        if shadow == "1" then
            pfUI.api.CreateBackdropShadow(frame)
        end
    end

    local function UpdateDataPanel(panel, enableKey, dataKey, entry, value, tooltip, func)
        if pfUI_config.locplus[enableKey] == "1" and entry == pfUI_config.locplus[dataKey] then
            if panel:IsShown() then
                panel.text:SetText(value)

                if panel.setup ~= entry then
                    panel:SetScript("OnEnter", tooltip)
                    panel:SetScript("OnLeave", function() GameTooltip:Hide() end)
                    panel:SetScript("OnClick", func)
                    panel.setup = entry
                end
            end
        end
    end


    -- ======================================
    -- ==   Central Zone Name Root Frame   ==
    -- ======================================
    local lpRootFrame = CreateFrame("Button", "CentralZoneFrame", UIParent)

    lpRootFrame.Refresh = function()
        if IsInInstance() then
            lpRootFrame:InstanceRefresh()
        else
            lpRootFrame:WorldRefresh()
        end
    end

    lpRootFrame.InstanceRefresh = function()
        local currentRealZone = GetRealZoneText()

        if not currentRealZone then
            lpRootFrame.text:SetText(PFLP_ERROR_NOREALZONE)
            return
        end

        local instanceInformation = LibLocPlus:GetInstanceInformation(currentRealZone)

        if not instanceInformation then
            lpRootFrame.text:SetText(PFLP_ERROR_NOREALZONE)
            return
        end

        lpRootFrame.text:SetText(GetMinimapZoneText() ..
            " " ..
            LibLocPlus:GetZoneLevelRangeText(instanceInformation.MinLevelRange, instanceInformation.MaxLevelRange))
    end

    lpRootFrame.WorldRefresh = function()
        local currentRealZone = GetRealZoneText()

        if not currentRealZone then
            lpRootFrame.text:SetText(PFLP_ERROR_NOREALZONE)
            return
        end

        local zoneInformation = LibLocPlus:GetZoneInformation(currentRealZone)

        if not zoneInformation then
            lpRootFrame.text:SetText(PFLP_ERROR_NOREALZONE)
            return
        end

        local zoneLevelRangeText = LibLocPlus:GetZoneLevelRangeText(zoneInformation.MinLevelRange,
            zoneInformation.MaxLevelRange)
        local finalText = GetMinimapZoneText()

        if pfUI_config.locplus.coloredstatuslocation == "1" then
            finalText = LibLocPlus:GetColorFromZoneStatus(zoneInformation.Status) .. finalText .. "|r"
        end

        lpRootFrame.text:SetText(finalText .. " " .. zoneLevelRangeText)
    end

    lpRootFrame.CreateTooltip = function()
        local isPlayerInInstance = IsInInstance()
        local realZoneText = GetRealZoneText()
        local zoneInformation = nil

        if isPlayerInInstance then
            zoneInformation = LibLocPlus:GetInstanceInformation(realZoneText)
        else
            zoneInformation = LibLocPlus:GetZoneInformation(realZoneText)
        end

        if not zoneInformation then
            GameTooltip:ClearLines()
            GameTooltip_SetDefaultAnchor(GameTooltip, lpRootFrame)
            GameTooltip:AddLine(PFLP_ERROR_TOOLTIPNOZONEINFORMATION)
            GameTooltip:Show()
            return
        end

        local playerFisherman, playerFishingLevel = LibLocPlus:IsPlayerFisherman()

        GameTooltip:ClearLines()
        GameTooltip_SetDefaultAnchor(GameTooltip, lpRootFrame)
        GameTooltip:AddLine(LibLocPlus.Colors.DarkGray .. PFLP_TOOLTIP_ZONEINFORMATIONTITLE)
        GameTooltip:AddDoubleLine(PFLP_TOOLTIP_ZONELABEL, LibLocPlus.Colors.White .. realZoneText)
        GameTooltip:AddDoubleLine(PFLP_TOOLTIP_CONTINENTLABEL, LibLocPlus.Colors.White .. zoneInformation.Continent)

        if not isPlayerInInstance then
            GameTooltip:AddDoubleLine(PFLP_TOOLTIP_STATUSLABEL,
                LibLocPlus:GetColorFromZoneStatus(zoneInformation.Status) .. zoneInformation.Status)
        end

        local zoneLevelRange = zoneInformation.MinLevelRange .. "-" .. zoneInformation.MaxLevelRange

        if zoneInformation.MinLevelRange == zoneInformation.MaxLevelRange then
            zoneLevelRange = tostring(zoneInformation.MaxLevelRange)
        end

        GameTooltip:AddDoubleLine(PFLP_TOOLTIP_LEVELRANGELABEL, LibLocPlus:GetZoneLevelRangeColor(zoneInformation.MinLevelRange, zoneInformation.MaxLevelRange) .. zoneLevelRange)

        if not isPlayerInInstance and playerFisherman and zoneInformation.FishingLevelRequirement ~= 0 then
            local color = (playerFishingLevel >= zoneInformation.FishingLevelRequirement) and LibLocPlus.Colors.Green or
                LibLocPlus.Colors.Red
            GameTooltip:AddDoubleLine(PFLP_TOOLTIP_FISHINGLABEL, color .. zoneInformation.FishingLevelRequirement)
        end

        if pfUI_config.locplus.enablerecommendedzones == "1" or pfUI_config.locplus.enablerecommendedinstances == "1" then
            local recZones, recInstances = LibLocPlus:GetRecommendedContent(realZoneText)

            if pfUI_config.locplus.enablerecommendedzones == "1" and recZones and table.getn(recZones) > 0 then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(LibLocPlus.Colors.White .. PFLP_TOOLTIP_RECOMMENDEDZONESLABEL .. "|r")
                for _, entry in ipairs(recZones) do
                    GameTooltip:AddDoubleLine(entry[1], entry[2])
                end
            end

            if pfUI_config.locplus.enablerecommendedinstances == "1" and recInstances and table.getn(recInstances) > 0 then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine(LibLocPlus.Colors.White .. PFLP_TOOLTIP_RECOMMENDEDINSTANCESLABEL .. "|r")
                for _, entry in ipairs(recInstances) do
                    GameTooltip:AddDoubleLine(entry[1], entry[2])
                end
            end
        end

        GameTooltip:AddLine(" ")
        GameTooltip:AddDoubleLine(PFLP_TOOLTIP_LEFTCLICKLABEL,
            LibLocPlus.Colors.White .. PFLP_TOOLTIP_TOGGLEWORLDMAPLABEL)
        GameTooltip:AddDoubleLine(PFLP_TOOLTIP_SHIFTCLICKLABEL,
            LibLocPlus.Colors.White .. PFLP_TOOLTIP_TOGGLEDATATEXTPANELSLABEL)
        GameTooltip:AddDoubleLine(PFLP_TOOLTIP_CTRLCLICKLABEL,
            LibLocPlus.Colors.White .. PFLP_TOOLTIP_TOGGLESETTINGSLABEL)
        GameTooltip:Show()
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
                if left then
                    left:Hide()
                end

                if right then
                    right:Hide()
                end
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
            pfUI.api.EnableAutohide(lpRootFrame, 0.1, true)
            return
        end

        if pfUI_config.locplus.enableininstance ~= "1" and IsInInstance() then
            pfUI.api.EnableAutohide(lpRootFrame, 0.1, true)
            return
        end

        pfUI.api.DisableAutohide(lpRootFrame)
    end)

    lpRootFrame:SetPoint("TOP", 0, -4)
    lpRootFrame:SetHeight(pfUI_config.locplus.locationframeheight or fontSize + 6)
    lpRootFrame:SetWidth(pfUI_config.locplus.locationframewidth or 270)
    ApplyPanelStyling(lpRootFrame, "CentralZoneFrameText")

    pfUI.api.UpdateMovable(lpRootFrame)


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

        local x = LibLocPlus:GetCoordinates()

        lpXCoordinate.text:SetText(x)
    end)
    lpXCoordinate:SetPoint("LEFT", -((pfUI_config.locplus.leftcoordinateframewidth or fontSize + 16) + 6), 0)
    lpXCoordinate:SetHeight(pfUI_config.locplus.leftcoordinateframeheight or fontSize + 2)
    lpXCoordinate:SetWidth(pfUI_config.locplus.leftcoordinateframewidth or fontSize + 16)
    ApplyPanelStyling(lpXCoordinate, "lpXCoordinateText")


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

        local _, y = LibLocPlus:GetCoordinates()

        lpYCoordinate.text:SetText(y)
    end)
    lpYCoordinate:SetPoint("RIGHT", (pfUI_config.locplus.rightcoordinateframewidth or fontSize + 16) + 6, 0)
    lpYCoordinate:SetHeight(pfUI_config.locplus.rightcoordinateframeheight or fontSize + 2)
    lpYCoordinate:SetWidth(pfUI_config.locplus.rightcoordinateframewidth or fontSize + 16)
    ApplyPanelStyling(lpYCoordinate, "lpYCoordinateText")


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
    ApplyPanelStyling(lpLeftDataPanel, "lpLeftDataPanelText")


    -- ====================================
    -- ==   Right Datatext Panel Frame   ==
    -- ====================================
    local lpRightDataPanelParent = lpYCoordinate

    if pfUI_config.locplus.rightcoordinateframeenable ~= "1" then
        lpRightDataPanelParent = lpRootFrame
    end

    local lpRightDataPanel = CreateFrame("Button", "lpRightDataPanel", lpRightDataPanelParent)
    lpRightDataPanel:RegisterForClicks("LeftButtonUp", "RightButtonUp")
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
    ApplyPanelStyling(lpRightDataPanel, "lpRightDataPanelText")


    -- ==============================
    -- ==   Datatext Panel Hooks   ==
    -- ==============================
    if pfUI.panel and pfUI.panel.OutputPanel then
        local hook_OutputPanel = pfUI.panel.OutputPanel

        pfUI.panel.OutputPanel = function(self, entry, value, tooltip, func)
            hook_OutputPanel(self, entry, value, tooltip, func)
            UpdateDataPanel(lpLeftDataPanel, "leftdatapanelenable", "leftdatapaneldatatext", entry, value, tooltip, func)
            UpdateDataPanel(lpRightDataPanel, "rightdatapanelenable", "rightdatapaneldatatext", entry, value, tooltip,
                func)
        end
    end

    LocationPlus = lpRootFrame
end)
