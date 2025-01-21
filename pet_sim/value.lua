local list = game:HttpGet''

local T,P = 0,require(game.ReplicatedStorage['1 | Directory']).Pets
for b,v in pairs(workspace.__THINGS.__REMOTES['Get Stats']:InvokeServer().Save.Pets)do
 if v.l then
  for t,ar in pairs(list:split'\n')do
   if ar:split'/'[3]==P[v.n].DisplayName:lower()then
    if v.l>=ar:split'/'[4]:split'-'[1]and v.l<=ar:split'/'[4]:split'-'[2]then
     T=T+ar:split'/'[1]
    end
   end
  end
 end
end
print(T,'value')
