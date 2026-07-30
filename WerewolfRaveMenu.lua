--[[
    If LibAddonMenu-2.0 is installed, this will add a menu for this addon.
]]

WerewolfRaveMenu = {}

WerewolfRaveMenu.optionsData = {}
WerewolfRaveMenu.panel = nil
WerewolfRaveMenu.panelName = "WerewolfRaveOptions"
WerewolfRaveMenu.panelData = {}

-- constants
WerewolfRaveMenu.STYLESEQUENCE_ICON_SIZE = 64
WerewolfRaveMenu.STYLESEQUENCE_MAX_COLUMNS = 3
WerewolfRaveMenu.STYLESEQUENCE_VISIBLE_ROWS = 2

function WerewolfRaveMenu.GetAuto()
    return WerewolfRave.savedVars.allowChangeWhenAuto
end

function WerewolfRaveMenu.SetAuto(value)
    if (value == true) then
        WerewolfRave.allowChangeWhenAuto = true
        WerewolfRave.savedVars.allowChangeWhenAuto = true
    else
        WerewolfRave.allowChangeWhenAuto = false
        WerewolfRave.savedVars.allowChangeWhenAuto = false
    end
end

function WerewolfRaveMenu.GetTF()
    return WerewolfRave.savedVars.allowChangeWhenTF
end

function WerewolfRaveMenu.SetTF(value)
    if (value == true) then
        WerewolfRave.allowChangeWhenTF = true
        WerewolfRave.savedVars.allowChangeWhenTF = true
    else
        WerewolfRave.allowChangeWhenTF = false
        WerewolfRave.savedVars.allowChangeWhenTF = false
    end
end

function WerewolfRaveMenu.GetCombat()
    return WerewolfRave.savedVars.enabledInCombat
end

function WerewolfRaveMenu.SetCombat(value)
    if (value == true) then
        WerewolfRave.enabledInCombat = true
        WerewolfRave.savedVars.enabledInCombat = true
    else
        WerewolfRave.enabledInCombat = false
        WerewolfRave.savedVars.enabledInCombat = false
    end
end

function WerewolfRaveMenu.GetFrequency()
    return WerewolfRave.savedVars.frequency
end

function WerewolfRaveMenu.SetFrequency(value)
    WerewolfRave.frequency = value
    WerewolfRave.savedVars.frequency = value
    WerewolfRave.UpdateFrequency()
end

function WerewolfRaveMenu.GetCombatFrequency()
    return WerewolfRave.savedVars.frequencyInCombat
end

function WerewolfRaveMenu.SetCombatFrequency(value)
    WerewolfRave.frequencyInCombat = value
    WerewolfRave.savedVars.frequencyInCombat = value
    WerewolfRave.UpdateFrequency()
end

function WerewolfRaveMenu.GetDuplicates()
    return WerewolfRave.savedVars.allowDisableStyle
end

function WerewolfRaveMenu.SetDuplicates(value)
    if (value == true) then
        WerewolfRave.allowDisableStyle = true
        WerewolfRave.savedVars.allowDisableStyle = true
    else
        WerewolfRave.allowDisableStyle = false
        WerewolfRave.savedVars.allowDisableStyle = false
    end
end

function WerewolfRaveMenu.GetRandom()
    return WerewolfRave.savedVars.randomized
end

function WerewolfRaveMenu.SetRandom(value)
    if (value == true) then
        WerewolfRave.randomized = true
        WerewolfRave.savedVars.randomized = true
    else
        WerewolfRave.randomized = false
        WerewolfRave.savedVars.randomized = false
    end
end

function WerewolfRaveMenu.GetStyleSequence(index) -- returns the icon of the skill at this index in the chosenStyleList
    -- if 

    index = tonumber(index)
    -- return chosenStyleList icon at this index
    return GetCollectibleIcon(WerewolfRave.savedVars.chosenStyleList[index])
end

function WerewolfRaveMenu.SetStyleSequence(index, value) -- sets the style at this index in the chosenStyleList, picked by the user via icon
    index = tonumber(index)
    value = tonumber(value)

    WerewolfRave.SetList(false, index, value)
end


function WerewolfRaveMenu.AddNewStyleRow()
    -- determine the default style
    local defaultStyle = nil
    local currentStyle = nil
    for i = 1, #WerewolfRave.discoveredStyleList do
        currentStyle = WerewolfRave.discoveredStyleList[i]
        if (IsCollectibleUnlocked(currentStyle)) then
            defaultStyle = currentStyle -- default style is the first unlocked style discovered
            break
        end
    end

    if (defaultStyle == nil) then return end -- if there are no styles unlocked, return

    -- create a new row internally
    WerewolfRave.SetList(false, "new", defaultStyle)

    -- create a new row in the gui
    WerewolfRaveMenu.optionsData[#WerewolfRaveMenu.optionsData + 1] =
    {
        type = "iconpicker",
        name = tostring(i),
        choices = styleSequenceImages,
        choicesTooltips = styleSequenceNames,
        iconSize = WerewolfRaveMenu.STYLESEQUENCE_ICON_SIZE,
        maxColumns = WerewolfRaveMenu.STYLESEQUENCE_MAX_COLUMNS,
        visibleRows = WerewolfRaveMenu.STYLESEQUENCE_VISIBLE_ROWS,
        getFunc = function() return WerewolfRaveMenu.GetStyleSequence(i) end,
        setFunc = function(value) WerewolfRaveMenu.SetStyleSequence(i, styleSequenceImageToID[value]) end
    }

    --WerewolfRaveMenu.panel = LibAddonMenu2:RegisterAddonPanel(WerewolfRaveMenu.panelName, WerewolfRaveMenu.panelData)
    --LibAddonMenu2:RegisterOptionControls(WerewolfRaveMenu.panelName, WerewolfRaveMenu.optionsData)
end


function WerewolfRaveMenu.RemoveLastStyleRow()
    if (#WerewolfRave.savedVars.chosenStyleList > 0) then
        -- remove the last element from the internal list
        WerewolfRave.SetList(false, "new", "nil")

        -- set the last entry of the optionsData table to nil
        WerewolfRaveMenu.optionsData[#WerewolfRaveMenu.optionsData] = nil
    end
    
    --WerewolfRaveMenu.panel = LibAddonMenu2:RegisterAddonPanel(WerewolfRaveMenu.panelName, WerewolfRaveMenu.panelData)
    --LibAddonMenu2:RegisterOptionControls(WerewolfRaveMenu.panelName, WerewolfRaveMenu.optionsData)
end


function WerewolfRaveMenu.Initialize()
    if (LibAddonMenu2) then
        -- addon is installed
        local LAM2 = LibAddonMenu2

        WerewolfRaveMenu.panelData = {}
        WerewolfRaveMenu.panelData.type = "panel"
        WerewolfRaveMenu.panelData.name = "Werewolf Rave"
        WerewolfRaveMenu.panelData.displayName = "|c3D3D4CWere|c8F807Ewolf |cE3E0E0Rave|r"
        WerewolfRaveMenu.panelData.author = "@Erickson9610"
        WerewolfRaveMenu.panelData.keywords = "werewolf"
        WerewolfRaveMenu.panelData.slashCommand = "/wwrui"
        WerewolfRaveMenu.panelData.registerForRefresh = true



        -- build valid icon picker options
        local styleSequenceImages = {}
        local styleSequenceNames = {}
        local styleSequenceImageToID = {}
        for i = 1, #WerewolfRave.discoveredStyleList do
            local currentStyle = WerewolfRave.discoveredStyleList[i]
            if (IsCollectibleUnlocked(currentStyle)) then
                styleSequenceImages[#styleSequenceImages + 1] = GetCollectibleIcon(currentStyle)
                styleSequenceNames[#styleSequenceNames + 1] = GetCollectibleName(currentStyle)
                styleSequenceImageToID[GetCollectibleIcon(currentStyle)] = currentStyle
            end
        end

        WerewolfRaveMenu.optionsData = {
            {
                type = "description",
                text = "Werewolf Rave automatically equips Werewolf Form Skill Styles depending on the selected activation methods, according to your custom style sequence.\n\nUse this addon to shuffle between your unlocked styles, loop through them in a sequence, give a weighted chance for certain styles to appear, and more!"
            },
            {
                type = "header",
                name = "Activation Methods",
                width = "full"
            },
            {
                type = "checkbox",
                name = "Activate continuously while transformed",
                tooltip = "Enables continuous swapping of Werewolf Form styles while transformed. Use this if you want to continuously change your fur color!",
                getFunc = function() 
                    return WerewolfRaveMenu.GetAuto() 
                end,
                setFunc = function(value) 
                    WerewolfRaveMenu.SetAuto(value) 
                end
            },
            {
                type = "checkbox",
                name = "Activate every time you revert form",
                tooltip = "Change your Werewolf Form style every time you revert form. Use this if you want to look different when you transform again!",
                getFunc = function() 
                    return WerewolfRaveMenu.GetTF() 
                end,
                setFunc = function(value) 
                    WerewolfRaveMenu.SetTF(value) 
                end
            },
            {
                type = "header",
                name = "Settings",
                width = "full"
            },
            {
                type = "dropdown",
                name = "Selection Method",
                choices = {"Randomized", "Sequential"},
                choicesValues = {true, false},
                choicesTooltips = {"The next style will be randomly selected.", "The next style will be the next in the sequence."},
                tooltip = "Determines whether the style sequence should be iterated through in a sequence, or treated as a list of weighted probabilities.",
                getFunc = function()
                    return WerewolfRaveMenu.GetRandom()
                end,
                setFunc = function(value)
                    WerewolfRaveMenu.SetRandom(value)
                end
            },
            {
                type = "checkbox",
                name = "Allow style changes while in combat",
                tooltip = "Allows Werewolf Rave to change your equipped style while you are in combat.",
                warning = "|cFF0000Style changes will delay ability casts!|r Adjust the frequency to make interrupts less likely or leave this disabled!",
                getFunc = function() 
                    return WerewolfRaveMenu.GetCombat() 
                end,
                setFunc = function(value) 
                    WerewolfRaveMenu.SetCombat(value) 
                end
            },
            {
                type = "checkbox",
                name = "Allow styles to be toggled off",
                tooltip = "If the equipped style is slated to be selected again, this setting will allow the style to be re-equipped, which unequips it and shows your morph's fur color underneath.",
                getFunc = function()
                    return WerewolfRaveMenu.GetDuplicates()
                end,
                setFunc = function(value)
                    WerewolfRaveMenu.SetDuplicates(value)
                end
            },
            {
                type = "slider",
                name = "Frequency",
                tooltip = "Determines the out-of-combat interval between style changes in seconds.",
                getFunc = function()
                    return WerewolfRaveMenu.GetFrequency()
                end,
                setFunc = function(value)
                    WerewolfRaveMenu.SetFrequency(value)
                end,
                disabled = function() 
                    return (not WerewolfRaveMenu.GetAuto())
                end,
                min = WerewolfRave.FREQUENCY_LOWER,
                max = WerewolfRave.FREQUENCY_UPPER
            },
            {
                type = "slider",
                name = "Frequency (in combat)",
                tooltip = "Determines the in-combat interval between style changes in seconds.",
                getFunc = function()
                    return WerewolfRaveMenu.GetCombatFrequency()
                end,
                setFunc = function(value)
                    WerewolfRaveMenu.SetCombatFrequency(value)
                end,
                disabled = function() 
                    return (not WerewolfRaveMenu.GetAuto() or not WerewolfRaveMenu.GetCombat())
                end,
                min = WerewolfRave.FREQUENCY_COMBAT_LOWER,
                max = WerewolfRave.FREQUENCY_COMBAT_UPPER
            },
            {
                type = "header",
                name = "Style Sequence",
                width = "full"
            },
            {
                type = "description",
                text = '|cFF0000Reload the UI to see changes to the list size!|r Alternatively, you can edit the list with /wwr idtable, /wwr getlist, and /wwr setlist <index> <styleID>.'
            },
            {
                type = "button",
                name = "Add New",
                tooltip = "Create a new entry at the end of the list.",
                width = "half",
                func = function()
                    return WerewolfRaveMenu.AddNewStyleRow()
                end
            },
            {
                type = "button",
                name = "Remove Last",
                tooltip = "Remove the last entry from the end of the list.",
                width = "half",
                func = function() 
                    return WerewolfRaveMenu.RemoveLastStyleRow()
                end
            } -- 14th
            --[[{  
                type = "iconpicker",
                name = "1",
                choices = styleSequenceImages,
                choicesTooltips = styleSequenceNames,
                iconSize = WerewolfRaveMenu.STYLESEQUENCE_ICON_SIZE,
                maxColumns = WerewolfRaveMenu.STYLESEQUENCE_MAX_COLUMNS,
                visibleRows = WerewolfRaveMenu.STYLESEQUENCE_VISIBLE_ROWS,
                getFunc = function()
                    return WerewolfRaveMenu.GetStyleSequence(WerewolfRaveMenu.optionsData[14].name)
                end,
                setFunc = function(value) 
                    WerewolfRaveMenu.SetStyleSequence(WerewolfRaveMenu.optionsData[14].name, styleSequenceImageToID[value])
                end
            }]]

        }
        
        -- now generate and append iconpicker options to the optionsData table to represent entries in the chosenStyleList
        local currentRow = 0
        for i = 1, #WerewolfRave.savedVars.chosenStyleList do
            -- populate each row with the data corresponding to an entry in chosenStyleList
            currentRow = #WerewolfRaveMenu.optionsData + 1
            WerewolfRaveMenu.optionsData[currentRow] =
            {
                type = "iconpicker",
                name = tostring(i),
                choices = styleSequenceImages,
                choicesTooltips = styleSequenceNames,
                iconSize = WerewolfRaveMenu.STYLESEQUENCE_ICON_SIZE,
                maxColumns = WerewolfRaveMenu.STYLESEQUENCE_MAX_COLUMNS,
                visibleRows = WerewolfRaveMenu.STYLESEQUENCE_VISIBLE_ROWS,
                getFunc = function() return WerewolfRaveMenu.GetStyleSequence(i) end,
                setFunc = function(value) WerewolfRaveMenu.SetStyleSequence(i, styleSequenceImageToID[value]) end
            }
        end


        
        WerewolfRaveMenu.panel = LibAddonMenu2:RegisterAddonPanel(WerewolfRaveMenu.panelName, WerewolfRaveMenu.panelData)
        LibAddonMenu2:RegisterOptionControls(WerewolfRaveMenu.panelName, WerewolfRaveMenu.optionsData)
    end
end