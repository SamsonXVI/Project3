local friendsGraph = Instance.new("Folder")
friendsGraph.Parent = game.ServerStorage
friendsGraph.Name = "FriendsGraph"
local completedNodes = {}

local friendPages = nil
local function iterPageItems(pages)
	return coroutine.wrap(function()
		local pagenum = 1
		while true do
			for _, item in ipairs(pages:GetCurrentPage()) do
				coroutine.yield(item, pagenum)
			end
			if pages.IsFinished then
				break
			end
			pages:AdvanceToNextPageAsync()
			pagenum = pagenum + 1
		end
	end)
end

function createUserNode(userID,UserName)
	local folder = game.ServerStorage.SampleNode:Clone()
	folder.Name = UserName
	folder.UserID.Value = userID
	folder.Parent = friendsGraph
	return folder
end

function addUsersFriends(origin)
	if completedNodes[origin.UserID.Value] == nil then
		wait(3.6) --Delay because of HTTP Request limit, also why I had to leave my computer running for 2 hours for the data to collect ;-;
		friendPages = game.Players:GetFriendsAsync(origin.UserID.Value)
		for item, pageNo in iterPageItems(friendPages) do
			local friendPointer = Instance.new("ObjectValue")
			friendPointer.Parent = origin.Friends
			local targetFolder = nil
			if friendsGraph:FindFirstChild(item.Username) == nil then
				targetFolder = createUserNode(item.Id, item.Username)
				friendPointer.Value = targetFolder
			else
				targetFolder = friendsGraph[item.Username]
				friendPointer.Value = targetFolder
			end
			friendPointer.Name = friendPointer.Value.Name
			
			if targetFolder.Friends:FindFirstChild(origin.Name) == nil then
				local friendPointer = Instance.new("ObjectValue")
				friendPointer.Parent = targetFolder.Friends
				friendPointer.Name = origin.Name
				friendPointer.Value = origin
			end
		end
		completedNodes[origin.UserID.Value] = true
	end
end




local origin = createUserNode(554744114,"SamsonXVI")
addUsersFriends(origin)
--Check Count
local users = friendsGraph:GetChildren()
local layer1Count = #users-1




local users = friendsGraph:GetChildren()
for i = 1, #users do
	addUsersFriends(users[i])
end
--Check Count
local users = friendsGraph:GetChildren()
local layer2Count = #users-1-layer1Count




local users = friendsGraph:GetChildren()
for i = 1, #users do
	addUsersFriends(users[i])
end
--Check Count
local users = friendsGraph:GetChildren()
local layer3Count = #users-1-layer1Count-layer2Count



print("Layer 1: "..layer1Count)
print("Layer 2: "..layer2Count)
print("Layer 3: "..layer3Count)
