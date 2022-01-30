--// Made by xxCloudd

if getgenv().MjXRqQs7cjVu8 then -- reload
	getgenv().MjXRqQs7cjVu8:Destroy()
end

local GUI = Instance.new("ScreenGui", game.CoreGui) 

getgenv().MjXRqQs7cjVu8 = GUI

local data_file = "INGAME_AUDIO_SEARCHER_DATA.xyz"
local AUDIOS;
local page; -- search / fav / settings
local version = "1.7.5"
local sortFavoritesAlphabetically = false
local showrobloxaudios = false
local SortType = 0

function JSONDecode(str)
	return game:GetService("HttpService"):JSONDecode(str)
end

function JSONEncode(str)
	return game:GetService("HttpService"):JSONEncode(str)
end

if not pcall(function() readfile(data_file) end) then -- if file doesnt exist, create a new one
	writefile(data_file, '[]')
end



pcall(function()
	AUDIOS = JSONDecode(readfile(data_file))
end)

if AUDIOS == nil then -- if decoding didnt work
	game.StarterGui:SetCore("SendNotification",{
		Title = "AudioBrowser Error!";
		Text = "Data file is corrupted, cloned corrupted file for backup, a new data file has been created";
		Duration = 5
	})
	writefile('corruptedAudioBrowserData_'..
	tostring(os.time())..".txt",
	readfile(data_file))
	writefile(data_file, '[]')
end

function SaveFavorites()
	writefile(data_file, JSONEncode(AUDIOS))
end

SaveFavorites()

local PREVIEW_VOLUME = 1

--------

local Frame = Instance.new("Frame", GUI)
local CloseButton = Instance.new("TextButton", Frame)
local MainTextBox = Instance.new("TextBox", Frame)
local MainScrollingFrame = Instance.new("ScrollingFrame", Frame)
local mainTextLabel = Instance.new("TextLabel", Frame)

local loading = false

local soundInstance;

GUI.Name = ""

local window_width = 350 -- 304

Instance.new("UICorner",Frame).CornerRadius = UDim.new(0, 5)

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
end

addProperty(Frame, {BackgroundColor3=Color3.fromRGB(25,25,25),BorderColor3=Color3.fromRGB(120,120,120),BackgroundTransparency=0,BorderSizePixel=0,Name='',Size=UDim2.new(0,window_width,0,183)})
addProperty(CloseButton, {Active=false,TextStrokeTransparency=.5,BackgroundTransparency=1,BorderColor3=Color3.fromRGB(1,1,1),BorderSizePixel=2,Position=UDim2.new(1,-18,0,0),Size=UDim2.new(0,18,0,18),Font='SourceSansBold',Text='X',Name='',TextColor3=Color3.fromRGB(200,200,200),TextSize=14,AutoButtonColor=false})
addProperty(MainTextBox, {BackgroundColor3=Color3.fromRGB(35,35,35),TextStrokeTransparency=.5,BorderSizePixel=0,BorderColor3=Color3.fromRGB(1,1,1),Position=UDim2.new(0,0,0.0983606577,0),Size=UDim2.new(1,0,0,18),Font=Enum.Font.SourceSansItalic,PlaceholderColor3=Color3.fromRGB(150,150,150),PlaceholderText="Audio Search",Text="",TextColor3=Color3.fromRGB(200,200,200),TextSize=14,ClearTextOnFocus=false,TextWrapped=true,Font='SourceSansSemibold',Name=''})
addProperty(MainScrollingFrame, {BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.9,BorderColor3=Color3.fromRGB(60, 60, 60),Position=UDim2.new(0,0,0.196721315,0),Size=UDim2.new(1,0,0,147),ScrollBarThickness=4,BottomImage="rbxasset://textures/ui/Scroll/scroll-middle.png",TopImage="rbxasset://textures/ui/Scroll/scroll-middle.png",ScrollBarImageColor3=Color3.fromRGB(100,100,100),CanvasSize=UDim2.new(0,0,0,0),Name=''})
addProperty(mainTextLabel, {TextStrokeTransparency=.5,TextColor3=Color3.fromRGB(200,200,200),BackgroundColor3=Color3.fromRGB(255,255,255),Name='',BackgroundTransparency=1,BorderSizePixel=0,Size=UDim2.new(0,386,0,18),Font='SourceSansBold',Text="  Online Search",TextSize=12,TextXAlignment=Enum.TextXAlignment.Left})

Frame.Position = UDim2.new(-1, 0, .5, -(Frame.Size.Y.Offset/2))

local minimizeButton = CloseButton:clone()
addProperty(minimizeButton, {Name='',Parent=Frame,Text='—',Position=UDim2.new(1,-36,0,0)})

local favButton = minimizeButton:clone()
addProperty(favButton,{Parent=Frame,TextScaled=false,TextSize=17,TextYAlignment='Top',Text='★',Position=UDim2.new(1,(-18)*4,0,0)})

local FavoritesScrollingFrame = MainScrollingFrame:clone()
addProperty(FavoritesScrollingFrame,{Parent=Frame})

local ScriptNameLabel = mainTextLabel:Clone()
addProperty(ScriptNameLabel,{Text="  AudioBrowser | v"..version,Parent=Frame,Visible=false})

local SettingsButton = minimizeButton:clone()
addProperty(SettingsButton, {Parent=Frame,Text='S',Font='SourceSansSemibold',Position=UDim2.new(1,(-18)*5,0,0)})

local searchButton = Instance.new("ImageButton", Frame)
addProperty(searchButton,{Active=false,Name='',Image="rbxassetid://3229239834",Size=UDim2.new(0,19,0,18),BackgroundTransparency=1,Position=UDim2.new(1,(-18)*3,0,0)})

local favSearchTextBox = MainTextBox:clone()
addProperty(favSearchTextBox, {Parent=Frame,PlaceholderText="Search Favorites"})


local SettingsScrollingFrame = MainScrollingFrame:clone()
addProperty(SettingsScrollingFrame,{Parent=Frame,Position=UDim2.new(0,0,0,20),Size=UDim2.new(1,0,1,-20)})

local SettingsUIGridLayout = Instance.new("UIGridLayout", SettingsScrollingFrame)
addProperty(SettingsUIGridLayout, {SortOrder="LayoutOrder",Name="",CellPadding = UDim2.new(0,0,0,0),CellSize = UDim2.new(1,0,0,20)})

function refreshSettingsScrollingFrameCanvas()
	SettingsScrollingFrame.CanvasSize = UDim2.new(0,0,0,(#SettingsScrollingFrame:GetChildren()*20)-20)
end

function addSettingsHeader(TEXT)
	local Header = Instance.new("TextLabel", SettingsScrollingFrame)
	addProperty(Header, {BackgroundTransparency=1,TextStrokeTransparency=.5,TextColor3=Color3.fromRGB(200,200,200),Text = TEXT or "",TextXAlignment="Center",TextSize=15,Font="SourceSansBold"})
	refreshSettingsScrollingFrameCanvas()
	return Header
end

function addSettingsText(TEXT)
	local Header = Instance.new("TextLabel", SettingsScrollingFrame)
	addProperty(Header, {BackgroundTransparency=1,TextStrokeTransparency=.5,TextColor3=Color3.fromRGB(200,200,200),Text = TEXT or "",TextXAlignment="Center",TextSize=13,Font="SourceSansBold"})
	refreshSettingsScrollingFrameCanvas()
	return Header
end

function addSettingsButton(TEXT, X_SIZE)
	local Frame = Instance.new("Frame", SettingsScrollingFrame)
	Frame.BackgroundTransparency=1
	local Button = Instance.new("TextButton", Frame)
	addProperty(Button,{Active=false,TextSize=14,Size = UDim2.new(0,X_SIZE,0,16),TextStrokeTransparency=.5,Font="SourceSansBold",TextColor3=Color3.fromRGB(200,200,200),TextXAlignment="Center",BorderSizePixel=1,AutoButtonColor=false,Text=TEXT or "",BackgroundTransparency=0,BackgroundColor3=Color3.fromRGB(25,25,25),TextStrokeTransparency=.7,BorderColor3=Color3.fromRGB(120,120,120)}) -- 
	Button.Position=UDim2.new(0.5,-(Button.Size.X.Offset/2),0.5,-(Button.Size.Y.Offset/2))
	refreshSettingsScrollingFrameCanvas()
	return Button
end

function addSettingsBox(PLACEHOLDERTEXT, X_SIZE)
	local Frame = Instance.new("Frame", SettingsScrollingFrame)
	Frame.BackgroundTransparency=1
	local Box = Instance.new("TextBox", Frame)
	addProperty(Box,{TextSize=14,Size = UDim2.new(0,X_SIZE,0,16),TextStrokeTransparency=.5,Font="SourceSansBold",TextColor3=Color3.fromRGB(200,200,200),TextXAlignment="Center",BorderSizePixel=1,Text="",PlaceholderText=PLACEHOLDERTEXT or "",BackgroundTransparency=0,BackgroundColor3=Color3.fromRGB(25,25,25),TextStrokeTransparency=.7,BorderColor3=Color3.fromRGB(120,120,120)}) -- 
	Box.Position=UDim2.new(0.5,-(Box.Size.X.Offset/2),0.5,-(Box.Size.Y.Offset/2))
	refreshSettingsScrollingFrameCanvas()
	return Box
end



local FavoritesTextLabel = mainTextLabel:Clone()
addProperty(FavoritesTextLabel,{Text="  Favorites",Parent=Frame,Position = UDim2.new(0,0,0,0)}) 

local SettingsIdTextLabel = mainTextLabel:Clone()
addProperty(SettingsIdTextLabel,{Text="  Settings",Parent=Frame,Position = UDim2.new(0,0,0,0)}) 

addSettingsHeader("Search Settings")

local SettingsChangeSearchType = addSettingsButton("Sort Type: Relevance", 200)
local ShowRobloxAudiosButton = addSettingsButton("Show Roblox Audios: OFF", 150)
local SettingsToggleAlphabeticalSort = addSettingsButton("Sort Favorites Alphabetically: OFF", 200)

addSettingsText()

addSettingsHeader("Add Audio Manually")

local SettingsIdTextBoxNAME = addSettingsBox("Audio Name Input",200)

local SettingsIdTextBoxID = addSettingsBox("Id Input",120)

local SettingsIdAddButton = addSettingsButton("Add", 190)

addSettingsText()

addSettingsHeader("Import from file")
addSettingsText("/workspace/filename.txt (must be .txt)")
addSettingsText('e.g. "0123456789 audioname"')


local importfilenamebox = addSettingsBox("Filename", 130)

local importbtn = addSettingsButton("Import", 140)

addSettingsText()

addSettingsHeader("Export to file")
addSettingsText("will be exported as .txt to /workspace/")

local exportfilenamebox = addSettingsBox("Filename", 130)

local exportbtn = addSettingsButton("Export audios to /workspace/",200)

addSettingsText()

addSettingsHeader("Other")

addSettingsText()

addSettingsHeader("How do I use this GUI?")
addSettingsText("Left Mouse Button: Preview")
addSettingsText("Right Mouse Button: Set to clipboard")
addSettingsText('Check the ★ to add the audio to your favorites!')

local rbxAudioExample = addSettingsText('This is a Roblox Audio')
rbxAudioExample.TextColor3 = Color3.new(.5,.25,.25)
local rbxAudioExample
addSettingsText('This is not a Roblox Audio')

addSettingsText()

local ClearAudioListData = addSettingsButton("Clear Data", 100)
ClearAudioListData.TextColor3=Color3.new(.5,.25,.25)
ClearAudioListData.BorderColor3=Color3.new(.5,.25,.25)

addSettingsText()

addSettingsHeader("Made by xxCloudd  |  AudioBrowser v"..version)

ShowRobloxAudiosButton.MouseButton1Click:connect(function()
	if showrobloxaudios == false then
		showrobloxaudios = true
		 ShowRobloxAudiosButton.Text = "Show Roblox Audios: ON"
	else
		showrobloxaudios = false
		ShowRobloxAudiosButton.Text = "Show Roblox Audios: OFF"
	end
	refreshFavoritesList(favSearchTextBox.Text)
end)

SettingsChangeSearchType.MouseButton1Click:connect(function()
	if SortType == 0 then
		SortType = 1
		SettingsChangeSearchType.Text = "Sort Type: MostFavorited"
	elseif SortType == 1 then
		SortType = 2
		SettingsChangeSearchType.Text = "Sort Type: Bestselling"
	elseif SortType == 2 then
		SortType = 3
		SettingsChangeSearchType.Text = "Sort Type: RecentlyUpdated"
	else
		SortType = 0
		SettingsChangeSearchType.Text = "Sort Type: Relevance"
	end
end)

-- VOUCH https://v3rmillion.net/member.php?action=profile&uid=159881

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
		wait(.5)
		ClearAudioListData.Text = "Clear Data"
	end
end)

exportbtn.MouseButton1Click:connect(function()
    local str = ""
	local totalAudios = 0
    for _,v in pairs(AUDIOS) do
        str = str .. v["ID"] .. " " .. v["Name"] .. "\n"
		totalAudios = totalAudios + 1
    end
    writefile(exportfilenamebox.Text .. ".txt", str)
    exportbtn.Text = "Exported " .. totalAudios .. " audios!"
    wait(.6)
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
	
	importbtn.Text = "Imported " .. totalAdded .. " audios"

	refreshFavoritesList()

	wait(.6)

	importbtn.Text = "Import"
	importdeb = false
end)

SettingsToggleAlphabeticalSort.MouseButton1Click:connect(function()
	if sortFavoritesAlphabetically then
	 	sortFavoritesAlphabetically = false
		SettingsToggleAlphabeticalSort.Text = "Sort Favorites Alphabetically: OFF"
	else
		sortFavoritesAlphabetically = true
		SettingsToggleAlphabeticalSort.Text = "Sort Favorites Alphabetically: ON"
	end
	refreshFavoritesList(favSearchTextBox.Text)
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

	SettingsIdAddButton.Text = '"'..Name..'" was saved to favorites'
	wait(1)
	SettingsIdAddButton.Text = "Save to Favorites"
end)

local Pages = {
	Search = {mainTextLabel, MainScrollingFrame, MainTextBox},
	Favorites = {FavoritesTextLabel, favSearchTextBox, FavoritesScrollingFrame},
	Settings = {SettingsScrollingFrame, SettingsToggleAlphabeticalSort, SettingsIdTextLabel}
}

local oldBooleans = {}

minimizeButton.MouseButton1Click:connect(function()
    if Frame.Size == UDim2.new(0,window_width,0,183) then
        for i, GUIElement in pairs(Frame:GetChildren())do
            if GUIElement ~= CloseButton and GUIElement ~= minimizeButton and GUIElement ~= ScriptNameLabel and not GUIElement:IsA('UICorner') then
                table.insert(oldBooleans, {
                Element = GUIElement,
                Bool = GUIElement.Visible
                })
                GUIElement.Visible = false
            end
        end
        ScriptNameLabel.Visible = true
        tween(Frame, .2, {Size=UDim2.new(0,window_width,0,18)})
    elseif Frame.Size == UDim2.new(0,window_width,0,18) then
        ScriptNameLabel.Visible = false
        tween(Frame, .2, {Size=UDim2.new(0,window_width,0,183)})
        for i, GUIElement in pairs(oldBooleans) do
            GUIElement["Element"].Visible = GUIElement["Bool"]
        end
        oldBooleans = {}
    end
end)

function refreshFavoritesList(str) -- Update list on GUI:
	FavoritesScrollingFrame:ClearAllChildren()
    FavoritesScrollingFrame.CanvasSize=UDim2.new(0,0,0,0)
    
	if sortFavoritesAlphabetically then
		local new = {}

		for i, audio in pairs(AUDIOS)do
			if string.find(audio["Name"]:lower(), (str and str:lower()) or '') then
				table.insert(new, {Name = audio["Name"], ID = audio["ID"]})
			end
		end

		table.sort(new,function(a,b)return a["Name"]:lower() < b["Name"]:lower()end)

		for i, audio in pairs(new)do
			createNew(FavoritesScrollingFrame, audio["Name"], audio["ID"])
		end
	else
    	for i, audio in pairs(AUDIOS)do
    		if string.find(audio["Name"]:lower(), (str and str:lower()) or '') then
				createNew(FavoritesScrollingFrame, audio["Name"], audio["ID"])
			end
    	end
	end
end

function addToAudiosTable(name,id)
	table.insert(AUDIOS, {
		Name = name,
		ID = id
	})
end

function addToFavorites(name,id)
	if isFavorited(id) then return end

    addToAudiosTable(name,id)
	
    SaveFavorites()
    refreshFavoritesList()

	return true
end

function removeFromFavorites(id)
    for i, audio in pairs(AUDIOS) do
        if audio["ID"] == id then
            table.remove(AUDIOS, i)
            break
        end
    end
    SaveFavorites()
    
    -- Update list on GUI:

    refreshFavoritesList()

	
end

function showPage(pg)

	if page == pg then return end

	local function viewContent(pg, Bool)
		for i,v in pairs(Pages[pg]) do 
			v.Visible = Bool
		end
	end

	viewContent("Search", false)
	viewContent("Favorites", false)
	viewContent("Settings", false)

	if pg == "search" then
		viewContent("Search", true)
	elseif pg == "fav" then
		viewContent("Favorites", true)
	elseif pg == "settings" then
		viewContent("Settings", true)
	end

	page = pg
end

favButton.MouseButton1Click:connect(function()
	showPage("fav")
end)

searchButton.MouseButton1Click:connect(function()
	showPage("search")
end)

SettingsButton.MouseButton1Click:connect(function()
	showPage("settings")
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
	tween(searchButton, .1, {ImageTransparency = 1}) -- bc imagebutton 
    wait(.1)
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

function playAudio(id)
	if soundInstance then
		if soundInstance.SoundId == "rbxassetid://" .. id then
			soundInstance:Destroy()
			soundInstance = nil
			return "StopSound"
		else
			soundInstance:Destroy()
			soundInstance = Instance.new("Sound", GUI)
			soundInstance.Volume = PREVIEW_VOLUME
			soundInstance.SoundId = "rbxassetid://" .. id
			soundInstance.Looped = true
			soundInstance:Play()
		end
	elseif (not soundInstance) or (not soundInstance.SoundId == "rbxassetid://" .. id) then
		soundInstance = Instance.new("Sound", GUI)
		soundInstance.Volume = PREVIEW_VOLUME
		soundInstance.SoundId = "rbxassetid://" .. id
		soundInstance.Looped = true
		soundInstance:Play()
	end
end
function createNew(Parent, txt, id, isARobloxAudio)

	if Parent:FindFirstChild(id) then return end

    local addOrRemove
    if isFavorited(id) then
        addOrRemove = "★"
    else
        addOrRemove = "☆"
    end

	local btn = Instance.new("TextButton", Parent)
	addProperty(btn,{Active=false,TextTruncate="AtEnd",TextStrokeTransparency=.5,Text=("  "..txt),BackgroundColor3=Color3.fromRGB(25,25,25),Size=UDim2.new(1,0,0,20),TextWrapped=true,Position=UDim2.new(0,20,0,(#Parent:GetChildren()*20)-20),BackgroundTransparency=0,TextColor3=(isARobloxAudio and Color3.new(.5,.25,.25) or Color3.fromRGB(140,140,140)),AutoButtonColor=false,TextSize=16,Name=id,TextXAlignment='Left',Font='SourceSansSemibold',BorderColor3=Color3.fromRGB(60,60,60)})
	local fav = Instance.new("TextButton", btn)
	addProperty(fav,{Active=false,TextStrokeTransparency=.5,Text=addOrRemove,BackgroundColor3=Color3.fromRGB(25,25,25),Size=UDim2.new(0,20,0,20),TextWrapped=true,Position=UDim2.new(0,-20,0,0),BackgroundTransparency=0,TextColor3=Color3.fromRGB(140,140,140),AutoButtonColor=false,TextSize=16,Name='fav',TextXAlignment='Center',Font='SourceSansBold',BorderColor3=Color3.fromRGB(60,60,60)})

	btn.MouseButton1Click:connect(function()
		local Play = playAudio(id)
		
		for i, button in pairs(MainScrollingFrame:GetChildren()) do
			tween(button, .1, {BackgroundColor3 = Color3.fromRGB(25,25,25)})
		end

		for i, button in pairs(FavoritesScrollingFrame:GetChildren()) do
			tween(button, .1, {BackgroundColor3 = Color3.fromRGB(25,25,25)})
		end
		
		wait()
		
		if Play ~= "StopSound" then
			tween(btn, .1, {BackgroundColor3 = Color3.fromRGB(35,35,35)})
		end
	end)
	
	btn.MouseButton2Click:connect(function()
		btn.Text = '  Set Id to clipboard'
		setclipboard(id)
		wait(.3)
		btn.Text = "  " .. txt
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
end

favSearchTextBox.Changed:connect(function(property)
	if property == "Text" then
		refreshFavoritesList(favSearchTextBox.Text)
	end
end)

function checkIfHasCharacters(str)
	local check = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_01234567889'
	local _check = false
	for i= 1, #check do
		if string.find(str, check:sub(i,i)) then
			_check = true
			break
		end
	end

	return _check

end

MainTextBox.FocusLost:connect(function(enter)
	if enter then
		local search = MainTextBox.Text

		if not checkIfHasCharacters(search) then return end
		
		clearMainList()
		
		if loading then return end
		
		loading = true
		MainTextBox.Text='Loading "'..search..'"..'
		MainTextBox.TextEditable=false
		
		local loadedresults = 0
		local totalresults = {}
		
		-- 3 pages

		local results1
		local results2
		local results3

		spawn(function() 
			results1=JSONDecode(game:HttpGet("https://search.roblox.com/catalog/json?Category=9&PageNumber=1&SortType="..SortType.."&Keyword="..search:gsub('/',''):gsub(" ","_"):lower()))
			loadedresults = loadedresults + 1
		end)
		spawn(function() 
			results2=JSONDecode(game:HttpGet("https://search.roblox.com/catalog/json?Category=9&PageNumber=2&SortType="..SortType.."&Keyword="..search:gsub('/',''):gsub(" ","_"):lower()))
			loadedresults = loadedresults + 1
		end)
		spawn(function() 
			results3=JSONDecode(game:HttpGet("https://search.roblox.com/catalog/json?Category=9&PageNumber=3&SortType="..SortType.."&Keyword="..search:gsub('/',''):gsub(" ","_"):lower()))
			loadedresults = loadedresults + 1
		end)
		
		repeat wait() until (loadedresults == 3)
		
		for i,v in pairs(results1) do
			totalresults[#totalresults+1] = v
		end
		for i,v in pairs(results2) do
			totalresults[#totalresults+1] = v
		end
		for i,v in pairs(results3) do
			totalresults[#totalresults+1] = v
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
		loading = false
		MainTextBox.TextEditable = true
	end
end)

refreshFavoritesList()

showPage("search")

tween(Frame, .25, {Position = UDim2.new(0, 10, .5, -(Frame.Size.Y.Offset/2))})
