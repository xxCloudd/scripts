--yes im lazy i used a converter
-- Gui to Lua
-- Version: 3.2

-- Instances:

local audiotester = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local shadow = Instance.new("ImageLabel")
local Frame_2 = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local test = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UICorner_3 = Instance.new("UICorner")
local UIGridLayout = Instance.new("UIGridLayout")
local title = Instance.new("TextLabel")
local ImageButton = Instance.new("ImageButton")
local UICorner_4 = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke", ScrollingFrame)
--Properties:

UIStroke.Color = Color3.fromRGB(26,26,26)
UIStroke.Thickness = 1
UIStroke.ApplyStrokeMode = 'Border'
UIStroke.LineJoinMode = 'Round'

audiotester.Name = "audiotester"
audiotester.Parent = game.CoreGui
audiotester.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = audiotester
Frame.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.368027121, 0, 0.276315778, 0)
Frame.Size = UDim2.new(0, 211, 0, 201)
Frame.Draggable = true
Frame.Active = true

shadow.Name = "shadow"
shadow.Parent = Frame
shadow.BackgroundTransparency = 1.000
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.ZIndex = -1
shadow.Image = "rbxassetid://1427967925"
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(6, 6, 25, 25)
shadow.TileSize = UDim2.new(0, 20, 0, 20)

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0, 3, 0, 20)
Frame_2.Size = UDim2.new(1, -6, 1, -23)

UICorner.CornerRadius = UDim.new(0, 3)
UICorner.Parent = Frame_2

test.Name = "test"
test.Parent = Frame_2
test.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
test.BorderColor3 = Color3.fromRGB(0, 0, 0)
test.BorderSizePixel = 0
test.Position = UDim2.new(0, 5, 0, 5)
test.Size = UDim2.new(1, -10, 0, 20)
test.Font = Enum.Font.SourceSans
test.Text = "Test Audios"
test.TextColor3 = Color3.fromRGB(186, 186, 186)
test.TextSize = 14.000

UICorner_2.CornerRadius = UDim.new(0, 3)
UICorner_2.Parent = test

ScrollingFrame.Parent = Frame_2
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1.000
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.024390243, 0, 0.174157307, 0)
ScrollingFrame.Size = UDim2.new(0, 196, 0, 141)
ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

UICorner_3.CornerRadius = UDim.new(0, 3)
UICorner_3.Parent = ScrollingFrame

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
UIGridLayout.CellSize = UDim2.new(1, -6, 0, 15)

title.Name = "title"
title.Parent = Frame
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 0
title.Position = UDim2.new(0, 6, 0, 0)
title.Size = UDim2.new(0, 0, 0, 20)
title.Font = Enum.Font.SourceSans
title.Text = "Audio Tester by bvthxry"
title.TextColor3 = Color3.fromRGB(186, 186, 186)
title.TextSize = 14.000
title.TextXAlignment = Enum.TextXAlignment.Left

ImageButton.Parent = Frame
ImageButton.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(1, -19, 0, 2)
ImageButton.Size = UDim2.new(0, 16, 0, 16)
ImageButton.Image = "rbxasset://textures/DevConsole/Close.png"
ImageButton.ImageRectOffset = Vector2.new(8, 0)
ImageButton.ImageRectSize = Vector2.new(10, 444)
ImageButton.ScaleType = Enum.ScaleType.Fit
ImageButton.TileSize = UDim2.new(1, -30, 1, -30)

UICorner_4.CornerRadius = UDim.new(0, 323)
UICorner_4.Parent = ImageButton

local TextLabel = Instance.new("TextLabel")
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold)
TextLabel.TextColor3 = Color3.fromRGB(186, 186, 186)
TextLabel.TextSize = 12
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Scripts:

local savedstr = ''
local setclipboard=print

test.MouseButton1Click:Connect(function()
	--remove dupes first

	if test.Text == 'Set working audios to clipboard' then
			setclipboard(tostring(savedstr))
	elseif test.Text:match'Test Audios' then
		local audios = audiotester:WaitForChild'Audios'
		test.Text = '0/'..#audios:GetChildren()


		local logger = game:GetService("LogService").MessageOut:connect(function(log, Type)
			if Type.Value == 3 and (log:gsub("%d+","")) == "Failed to load sound rbxassetid://: Unable to download sound data" then
				local id = log:match("%d+")
				audios:FindFirstChild(id):Destroy()
			end
		end)

		for i, audio in pairs(audios:GetChildren()) do
			local name, id = audio.Value, audio.Name

			local s = Instance.new("Sound",game.Players.LocalPlayer)
			s.Volume = 0
			s.SoundId = "rbxassetid://" .. id
			s:Play()
			repeat wait() until s.IsLoaded or not audios:FindFirstChild(id)
			s:Stop()
			s:Destroy()
			test.Text = i..'/'..#audios:GetChildren()

			local newlbl=TextLabel:Clone()
			if not audios:FindFirstChild(id) then 
				newlbl.TextColor3 = Color3.fromRGB(189, 130, 130)
			else
				savedstr = savedstr .. id .. ' ' .. name
			end
			newlbl.Text = (' [%s] %s'):format(id, name)
			newlbl.Parent = ScrollingFrame
		end

		logger:Disconnect()

		test.Text = 'Set working audios to clipboard'
	end
end)

ImageButton.MouseButton1Click:Connect(function()
	audiotester:Destroy()
end)

return function(audiotable)
	local b = Instance.new('Folder',audiotester)
	b.Name = 'Audios'
	for _,audio in pairs(audiotable) do
		local c = Instance.new("StringValue", b)
		c.Name = audio.ID
		c.Value = audio.Name
	end
	test.Text = 'Test Audios [' .. #audiotable ..']'
end
