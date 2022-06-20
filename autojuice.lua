lp = game.Players.LocalPlayer
teamname = lp.Team.Name

wfc = function(part, str)
    return part:WaitForChild(str)
end

ffc = function(part, str)
    return part:FindFirstChild(str)
end

rTycoon = function()
    local t = wfc(workspace.Tycoons,teamname)
    wfc(t, "Buttons")
    wfc(t, "Drops")
    return t
end

Trees = {
{"CoconutTree1", 2000000},
{"CoconutTree2", 3000000},
{"PearTree1", 500000},
{"PeachTree1", 150000},
{"CherryTree1", 75000},
{"PineappleTree1", 40000},
{"LimeTree1", 20000},
{"BlueberryBush1", 7500},
{"StrawberryBush1", 3000},
{"RaspberryBush1", 1500},
{"GrapeVine1", 750},
{"LemonTree1", 300},
{"AppleTree1", 100},
{"OrangeTree1", 0}
}

autopick = function()
    rTycoon().Drops.ChildAdded:connect(function(c)
        game.ReplicatedStorage.CollectFruit:fireServer(c)
    end)
end

returnMoney = function()
    return lp.leaderstats.Money.Value
end

touch = function(part)
    firetouchinterest(part, lp.Character.Head, 1)
    firetouchinterest(part, lp.Character.Head, 0)
end

attemptprestige = function()
    local btns = rTycoon().Buttons
    
    if ffc(btns, "Prestige") and returnMoney() >= (lp.leaderstats.Prestige.Value + 1)*1e7 then 
        touch(btns.Prestige)
        local statue = wfc(rTycoon().Purchased, "Golden Tree Statue")
        
        lp.Character.HumanoidRootPart.CFrame = statue.StatueBottom.CFrame
        wait(.5)
        fireproximityprompt(statue.StatueBottom.PrestigePrompt)
        
        wait(2)
        
        autopick()
        spawn(buybest)
        return false
    end
    
    local r1,r2,r3,r4=ffc(btns,"RoberryTree1"),ffc(btns,"RoberryTree2"),ffc(btns,"RoberryTree3"),ffc(btns,"RoberryTree4")
    
    if r1 then
        touch(r1)
    end
    if r2 then
        touch(r2)
    end
    if r3 then
        touch(r3)
    end
    if r4 then
        touch(r4)
    end
    
    if not r1 and not r2 and not r3 and not r4 then
        return false
    end
    
    return true
end


function buybest()
    
    local attempt = attemptprestige()
    
    if attempt == false then return end
    
    for i, val in pairs(Trees) do  
        local tree, price = val[1], val[2]
        
        if returnMoney() >= price and ffc(rTycoon().Buttons, tree) then 
            local Tree = rTycoon().Buttons[tree]
            touch(Tree)
            print("Bought " .. tree)
            break
        end
    end
end

autopick()

repeat
    
    local x = lp.Character.HumanoidRootPart
    
    touch(workspace.ObbyParts.RealObbyStartPart)--x.CFrame = CFrame.new(0, 3, 142)
    wait(.5)
    touch(workspace.ObbyParts.VictoryPart)--x.CFrame = CFrame.new(0, 4, 410)
    
    for i = 1, 31 do--wait(31)
        attemptprestige()
        wait(1)
    end
    
    buybest()
    
    if returnMoney() > 50 then
        local btn = ffc(rTycoon().Buttons,"JuiceSpeedUpgrade1")
        if btn then 
            touch(btn)
            print("Bought" .. btn.Name)
        end
    end
    
    if returnMoney() > 2000 then
        local s = "JuiceSpeedUpgrade"
        for i = 2, 4 do 
            local btn = ffc(rTycoon().Buttons,s..i)
            if btn then 
                touch(btn)
                wait(.5)
                print("Bought" .. btn.Name)
            end
        end
    end
    
    if returnMoney() > 120000 then
        local s = "JuiceSpeedUpgrade"
        for i = 5, 8 do 
            local btn = ffc(rTycoon().Buttons,s..i)
            if btn then 
                touch(btn)
                wait(.5)
                print("Bought" .. btn.Name)
            end
        end
    end
    
    wait(4*60+30)
    
until 0==1