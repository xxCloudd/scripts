function onChatted(player, func)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(messageData) 
        if player == game.Players[messageData.FromSpeaker] then
            func(messageData.Message) 
        end
    end)
end

onChatted(game.Players.LocalPlayer, function(c)
    print(c)
end)

