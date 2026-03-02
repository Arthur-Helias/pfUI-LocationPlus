setfenv(1, pfUI:GetEnvironment())

local fontSize = C.panel.use_unitfonts == "1" and C.global.font_unit_size or C.global.font_size

local DoesTableContainsKeyLP = function(table, contains)
    return table[contains] ~= nil
end

local function InitializeDefaultValues()
    if not pfUI_config then return end

    if not DoesTableContainsKeyLP(pfUI_config, "locplus") then
        pfUI_config.locplus = {}
    end

    local defaults = {
        enableincombat = "1",
        enableininstance = "1",
        enableshadow = "1",
        enabletransparent = "1",
        enablerecommendedzones = "1",
        enablerecommendedinstances = "1",
        coloredstatuslocation = "0",
        locationframeheight = fontSize + 6,
        locationframewidth = 270,
        leftcoordinateframeenable = "1",
        leftcoordinateframeheight = fontSize + 2,
        leftcoordinateframewidth = fontSize + 16,
        rightcoordinateframeenable = "1",
        rightcoordinateframeheight = fontSize + 2,
        rightcoordinateframewidth = fontSize + 16,
        leftdatapanelenable = "1",
        leftdatapaneldatatext = "durability",
        leftdatapanelheight = fontSize + 2,
        leftdatapanelwidth = 100,
        rightdatapanelenable = "1",
        rightdatapaneldatatext = "time",
        rightdatapanelheight = fontSize + 2,
        rightdatapanelwidth = 100,
    }

    for key, value in pairs(defaults) do
        if not DoesTableContainsKeyLP(pfUI_config.locplus, key) then
            pfUI:UpdateConfig("locplus", nil, key, value)
        end
    end
end


local function CreateGuiConfigEntries()
    local CreateConfig = pfUI.gui.CreateConfig
    local CreateGUIEntry = pfUI.gui.CreateGUIEntry
    local U = pfUI.gui.UpdaterFunctions

    CreateGUIEntry(T["Thirdparty"], T["Location Plus"], function()
        -- General Options
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_GENERALOPTIONS], nil, nil, "header")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_ENABLEINCOMBAT], C.locplus, "enableincombat", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_ENABLEININSTANCE], C.locplus, "enableininstance", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_ENABLESHADOW], C.locplus, "enableshadow", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_ENABLETRANSPARENT], C.locplus, "enabletransparent", "checkbox")

        -- Tooltip Options
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_TOOLTIPOPTIONS], nil, nil, "header")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_RECOMMENDEDZONES], C.locplus, "enablerecommendedzones", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_RECOMMENDEDINSTANCES], C.locplus, "enablerecommendedinstances",
            "checkbox")

        -- Central Zone Panel Options
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_CENTRALZONEPANEL], nil, nil, "header")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_COLOREDSTATUSLOCATION], C.locplus, "coloredstatuslocation", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELHEIGHT], C.locplus, "locationframeheight", "text", nil, nil,
            nil, "number")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELWIDTH], C.locplus, "locationframewidth", "text", nil, nil, nil,
            "number")

        -- Left Coordinate Panel Options
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_LEFTCOORDINATEPANEL], nil, nil, "header")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELENABLE], C.locplus, "leftcoordinateframeenable", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELHEIGHT], C.locplus, "leftcoordinateframeheight", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELWIDTH], C.locplus, "leftcoordinateframewidth", "text", nil,
            nil,
            nil, "number")

        -- Right Coordinate Panel Options
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_RIGHTCOORDINATEPANEL], nil, nil, "header")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELENABLE], C.locplus, "rightcoordinateframeenable", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELHEIGHT], C.locplus, "rightcoordinateframeheight", "text",
            nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELWIDTH], C.locplus, "rightcoordinateframewidth", "text", nil,
            nil,
            nil, "number")

        -- Left Data Panel Options
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_LEFTDATAPANEL], nil, nil, "header")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELENABLE], C.locplus, "leftdatapanelenable", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELDATATEXT], C.locplus, "leftdatapaneldatatext", "dropdown",
            pfUI.gui.dropdowns.panel_values)
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELHEIGHT], C.locplus, "leftdatapanelheight", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELWIDTH], C.locplus, "leftdatapanelwidth", "text", nil,
            nil,
            nil, "number")

        -- Right Data Panel Options
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_RIGHTDATAPANEL], nil, nil, "header")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELENABLE], C.locplus, "rightdatapanelenable", "checkbox")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELDATATEXT], C.locplus, "rightdatapaneldatatext", "dropdown",
            pfUI.gui.dropdowns.panel_values)
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELHEIGHT], C.locplus, "rightdatapanelheight", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_PANELWIDTH], C.locplus, "rightdatapanelwidth", "text", nil,
            nil,
            nil, "number")

        -- Version + Website
        CreateConfig(U["locplus"],
            T[PFLP_SETTINGS_VERSIONLABEL .. " " .. PFLP_VERSION_MAJOR .. "." .. PFLP_VERSION_MINOR .. "." .. PFLP_VERSION_PATCH],
            nil, nil, "header")
        CreateConfig(U["locplus"], T[PFLP_SETTINGS_WEBSITE], nil, nil, "button", function()
            pfUI.chat.urlcopy.CopyText("https://github.com/Arthur-Helias/pfUI-LocationPlus")
        end)
    end)
end

local configFrame = CreateFrame("Frame")
configFrame:RegisterEvent("VARIABLES_LOADED")
configFrame:SetScript("OnEvent", function()
    InitializeDefaultValues()
    CreateGuiConfigEntries()
end)
