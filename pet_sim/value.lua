local list = game:HttpGet''

local T,P,tn = 0,require(game.ReplicatedStorage['1 | Directory']).Pets, tonumber
function z(_) return _.dm and _.r and'gli'or _.g and'g'or _.r and not _.dm and'rb'or _.dm and not _.r and'dm'or'reg' end
for b,v in pairs(workspace.__REMOTES.Core['Get Stats']:InvokeServer().Save.Pets)do
 if v.l then
  for t,ar in pairs(list:split'\n')do
   if z(v)==ar:split'/'[2] then
    if ar:split'/'[3]==P[v.n].DisplayName:lower()then
     if v.l>=tn(ar:split'/'[4])and v.l<=tn(ar:split'/'[5])then
      T=T+tn(ar:split'/'[1])
     end
    end
   end
  end
 end
end
print(T,'value')
