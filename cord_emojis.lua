-- script is not mine, just chopped useless stuff and optimized

local config = {
    ['EmojiAutofill'] = true,
    ['EmojiReplace'] = true
}

repeat wait() until game:IsLoaded()

local lp = game:GetService("Players").LocalPlayer

local CCCCC = lp:WaitForChild("PlayerGui"):WaitForChild("Chat")

local getchat = function()
    return {
        main = CCCCC,
        chatbar = CCCCC.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar,
        messages = CCCCC.Frame.ChatChannelParentFrame.Frame_MessageLogDisplay.Scroller
    }
end

local cache = {}
local dependencies = {
    ['Emojis'] = game:GetService("HttpService"):JSONDecode(game:HttpGet('https://raw.githubusercontent.com/Aidez/emojiscopy/master/main')),
    ['Chat'] = getchat()
}

local get = function(s)
    return dependencies['Emojis'][s] or nil
end

local fillmatches = function(emojis, object)
    local t = object.Text
    for i, v in pairs(emojis) do
        local emoji = get(v)
        if emoji then
            object.Text = string.gsub(object.Text, ":"..v..":", emoji)
        end
    end
end

local last

local autofill = function(tbl, object)
    local find = tbl[1]
    if #find >= 2 then else return end
    
    local start = tbl[2]
    last = tbl
    
    local match
    
    for i, v in pairs(dependencies['Emojis']) do
        if i:lower():sub(1, #find) == find:lower() then
            match = i
        end
    end
    
    object.Parent.AutofillBox.PlaceholderText = ''

    if match then
        local s = object.Text:sub(1, start - 1)
        object.Parent.AutofillBox.PlaceholderText = s..':'..match..':'
    end
end

local trueautofill = function(tbl, object)
    local find = tbl[1]
    local start = tbl[2]
    
    local match
    last = nil
    
    if #find >= 2 then else return end
    
    for i, v in pairs(dependencies['Emojis']) do
        if i:lower():sub(1, #find) == find:lower() then
            match = i
        end
    end
    
    if match then
        local s = object.Text:sub(1, start - 1)
        object.Text = s..':'..match..':'
    end
end


local match = function(t, obj)
    if t:find(":") then
        local start = 0
        local scan = {}
        local autofills = {}
        
        for i = 1, #t do
            local s = t:sub(i, i)
            if s == ':' then
                if start >= 1 then
                    table.insert(scan, t:sub(start + 1, i - 1))
                    start = 0
                else
                    start = i
                end
            end
        end
        
        start = 0
        
        for i = 1, #t do
            local s = t:sub(i, i)
            if s == ':' then
                start = start >= 1 and 0 or i
            end
        end
        
        obj.Parent.AutofillBox.PlaceholderText = ''
        
        if start >= 1 then
            table.insert(autofills, t:sub(start + 1, #t))
            if config['EmojiAutofill'] == true then
                autofill({autofills[1],start}, obj)
            end
        else
            obj.Parent.AutofillBox.PlaceholderText = ''
        end
    
        if config['EmojiReplace'] == true then
            fillmatches(scan, obj)
        end
    else    
        return {}
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if cache[dependencies['Chat'].chatbar] == nil then
        cache[dependencies['Chat'].chatbar] = true
        dependencies['Chat'] = getchat()
        THING(dependencies['Chat'])
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(k)
    if k.KeyCode == Enum.KeyCode.Tab and focused and last then
        local object = dependencies['Chat'].chatbar
        trueautofill(last, object)
        wait()
        object.Text = object.Text:sub(1, #object.Text - 1)
    end
end)

THING = function(tbl)
    local bar = tbl.chatbar
    bar.ZIndex = 2
    bar.Parent.TextLabel.ZIndex = 3
    local clone = bar:Clone()
    clone.Name = 'AutofillBox'
    clone.Parent = bar.Parent
    clone.TextEditable = false
    clone.ZIndex = 1
    clone.TextTransparency = .5
    clone.PlaceholderColor3 = Color3.fromRGB(0, 0, 0)
    
    bar:GetPropertyChangedSignal("Text"):Connect(function()
        focused = true
        local txt = bar.Text
        if txt == '' then
            clone.PlaceholderText = ''
            return
        end
        match(txt, bar)
    end)

    bar.FocusLost:Connect(function()
        clone.PlaceholderText = ''
        focused = false
    end)
end
