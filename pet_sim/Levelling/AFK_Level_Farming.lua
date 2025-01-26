--[[ Instructions

stop script: [ _G.FARMING = false ]

PET_ID - the ID of the Pet to be levelled up
CLEANER_PET_ID - the ID of the Pet that breaks unused coins that build up and are bad for farming, use some high-power pet like a Dominus Huge

# Best configuration for Pets leveled under 2,250,000 #
---
mineCoins = {"Christmas2 Small Coin"}
mineUnusedCoins = {"Christmas2 Coin", "Christmas2 Coin Stack", "Christmas2 Small Chest", "Christmas2 Chest"}
---

# Best configuration for Pets leveled above 2,250,000 #
---
CLEANER_PET_ID = 0
mineCoins = {"Christmas3 Small Cane", "Christmas3 Cane"}
mineUnusedCoins = {}
---
]]

-- Settings :

PET_ID = 12345670
CLEANER_PET_ID = 12345670
mineCoins = {"Christmas2 Small Coin"}
mineUnusedCoins = {"Christmas2 Coin", "Christmas2 Coin Stack", "Christmas2 Small Chest", "Christmas2 Chest"}

--// Don't change anything under

function getLvl(ID)
    local Stats = workspace.__REMOTES.Core["Get Stats"]:InvokeServer()
    
    for i, pet in pairs(Stats.Save.Pets) do
        if pet.id == ID then
            local l = pet.l
            if pet.h then
                for _, h in pairs(Stats.Save.Hats) do
                    if h.id == pet.h then
                        l = l + h.l
                        break
                    end
                end
            end
            return l
        end
    end
end

local CLEANER_PET_LVL = getLvl(CLEANER_PET_ID)
local PET_LVL = getLvl(PET_ID)
task.wait(.13*4)
_G.FARMING = true
local lastMainPetCooldwn, lastBreakPetCooldwn = os.clock(), os.clock()

repeat task.wait(.13)
    for i, v in pairs(workspace.__THINGS.Coins:GetChildren()) do
        local cn = v:FindFirstChild'CoinName'
        if cn then
            if table.find(mineCoins, cn.Value) and os.clock() > lastMainPetCooldwn + .13 then
                workspace.__REMOTES.Game.Coins:FireServer("Mine", v.Name, (PET_LVL)*2-1, PET_ID)
                lastMainPetCooldwn = os.clock()
            elseif table.find(mineUnusedCoins, cn.Value) and os.clock() > lastBreakPetCooldwn + .13 and CLEANER_PET_LVL then
                workspace.__REMOTES.Game.Coins:FireServer("Mine", v.Name, CLEANER_PET_LVL*2-1, CLEANER_PET_ID)
                lastBreakPetCooldwn = os.clock()
            end
        end
    end
    if math.random(1000) == 1 then PET_LVL = getLvl(PET_ID) end
until not _G.FARMING
