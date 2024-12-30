local petid = 123456790
local level = 1337
local petsToAttackOfLevelAbove = 200e6
--//
local s, r = workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save, workspace.__REMOTES.Game.Coins
local b, v = table.find(s.Gamepasses, 4918550) and 2 or 1, table.find(s.Gamepasses, 4918538) and 1.5 or 1

function calc(l)
 return l<0 and -3 or ((l-1)*2*(l+1))
end

local pet
for i,v in pairs(s.Pets) do
 if v.id == petid then
  pet=v
  break
 end
end

local coin
for i,c in pairs(workspace.__THINGS.Coins:GetChildren()) do
 if c.CoinName.Value=='1 Small Coin' and c.Color==Color3.fromRGB(244,180,17) then
  coin = c
  break
 end
end

r:FireServer("Mine", coin.Name, ((calc(level)-pet.xp)*10)/(b * v), petid)

if game.Players.LocalPlayer.Character then
 game.Players.LocalPlayer.Character:MoveTo(coin.Position)
end

repeat task.wait(.13)
 for i,v in pairs(s.Pets) do
  if v.l>petsToAttackOfLevelAbove and v.id~=petid then
   task.spawn(function()
    r:FireServer('Mine',coin.Name,v.l*2-1,v.id)
   end)
  end
 end
until not coin or coin.Parent~=workspace.__THINGS.Coins
