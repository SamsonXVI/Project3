local DFSModule = {}

function DFSModule.DFS(origin,target)
	local t1 = tick()

	local users = game.ServerStorage.FriendsGraph:GetChildren()
	local origin = game.ServerStorage.FriendsGraph[origin]
	local targetUser =  game.ServerStorage.FriendsGraph[target]

	local stack = {}
	local visited = {}

	table.insert(stack,origin)
	visited[stack[#stack]] = origin

	local t = 0
	while #stack > 0 do
		local node = stack[#stack]
		table.remove(stack,#stack)

		local friends = node.Friends:GetChildren()
		for i = 1, #friends do
			local friend = friends[i].Value
			if visited[friend] == nil then
				visited[friend] = node
				table.insert(stack,friend)
			end
		end
	end

	local current = targetUser
	local pathList = {}
	repeat
		table.insert(pathList,current)
		current = visited[current]
	until current == origin
	table.insert(pathList,origin)

	local orderedPathList = {}
	for i = #pathList, 1, -1 do
		--print(i..": "..pathList[i].Name)
		table.insert(orderedPathList,pathList[i])
	end

	for i = 1, #orderedPathList do
		--print(i..": "..orderedPathList[i].Name)
	end

	local runTime = tick()-t1
	print(runTime)
	local visualizer = require(game.ServerScriptService.Visualizer)
	visualizer.visualize(orderedPathList,runTime)
	--game.ServerScriptService.VisualizerModel.Visualize:Fire(orderedPathList,runTime)
end

return DFSModule
