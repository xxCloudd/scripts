gui = game:GetObjects("rbxassetid://11589975011")[1]
gui.Parent = game.CoreGui

Frame = gui.Frame


do
    local function tween(instance, speed, properties)
	    game:GetService("TweenService"):Create(instance, TweenInfo.new(speed), properties):Play()
    end
    
	local dragToggle = nil
	local dragSpeed = 0.1
	local dragInput = nil
	local dragStart = nil
	local dragPos = nil
	
	local function updateInput(input)
		local Delta = input.Position - dragStart
		local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		tween(Frame, dragSpeed, {Position = Position})
	end
	
	Frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if (input.UserInputState == Enum.UserInputState.End) then
					dragToggle = false
				end
			end)
		end
	end)
	
	Frame.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			dragInput = input
		end
	end)
	
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if (input == dragInput and dragToggle) then
			updateInput(input)
		end
	end)
end

new = function(jobId, players, ping)
    local Button = gui.Frame.Button.Button:Clone()
    Button.Name = jobId
    
    Button.JobId.Text = jobId
    Button.Ping.Text = ping
    Button.Players.Text = players
    
    if game.JobId == jobId then
        local red = Color3.fromRGB(192, 117, 117)
        Button.JobId.BackgroundColor3 = red
        Button.Ping.BackgroundColor3 = red
        Button.Players.BackgroundColor3 = red
    else
        for i, v in pairs(Button:GetChildren()) do 
	        v.MouseButton1Click:Connect(function()
	        	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobId, game.Players.LocalPlayer)
	        end)
        end
    end
    
    Button.Parent = Frame.ScrollingFrame
    
end

function getServerList()
	local cursor
	local servers = {}
	repeat
		local response = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor and "&cursor=" .. cursor or "")))
		for _, v in pairs(response.data) do
			table.insert(servers, v)
		end
		cursor = response.nextPageCursor
	until not cursor
	return servers
end

refreshing = false
refresh = function()
	if refreshing then return end
	refreshing = true
	Frame.listing.Text = "..."
	Frame.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
	
	for i, v in pairs(Frame.ScrollingFrame:GetChildren()) do 
		if v:isA("Frame") then
			v:Destroy()
		end
	end
	
	local list = getServerList()
	table.sort(list, function(a,b) return a.playing > b.playing end)
	
	for i, v in pairs(list) do 
		new(v.id,(string.format("%0." .. #(tostring(v.maxPlayers)) .. "i", v.playing).."/"..v.maxPlayers), v.ping)
	end
	
	Frame.ScrollingFrame.CanvasSize = UDim2.new(0,0,0, #list * 20)
	Frame.listing.Text = "Listing " .. #list .. " servers"
	refreshing = false
end

Frame.close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

Frame.refresh.MouseButton1Click:Connect(refresh)

refresh()
