local TRADE_ID = 12345
local pets = workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save.Pets
for _, pet in pairs(pets) do
    task.spawn(function()
        workspace.__REMOTES.Game.Trading:InvokeServer("Add", TRADE_ID, pet.id)
        TTL = TTL + 1
    end)
end
repeat task.wait() until TTL == #pets
TR:InvokeServer("Ready", tradeId)
