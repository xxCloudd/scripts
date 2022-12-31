if getgenv().MjXRqQs7cjVu8 then -- reload
	getgenv().MjXRqQs7cjVu8:Destroy()
end

function NEW(a, b, c)
	local d = Instance.new(a, b)
	if c then
		for i,v in next,c do
			d[i] = v
		end
	end
	return d
end

local GUI = NEW("ScreenGui", game.CoreGui, {Name = "UAS"}) 
getgenv().MjXRqQs7cjVu8 = GUI

if syn then
syn.protect_gui(GUI)
end

local LocalPlr = game:GetService("Players").LocalPlayer

local data_file = "INGAME_AUDIO_SEARCHER_DATA.xyz"

local version = "1.9.2"
local sortFavoritesAlphabetically = false
local showrobloxaudios = false

local soundInstance
local page
local AUDIOS

if not pcall(function() readfile(data_file) end) then
	writefile(data_file, '[]')
end

function JSONDecode(str)
	return game:GetService("HttpService"):JSONDecode(str)
end

function JSONEncode(str)
	return game:GetService("HttpService"):JSONEncode(str)
end

pcall(function()
	AUDIOS = JSONDecode(readfile(data_file))
end)

if AUDIOS == nil then -- if decoding didnt work
	local FILENAME = ('corruptedAudioData_' .. os.time() .. ".txt")
	game.StarterGui:SetCore("SendNotification",{
		Title = "Error!";
		Text = ("Data file is corrupted, cloned: " .. FILENAME .. " , a new data file has been created"),
		Duration = 5
	})
	writefile(FILENAME, readfile(data_file))
	writefile(data_file, '[]')
end

function SaveFavorites()
	writefile(data_file, JSONEncode(AUDIOS))
end

SaveFavorites()


local OnlineSearchPage = Instance.new("Flag", GUI)
local FavoritesPage = Instance.new("Flag", GUI)
local SettingsPage = Instance.new("Flag", GUI)

OnlineSearchPage.Name = "OnlineSearchPage"
FavoritesPage.Name = "FavoritesPage"
SettingsPage.Name = "SettingsPage"

local ReferenceInstances = Instance.new("NegateOperation", GUI)
ReferenceInstances.Name = "ReferenceInstances"

local Frame = Instance.new("Frame", GUI)
local shadow = Instance.new('UIStroke', Frame)
shadow.Transparency = .5
shadow.Thickness=1.5

local FrameButtons = Instance.new("Folder", Frame)
FrameButtons.Name = "FrameButtons"

local CloseButton = Instance.new("TextButton", FrameButtons)
local MainTextBox = Instance.new("TextBox", OnlineSearchPage)

local frameMainScrollingFrame = Instance.new("Frame", OnlineSearchPage)
frameMainScrollingFrame.Name = "FrameMainScrollingFrame"
frameMainScrollingFrame.Size = UDim2.new(1,0,0,175-36)
frameMainScrollingFrame.Position = UDim2.new(0,0,1,-frameMainScrollingFrame.Size.Y.Offset)
frameMainScrollingFrame.BackgroundTransparency = 1
frameMainScrollingFrame.ClipsDescendants = true

local fakeScroll = Instance.new("ScrollingFrame", frameMainScrollingFrame)

fakeScroll.Size = UDim2.new(0,10,1,0)
fakeScroll.BackgroundColor3 = Color3.fromRGB(25,25,25)
fakeScroll.ZIndex=2

fakeScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
fakeScroll.ScrollBarThickness = 10
fakeScroll.Position = UDim2.new(1,-10,0,0)
fakeScroll.BorderSizePixel = 1
fakeScroll.ScrollingDirection = "Y"
fakeScroll.BorderColor3 = Color3.fromRGB(60,60,60)
fakeScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
fakeScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
fakeScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
fakeScroll.Name = "FakeScroll"

local MainScrollingFrame = Instance.new("ScrollingFrame", frameMainScrollingFrame)

local PageLabel = Instance.new("TextLabel", FrameButtons)
local window_width = 350

function addProperty(instance, properties)
	for i, v in pairs(properties) do
		instance[i] = v
	end
end

function tween(instance, speed, properties)
	game:GetService("TweenService"):Create(instance, TweenInfo.new(speed), properties):Play()
end

function clearMainList()
    MainScrollingFrame:ClearAllChildren()
    MainScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    --Parent.Parent.FakeScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
end

addProperty(Frame, {
    Active = true,
	BackgroundColor3 = Color3.fromRGB(25,25,25),
	BorderColor3 = Color3.fromRGB(120,120,120),
	BackgroundTransparency=0,
	BorderSizePixel=0,
	Name = 'MainFrame',
	Size=UDim2.new(0,window_width,0,175)
})

addProperty(CloseButton, {
	Active = false,
	TextStrokeTransparency = .5,
	BackgroundTransparency = 1,
	BorderColor3 = Color3.fromRGB(1,1,1),
	BorderSizePixel = 2,
	Position = UDim2.new(1,-18,0,0),
	Size = UDim2.new(0,18,0,18),
	Font = 'SourceSansBold',
	Text = 'X',
	Name = 'CloseButton',
	TextColor3 = Color3.fromRGB(200,200,200),
	TextSize = 14,
	AutoButtonColor=false
})

addProperty(MainTextBox, {
	BackgroundColor3 = Color3.fromRGB(35,35,35),
	TextStrokeTransparency = .5,
	BorderSizePixel = 0,
	BorderColor3 = Color3.fromRGB(1,1,1),
	Position = UDim2.new(0,0,0,18),
	Size = UDim2.new(1,(-18*4),0,18),
	Font = Enum.Font.SourceSansItalic,
	PlaceholderColor3 = Color3.fromRGB(150,150,150),
	PlaceholderText = "Online Search",
	Text = "",
	TextColor3 = Color3.fromRGB(200,200,200),
	TextSize = 14,
	ClearTextOnFocus = false,
	TextWrapped = true,
	Font = 'SourceSansSemibold',
	Name = 'OnlineSearchTextBox'
})

addProperty(MainScrollingFrame, {
	BackgroundColor3 = Color3.fromRGB(0,0,0),
	BackgroundTransparency = 0.9,
	BorderColor3 = Color3.fromRGB(60, 60, 60),
	Size = frameMainScrollingFrame.Size,
	ScrollBarThickness = 0,
	ScrollingEnabled = false,
	BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
	TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
	ScrollBarImageColor3 = Color3.fromRGB(100,100,100),
	CanvasSize = UDim2.new(0,0,0,0),
	Name = 'OnlineSearchScrollingFrame'
})

addProperty(PageLabel, {
	TextStrokeTransparency = .5,
	TextColor3 = Color3.fromRGB(200,200,200),
	BackgroundColor3 = Color3.fromRGB(255,255,255),
	Name = 'PageLabel',
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Size = UDim2.new(0,386,0,18),
	Font = 'SourceSansBold',
	Text = "  UAS・Online Search",
	TextSize = 12,
	TextXAlignment = Enum.TextXAlignment.Left
})

Frame.Position = UDim2.new(-1, 0, .5, -(Frame.Size.Y.Offset/2))

local minimizeButton = CloseButton:clone()

addProperty(minimizeButton, {
	Name = 'MinimizeButton',
	Parent = FrameButtons,
	Text = '—',
	Position = UDim2.new(1,-36,0,0)
})

local favButton = minimizeButton:clone()

addProperty(favButton, {
	Parent = FrameButtons,
	TextScaled = false,
	TextSize = 17,
	Name = 'FavoritesPageButton',
	TextYAlignment = 'Top',
	Text = '★',
	Position = UDim2.new(1,(-18)*4,0,0)
})

local frameFavoritesScrollingFrame = frameMainScrollingFrame:clone()
frameFavoritesScrollingFrame.Parent = FavoritesPage
frameFavoritesScrollingFrame.Name = "FrameFavoritesScrollingFrame"

function getActualScrollingFrame(frame)
    for i,v in pairs(frame:GetChildren()) do 
        if v:isA("ScrollingFrame") and v.Name ~= "FakeScroll" then
            return v
        end
    end
end

local FavoritesScrollingFrame = getActualScrollingFrame(frameFavoritesScrollingFrame)
FavoritesScrollingFrame.Name = "FavoritesScrollingFrame"

local SettingsButton = minimizeButton:clone()

addProperty(SettingsButton, {
	Parent = FrameButtons,
	Text = 'S',
	Name = 'SettingsPageButton',
	Font = 'SourceSansSemibold',
	Position = UDim2.new(1,(-18)*5,0,0)
})

local searchButton = Instance.new("ImageButton", FrameButtons)

addProperty(searchButton, {
	Active = false,
	Name = 'OnlineSearchPageButton',
	Image = "rbxassetid://3229239834",
	Size = UDim2.new(0,19,0,18),
	BackgroundTransparency = 1,
	Position = UDim2.new(1,(-18)*3,0,0)
})

local favSearchTextBox = MainTextBox:clone()

addProperty(favSearchTextBox, {
	Parent = FavoritesPage,
	PlaceholderText = "Search Favorites",
	Name = "FavoritesTextBox"
})

local FavoritesSortType = "new-old"

local MainSortTypeButton = Instance.new("TextButton", OnlineSearchPage)

addProperty(MainSortTypeButton, {
	Text = FavoritesSortType,
	Size = UDim2.new(0,(18*4),0,18),
	Position = UDim2.new(1,-(18*4),0,18),
	Font = "SourceSansBold",
	BackgroundColor3 = Color3.fromRGB(25,25,25),
	BorderSizePixel = 1,
	BorderColor3 = Color3.fromRGB(35, 35, 35),
	TextColor3 = Color3.fromRGB(140,140,140),
	AutoButtonColor = false,
	BorderMode = "Inset",
	Text = 'relevance',
	Name = 'OnlineSearchSortTypeButton',
	TextSize = 14,
	TextStrokeTransparency = 0.5,
	Active = false
})

local MainSortType = 0

MainSortTypeButton.MouseButton1Click:connect(function()
	local txt = MainSortTypeButton.Text

	if MainSortType == 0 then
		MainSortType = 1
		MainSortTypeButton.Text = "most fav"
	elseif MainSortType == 1 then
		MainSortType = 3
		MainSortTypeButton.Text = "recent"
	else
		MainSortType = 0
		MainSortTypeButton.Text = "relevance"
	end
end)


local FavoritesSortTypeButton = MainSortTypeButton:clone()
FavoritesSortTypeButton.Parent = FavoritesPage
FavoritesSortTypeButton.Name = "FavoritesSortTypeButton"
FavoritesSortTypeButton.Text = FavoritesSortType

FavoritesSortTypeButton.MouseButton1Click:connect(function()
	local txt = FavoritesSortTypeButton.Text

	if txt == "new-old" then
		FavoritesSortTypeButton.Text = "old-new"
	elseif txt == "old-new" then
		FavoritesSortTypeButton.Text = "A-Z"
	elseif txt == "A-Z" then
		FavoritesSortTypeButton.Text = "new-old"
	end

	FavoritesSortType = FavoritesSortTypeButton.Text

	refreshFavoritesList()
end)

local frameSettingsScrollingFrame = frameMainScrollingFrame:clone()
frameSettingsScrollingFrame.Parent = SettingsPage
frameSettingsScrollingFrame.Size = UDim2.new(1,0,1,-20)
frameSettingsScrollingFrame.Position = UDim2.new(0,0,0,20)
frameSettingsScrollingFrame.Name = "FrameSettingsScrollingFrame"

local SettingsScrollingFrame = getActualScrollingFrame(frameSettingsScrollingFrame)

addProperty(SettingsScrollingFrame, {
	Name = "SettingsScrollingFrame",
	Size = UDim2.new(1,0,1,0)
})

local SettingsUIGridLayout = Instance.new("UIGridLayout", SettingsScrollingFrame)

addProperty(SettingsUIGridLayout, {
	SortOrder = "LayoutOrder",
	CellPadding = UDim2.new(0,0,0,0),
	CellSize = UDim2.new(1,0,0,20)
})

function refreshSettingsScrollingFrameCanvas()
	SettingsScrollingFrame.CanvasSize = UDim2.new(0,0,0,(#SettingsScrollingFrame:GetChildren()*20)-20)
	--SettingsScrollingFrame.Parent.FakeScroll.CanvasSize = UDim2.new(0,0,0,(#SettingsScrollingFrame:GetChildren()*20)-20)
end

function addSettingsHeader(TEXT)
	local Header = Instance.new("TextLabel", SettingsScrollingFrame)
	addProperty(Header, {
		BackgroundTransparency = 1,
		TextStrokeTransparency = .5,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		Text = TEXT or "",
		TextXAlignment = "Center",
		TextSize = 15,
		Font = "SourceSansBold"
	})
	refreshSettingsScrollingFrameCanvas()
	
	return Header
end

function addSettingsText(TEXT)
	local Header = Instance.new("TextLabel", SettingsScrollingFrame)
	addProperty(Header, {
		BackgroundTransparency = 1,
		TextStrokeTransparency = .5,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		Text = TEXT or "",
		TextXAlignment = "Center",
		TextSize = 13,
		Font = "SourceSansBold"
	})
	refreshSettingsScrollingFrameCanvas()

	return Header
end

function addSettingsButton(TEXT, X_SIZE)
	local Frame = Instance.new("Frame", SettingsScrollingFrame)
	Frame.BackgroundTransparency = 1

	local Button = Instance.new("TextButton", Frame)
	addProperty(Button, {
		Active = false,
		TextSize = 14,
		Size = UDim2.new(0, X_SIZE, 0, 16),
		Font = "SourceSansBold",
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextXAlignment = "Center",
		BorderSizePixel = 1,
		AutoButtonColor = false,
		Text = TEXT or "",
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(25, 25, 25),
		TextStrokeTransparency = .7,
		BorderColor3 = Color3.fromRGB(120, 120, 120)
	})

	Button.Position = UDim2.new(0.5, -(Button.Size.X.Offset / 2), 0.5, -(Button.Size.Y.Offset / 2))
	
	refreshSettingsScrollingFrameCanvas()
	return Button
end

function addSettingsBox(PLACEHOLDERTEXT, X_SIZE)
	local Frame = Instance.new("Frame", SettingsScrollingFrame)
	Frame.BackgroundTransparency=1
	local Box = Instance.new("TextBox", Frame)
	addProperty(Box, {
		TextSize = 14,
		Size = UDim2.new(0, X_SIZE, 0, 16),
		TextStrokeTransparency = .5,
		Font = "SourceSansBold",
		TextColor3 = Color3.fromRGB(200,200,200),
		TextXAlignment = "Center",
		BorderSizePixel = 1,
		Text = "",
		PlaceholderText = (PLACEHOLDERTEXT or ""),
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(25,25,25),
		TextStrokeTransparency = .7,
		BorderColor3=Color3.fromRGB(120,120,120)
	})
	
	Box.Position = UDim2.new(0.5, -(Box.Size.X.Offset / 2), 0.5, -(Box.Size.Y.Offset / 2))
	
	refreshSettingsScrollingFrameCanvas()
	return Box
end


function scrlup(scrollF, i)
    scrollF.CanvasPosition = scrollF.CanvasPosition - Vector2.new(0, i)
end
function scrldn(scrollF, i)
    scrollF.CanvasPosition = scrollF.CanvasPosition + Vector2.new(0, i)
end

function scrollButtons(frame)
    
    local scrollF = getActualScrollingFrame(frame)
    local fakeScroll = frame.FakeScroll
    
    function updateFakeScroll()
        fakeScroll.CanvasSize = scrollF.CanvasSize
        fakeScroll.CanvasPosition =  scrollF.CanvasPosition
    end
    
    scrollF:GetPropertyChangedSignal("CanvasSize"):connect(updateFakeScroll)
    scrollF:GetPropertyChangedSignal("CanvasPosition"):connect(updateFakeScroll)
    
    fakeScroll:GetPropertyChangedSignal("CanvasPosition"):connect(function()
        scrollF.CanvasPosition = frame.FakeScroll.CanvasPosition
    end)
    
    frame.MouseWheelForward:connect(function()
        scrlup(scrollF, 40)
        wait(.05)
    end)
    frame.MouseWheelBackward:connect(function()
        scrldn(scrollF, 40)
        wait(.05)
    end)
    
    
    local function u()
        scrlup(scrollF, 20)
        wait(.025)
    end
    local function d()
        scrldn(scrollF, 20)
        wait(.025)
    end
end

scrollButtons(frameMainScrollingFrame)
scrollButtons(frameFavoritesScrollingFrame)
scrollButtons(frameSettingsScrollingFrame)
addSettingsHeader("- Search Settings -")
local ShowRobloxAudiosButton = addSettingsButton("Show Roblox Audios: OFF", 150)
addSettingsText()
addSettingsHeader("- Play on Boombox -")
addSettingsText("Must hold boombox first")
local playOnBoomboxButton = addSettingsButton("Disabled", 70)
addSettingsText()
addSettingsHeader("- Add Audio Manually -")
local SettingsIdTextBoxNAME = addSettingsBox("Audio Name Input",200)
local SettingsIdTextBoxID = addSettingsBox("Id Input",120)
local SettingsIdAddButton = addSettingsButton("Add", 190)
addSettingsText()
addSettingsHeader("- Import from file -")
addSettingsText("/workspace/filename.txt (must be .txt)")
addSettingsText('e.g. "0123456789 audioname"')
local importfilenamebox = addSettingsBox("Filename", 130)
local importbtn = addSettingsButton("Import", 140)
addSettingsText()
addSettingsHeader("- Export to file -")
addSettingsText("will be exported as .txt to /workspace/")
local exportfilenamebox = addSettingsBox("Filename", 130)
local exportbtn = addSettingsButton("Export audios to /workspace/",200)
addSettingsText()
addSettingsHeader("- Help -")
addSettingsText("Left Mouse Button: Preview / Boombox")
addSettingsText("Right Mouse Button: Set ID to clipboard")
addSettingsText('Roblox Audios are highlighted like this').TextColor3 = Color3.new(0.5, 0.25, 0.25)
addSettingsText()
local reloadScriptButton = addSettingsButton("Reload GUI", 80)
reloadScriptButton.TextColor3 = Color3.fromRGB(95, 66, 120)reloadScriptButton.BorderColor3 = Color3.fromRGB(95, 66, 120)
addSettingsText()
local ClearAudioListData = addSettingsButton("Clear Data", 100)
ClearAudioListData.TextColor3 = Color3.new(0.5, 0.25, 0.25)ClearAudioListData.BorderColor3 = Color3.new(0.5, 0.25, 0.25)
addSettingsText()
addSettingsHeader("Made by bvthxry・Unnamed Audio Searcher v"..version)

reloadScriptButton.MouseButton1Click:connect(function()
	loadstring(game:HttpGet'https://raw.githubusercontent.com/xxCloudd/scripts/main/audio_gui.lua')()
end)

ShowRobloxAudiosButton.MouseButton1Click:connect(function()
	showrobloxaudios = not showrobloxaudios
	ShowRobloxAudiosButton.Text = "Show Roblox Audios: " .. (showrobloxaudios and "ON" or "OFF")
	refreshFavoritesList()
end)

local playOnBoombox = false
playOnBoomboxButton.MouseButton1Click:connect(function()
	playOnBoombox = not playOnBoombox
	playOnBoomboxButton.Text = (playOnBoombox and "Enabled" or "Disabled")
end)

ClearAudioListData.MouseButton1Click:connect(function()
	local b = ClearAudioListData.Text
	if b == "Clear Data" then
		ClearAudioListData.Text = "Are you sure?"
		wait(2)
		ClearAudioListData.Text = "Clear Data"
	elseif b == "Are you sure?" then
		AUDIOS = {}
		SaveFavorites()
		refreshFavoritesList()
		ClearAudioListData.Text = "Data cleared!"
		wait(0.5)
		ClearAudioListData.Text = "Clear Data"
	end
end)

exportbtn.MouseButton1Click:connect(function()
    local str = ""
	local totalAudios = 0

    for i, audio in pairs(AUDIOS) do
        str = (str .. audio.ID .. " " .. audio.Name .. "\n")
		totalAudios = totalAudios + 1
    end

    writefile( ((exportfilenamebox.Text ~= "" and exportfilenamebox.Text) or os.time()) .. ".txt", str)
    exportbtn.Text = ("Exported " .. totalAudios .. " audios!")
    wait(0.6)
    exportbtn.Text = "Export audios to /workspace/"
end)

local importdeb=false

importbtn.MouseButton1Click:connect(function()
	if not importdeb then importdeb=true else return end
	local file
	pcall(function()
		file = readfile(importfilenamebox.Text .. ".txt")
	end)
	if not file then
		importfilenamebox.Text = "File not found"
		wait(.6)
		importfilenamebox.Text = ""
		return
	end

	local totalAdded = 0

	for i,v in pairs(file:split("\n")) do 
		local split = v:split(" ")
		if split[1] and tonumber(split[1]) and split[2] then
			local new = v:split(" ")
			table.remove(new, 1)

			local AlreadyAdded = isFavorited(tonumber(split[1]))

			if not AlreadyAdded then
				totalAdded = totalAdded + 1
				addToAudiosTable(table.concat(new, " "),tonumber(split[1]))
			end
		end
	end
	
    SaveFavorites()
	
	importbtn.Text = ("Imported " .. totalAdded .. " audios")

	refreshFavoritesList()

	wait(.6)

	importbtn.Text = "Import"
	importdeb = false
end)

SettingsIdAddButton.MouseButton1Click:connect(function()
	local ID = tonumber(SettingsIdTextBoxID.Text)
	local Name = SettingsIdTextBoxNAME.Text

	local function thingy(str)
		SettingsIdAddButton.Text = str
		wait(.5)
		SettingsIdAddButton.Text = "Add"
	end

	if not checkIfHasCharacters(Name) then
		thingy('Please insert a name')
		return
	end

	if not ID then
		thingy('Please insert an Id')
		return
	end
	
	if isFavorited(ID) then
		thingy('Id "' .. ID .. '" was already saved')
		return
	end

	addToFavorites(Name, ID)

	SettingsIdTextBoxNAME.Text = ""
	SettingsIdTextBoxID.Text = ""

	SettingsIdAddButton.Text = ('"' ..Name.. '" was saved to favorites')
	wait(1)
	SettingsIdAddButton.Text = "Save to Favorites"
end)

local Pages = {}

for _, page in pairs(GUI:GetChildren()) do
    if page:IsA("Flag") then
        Pages[page.Name] = {}
        for i, page_content in pairs(page:GetChildren()) do
            Pages[page.Name][i] = page_content
        end
    end
end

local oldpage


local closedGUI = false
local closeDeb = false

minimizeButton.MouseButton1Click:connect(function()
	if closeDeb then return end

    if not closedGUI then
        closeDeb = true
        
        oldpage = page
        
        showPage()
        page = nil
        
        SettingsButton.Visible = false
        searchButton.Visible = false
        favButton.Visible = false
        wait(.2)
        tween(Frame, .15, {
			Size = UDim2.new(0,window_width,0,18)
		})
        wait(.15)
        closeDeb = false
        closedGUI = true
    else
        closeDeb = true
        tween(Frame, .15, {
			Size = UDim2.new(0, window_width, 0, 175)
		})
		wait(.2)
		SettingsButton.Visible = true
        searchButton.Visible = true
        favButton.Visible = true
		
		showPage(oldpage)
		closeDeb = false
		closedGUI = false
    end
end)

function reverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end

--[[
	new-old
	old-new
	A-Z
]]

function refreshFavoritesList() -- GUI Refresh
	FavoritesScrollingFrame:ClearAllChildren()
    FavoritesScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
    
	local str = favSearchTextBox.Text

	if FavoritesSortType == "A-Z" then
		local new = {}

		for i, audio in pairs(AUDIOS) do
			local audio_name = audio["Name"]:lower()

    		if string.find(audio_name, (str and str:lower()) or '') then
				table.insert(new, {
					Name = audio["Name"],
					ID = audio["ID"]
				})
			end
		end

		table.sort(new, function(a, b)
			return a["Name"]:lower() < b["Name"]:lower()
		end)

		for i, audio in pairs(new)do
			createNew(FavoritesScrollingFrame, audio["Name"], audio["ID"])
		end

	elseif FavoritesSortType == "new-old" then
		
		local reversedAudioOrder = {}

    	for k, v in ipairs(AUDIOS) do
    	    reversedAudioOrder[#AUDIOS + 1 - k] = v
    	end

    	for i, audio in pairs(reversedAudioOrder) do
			local audio_name = audio["Name"]:lower()

    		if string.find(audio_name, (str and str:lower()) or '') then
				createNew(FavoritesScrollingFrame, audio["Name"], audio["ID"])
			end
    	end

	elseif FavoritesSortType == "old-new" then

		for i, audio in pairs(AUDIOS) do
			local audio_name = audio["Name"]:lower()

    		if string.find(audio_name, (str and str:lower()) or '') then
				createNew(FavoritesScrollingFrame, audio["Name"], audio["ID"])
			end
    	end

	end
end

function addToAudiosTable(name, id)
	table.insert(AUDIOS, {
		Name = name,
		ID = id
	})
end

function removefromAudiosTable(id)
	for i, audio in pairs(AUDIOS) do
        if audio["ID"] == id then
            table.remove(AUDIOS, i)
            break
        end
    end
end

function addToFavorites(name, id)
	if isFavorited(id) then return end

    addToAudiosTable(name,id)
	
    SaveFavorites()
    refreshFavoritesList()

	return true
end

function removeFromFavorites(id)
    removefromAudiosTable(id)
    
    SaveFavorites()
    refreshFavoritesList() -- Update list on GUI

end

function showPage(page_to_show)

	if page == page_to_show then return end
	    
	local function viewContent(page_to_show, Bool)
		for i, page_content in pairs(Pages[page_to_show]) do 
		    if Bool == true then
		        page_content.Parent = Frame
		    else
		        page_content.Parent = GUI[page_to_show]
		    end
		end
	end

	viewContent("OnlineSearchPage", false)
	viewContent("FavoritesPage", false)
	viewContent("SettingsPage", false)

    if page_to_show == nil then
        PageLabel.Text = ("  UAS・v" .. version)
        return
    end

    viewContent(page_to_show, true)

	if page_to_show == "OnlineSearchPage" then
		PageLabel.Text = "  UAS・Online Search"
	elseif page_to_show == "FavoritesPage" then
		PageLabel.Text = "  UAS・Favorites"
	elseif page_to_show == "SettingsPage" then
		PageLabel.Text = "  UAS・Settings"
	end

	page = page_to_show
end

favButton.MouseButton1Click:connect(function()
	showPage("FavoritesPage")
end)

searchButton.MouseButton1Click:connect(function()
	showPage("OnlineSearchPage")
end)

SettingsButton.MouseButton1Click:connect(function()
	showPage("SettingsPage")
end)

--// frame drag

local function dragify(Frame)
	dragToggle = nil
	dragSpeed = 0.1
	dragInput = nil
	dragStart = nil
	dragPos = nil
	
	function updateInput(input)
		Delta = input.Position - dragStart
		Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
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

dragify(Frame)

local dragify

--\\ frame drag

CloseButton.MouseButton1Click:connect(function()
    for i, GUIElement in pairs(GUI:GetDescendants())do
        pcall(function()
			tween(GUIElement, .1, {Transparency = 1})
        end)
		if GUIElement:IsA("TextBox") or GUIElement:IsA("TextLabel") or GUIElement:IsA("TextButton") then
			tween(GUIElement, .1, {TextStrokeTransparency = 1})
		end
    end

	tween(searchButton, .1, {ImageTransparency = 1}) -- ImageButtons

    wait(0.1)

    if soundInstance then
    	soundInstance:Destroy()
	end

	GUI:destroy()
	getgenv().MjXRqQs7cjVu8 = nil
end)

function isFavorited(id)
    for i, audio in pairs(AUDIOS) do
        if audio["ID"] == id then
            return audio["ID"]
        end
    end
end

function getNameFromId(id)
    for i, audio in pairs(AUDIOS) do
        if audio["ID"] == id then
            return audio["Name"]
        end
    end
end

do
    local btn = Instance.new("TextButton", ReferenceInstances)
	addProperty(btn, {
		Active = false,
		TextTruncate = "AtEnd",
		TextStrokeTransparency = .5,
		BackgroundColor3 = Color3.fromRGB(25,25,25),
		Size = UDim2.new(1,-20,0,20),
		TextWrapped = true,
		BackgroundTransparency = 0,
		TextColor3 = (isARobloxAudio and Color3.new(.5,.25,.25) or Color3.fromRGB(140,140,140)),
		AutoButtonColor = false,
		TextSize = 16,
		Name = "AudioButton",
		TextXAlignment = 'Left',
		Font = 'SourceSansSemibold',
		BorderColor3 = Color3.fromRGB(60,60,60)
	})
	
	
	local fav = Instance.new("TextButton", btn)
	addProperty(fav, {
		Active = false,
		TextStrokeTransparency = 0.5,
		BackgroundColor3 = Color3.fromRGB(25,25,25),
		Size = UDim2.new(0,20,0,20),
		TextWrapped = true,
		Position = UDim2.new(0,-20,0,0),
		BackgroundTransparency = 0,
		TextColor3 = Color3.fromRGB(140,140,140),
		AutoButtonColor = false,
		TextSize = 16,
		Name = 'fav',
		TextXAlignment = 'Center',
		Font = 'SourceSansBold',
		BorderColor3 = Color3.fromRGB(60,60,60)
	})
end


function playAudio(id)
	if playOnBoombox == true then
		if soundInstance then
			soundInstance:Destroy()
			soundInstance = nil
		end
		if LocalPlr.Character then 
			local boombox = LocalPlr.Character:FindFirstChildOfClass("Tool")
			if boombox and boombox:FindFirstChildOfClass("RemoteEvent") then
				boombox:FindFirstChildOfClass("RemoteEvent"):FireServer("PlaySong", id)
			end
		end
		return "StopSound"
	else
		if soundInstance then
			if soundInstance.SoundId == "rbxassetid://" .. id then
				soundInstance:Destroy()
				soundInstance = nil
				return "StopSound"
			else
				soundInstance:Destroy()
				soundInstance = Instance.new("Sound", GUI)
				soundInstance.Volume = 1
				soundInstance.SoundId = "rbxassetid://" .. id
				soundInstance.Looped = true
				soundInstance:Play()
			end
		elseif (not soundInstance) or (not soundInstance.SoundId == "rbxassetid://" .. id) then
			soundInstance = Instance.new("Sound", GUI)
			soundInstance.Volume = 1
			soundInstance.SoundId = "rbxassetid://" .. id
			soundInstance.Looped = true
			soundInstance:Play()
		end
	end
end

function createNew(Parent, txt, id, isARobloxAudio)

	if Parent:FindFirstChild(id) then return end
	
	local btn = ReferenceInstances.AudioButton:clone()
	btn.Parent = Parent
	
	local fav = btn.fav
	
	addProperty(btn, {
		Text = ("  "..txt),
	    Name = id,
	    Position = UDim2.new(0,20,0,(#Parent:GetChildren()*20)-20)
	})
	
	fav.Text = ((isFavorited(id) and "★") or "☆")

	btn.MouseButton1Click:connect(function()
		local Play = playAudio(id)
		
		for i, button in pairs(MainScrollingFrame:GetChildren()) do
			tween(button, .1, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)})
		end

		for i, button in pairs(FavoritesScrollingFrame:GetChildren()) do
			tween(button, .1, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)})
		end
		
		wait()
		
		if Play ~= "StopSound" then
			tween(btn, .1, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)})
		elseif playOnBoombox == true and Play == "StopSound" then
		    tween(btn, .1, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)})
		    wait(.1)
		    tween(btn, .1, {BackgroundColor3 = Color3.fromRGB(25, 25, 25)})
		end
	end)
	
	btn.MouseButton2Click:connect(function()
		btn.Text = '  Set Id to clipboard'
		setclipboard(tostring(id))
		wait(0.3)
		btn.Text = ("  " .. txt)
	end)
	
	fav.MouseButton1Click:connect(function()
	    if fav.Text == "★" then
	        removeFromFavorites(id)
			local IfExistsFavoritedInMainScrollingFrame = MainScrollingFrame:FindFirstChild(id)

			if IfExistsFavoritedInMainScrollingFrame then 
				IfExistsFavoritedInMainScrollingFrame.fav.Text = "☆"
			end

			fav.Text = "☆"
	    elseif fav.Text == "☆" then
	        addToFavorites(txt, id)
			fav.Text = "★"
	    end
	end)
	
	Parent.CanvasSize = Parent.CanvasSize + UDim2.new(0,0,0,20)
	--Parent.Parent.FakeScroll.CanvasSize = Parent.CanvasSize + UDim2.new(0,0,0,20)
end

favSearchTextBox.Changed:connect(function(property)
	if property == "Text" then
		refreshFavoritesList()
	end
end)

function checkIfHasCharacters(str)
	return string.match(str, "%w") ~= nil
end

function Search(search, PageNumber)
	local Results = game:HttpGet("https://search.roblox.com/catalog/json?Category=9&PageNumber=" .. PageNumber .. "&SortType=" .. MainSortType .. "&Keyword=" .. (search:gsub('/',''):gsub(" ","+"):lower()))
	local DecodedResults = JSONDecode(Results)

	return DecodedResults
end

local onlineSearchLoadingResults = false

MainTextBox.FocusLost:connect(function(enter)
	if enter then
		local search = MainTextBox.Text
		
		if (not checkIfHasCharacters(search)) and search ~= "" then return end
		
		clearMainList()
		
		if onlineSearchLoadingResults then return end
		
		onlineSearchLoadingResults = true

		if search == "" then
			MainTextBox.Text = ('Loading the "' .. MainSortTypeButton.Text .. '" category')
		else
			MainTextBox.Text = ('Loading "' .. search .. '"..')
		end

		MainTextBox.TextEditable = false
		
		local loadedresults = 0
		local totalresults = {}
		
		-- 3 pages

		local results_1;
		local results_2;
		local results_3;

		spawn(function() 
			results_1 = Search(search, 1)
			loadedresults = loadedresults + 1
		end)

		spawn(function() 
			results_2 = Search(search, 2)
			loadedresults = loadedresults + 1
		end)

		spawn(function() 
			results_3 = Search(search, 3)
			loadedresults = loadedresults + 1
		end)
		
		repeat wait() until (loadedresults == 3)
		
		for i, result in pairs(results_1) do
			totalresults[#totalresults + 1] = result
		end

		for i, result in pairs(results_2) do
			totalresults[#totalresults + 1] = result
		end

		for i, result in pairs(results_3) do
			totalresults[#totalresults + 1] = result
		end

		for i, audio in pairs(totalresults) do
			if audio.AudioUrl then
				local name = audio.Name
				local id = audio.AssetId

				if audio.CreatorID == 1 then
					if showrobloxaudios then
						createNew(MainScrollingFrame, name, id, true)
					end
				else
					createNew(MainScrollingFrame, name, id, false)
				end
			end
		end

		MainTextBox.Text = ""
		onlineSearchLoadingResults = false
		MainTextBox.TextEditable = true
	end
end)

refreshFavoritesList()

showPage("FavoritesPage")

tween(Frame, .25, {Position = UDim2.new(0, 10, .5, -(Frame.Size.Y.Offset / 2))})
