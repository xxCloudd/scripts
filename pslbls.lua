function add(frame)
	if frame:isA'Frame' then
		if frame:FindFirstChild'TextLabel' then
			frame.TextLabel.Text=frame.Name
		else
			local a=Instance.new("TextLabel",frame)
			a.Text=frame.Name
			a.BackgroundTransparency = 1
			a.Size = UDim2.new(1,0,0,20)
			a.ZIndex=20
			a.TextColor3=Color3.new(0,1,0)
			a.TextStrokeTransparency=.5
			a.TextSize=14
		end
	end
end

while task.wait(1) do
	for i, v in pairs(game.Players.LocalPlayer.PlayerGui.Inventory.Frame.Pets:children()) do
		add(v)
	end
end
