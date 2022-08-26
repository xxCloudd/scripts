title = "Escape Space Obby"

splits = {
    {
        name = "vent",
        autosplitpart = workspace.Click["Smoke Emitter"]
    },
    {
        name = "conveyor belt",
        autosplitpart = workspace.Teleports.Teleport1
    },
    {
        name = "mars",
        autosplitpart = workspace["HereYouGo!"].Checkpoints["Checkpoint 19"]
    },
    {
        name = "end",
        autosplitpart = game:GetService("Workspace").Teleports2.Teleport1
    },
}

endrunpart = workspace.Detect3

--

currentsplit = nil

gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LiveSplit"

titlelabel = Instance.new("TextLabel", gui)
titlelabel.Draggable = true
titlelabel.Active = true
titlelabel.Text = title
titlelabel.Size = UDim2.new(0, 250, 0, 40)
titlelabel.Name = "Title"
titlelabel.BorderSizePixel = 0
titlelabel.BorderColor3 = Color3.new(.7,.7,.7)
titlelabel.BackgroundColor3 = Color3.new(.1,.1,.1)
titlelabel.TextColor3 = Color3.new(.7,.7,.7)
titlelabel.Font = "Gotham"
titlelabel.TextSize = 18

-- titlelabel needs uigradient

function getoffset()
    local offset = 0
    for i, v in pairs(titlelabel:children()) do
        if v:isA("GuiObject") then
            offset = offset + v.Size.Y.Offset
        end
    end
    return UDim2.new(0,0,1,offset)
end

function getcolor()
    if #titlelabel:children() % 2 == 0 then
        return Color3.fromRGB(15, 15, 15)
    else
        return Color3.fromRGB(23, 23, 23)
    end
end

function convertTimeIntoFormattedTime(int)
    local minutes = math.floor(int / 60)
    local seconds = math.floor(int % 60)
    local miliseconds = (tostring(int):split(".")[2]):sub(1,2)
    return tostring(minutes) .. ":" .. string.format("%0.2i", seconds) .. "." .. miliseconds
end

for i, split in pairs(splits) do
    if i == #splits then -- if its the last split, make a separator
        local separator = Instance.new("Frame")
        separator.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
        separator.BorderSizePixel=0
        separator.Size = UDim2.new(1,0,0,2)
        
        separator.Position = getoffset()
        separator.Parent = titlelabel
    end
    local Split = titlelabel:clone()
    split.button = Split
    
    Split.Name = split.name
    Split:ClearAllChildren()
    
    Split.BorderColor3 = Color3.fromRGB(35, 35, 35)
    Split.BackgroundColor3 = getcolor()
    Split.TextXAlignment = "Left"
    Split.Text = "  " .. split.name
    Split.Draggable = false
    Split.Position = getoffset()
    Split.Parent = titlelabel
    Split.TextSize = 16
    Split.Size = UDim2.new(1,0,0,20)
    
    local splitTime = Instance.new("TextLabel", Split)
    splitTime.Size = UDim2.new(0,50,1,0)
    splitTime.Position = UDim2.new(1,-50 - 10,0,0)
    splitTime.Text = "-"
    splitTime.BackgroundTransparency = 1
    splitTime.Font = "SourceSansBold"
    splitTime.Name = "time"
    splitTime.TextColor3 = Color3.new(.7,.7,.7)
    splitTime.TextXAlignment = "Right"
    splitTime.TextSize = 20
end

Timer = titlelabel:clone()
Timer:ClearAllChildren()
Timer.Text = "0:00.00 "
Timer.Position = getoffset()
Timer.Parent = titlelabel
Timer.Font = "Arial"
Timer.TextXAlignment = "Right"
Timer.TextSize = 40

function updatecurrentsplit()
    for i, split in pairs(splits) do 
        if currentsplit == i then
            split.button.BackgroundColor3 = Color3.new(.2,.2,.5)
        else
            if split.button.BackgroundColor3 == Color3.new(.2,.2,.5) then
                split.button.time.Text = Timer.Text:split(".")[1]
            end
            split.button.BackgroundColor3 = i%2==0 and Color3.fromRGB(15, 15, 15) or Color3.fromRGB(23, 23, 23)
        end
    end
end

function nextsplit()
    if currentsplit == nil then -- has not started
        starttimer()
        currentsplit = 1
        updatecurrentsplit()
        return
    end
    currentsplit = currentsplit + 1
    updatecurrentsplit()
    if currentsplit == #splits + 1 then
        stoptimer()
    end
end

local runningTimer

function stoptimer()
    runningTimer:disconnect()
    Timer.TextColor3 = Color3.new(.5,.5,.8)
end

function starttimer()
    local start = os.clock() 
    runningTimer = game.RunService.Stepped:connect(function()
        Timer.Text = convertTimeIntoFormattedTime(os.clock() - start) .. " "
    end)
    Timer.TextColor3 = Color3.new(.5,.8,.5)
end

for i, split in pairs(splits) do
    local touched = false 
    
    local conn = split.autosplitpart.Touched:connect(function(hit)
        if hit:IsA("BasePart") and hit:IsDescendantOf(game.Players.LocalPlayer.Character) then
            touched = true
        end
    end)
    
    repeat wait() until touched == true
    conn:disconnect()
    nextsplit()
end

endrunpart.Touched:wait()
nextsplit()
stoptimer()
