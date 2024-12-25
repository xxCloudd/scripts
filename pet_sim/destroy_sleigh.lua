local pets_level_required = 200e6

local coin
for i, v in pairs(workspace.__THINGS.Coins:children()) do 
	if v.CoinName.Value == "Christmas1 Sleigh" then
		coin = v
		break
	end
end

local pets = workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save.Pets

repeat task.wait(.13)
	for i,v in pairs(pets) do
		if v.l > pets_level_required then
			spawn(function()
			  workspace.__REMOTES.Game.Coins:FireServer('Mine', coin.Name, v.l * 2 - 1, v.id)
			end)
		end
	end
until not coin or coin.Parent ~= workspace.__THINGS.Coins
