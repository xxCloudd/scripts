--++##'' Made by xxCloudd ''##++--

--++##'' Settingz ''##++--

local multithreading = false
local letters = true
local numbers = true
local underscore = true
local WindowColor = Color3.fromRGB(103, 115, 204) -- Default: 103, 115, 204

--++##'' Varz ''##++--

local searching = false 
local LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
local NUMBERS = '0123456789'

--++##'' Instancez ''##++--

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local TextButton = Instance.new("TextButton")
local TextBox = Instance.new("TextBox")
local TextLabel = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local TextLabel_2 = Instance.new("TextLabel")
local TextButton_3 = Instance.new("TextButton")
local TextButton_4 = Instance.new("TextButton")
local TextButton_5 = Instance.new("TextButton")
local TextButton_6 = Instance.new("TextButton")
local TextButton_7 = Instance.new("TextButton")
local TextButton_8 = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.Active = true
Frame.BackgroundColor3 = WindowColor
Frame.Position = UDim2.new(0.0901065618, 0, 0.504587173, 0)
Frame.Size = UDim2.new(0, 424, 0, 250)
Frame.ClipsDescendants=true

Instance.new("UICorner", Frame)

ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = WindowColor
ScrollingFrame.BorderSizePixel = 1
ScrollingFrame.BorderColor3 = Color3.fromRGB(25, 25, 25)
ScrollingFrame.Position = UDim2.new(0.190, 0, 1,-211)
ScrollingFrame.Size = UDim2.new(0, 343, 0, 211)
ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 0.900
TextButton.Position = UDim2.new(0.02655, 0, 0.0272, 0)
TextButton.Size = UDim2.new(0, 57, 0, 23)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "start"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 20
TextButton.TextWrapped = true

Instance.new("UICorner", TextButton)

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 0.900
TextBox.Position = UDim2.new(-0.0015, 0, 0.212, -15)
TextBox.Size = UDim2.new(0, 81, 0, 25)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(1, 1, 1)
TextBox.PlaceholderText = "length 5-20"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextScaled = true
TextBox.TextSize = 14
TextBox.TextWrapped = true

Instance.new("UICorner", TextBox)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.19, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 303, 0, 38)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "xxCloudd's username gen\nright click to copy to clipboard"
TextLabel.TextColor3 = Color3.fromRGB(15, 15, 15)
TextLabel.TextScaled = true
TextLabel.TextSize = 22
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Right

TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.BackgroundTransparency = 0.900
TextButton_2.Position = UDim2.new(0.9334, 0, 0.035, 0)
TextButton_2.Size = UDim2.new(0, 21, 0, 22)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "X"
TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.TextSize = 20
TextButton_2.TextWrapped = true

Instance.new("UICorner", TextButton_2)

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.Position = UDim2.new(-0.002, 0, 0.935, 0)
TextLabel_2.Size = UDim2.new(0, 81, 0, 16)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "results: 0"
TextLabel_2.TextColor3 = Color3.fromRGB(15, 15, 15)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 12
TextLabel_2.TextWrapped = true

TextButton_3.Parent = Frame
TextButton_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.BackgroundTransparency = 0.900
TextButton_3.Position = UDim2.new(0, 0, 0.956, -45)
TextButton_3.Size = UDim2.new(0, 80, 0, 13)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = "save to .txt"
TextButton_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_3.TextSize = 14
TextButton_3.TextWrapped = true

Instance.new("UICorner", TextButton_3)

TextButton_4.Parent = Frame
TextButton_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_4.BackgroundTransparency = 0.900
TextButton_4.Position = UDim2.new(0, 0, 0.62, -85)
TextButton_4.Size = UDim2.new(0, 80, 0, 36)
TextButton_4.Font = Enum.Font.SourceSans
TextButton_4.Text = "multithreading: " .. tostring(multithreading)
TextButton_4.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_4.TextSize = 14
TextButton_4.TextWrapped = true

Instance.new("UICorner", TextButton_4)

TextButton_5.Parent = Frame
TextButton_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_5.BackgroundTransparency = 0.900
TextButton_5.Position = UDim2.new(0, 0, 1.26400006, -103)
TextButton_5.Size = UDim2.new(0, 81, 0, 13)
TextButton_5.Font = Enum.Font.SourceSans
TextButton_5.Text = "clear"
TextButton_5.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_5.TextSize = 14
TextButton_5.TextWrapped = true

Instance.new("UICorner", TextButton_5)

TextButton_6.Parent = Frame
TextButton_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_6.BackgroundTransparency = 0.900
TextButton_6.Position = UDim2.new(0, 0, 0.796000004, -85)
TextButton_6.Size = UDim2.new(0, 80, 0, 19)
TextButton_6.Font = Enum.Font.SourceSans
TextButton_6.Text = "letters: " .. tostring(letters)
TextButton_6.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_6.TextSize = 14
TextButton_6.TextWrapped = true

Instance.new("UICorner", TextButton_6)

TextButton_7.Parent = Frame
TextButton_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_7.BackgroundTransparency = 0.900
TextButton_7.Position = UDim2.new(-0.0023584906, 0, 0.903999984, -85)
TextButton_7.Size = UDim2.new(0, 80, 0, 19)
TextButton_7.Font = Enum.Font.SourceSans
TextButton_7.Text = "numbers: " .. tostring(numbers)
TextButton_7.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_7.TextSize = 14
TextButton_7.TextWrapped = true

Instance.new("UICorner", TextButton_7)

TextButton_8.Parent = Frame
TextButton_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_8.BackgroundTransparency = 0.900
TextButton_8.Position = UDim2.new(0, 0, 1.00800002, -85)
TextButton_8.Size = UDim2.new(0, 80, 0, 19)
TextButton_8.Font = Enum.Font.SourceSans
TextButton_8.Text = "underscore: " .. tostring(numbers) 
TextButton_8.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_8.TextSize = 13
TextButton_8.TextWrapped = true

Instance.new("UICorner", TextButton_8)

--++##'' Framez Dragz ''##++--

do
	local dragToggle = nil
	local dragSpeed = 0.1 
	local dragInput = nil
	local dragStart = nil
	local dragPos = nil
	
	function updateInput(input)
		Delta = input.Position - dragStart
		Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(Frame, TweenInfo.new(dragSpeed), {Position = Position}):Play()
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

--++##'' Functionz ''##++--

function updateResults()
    TextLabel_2.Text = "results: " .. #ScrollingFrame:GetChildren()
	Frame.ClipsDescendants = true
end

function userExists(user)
    return game:GetService("HttpService"):JSONDecode(game:HttpGet("https://api.roblox.com/users/get-by-username?username="..user)).Id ~= nil
end

function filtered(str)
    local Filtered = false
    for i,v in pairs({"SEX","ROBUX","BUX","MILF","FKK","FUX","GAY","DCK","KKK","FUK","FUC","455","69","420","88","18","6_9","1_8","8_8"}) do
        if string.find(str, v) then
            Filtered = true
            break
        end
    end
    return Filtered
end

function getRandomStr(length)
	if not tonumber(length) then
		length = 5
	elseif tonumber(length) > 20 then
	    length = 20
	elseif tonumber(length) < 5 then
	    length = 5
	end
	
	local CHARACTERS = ""

	if letters == true then 
		CHARACTERS = CHARACTERS .. LETTERS
	end

	if numbers == true then 
		CHARACTERS = CHARACTERS .. NUMBERS
	end


	local mid = ''
	local UNDERSCORED = false
	
	local function pickWithout()
	    local a = math.random(1, #CHARACTERS)
	    return CHARACTERS:sub(a, a)
	end
	
	local function pickWith()
		if underscore then
	    	local a = math.random(1, #CHARACTERS+1)
	    	return (CHARACTERS.."_"):sub(a, a)
		else
			local a = math.random(1, #CHARACTERS)
	    	return CHARACTERS:sub(a, a)
		end
	end
	
	for i = 1, (length - 2) do
	    local RANDOMCHAR = pickWith()

	    if UNDERSCORED then
	        RANDOMCHAR = pickWithout()
	    end

		if RANDOMCHAR == "_" then
		    UNDERSCORED = true
		end

		mid = mid .. RANDOMCHAR
	end
	return pickWithout() .. mid .. pickWithout()
end

function create(txt)
    local height = 25
	local Button = Instance.new("TextButton")
	Button.Size=UDim2.new(1,0,0,height)
	Button.Position = UDim2.new(0, 0, 0, #Frame.ScrollingFrame:GetChildren() * height)
	Button.Parent = ScrollingFrame
	Button.Text = "  " .. txt
	Button.TextColor3 = Color3.fromRGB(25,25,25)
	Button.TextXAlignment = "Left"
	Button.TextScaled = true
	Button.BackgroundColor3 = WindowColor
	Button.BorderColor3 = Color3.fromRGB(25,25,25)
	Button.Name = txt
	Button.Font = "Roboto"
	Frame.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,#Frame.ScrollingFrame:GetChildren() * height)
	Frame.ScrollingFrame.CanvasPosition = Vector2.new(0,#Frame.ScrollingFrame:GetChildren() * height)

	updateResults()

	Button.MouseButton2Click:connect(function()
	    Button.Text = '  Set to to clipboard'
		setclipboard(txt)
		wait(.3)
		Button.Text = "  " .. txt
	end)
end

function get()
    local function Get()
		if not letters and not numbers then return end
		
        local user = getRandomStr(TextBox.Text)

		if filtered(user) or ScrollingFrame:FindFirstChild(user) then return end

	    local check = userExists(user)
        if not check then
        	create(user)
        end
    end
    if multithreading then
        spawn(Get)
		wait(.075)
    else
        Get()
    end
end

--++##'' Buttonz ''##++--

TextButton_4.MouseButton1Click:connect(function()
    multithreading = not multithreading
    TextButton_4.Text = "multithreading: " .. tostring(multithreading)
end)

TextButton_6.MouseButton1Click:connect(function()
    letters = not letters
    TextButton_6.Text = "letters: " .. tostring(letters)
end)

TextButton_7.MouseButton1Click:connect(function()
    numbers = not numbers
    TextButton_7.Text = "numbers: " .. tostring(numbers)
end)

TextButton_8.MouseButton1Click:connect(function()
    underscore = not underscore
    TextButton_8.Text = "underscore: " .. tostring(underscore) 
end)

TextButton_5.MouseButton1Click:connect(function()
    ScrollingFrame:ClearAllChildren()
    ScrollingFrame.CanvasSize=UDim2.new(0,0,0,0)
    updateResults()
end)

TextButton.MouseButton1Click:Connect(function()
	if searching == false then
		searching = true 
		TextButton.Text="stop"
		repeat wait()
		    get()
		until not searching
	else
		searching = false
		TextButton.Text="start"
	end
end)


TextButton_2.MouseButton1Click:Connect(function()
	ScreenGui:destroy()
	a=false
end)

TextButton_3.MouseButton1Click:Connect(function()
	local saveFile = "users_" .. os.time() .. ".txt"
	local String = #ScrollingFrame:GetChildren() .. " UNTAKEN USERS"
	for i,v in pairs(ScrollingFrame:getChildren())do
		String = String .. "\n" .. v.Name
	end
	writefile(saveFile, String)
	TextButton_3.Text = "saved"
	wait(.3)
	TextButton_3.Text = "save to .txt"
end)