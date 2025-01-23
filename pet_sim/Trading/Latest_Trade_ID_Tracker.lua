local tradeId=0
local lastupdate=nil
local h = Instance.new('Hint', workspace)
h.Text='waiting for trade update'
game:FindFirstChild('Trade Update', true).OnClientEvent:Connect(function(id)
    lastupdate=id
    h.Text='Latest Trade Update ID: ' .. lastupdate .. ' | ' .. os.clock()
end)
