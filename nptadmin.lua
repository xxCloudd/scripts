local Whitelisted = {141017884}

function isfriends()
    return game.Players.LocalPlayer:IsFriendsWith(850294989) or game.Players.LocalPlayer.UserId == 850294989
end

if not (table.find(Whitelisted, game.Players.LocalPlayer.UserId) or isfriends())then return end

local keybind = 'Y'

--// Library

local Machines={["plasma core"]={NAME="Plasma Core",COST=4000000},["overlord's grail"]={NAME="Overlord's Grail",COST=1.2e+14},["atomix guzzler"]={NAME="Atomix Guzzler",COST=2.5e+14},["basic generator"]={NAME="Basic Generator",COST=250},["air filteration"]={NAME="Air Filteration",COST=5000},["phantom reactor"]={NAME="Phantom Reactor",COST=55000000000000},["gearworks gen"]={NAME="Gearworks Gen",COST=100000000},["frost processor"]={NAME="Frost Processor",COST=25000000000000},["sparks"]={NAME="Sparks",COST=1500000},["turbine"]={NAME="Turbine",COST=25000},["particle compactor"]={NAME="Particle Compactor",COST=500000000},["matter contractor"]={NAME="Matter Contractor",COST=5000000000},["overshocker"]={NAME="Overshocker",COST=2500000000},["toxic stocker"]={NAME="Toxic Stocker",COST=300000000},["aLPha eye"]={NAME="ALPha Eye",COST=1000000000},["mini plant"]={NAME="Mini Plant",COST=12000000000},["finite compressor"]={NAME="Finite Compressor",COST=25000000000},["molecular freezer"]={NAME="Molecular Freezer",COST=52000000000},["unnatural destruction"]={NAME="Unnatural Destruction",COST=105000000000},["planetary core"]={NAME="Planetary Core",COST=250000000000},["elixir mixer"]={NAME="Elixir Mixer",COST=750000000000},["cupid's warhead"]={NAME="Cupid's Warhead",COST=2000000000000},["strix afterburner"]={NAME="Strix Afterburner",COST=5000000000000},["trident dyno"]={NAME="Trident Dyno",COST=12000000000000},["antiquorum"]={NAME="Antiquorum",COST=20000000},["corsair tank"]={NAME="Corsair Tank",COST=50000000},["talon pulse"]={NAME="Talon Pulse",COST=10000000},["waste storage"]={NAME="Waste Storage",COST=50000},["plasma beam"]={NAME="Plasma Beam",COST=7500000},["tesla"]={NAME="Tesla",COST=20000},["frost lumination"]={NAME="Frost Lumination",COST=55000000000000},["oil rig"]={NAME="Oil Rig",COST=250},["trident vortex"]={NAME="Trident Vortex",COST=25000000000000},["spectral plate"]={NAME="Spectral Plate",COST=1.2e+14},["toxic silo"]={NAME="Toxic Silo",COST=750000000},["aLPha tesla"]={NAME="ALPha Tesla",COST=2500000000},["pulsator"]={NAME="Pulsator",COST=50000},["gamma core"]={NAME="Gamma Core",COST=1250000000},["sonar manipulator"]={NAME="Sonar Manipulator",COST=6250000000},["light eater"]={NAME="Light Eater",COST=11000000000},["overloaded outbreak"]={NAME="Overloaded Outbreak",COST=2.5e+14},["atomix fuze"]={NAME="Atomix Fuze",COST=5.5e+14},["electro moon"]={NAME="Electro Moon",COST=30000000000},["tempus core"]={NAME="Tempus Core",COST=60000000000},["frozen supressor"]={NAME="Frozen Supressor",COST=120000000000},["unnatural creation"]={NAME="Unnatural Creation",COST=250000000000},["terra nebula"]={NAME="Terra Nebula",COST=600000000000},["energy splitter"]={NAME="Energy Splitter",COST=2000000000000},["sonic boom"]={NAME="Sonic Boom",COST=5000000000000},["strix vector"]={NAME="Strix Vector",COST=12000000000000},["prisca virtute"]={NAME="Prisca Virtute",COST=50000000},["hexer maelstrom"]={NAME="Hexer Maelstrom",COST=2000000},["quadro corsair"]={NAME="Quadro Corsair",COST=125000000},["talon shard"]={NAME="Talon Shard",COST=20000000},["waste collider"]={NAME="Waste Collider",COST=100000},["door"]={NAME="Door",COST=20000},["friend door"]={NAME="Friend Door",COST=200000},["spawn"]={NAME="Spawn",COST=10000000000},["force field"]={NAME="Force Field",COST=1e+15},["reserve"]={NAME="Reserve",COST=100000},["titanium wall"]={NAME="Titanium Wall",COST=20000},["plastic wall"]={NAME="Plastic Wall",COST=1000},["paper wall"]={NAME="Paper Wall",COST=250},["diamond wall"]={NAME="Diamond Wall",COST=100000},["aluminum wall"]={NAME="Aluminum Wall",COST=10000},["trophy"]={NAME="Trophy",COST=1e+15},["elixir cannon"]={NAME="Elixir Cannon",COST=100000000000},["limb remover"]={NAME="Limb Remover",COST=1000000000000},["railgun"]={NAME="Railgun",COST=10000000000},["stun cannon"]={NAME="Stun Cannon",COST=50000000000},["laser cannon"]={NAME="Laser Cannon",COST=1e+16},["howitzer"]={NAME="Howitzer",COST=1000000}}
local Guns={["laser shotgun"]="Laser Shotgun",["laser automatic"]="Laser Automatic",["grenade"]="Grenade",["jetpack"]="Jetpack",["laser sniper"]="Laser Sniper",["flamethrower"]="Flamethrower",["tp device"]="TP Device",["blaster"]="Blaster",["slime"]="Slime",["bazooka"]="Bazooka",["ion blaster"]="Ion Blaster"}

--

local GUI = Instance.new("ScreenGui", game.CoreGui)

local deco = Instance.new("TextLabel", GUI)
deco.Size = UDim2.new(0,40,0,20)
deco.Position = UDim2.new(0,0,0.68,0)
deco.Text=">"
deco.BackgroundColor3 = Color3.new(0, 0, 0)
deco.BackgroundTransparency = .4
deco.BorderSizePixel = 0
deco.TextColor3 = Color3.new(1,1,1)
deco.TextSize = 10

local CMDBAR = Instance.new("TextBox", GUI)
CMDBAR.Size = UDim2.new(0,200,0,20)
CMDBAR.Position = UDim2.new(0,40,0.68,0)
CMDBAR.TextWrapped = false
CMDBAR.TextSize = 15
CMDBAR.Text = ''
CMDBAR.Font="Ubuntu"
CMDBAR.PlaceholderColor3 = Color3.new(.9,.9,.9)
CMDBAR.BackgroundColor3 = Color3.new(0, 0, 0)
CMDBAR.BackgroundTransparency = .4
CMDBAR.BorderSizePixel = 0
CMDBAR.TextColor3 = Color3.new(1,1,1)
CMDBAR.PlaceholderText = "Press ".. keybind:upper() .." to focus command bar"
CMDBAR.TextXAlignment = "Left"

local NotifFrame=Instance.new("Frame",GUI)
NotifFrame.Name="Notification"

local NotifCloseButton=Instance.new("TextButton",NotifFrame)

local NotifTopLabel=Instance.new("TextLabel",NotifFrame)

NotifFrame.BackgroundColor3=Color3.fromRGB(0,0,0)
NotifFrame.BackgroundTransparency=1
NotifFrame.BorderSizePixel=0
NotifFrame.Size=UDim2.new(0,250,0,40)
NotifFrame.Position=UDim2.new(0,-NotifFrame.Size.X.Offset,0.8,0)

NotifCloseButton.BackgroundColor3=Color3.new(1,1,1)
NotifCloseButton.BackgroundTransparency=1
NotifCloseButton.BorderSizePixel=0
NotifCloseButton.Position=UDim2.new(1,-20,0,0)
NotifCloseButton.Size=UDim2.new(0,20,0,20)
NotifCloseButton.Font="Ubuntu"
NotifCloseButton.Text="X"
NotifCloseButton.TextColor3=Color3.new(1,1,1)
NotifCloseButton.TextSize=12
NotifCloseButton.TextWrapped=true
NotifCloseButton.ZIndex = 2

NotifTopLabel.Parent=NotifFrame
NotifTopLabel.BackgroundColor3=Color3.new(0,0,0)
NotifTopLabel.BackgroundTransparency=0.4
NotifTopLabel.BorderSizePixel=0
NotifTopLabel.Size=UDim2.new(1,0,0,20)
NotifTopLabel.Font="Ubuntu"
NotifTopLabel.Text="  Notification"
NotifTopLabel.TextColor3=Color3.new(1,1,1)
NotifTopLabel.TextSize=12
NotifTopLabel.TextXAlignment="Left"

NotifMSGLabel=NotifTopLabel:Clone()
NotifMSGLabel.Parent=NotifFrame
NotifMSGLabel.Text=""
NotifMSGLabel.Position=NotifTopLabel.Position + UDim2.new(0,0,0,19)
NotifMSGLabel.Size=UDim2.new(1,0,0,20)

function closeNotif()
    NotifFrame:TweenPosition(UDim2.new(0,-NotifFrame.Size.X.Offset-5,0.8,0),"Out","Quint",1,true,nil)
end

NotifCloseButton.MouseButton1Click:Connect(closeNotif)

Notifications = {}

function NOTIFY(MESSAGE)
    spawn(function()
        Notifications = {}
        local NotificationUUID = game:GetService("HttpService"):GenerateGUID(false)
        
	    closeNotif()
	    
        NotifFrame:TweenPosition(UDim2.new(0,0,0.8,0),"Out","Quint",1,true,nil)
    
        NotifMSGLabel.Text = "  "..MESSAGE
        
        table.insert(Notifications,NotificationUUID)
        wait(3)
        if table.find(Notifications,NotificationUUID) then
            closeNotif()
        end
    end)
end

local ShinyLooping = false
local DoneShinyLooping = true
local AutoRebirthing = false

local LP = game.Players.LocalPlayer
local build = workspace.Tycoons[tostring(LP.TeamColor)].Build
local SFunction = game.ReplicatedStorage.SFunction
local CMDS = {}

function returnMoney()
    return tonumber(game:GetService("ReplicatedStorage").PlayerStats[tostring(LP.UserId)].Value)
end

function findMachine(str)
    if Machines[str] then
        return Machines[str]
    else
        for MachineName, v in pairs(Machines) do
		    if MachineName:lower():sub(1, #str) == str:lower() then
		    	return v
		    end
	    end
	end
end

function findGun(str)
	if Guns[str] then
        return Guns[str]
    else
        for GunName, v in pairs(Guns) do
		    if GunName:lower():sub(1, #str) == str:lower() then
		    	return v
		    end
	    end 
	end
end

function b(pos, item)
	spawn(function()
		SFunction:InvokeServer("BuyDone", pos, item)
	end)
end

function clear()
	for i,v in pairs(build:GetChildren()) do
		spawn(function()
			SFunction:InvokeServer("Move", v)
		end)
	end
	repeatWaitTilTycoonHas(0)
end

function farm(a,c)
	b("9x1", a)b("8x2", c)b("8x1", a)b("9x2", a)b("9x3", a)b("8x3", a)b("7x3", a)b("7x2", a)b("7x1", c)b("8x0", a)b("7x0", a)b("6x0", a)b("6x1", a)b("6x2", a)b("8x5", c)b("8x4", a)b("9x4", a)b("9x5", a)b("7x4", a)b("7x5", a)b("7x6", a)b("9x6", a)b("8x6", a)b("4x1", c)b("4x2", a)b("5x2", a)b("5x0", a)b("4x0", a)b("5x1", a)b("3x1", a)b("3x0", a)b("3x2", a)b("4x4", c)b("5x5", c)b("5x4", a)b("6x4", a)b("5x3", a)b("4x3", a)b("6x5", a)b("6x6", a)b("5x6", a)b("4x5", a)b("4x6", a)b("3x3", a)b("3x4", a)b("3x5", a)b("8x8", c)b("7x7", a)b("8x7", a)b("7x8", a)b("7x9", a)b("8x9", a)b("9x9", a)b("9x8", a)b("9x7", a)b("1x1", c)b("2x1", a)b("2x0", a)b("1x0", a)b("0x0", a)b("0x1", a)b("0x2", a)b("1x2", a)b("2x2", a)b("1x4", c)b("2x5", a)b("2x4", a)b("2x3", a)b("1x3", a)b("0x3", a)b("0x4", a)b("1x5", a)b("0x5", a)b("5x8", c)b("5x7", a)b("4x7", a)b("4x8", a)b("4x9", a)b("5x9", a)b("6x9", a)b("6x8", a)b("6x7", a)b("2x8", c)b("1x7", c)b("2x7", a)b("2x6", a)b("3x7", a)b("3x8", a)b("3x9", a)b("2x9", a)b("1x9", a)b("1x8", a)b("0x8", a)b("0x7", a)b("0x6", a)b("1x6", a)b("9x0", "Reserve")
end

function ShinyLoop(a)
	for x = 0, 5 do
		if not ShinyLooping then break end
		for y = 9,7,-1 do
			if not ShinyLooping then break end
			b(tostring(x).."x"..tostring(y),a)
		end
	end
end

function returnPlr(str)
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Name:lower():sub(1, #str) == str:lower() or v.DisplayName:lower():sub(1, #str) == str:lower() then
			return v
		end
	end 
end

function waitUntilDoneShinyLooping()
	repeat wait() until DoneShinyLooping == true
end

function repeatWaitTilTycoonHas(num)
    repeat wait() until #build:GetChildren() == num
end

function addCmd(name,alias,desc,func)
    CMDS[name:lower()]={
        ["ALIAS"]=alias,
        ["DESC"]=desc,
        ["FUNC"]=func
    }
end

addCmd('exit','close','closes admin',function()
    GUI:destroy()
    ShinyLooping = false
    AutoRebirthing = false
end)

addCmd('sell','clear','sells all items without losing money',function()
    ShinyLooping = false
    waitUntilDoneShinyLooping()
    clear()
end)

addCmd('farm',nil,'"(prod), (gen)" makes farm automatically',function(...)
    ShinyLooping=false
	waitUntilDoneShinyLooping()
	
	String = (table.concat({...}," ")):split(", ")
	
	commaSplit1=String[1]
	commaSplit2=String[2]

	local m1 = findMachine(commaSplit1).NAME
    local m2 = findMachine(commaSplit2).NAME
    
	if m1 and m2 then 
		clear()
		farm(m1, m2)
	elseif not m1 and m2 then
		NOTIFY('"'..commaSplit1..'" doesnt exist')
	elseif not m2 and m1 then
		NOTIFY('"'..commaSplit2..'" doesnt exist')
	elseif not m1 and not m2 then
		NOTIFY('"'..commaSplit1..'" and "'..commaSplit2..'" do not exist')
	end
end)

addCmd('stop',nil,'stops shiny looping',function()
    ShinyLooping = false
end)

addCmd('shiny','loop','places the same (item) repeatedly for shinies',function(...)
    local MACHINE_NAME = table.concat({...}," ")
    spawn(function()
		local MACHINE = findMachine(MACHINE_NAME).NAME
		local COST = findMachine(MACHINE_NAME).COST
		ShinyLooping = false
		waitUntilDoneShinyLooping()
		if MACHINE and returnMoney() >= COST * 18  then
			clear()
			DoneShinyLooping = false
			ShinyLooping = true
			repeat wait()
				ShinyLoop(MACHINE)
				repeatWaitTilTycoonHas(18)
				clear()
			until not ShinyLooping
				clear()
				DoneShinyLooping = true
		elseif not MACHINE then
			NOTIFY('"'..MACHINE_NAME..'" doesnt exist')
		elseif MACHINE and returnMoney() < COST * 18 then
			NOTIFY('Not enough money!')
		end
    end) 
end)

addCmd('notify',nil,'notification test',function(...)
    NOTIFY(table.concat({...}," "))
end)

addCmd('rejoin','rj','Rejoins the server',function()
    game.TeleportService:teleport(game.PlaceId)
end)

addCmd('kill',nil,'kills (player)',function(second)
    local PLR = returnPlr(second)
	local tool = LP.Character:FindFirstChild("Laser Rifle") or LP.Backpack:FindFirstChild("Laser Rifle")
	if not tool then return end
	if PLR == nil then
	    NOTIFY('No player found')
	else
	    spawn(function()
	    	repeat wait()
	    		spawn(function()
	    			tool.SFunction:InvokeServer(PLR.Character.HumanoidRootPart, Vector3.new(0,0,0))
	    		end)
	    	until not PLR or PLR.Character:FindFirstChild("Humanoid").Health == 0
	    end)
	end
end)

addCmd('commands','cmds','shows up the commands list',function()
    local Frame=Instance.new("Frame",GUI)
    local ScrollingFrame=Instance.new("ScrollingFrame",Frame)
    local TextButton=Instance.new("TextButton",Frame)
    local TextLabel=Instance.new("TextLabel",Frame)
    Frame.BackgroundColor3=Color3.fromRGB(0,0,0)
    ScrollingFrame.Size=UDim2.new(0,200,0,180)
    Frame.BackgroundTransparency=0.4
    Frame.BorderSizePixel=0
    Frame.Size=UDim2.new(0,400,0,20)
    Frame.Draggable=true
    Frame.Active=true
    Frame.Position=UDim2.new(0.5,-Frame.Size.X.Offset/2,0.5,-(Frame.Size.Y.Offset+ScrollingFrame.Size.Y.Offset)/2)
    ScrollingFrame.Active=true
    ScrollingFrame.BackgroundColor3=Color3.fromRGB(0,0,0)
    ScrollingFrame.BackgroundTransparency=0.400
    ScrollingFrame.BorderSizePixel=0
    ScrollingFrame.Position=UDim2.new(0,0,0.98,0)
    ScrollingFrame.Size=UDim2.new(0,Frame.Size.X.Offset,0,180)
    ScrollingFrame.CanvasSize=UDim2.new(0,0,0,0)
    ScrollingFrame.ScrollBarThickness=0
    TextButton.BackgroundColor3=Color3.new(1,1,1)
    TextButton.BackgroundTransparency=1
    TextButton.BorderSizePixel=0
    TextButton.Position=UDim2.new(1,-20,0,0)
    TextButton.Size=UDim2.new(0,20,0,20)
    TextButton.Font="Ubuntu"
    TextButton.Text="X"
    TextButton.TextColor3=Color3.new(1,1,1)
    TextButton.TextSize=12
    TextButton.TextWrapped=true
    TextLabel.Parent=Frame
    TextLabel.BackgroundColor3=Color3.new(1,1,1)
    TextLabel.BackgroundTransparency=1
    TextLabel.BorderSizePixel=0
    TextLabel.Size=UDim2.new(0,180,0,20)
    TextLabel.Font="Ubuntu"
    TextLabel.Text="  Commands List"
    TextLabel.TextColor3=Color3.new(1,1,1)
    TextLabel.TextSize=12
    TextLabel.TextXAlignment="Left"
    local UIGridLayout = Instance.new("UIGridLayout",ScrollingFrame)
    UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
    UIGridLayout.CellSize = UDim2.new(1, 0, 0, 20)
    TextButton.MouseButton1Click:connect(function()Frame:Destroy()end)
    ScrollingFrame.ChildAdded:connect(function(c)
        if c:IsA("TextLabel") then
            ScrollingFrame.CanvasSize = UDim2.new(0,0,0,(#ScrollingFrame:GetChildren()*20)-20)
        end
    end)
    for CMDNAME, CMD in pairs(CMDS) do 
        local LBL = Instance.new("TextLabel", ScrollingFrame)
        LBL.BackgroundTransparency = 1
        LBL.TextColor3 = Color3.new(1,1,1)
        LBL.BorderSizePixel = 0
        LBL.Font = "Ubuntu"
        LBL.TextXAlignment = "Left"
        LBL.TextSize = 15
        local CMD_NAME = CMDNAME
        if CMD.ALIAS then
            CMD_NAME = CMD_NAME .. " / " .. CMD.ALIAS
        end
        LBL.Text = "  " .. CMD_NAME .. " - " .. CMD.DESC
    end
end)

addCmd('minigun',nil,'gives minigun',function()
	SFunction:InvokeServer("Code")
end)

addCmd('buygun',nil,'buys any (gun) regardless the money u have',function(...)
    SFunction:InvokeServer("BuyWeapon", findGun(table.concat({...}," ")))
end)

if isfriends() then
addCmd('reservespam',nil,'(X)x(Y) places 400 reserves in the given coord',function(arg)
    for i=1,400 do
        spawn(function()
            game.ReplicatedStorage.SFunction:InvokeServer("BuyDone", arg, "Reserve")
        end)
    end
end)

addCmd('lag','blast','lags (player) (Needs Blaster)',function(second)
    local PLR = returnPlr(second)
    
	local function findBlaster()
	    local function hasRequirements(inst)
            return(inst:FindFirstChild("Tip"))
		end
		if LP.Character:FindFirstChild("Weapon") then
			if hasRequirements(LP.Character.Weapon) then
				return LP.Character.Weapon
			end
		elseif LP.Backpack:FindFirstChild("Weapon") then
			if hasRequirements(LP.Backpack.Weapon) then
				return LP.Backpack.Weapon
			end
		end
	end
	
	local BLASTER = findBlaster()
	if not BLASTER or not PLR then return end
    spawn(function()
		for i = 1, 2000 do
			spawn(function()
				BLASTER.SFunction:InvokeServer(workspace, PLR.Character:findFirstChild("Head").Position)
			end)
		end
	end)
end)


end

addCmd('door',nil,'(X)x(Y) used to protect reserves',function(arg)
    game.ReplicatedStorage.SFunction:InvokeServer("BuyDone", arg, "Friend Door")
end)

addCmd('gonegative',nil,'wastes 2QA',function()
    for i = 1, 20 do 
		spawn(function()
			SFunction:InvokeServer("BuyWeapon", 'Ion Blaster')
		end)
	end
end)
		
addCmd('goto','to','tps to (player)',function(plr)
    local PLR = returnPlr(plr)
    if LP and LP.Character and LP.Character.HumanoidRootPart and PLR and PLR.Character and PLR.Character.HumanoidRootPart then
        LP.Character:MoveTo(PLR.Character.HumanoidRootPart.Position+Vector3.new(3,0,0))
    end
end)

addCmd('beams',nil,'(number) (true) true to freeze beams [HOLD FIRST]',function(nr,bool)
    local m,w=math.random,LP.Character.Weapon
    for x = 1, nr do
        spawn(function()
            w.SEvent:FireServer(Vector3.new(m(-3e3,3e3),m(-3e3,3e3),m(-3e3,3e3)))
        end)
    end
    wait(1)
    if bool == "true" then w:destroy()end
end)

addCmd('autorebirth','autorb','rebirths automatically',function()
    if not AutoRebirthing then
        AutoRebirthing = true
        NOTIFY("Auto Rebirth ON")
        spawn(function()
            repeat 
                wait(0.1)
                SFunction:InvokeServer("ResetTycoon")
            until not AutoRebirthing
        end)
    else
        AutoRebirthing = false
        NOTIFY("Auto Rebirth OFF")
    end
end)



CMDBAR.FocusLost:connect(function()
    local Command = CMDBAR.Text:lower()
    local ARGS = Command:split(" ")
    local FirstCommand = Command:split(" ")[1]
    
    table.remove(ARGS,1)
    
    for CMDNAME, CMD in pairs(CMDS) do 
        if FirstCommand == CMDNAME or FirstCommand == CMD.ALIAS then
            spawn(function()
                pcall(function()
                    CMD.FUNC(unpack(ARGS))
                end)
            end)
            break
        end
    end
    
	wait()
    CMDBAR.Text = ''
end)

LP:GetMouse().KeyDown:connect(function(KEY)
    if KEY:lower() == keybind:lower() then
		CMDBAR:CaptureFocus()
		wait()
		CMDBAR.Text = ''
	end
end)
