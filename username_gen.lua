-- Made by xxCloudd

multithreading = false 

--//

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local ScrollingFrame = Instance.new("ScrollingFrame")
local TextButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
local UICorner_3 = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local TextLabel_2 = Instance.new("TextLabel")
local TextButton_3 = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(213,67,67)
Frame.Position = UDim2.new(0.1, 0, 0.507645249, 0)
Frame.Size = UDim2.new(0, 272, 0, 170)

UICorner.Parent = Frame

ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BackgroundTransparency = 0.9
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.190860182, 0, 0.205882356, 0)
ScrollingFrame.Size = UDim2.new(0, 219, 0, 135)
ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 0.900
TextButton.Position = UDim2.new(0.0241935961, 0, 0.0352941193, 0)
TextButton.Size = UDim2.new(0, 56, 0, 23)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "start"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 20.000

UICorner_2.Parent = TextButton

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 0.900
TextBox.Position = UDim2.new(-0.0015416987, 0, 0.300000012, -15)
TextBox.Size = UDim2.new(0, 51, 0, 25)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(1, 1, 1)
TextBox.PlaceholderText = "length\n5-20"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextWrapped = true

UICorner_3.Parent = TextBox

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.277870059, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 155, 0, 35)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "xxCloudd's username gen\nright click to copy to clipboard"
TextLabel.TextColor3 = Color3.fromRGB(15, 15, 15)
TextLabel.TextScaled = true
TextLabel.TextSize = 22.000
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Right

TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.BackgroundTransparency = 0.900
TextButton_2.Position = UDim2.new(0.895754218, 0, 0.0352941193, 0)
TextButton_2.Size = UDim2.new(0, 21, 0, 22)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "X"
TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.TextSize = 20.000

UICorner_4.Parent = TextButton_2

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0, 0, 0.835294127, 0)
TextLabel_2.Size = UDim2.new(0, 50, 0, 28)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "rushed gui\nresults: 0"
TextLabel_2.TextColor3 = Color3.fromRGB(15, 15, 15)
TextLabel_2.TextSize = 12.000

TextButton_3.Parent = Frame
TextButton_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_3.BackgroundTransparency = 0.900
TextButton_3.Position = UDim2.new(0, 0, 1, -45)
TextButton_3.Size = UDim2.new(0, 51, 0, 13)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = "save to .txt"
TextButton_3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_3.TextSize = 14.000


multi = TextButton_3:clone()
multi.Parent=Frame
multi.Position = TextButton_3.Position-UDim2.new(0,0,0,40)
multi.Size = UDim2.new(0, 51, 0, 36)
multi.Text="multi\nthreading: \n"..tostring(multithreading)
Instance.new("UICorner",multi)
multi.TextScaled=true
multi.MouseButton1Click:connect(function()
    multithreading = not multithreading
    multi.Text="multi\nthreading: \n"..tostring(multithreading)
end)


clr = TextButton_3:clone()
clr.Parent=Frame
clr.Position = TextButton_3.Position-UDim2.new(0,0,0,58)
clr.Text="clear"
Instance.new("UICorner",clr)
clr.MouseButton1Click:connect(function()
    ScrollingFrame:ClearAllChildren()
    ScrollingFrame.CanvasSize=UDim2.new(0,0,0,0)
    updateResults()
end)
Frame.Draggable=true
Frame.Active=true
UICorner_5.Parent = TextButton_3

a = false 

function updateResults()
    TextLabel_2.Text = "rushed gui\nresults: "..#ScrollingFrame:GetChildren()
end

local Players = game:GetService("Players")
local cache = {}
function getUserIdFromUsername(name)
	if cache[name] then return cache[name] end
	local player = Players:FindFirstChild(name)
	if player then
		cache[name] = player.UserId
		return player.UserId
	end 
	local id
	pcall(function ()
		id = Players:GetUserIdFromNameAsync(name)
	end)
	cache[name] = id
	return id
end

function getRandomStr(length)
	if not tonumber(length) then
		length = 5
	elseif tonumber(length) > 20 then
	    length = 20
	elseif tonumber(length) < 5 then
	    length = 5
	end
	local CHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789'
	local FINALSTRING = ''
	local UNDERSCORED = false
	
	for i = 1, length do
	    local RANDOMCHAR_NR = math.random(1, #CHARACTERS)
	    local RANDOMCHAR = CHARACTERS:sub(RANDOMCHAR_NR, RANDOMCHAR_NR)
	    
	    if i == 1 or i == length or UNDERSCORED then
	        repeat
	            RANDOMCHAR_NR = math.random(1, #CHARACTERS)
	            RANDOMCHAR = CHARACTERS:sub(RANDOMCHAR_NR, RANDOMCHAR_NR)
	        until RANDOMCHAR ~= "_"
	    end
		
		if RANDOMCHAR == "_" then
		    UNDERSCORED = true
		end
		
		FINALSTRING = FINALSTRING .. RANDOMCHAR
	end
	return FINALSTRING
end

function create(txt)
	local Button = Instance.new("TextButton")
	Button.Size=UDim2.new(1,0,0,20)
	Button.Position = UDim2.new(0,0,0,#Frame.ScrollingFrame:getChildren() * 20)
	Button.Parent = ScrollingFrame
	Button.Text = "  "..txt
	Button.TextColor3=Color3.new(0,0,0)
	Button.TextXAlignment = "Left"
	Button.BackgroundColor3=Frame.BackgroundColor3
	--Button.BackgroundTransparency=.9
	Button.BorderColor3=Color3.fromRGB(255,120,120)
	Button.Name=txt
	Frame.ScrollingFrame.CanvasSize=UDim2.new(0,0,0,#Frame.ScrollingFrame:getChildren() * 20)
	Frame.ScrollingFrame.CanvasPosition=Vector2.new(0,#Frame.ScrollingFrame:getChildren() * 20)
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
        local user = getRandomStr(TextBox.Text)
	    local check = getUserIdFromUsername(user)
        if not check then
        	create(user)
        end
    end
    if multithreading then
        spawn(Get)
    else
        Get()
    end
end

TextButton.MouseButton1Click:Connect(function()
	if a == false then
		a=true 
		TextButton.Text="stop"
		repeat wait()
		    get()
		until not a
	else
		a = false
		TextButton.Text="start"
	end
end)


TextButton_2.MouseButton1Click:Connect(function()
	ScreenGui:destroy()
	a=false
end)

TextButton_3.MouseButton1Click:Connect(function()
	local saveFile = "usernames_" .. math.random(1,10000000) .. ".txt"
	local String = #Frame.ScrollingFrame:GetChildren() .. " RESULTS:"
	for i,v in pairs(Frame.ScrollingFrame:getChildren())do
		String = String .. "\n" .. v.Name
	end
	writefile(saveFile, String)
end)
