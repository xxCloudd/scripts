function add(frame)
	if frame:isA'Frame' then
		if frame:FindFirstChild'TextButton' then
			frame.TextLabel.Text=frame.Name
		else
			local a=Instance.new("TextButton",frame)
			a.Text=frame.Name
			a.BackgroundTransparency = 1
			a.Size = UDim2.new(1,0,0,20)
			a.ZIndex=20
			a.TextColor3=Color3.new(0,1,0)
			a.TextStrokeTransparency=.5
			a.TextSize=14
            a.MouseButton1Click:Connect(function()
                setclipboard(a.Parent.Name)
            end)
		end
	end
end

while true do
	for i, v in pairs(game.Players.LocalPlayer.PlayerGui.Inventory.Frame.Pets:children()) do
		add(v)
	end
    task.wait(1)
end
