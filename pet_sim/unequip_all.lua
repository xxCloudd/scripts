for _,v in pairs(workspace.__REMOTES.Core['Get Stats']:InvokeServer().Save.Pets)do
  if v.e then
    task.spawn(function()
        workspace.__REMOTES.Game.Inventory:InvokeServer('Unequip', v.id)
    end)
  end
end
