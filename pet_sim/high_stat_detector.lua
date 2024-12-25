local level_offset = 100000 -- determines how much from the max it's required to be considered a "high stat"

--//

local dir = require(game.ReplicatedStorage['1 | Directory']).Pets

local fn = function(number) -- didnt make this func
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

warn'####'

for _, user in pairs(game.Players:GetChildren())do
    for i,v in pairs(workspace.__REMOTES.Core['Get Other Stats']:InvokeServer()[user.Name].Save.Pets) do
        local multi = v.g and 3 or v.r and 6 or v.dm and 18 or 1
        local h = v.dm and v.r and'Glitched 'or v.dm and'DM 'or v.r and'Rainbow 'or v.g and'Gold 'or'Regular '
        if not (v.n == "17009" and v.dm) and v.l >= dir[v.n].Level[2]*multi + level_offset then
            print(user.Name .. ' has a LVL ' .. fn(v.l) .. ' ' ..  h .. dir[v.n].DisplayName .. ' (' .. fn(dir[v.n].Level[2]*multi) .. ' + ' .. fn(v.l - dir[v.n].Level[2]*multi) .. ')')
        end
    end
end
