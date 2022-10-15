local cmds = {}

addcmd = function(aliases, func) -- addcmd({'test1','test2'}, func)
    cmds[#cmds+1] = {
        aliases = aliases,
        f = func
    }
end

execmd = function(s)
    local args = s:split(" ")
    local cmdinput = args[1]
    table.remove(args, 1) -- .cmd is not an arg!!
    
    for i, cmd in next, cmds do 
        if table.find(cmd.aliases, cmdinput) then 
            spawn(function()
                cmd.f(unpack(args))
            end)
            break 
        end
    end
end

getplr = function(s)
    for i, player in pairs(game.Players:GetPlayers()) do
        if (player.Name:lower()):sub(1, #s) == s or (player.DisplayName:lower()):sub(1, #s) == s then
            return player
        end
    end
end
