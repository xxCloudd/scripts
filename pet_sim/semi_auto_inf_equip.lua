--tar/bv
local alt = ''
--//
function getsave()
	return workspace.__REMOTES.Core["Get Stats"]:InvokeServer().Save
end
function getpets()
	return getsave().Pets
end
function getequippedpets()
	local t = {}
	for _,p in pairs(getpets()) do
		if p.e then
			t[#t+1]=p
		end
	end
	return t
end
local mp = getsave().MaxPets
local T = workspace.__REMOTES.Game.Trading
local IR = workspace.__REMOTES.Game.Inventory
local ge = false
local con
repeat task.wait()
	if con then con:Disconnect() con = nil end -- reset connection
	local lastTradeId = nil
        
	con = game:FindFirstChild('Trade Update', true).OnClientEvent:Connect(function(id, data, operation)
		lastTradeId = id
	end)
	repeat task.wait(.25) until T:InvokeServer("InvSend", game.Players[alt]) == true
        
	repeat task.wait() until lastTradeId
	local TotalIn = 0
	local TotalE = #getequippedpets()
	print(TotalE)
	for _, p in pairs(getequippedpets()) do
		task.spawn(function()
                	T:InvokeServer("Add", lastTradeId, p.id)
                	TotalIn += 1
            	end)
	end
	
	repeat task.wait(.1) until TotalIn == TotalE
	
	local curr = #getpets()
        workspace.__REMOTES.Game.Trading:InvokeServer("Ready", lastTradeId)
	repeat task.wait(.1) until curr ~= #getpets()
	workspace.__REMOTES.Game.Trading:InvokeServer("Cancel", lastTradeId)

	local TEquipped = 0
	local TFoundNonEquipped = 0
	local absT = 0
	for _, p in pairs(getpets()) do
		if not p.e then
			absT = absT + 1
			if TFoundNonEquipped ~= mp then
				TFoundNonEquipped = TFoundNonEquipped + 1
				task.spawn(function()
					print(p.id,IR:InvokeServer('Equip', p.id))
					TEquipped = TEquipped + 1
				end)
			end
		end
	end 
	repeat task.wait() until TEquipped == TFoundNonEquipped
	
	ge = (absT==TFoundNonEquipped)
	repeat task.wait() until curr <= #getpets()
until #getequippedpets() == 0 or ge
