local toolbar = plugin:CreateToolbar("Project")
local functionScriptButton = toolbar:CreateButton("OPEN/CLOSE PROJECT", "", "rbxassetid://12411755336")

local gui = script:WaitForChild("Main")

functionScriptButton.Click:Connect(function()
	if script:FindFirstChild("Main") then
		gui.Parent = game:WaitForChild("CoreGui")
		gui.Frame.Origin.TextBox.Text = "[USERNAME]"
		gui.Frame.Target.TextBox.Text = "[USERNAME]"
		gui.Option.Value = "BFS"
		workspace.Board.BoardPart.SurfaceGui.Frame.RunTime.Text = "Total Runtime: 0ms"
		workspace.Board.BoardPart.SurfaceGui.Frame.ChainLength.Text = "Chain Size: 0 Users"
	else
		gui.Parent = script
	end
end)

gui.Frame.Algorithm.BFSButton.MouseButton1Click:Connect(function()
	gui.Frame.Algorithm.BFSButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
	gui.Frame.Algorithm.DFSButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
	gui.Option.Value = "BFS"
end)

gui.Frame.Algorithm.DFSButton.MouseButton1Click:Connect(function()
	gui.Frame.Algorithm.DFSButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
	gui.Frame.Algorithm.BFSButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
	gui.Option.Value = "DFS"
end)

gui.Frame.Reset.ImageButton.MouseButton1Click:Connect(function()
	local visuals = workspace.Visual:GetChildren()
	for i = 1, #visuals do
		visuals[i]:Destroy()
	end
	gui.Frame.Origin.TextBox.Text = "[USERNAME]"
	gui.Frame.Target.TextBox.Text = "[USERNAME]"
	workspace.Board.BoardPart.SurfaceGui.Frame.RunTime.Text = "Total Runtime: 0ms"
	workspace.Board.BoardPart.SurfaceGui.Frame.ChainLength.Text = "Chain Size: 0 Users"
end)

gui.Frame.Start.ImageButton.MouseButton1Click:Connect(function()
	local origin = gui.Frame.Origin.TextBox.Text
	local target = gui.Frame.Target.TextBox.Text
	if gui.Option.Value == "BFS" then
		--game.ServerScriptService.BFS.Start:Fire(origin,target)
		local BFS = require(game.ServerScriptService.BFSModule)
		BFS.BFS(origin,target)
	else
		local DFS = require(game.ServerScriptService.DFSModule)
		DFS.DFS(origin,target)
	end
end)
