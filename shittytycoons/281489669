l = game.Players.LocalPlayer

wand = l.Backpack:findFirstChild("Wand") or l.Character:FindFirstChild("Wand")

if wand.Parent == l.Backpack then wand.Parent = l.Character end

for i, plr in pairs(game.Players:children()) do
    if plr ~= l and plr.Character and plr.Character:FindFirstChild"HumanoidRootPart" then
        wand.Fire:fireServer(plr.Character.HumanoidRootPart.CFrame,100,0,wand,1e5,l.Character)
    end
end
