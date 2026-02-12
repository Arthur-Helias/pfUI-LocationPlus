setfenv(1, pfUI:GetEnvironment())

local fontSize = C.panel.use_unitfonts == "1" and C.global.font_unit_size or C.global.font_size

local configFrame = CreateFrame("Frame")
configFrame:RegisterEvent("VARIABLES_LOADED")
configFrame:SetScript("OnEvent", function()
    InitializeDefaultValues()
    CreateGuiConfigEntries()
end)

function InitializeDefaultValues()
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config, "locplus") then
        pfUI_config.locplus = {}
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "enableincombat") then
        pfUI:UpdateConfig("locplus", nil, "enableincombat", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "enableininstance") then
        pfUI:UpdateConfig("locplus", nil, "enableininstance", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "enableshadow") then
        pfUI:UpdateConfig("locplus", nil, "enableshadow", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "enabletransparent") then
        pfUI:UpdateConfig("locplus", nil, "enabletransparent", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "enablerecommendedzones") then
        pfUI:UpdateConfig("locplus", nil, "enablerecommendedzones", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "enablerecommendedinstances") then
        pfUI:UpdateConfig("locplus", nil, "enablerecommendedinstances", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "locationframeheight") then
        pfUI:UpdateConfig("locplus", nil, "locationframeheight", fontSize + 6)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "locationframewidth") then
        pfUI:UpdateConfig("locplus", nil, "locationframewidth", 270)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "leftcoordinateframeenable") then
        pfUI:UpdateConfig("locplus", nil, "leftcoordinateframeenable", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "leftcoordinateframeheight") then
        pfUI:UpdateConfig("locplus", nil, "leftcoordinateframeheight", fontSize + 2)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "leftcoordinateframewidth") then
        pfUI:UpdateConfig("locplus", nil, "leftcoordinateframewidth", fontSize + 16)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "rightcoordinateframeenable") then
        pfUI:UpdateConfig("locplus", nil, "rightcoordinateframeenable", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "rightcoordinateframeheight") then
        pfUI:UpdateConfig("locplus", nil, "rightcoordinateframeheight", fontSize + 2)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "rightcoordinateframewidth") then
        pfUI:UpdateConfig("locplus", nil, "rightcoordinateframewidth", fontSize + 16)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "leftdatapanelenable") then
        pfUI:UpdateConfig("locplus", nil, "leftdatapanelenable", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "leftdatapaneldatatext") then
        pfUI:UpdateConfig("locplus", nil, "leftdatapaneldatatext", "durability")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "leftdatapanelheight") then
        pfUI:UpdateConfig("locplus", nil, "leftdatapanelheight", fontSize + 2)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "leftdatapanelwidth") then
        pfUI:UpdateConfig("locplus", nil, "leftdatapanelwidth", 100)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "rightdatapanelenable") then
        pfUI:UpdateConfig("locplus", nil, "rightdatapanelenable", "1")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "rightdatapaneldatatext") then
        pfUI:UpdateConfig("locplus", nil, "rightdatapaneldatatext", "time")
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "rightdatapanelheight") then
        pfUI:UpdateConfig("locplus", nil, "rightdatapanelheight", fontSize + 2)
    end
    if pfUI_config and not DoesTableContainsKeyLP(pfUI_config.locplus, "rightdatapanelwidth") then
        pfUI:UpdateConfig("locplus", nil, "rightdatapanelwidth", 100)
    end
end

function CreateGuiConfigEntries()
    local CreateConfig = pfUI.gui.CreateConfig
    local CreateGUIEntry = pfUI.gui.CreateGUIEntry
    local U = pfUI.gui.UpdaterFunctions

    CreateGUIEntry(T["Thirdparty"], T["Location Plus"], function()
        CreateConfig(U["locplus"], T["General Options"], nil, nil, "header")
        CreateConfig(U["locplus"], T["Enable In Combat"], C.locplus, "enableincombat", "checkbox")
        CreateConfig(U["locplus"], T["Enable In Instance"], C.locplus, "enableininstance", "checkbox")
        CreateConfig(U["locplus"], T["Enable Frames Background Shadow"], C.locplus, "enableshadow", "checkbox")
        CreateConfig(U["locplus"], T["Enable Frames Transparent Background"], C.locplus, "enabletransparent", "checkbox")
        CreateConfig(U["locplus"], T["Tooltip Options"], nil, nil, "header")
        CreateConfig(U["locplus"], T["Show Recommended Zones"], C.locplus, "enablerecommendedzones", "checkbox")
        CreateConfig(U["locplus"], T["Show Recommended Instances"], C.locplus, "enablerecommendedinstances", "checkbox")
        CreateConfig(U["locplus"], T["Central Zone Frame"], nil, nil, "header")
        CreateConfig(U["locplus"], T["Frame Height"], C.locplus, "locationframeheight", "text", nil, nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Frame Width"], C.locplus, "locationframewidth", "text", nil, nil, nil,
            "number")
        CreateConfig(U["locplus"], T["Left Coordinate Frame (x)"], nil, nil, "header")
        CreateConfig(U["locplus"], T["Enabled"], C.locplus, "leftcoordinateframeenable", "checkbox")
        CreateConfig(U["locplus"], T["Frame Height"], C.locplus, "leftcoordinateframeheight", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Frame Width"], C.locplus, "leftcoordinateframewidth", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Right Coordinate Frame (y)"], nil, nil, "header")
        CreateConfig(U["locplus"], T["Enabled"], C.locplus, "rightcoordinateframeenable", "checkbox")
        CreateConfig(U["locplus"], T["Frame Height"], C.locplus, "rightcoordinateframeheight", "text",
            nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Frame Width"], C.locplus, "rightcoordinateframewidth", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Left Data Panel"], nil, nil, "header")
        CreateConfig(U["locplus"], T["Enabled"], C.locplus, "leftdatapanelenable", "checkbox")
        CreateConfig(U["locplus"], T["Datatext"], C.locplus, "leftdatapaneldatatext", "dropdown",
            pfUI.gui.dropdowns.panel_values)
        CreateConfig(U["locplus"], T["Panel Height"], C.locplus, "leftdatapanelheight", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Panel Width"], C.locplus, "leftdatapanelwidth", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Right Data Panel"], nil, nil, "header")
        CreateConfig(U["locplus"], T["Enabled"], C.locplus, "rightdatapanelenable", "checkbox")
        CreateConfig(U["locplus"], T["Datatext"], C.locplus, "rightdatapaneldatatext", "dropdown",
            pfUI.gui.dropdowns.panel_values)
        CreateConfig(U["locplus"], T["Panel Height"], C.locplus, "rightdatapanelheight", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Panel Width"], C.locplus, "rightdatapanelwidth", "text", nil,
            nil,
            nil, "number")
        CreateConfig(U["locplus"], T["Location Plus Version: 1.0"], nil, nil, "header")
        CreateConfig(U["locplus"], T["Website"], nil, nil, "button", function()
            pfUI.chat.urlcopy.CopyText("https://github.com/Arthur-Helias/pfUI-LocationPlus")
        end)
    end)
end

DoesTableContainsKeyLP = function(table, contains)
    return table[contains] ~= nil
end
