local BFSModule = {}

function BFSModule.BFS(origin,target)
	local t1 = tick()

	local users = game.ServerStorage.FriendsGraph:GetChildren()
	local origin = game.ServerStorage.FriendsGraph[origin]
	local targetUser =  game.ServerStorage.FriendsGraph[target]

	local queue = {}
	local visited = {}

	table.insert(queue,origin)
	visited[queue[1]] = origin

	while #queue > 0 do
		local node = queue[1]
		table.remove(queue,1)

		local friends = node.Friends:GetChildren()
		for i = 1, #friends do
			local friend = friends[i].Value
			if visited[friend] == nil then
				visited[friend] = node
				table.insert(queue,friend)
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

return BFSModule
