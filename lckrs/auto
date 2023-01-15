-- sdfdsfsafsafsf

speed = 1.2
stopmsg = '!s'

l=game.Players.LocalPlayer
h=l.Character.HumanoidRootPart
mf=math.floor

h.CFrame=CFrame.new(0,mf(h.CFrame.Y),mf(h.CFrame.Z))*CFrame.Angles(0,math.rad((mf(mf(h.Position.Y-3)/16)+1)%2==0 and 0 or 180),0)
wait(.5)
d=true

l.Chatted:connect(function(c)
    if c==stopmsg then 
        d=false
        h.Parent.Humanoid.HipHeight = 0
    end
end)

h.Parent.Humanoid.HipHeight = 4 -- avoid obstacles
while d do wait()
    local zpos
    repeat wait()
        zpos = h.Position.Z
        h.CFrame=h.CFrame*CFrame.new(0,0,-speed)
    until (zpos > 4000) or (zpos < -2) or not d
    
    if not d then return end
    
    local newzpos
    if zpos > 4000 then
        newzpos = CFrame.new(h.Position.X, h.Position.Y, 3985)
    elseif zpos < -2 then
        newzpos = CFrame.new(h.Position.X, h.Position.Y, 12)*CFrame.Angles(0,math.rad(180),0)
    end
    wait(4)
    h.CFrame=newzpos*CFrame.new(0,16,0)
    wait(4)
end
