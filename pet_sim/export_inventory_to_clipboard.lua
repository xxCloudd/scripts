-- Accounts need to be in-game

local accounts = {'ROBLOX','Guest','Admin'}

--

local s, tt, n, s0rt ='Inventory of '..table.concat(accounts,', '), 0 , {}, {}
local dir = require(game.ReplicatedStorage['1 | Directory']).Pets

for _, user in pairs(accounts)do
	local p = workspace.__REMOTES.Core['Get Other Stats']:InvokeServer()[user].Save.Pets
	for _, v in pairs(p) do
		local h = v.dm and v.r and'Glitched'or v.dm and'DM'or v.r and'Rainbow'or v.g and'Gold'or'Regular'
		n[v.n..'-'..h..'-'..v.l]=n[v.n..'-'..h..'-'..v.l] and n[v.n..'-'..h..'-'..v.l]+1 or 1
		tt=tt+1
	end
end

s = s .. '\nTotal: ' .. tt .. '\n\n'

fn = function(number) -- didnt make this function
	local formatted = tostring(number)
	local k
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then
			break
		end
	end
	return formatted
end

for i,v in pairs(n)do
	local lol=i:split'-'
	s0rt[#s0rt+1]=v..'x '..lol[2]..' '..dir[lol[1]].DisplayName..' | '..lol[3]
end

table.sort(s0rt,function(a,b)
	return tonumber(a:split' | '[2]) > tonumber(b:split' | '[2])
end)

for i,v in pairs(s0rt)do
	s = s..v:split' | '[1]..' | '..fn(v:split' | '[2])..'\n'
end

setclipboard(s)
