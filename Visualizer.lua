local visualizer = {}

function visualizer.LoadAvatarAppearance(character)
	
	local appearanceModel = nil
	local success, msg = pcall(function()
		appearanceModel = game.Players:GetCharacterAppearanceAsync(character.Configuration.userId.Value)
	end)
	if success then
		
		local modelChildren = appearanceModel:GetChildren()

		for i = 1, #modelChildren do
			if modelChildren[i]:IsA("BodyColors") then
				modelChildren[i].Parent = character
			end
			if modelChildren[i]:IsA("Accessory") then
				modelChildren[i].Parent = character
				local isLayered = false
				local stuff = modelChildren[i]:GetDescendants()
				for i = 1, #stuff do
					if stuff[i]:IsA("WrapLayer") then
						isLayered = true
						break
					end
				end
				if isLayered == true then
					modelChildren[i]:Destroy()
				end
			end
			if modelChildren[i]:IsA("CharacterMesh") then
				modelChildren[i].Parent = script.Parent[modelChildren[i].BodyPart]
			end
			if modelChildren[i]:IsA("Shirt") then
				modelChildren[i].Parent = character
			end
			if modelChildren[i]:IsA("Pants") then
				modelChildren[i].Parent = character
			end
			if modelChildren[i]:IsA("ShirtGraphic") then
				modelChildren[i].Parent = character
			end
			if modelChildren[i]:IsA("Decal") then
				modelChildren[i].Parent = character.Head
			end
			if modelChildren[i].Name == "face" then
				modelChildren[i].Parent = character.Head
			end
			if modelChildren[i].Name == "R6" then
				local stuff = modelChildren[i]:GetChildren()
				for i = 1, #stuff do
					stuff[i].Parent = character
				end
			end
		end
	end
end

function visualizer.spawnAvatar(node,index,isLast)
	local avatar = script.SampleAvatar:Clone()
	avatar.Name = node.Name
	avatar.Configuration.userId.Value = node.UserID.Value
	avatar.Parent = workspace.Visual
	avatar.HumanoidRootPart.CFrame = CFrame.new(index*-10,3.196,20)
	visualizer.LoadAvatarAppearance(avatar)
	if isLast == false then
		local arrow = script.Arrow:Clone()
		arrow:SetPrimaryPartCFrame(CFrame.new(index*-10-4.8,3,20))
		arrow.Parent = workspace.Visual
	end
end

function visualizer.visualize(nodeList,duration)
	duration = duration*1000
	duration = math.round(duration)
	workspace.Board.BoardPart.SurfaceGui.Frame.RunTime.Text = "Total Runtime: "..duration.."ms"
	workspace.Board.BoardPart.SurfaceGui.Frame.ChainLength.Text = "Chain Size: "..#nodeList.." Users"
	
	--[[local delayTime = 0
	if #nodeList > 7 then
		delayTime = .2
	end]]
	for i = 1, #nodeList do
		--wait(delayTime)
		if i ~= #nodeList then
			visualizer.spawnAvatar(nodeList[i],i,false)
		else
			visualizer.spawnAvatar(nodeList[i],i,true)
		end
	end
end

return visualizer
