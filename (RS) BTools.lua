--Made by rouxhaver

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

player = game:GetService("Players").LocalPlayer
Gui = player.PlayerGui
Backpack = player.Backpack
Mouse = player:GetMouse()

Parts_Folder = Instance.new("Folder",workspace)

for i, Hat in pairs(player.Character:GetChildren()) do
	if Hat:IsA("Accessory") then
		local Part = Instance.new("Part",Parts_Folder)
		Part.Name = Hat.Name
		obj = Instance.new("ObjectValue",Part)
		obj.Name = "obj"
		obj.Value = Hat
		Part.Anchored = true
		Part.Size = Hat.Handle.Size
		Part.Position = player.Character.Head.Position + Vector3.new(math.random(-5,5),math.random(-1,1),math.random(-5,5))
		Part:SetAttribute("Moveable",true)
		Part.Material = Enum.Material.SmoothPlastic
		Part.CanCollide = false
        Part.Color = Color3.new(1,0,0)
	end
end


Move_Tool = Instance.new("Tool",Backpack)
Rotate_Tool = Instance.new("Tool",Backpack)
MHandle = Instance.new("Part",Move_Tool)
RHandle = Instance.new("Part",Rotate_Tool)
Mgrabs = Instance.new("Handles",Gui)
Rgrabs = Instance.new("ArcHandles",Gui)
Outline = Instance.new("Highlight")

Move_Tool.Name = "Move"
Move_Tool.CanBeDropped = false

Rotate_Tool.Name = "Rotate"
Rotate_Tool.CanBeDropped = false

MHandle.Name = "Handle"
MHandle.Transparency = 1

RHandle.Name = "Handle"
RHandle.Transparency = 1

Mgrabs.Visible = false
Mgrabs.Color3 = Color3.fromRGB(248, 236, 0)
Mgrabs.Style = "Movement"

Rgrabs.Visible = false

Outline.FillTransparency = 1
Outline.OutlineTransparency = 0

Active_Part = nil

Move_Tool.Equipped:Connect(function()
	if Active_Part ~= nil then
		Mgrabs.Visible = true
		Mgrabs.Adornee = Active_Part
	end
end)

Move_Tool.Unequipped:Connect(function()
	Mgrabs.Visible = false
	Mgrabs.Adornee = nil
end)

Move_Tool.Activated:Connect(function()
	if Mouse.Target:GetAttribute("Moveable") then
		Active_Part = Mouse.Target
		Mgrabs.Visible = true
		Mgrabs.Adornee = Active_Part
		Outline.Parent = Active_Part
	end
end)

Rotate_Tool.Equipped:Connect(function()
	if Active_Part ~= nil then
		Rgrabs.Visible = true
		Rgrabs.Adornee = Active_Part
	end
end)

Rotate_Tool.Unequipped:Connect(function()
	Rgrabs.Visible = false
	Rgrabs.Adornee = nil
end)

Rotate_Tool.Activated:Connect(function()
	if Mouse.Target:GetAttribute("Moveable") then
		Active_Part = Mouse.Target
		Rgrabs.Visible = true
		Rgrabs.Adornee = Active_Part
		Outline.Parent = Active_Part
	end
end)

MOGCFrame = CFrame.new()

Mgrabs.MouseButton1Down:Connect(function()
	MOGCFrame = Active_Part.CFrame
end)

Mgrabs.MouseDrag:Connect(function(knob, pos)
	if knob == Enum.NormalId.Front then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.LookVector * pos
	end
	if knob == Enum.NormalId.Back then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.LookVector * -pos
	end
	if knob == Enum.NormalId.Top then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.UpVector * pos
	end
	if knob == Enum.NormalId.Bottom then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.UpVector * -pos
	end
	if knob == Enum.NormalId.Left then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.RightVector * -pos
	end
	if knob == Enum.NormalId.Right then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.RightVector * pos
	end
end)

ROGCFrame = CFrame.new()

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "(RS) Btools Loaded",
	Text = "Made by Rouxhaver",
	Icon = "rbxassetid://12997341656"
})

Rgrabs.MouseButton1Down:Connect(function()
	ROGCFrame = Active_Part.CFrame
end)

Rgrabs.MouseDrag:Connect(function(knob, angle)
	if knob == Enum.Axis.Y then
		Active_Part.CFrame = ROGCFrame * CFrame.Angles(0,angle,0)
	end
	if knob == Enum.Axis.X then
		Active_Part.CFrame = ROGCFrame * CFrame.Angles(angle,0,0)
	end
	if knob == Enum.Axis.Z then
		Active_Part.CFrame = ROGCFrame * CFrame.Angles(0,0,angle)
	end
end)

HRP = player.Character.HumanoidRootPart

for i, Part in pairs(Parts_Folder:GetChildren()) do
	local Hat = Part.obj.Value.Handle
	Hat.AccessoryWeld:Destroy()
	local vbreak = false
	coroutine.wrap(function()
		while task.wait() do
			if vbreak == true then break end
			Hat.CFrame = Part.CFrame
		end
	end)()
	Hat:FindFirstChildWhichIsA("SpecialMesh"):Destroy()
end

player.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
	Parts_Folder:Destroy()
end)
