--[[
    Brought to you by tar/bv/1rs
    1.03 - removed extra 40s measure
]]

ACC_TO_GIVE_PETS = _G.ACC_TO_GIVE_PETS or ""

-- // tar - 1rs - bv - :-)

local Debris = game:GetService'Debris'
local TeleportService = game:GetService'TeleportService'
local Ver = '1.03'

if not game.Players:FindFirstChild(ACC_TO_GIVE_PETS) then
    local xd=Instance.new('Message',workspace)
    xd.Text='player isnt in game'
    Debris:AddItem(xd, 5)
    return
end
local servers = {}
if http_request then
    
    local req = http_request({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)})
    local body = game:service'HttpService':JSONDecode(req.Body)

    if body and body.data then
        for i, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                servers[#servers+1] = v
            end
        end
    end
    
    table.sort(servers, function(a, b) return a.playing < b.playing end)
    
    local SERVER = servers[1].id
    if #servers > 0 then
        local H = Instance.new("Hint", workspace)
        H.Text = "[1/4] Teleporting to a different server"
        Debris:AddItem(H, 10)

    else
        local xd=Instance.new('Message',workspace)
        xd.Text='didnt find a new server to do dis'
        Debris:AddItem(xd, 5)
        return
    end
else
    local xd=Instance.new('Message',workspace)
    xd.Text='ur exploitie no supportie httprequest()'
    Debris:AddItem(xd, 5)
    return
end
    
    
if not queue_on_teleport then 
    local xd=Instance.new('Message',workspace)
    xd.Text='ur exploitie no supportie queue_on_teleport()'
    Debris:AddItem(xd, 5)
    return
end

queue_on_teleport([==[
    local h = Instance.new('Hint',workspace)for i=2,0,-1 do h.Text='[2/4] '..i task.wait(1)end h.Text='[2/4] Teleporting back..'

    queue_on_teleport([=[
        hookfunction(getsenv(game.Players.LocalPlayer.PlayerGui.Scripts.GUIs.Trading).UpdateTrade,function()end)
        Instance.new('Hint',workspace).Text = '[3/4] Trading pets to account' 
        local T, lastTradeId = workspace.__REMOTES.Game.Trading, nil
        local PLR = game.Players[']==] .. ACC_TO_GIVE_PETS .. [==[']
        
        game:FindFirstChild('Trade Update', true).OnClientEvent:Connect(function(id, data, operation)
            lastTradeId = id
        end)
        
        repeat task.wait(.25) until T:InvokeServer("InvSend", PLR) == true
        
        repeat task.wait() until lastTradeId
        
        local PLR_PET_COUNT = #workspace.__REMOTES.Core["Get Other Stats"]:InvokeServer()[PLR.Name].Save.Pets
        
        local TotalIn = 0
        local TotalPets = 0
        
        for i, p in pairs(workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save.Pets) do
            TotalPets += 1
            task.spawn(function()
                T:InvokeServer("Add", lastTradeId, p.id)
                TotalIn += 1
            end)
        end
        
        repeat task.wait(.1) until TotalIn == TotalPets
        
        workspace.__REMOTES.Game.Trading:InvokeServer("Ready", lastTradeId)
        
        repeat task.wait(0.1) until PLR_PET_COUNT < #workspace.__REMOTES.Core["Get Other Stats"]:InvokeServer()[PLR.Name].Save.Pets
        
        queue_on_teleport([[
            local h = Instance.new('Hint',workspace)for i=40,0,-1 do h.Text='[4/4] '..i wait(1) end h.Text='[4/4] Teleporting..'
            queue_on_teleport("local h = Instance.new('Hint',workspace)h.Text='Done'wait(10)h:Destroy()")
            game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==] .. game.JobId .. [==[", game.Players.LocalPlayer)
        ]])
        game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==] .. servers[1].id .. [==[", game.Players.LocalPlayer)
    ]=])
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==].. game.JobId .. [==[", game.Players.LocalPlayer)

]==])
TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id, game.Players.LocalPlayer)
