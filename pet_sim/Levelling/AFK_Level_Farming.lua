-- do _G.FARMING = false to stop

PET_ID = 74857084
HAT_LVL = 439856 -- 0 = No hat
CLEANER_PET_ID = 9642691 -- This is to break unused coins that build up and are bad for farming, use like a Dom Huge idk

-- Best configuration for Pets leveled under 2,250,000

mineCoins = {"Christmas2 Small Coin"}
mineUnusedCoins = {"Christmas2 Coin", "Christmas2 Coin Stack", "Christmas2 Small Chest", "Christmas2 Chest"}

--//

function getLvl(ID)
    local Stats = workspace.__REMOTES.Core["Get Stats"]:InvokeServer()
    
    for i, pet in pairs(Stats.Save.Pets) do
        if pet.id == ID then
            return pet.l
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
                workspace.__REMOTES.Game.Coins:FireServer("Mine", v.Name, (PET_LVL + HAT_LVL)*2-1, PET_ID)
                lastMainPetCooldwn = os.clock()
            elseif table.find(mineUnusedCoins, cn.Value) and os.clock() > lastBreakPetCooldwn + .13 and CLEANER_PET_LVL then
                workspace.__REMOTES.Game.Coins:FireServer("Mine", v.Name, CLEANER_PET_LVL*2-1, CLEANER_PET_ID)
                lastBreakPetCooldwn = os.clock()
            end
        end
    end
    if math.random(1000) == 1 then PET_LVL = getLvl(PET_ID) end
until not _G.FARMING
