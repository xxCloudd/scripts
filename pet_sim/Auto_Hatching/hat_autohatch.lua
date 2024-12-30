local getOnlyOne = true
local Hat = 'Robux'
--//
local Hats = {
	[40005] = {"Hat Stack",4},
	[40006] = {"Blue Top Hat",4},
	[40007] = {"Robux",5},
	[30001] = {"Traffic Cone",3},
	[30002] = {"Pirate Hat",3},
	[30003] = {"Chessboard",3},
	[30004] = {"Horns",3},
	[30005] = {"Green Banded Top Hat",3},
	[30006] = {"Yellow Banded Top Hat",3},
	[30007] = {"White Top Hat",3},
	[30008] = {"Blue Traffic Cone",3},
	[99001] = {"Rain Cloud",5},
	[99002] = {"Crown",5},
	[20001] = {"Paper Hat",2},
	[99004] = {"Lord of the Federation",5},
	[99005] = {"Domino Crown",5},
	[20004] = {"Propeller Beanie",2},
	[20005] = {"Cowboy Hat",2},
	[20006] = {"Viking",2},
	[20007] = {"Giant Cheese",2},
	[10001] = {"Lei",1},
	[10002] = {"Apple",1},
	[10003] = {"Black Winter Cap",1},
	[10004] = {"Pot",1},
	[99003] = {"Duke of the Federation",5},
	[99006] = {"Black Iron Domino Crown",5},
	[20002] = {"Cheese",2},
	[40001] = {"Neon Pink Banded Top Hat",4},
	[40002] = {"Rubber Duckie",4},
	[40003] = {"Noob Sign",4},
	[40004] = {"Bling Top Hat",4},
	[20003] = {"Princess Hat",2},
}
local present, id
for i, v in pairs(Hats)do
	if v[1] == Hat then
		id = i
		present = v[2] == 5 and 'Golden' or 'Tier ' .. v[2]
	end
end
local r = workspace.__REMOTES
local b = false
local mh = r.Core["Get Stats"]:InvokeServer().Save.HatSlots
repeat task.wait()
	local td, wt = {}, 0
	local tb = mh - #r.Core["Get Stats"]:InvokeServer().Save.Hats
	for _ = 1, tb do
		task.spawn(function()
			local _, h = r.Game.Shop:InvokeServer("Buy", "Presents", present)
			if tonumber(h[1][1].n) ~= id then
				table.insert(td, h[1][1].id)
			else
				warn"got robux hat"
				b = true
			end
			wt = wt + 1
		end)
	end
	repeat task.wait() until wt == tb 

	r.Game.Hats:InvokeServer("MultiDelete", td)
until getOnlyOne and b
