--[[
Made by Rouxhaver

Required hats:
https://www.roblox.com/catalog/62234425/Brown-Hair
https://www.roblox.com/catalog/63690008/Pal-Hair
https://www.roblox.com/catalog/48474313/Red-Roblox-Cap

wear some other 7 hats/hairs before running
R6 character Required
]]


player = game:GetService("Players").LocalPlayer
mouse = player:GetMouse()
input = game:GetService("UserInputService")
character = player.Character
torso = character.Torso

ammo = 7
gunequpped = false
debugtransparency = 1

gui = Instance.new("ScreenGui",player.PlayerGui)
gui.IgnoreGuiInset = true

frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(.25,0,.25,0)
frame.AnchorPoint = Vector2.new(1,1)
frame.Position = UDim2.new(1,0,1,0)
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(170, 145, 5)
frame.Visible = false

ammocount = Instance.new("TextLabel",frame)
ammocount.Size = UDim2.new(.85,0,.85,0)
ammocount.AnchorPoint = Vector2.new(.5,.5)
ammocount.Position = UDim2.new(.5,0,.5,0)
ammocount.TextScaled = true
ammocount.BackgroundTransparency = 1
ammocount.TextColor3 = Color3.new(0,0,0)
ammocount.Font = Enum.Font.Ubuntu

Instance.new("UIAspectRatioConstraint",frame)

guntool = Instance.new("Tool",player.Backpack)
guntool.Name = "Gun"

stuff = Instance.new("Folder",workspace)
bullets = Instance.new("Folder",stuff)
mouse.TargetFilter = stuff

fakearm = Instance.new("Part",stuff)
fakearm.Size = Vector3.new(1,2,1)
fakearm.CanCollide = false
fakearm.Transparency = debugtransparency
fakearm.Anchored = true

gunhandle = Instance.new("Part",stuff)
gunhandle.Size = Vector3.new(1,2,1)
gunhandle.CanCollide = false
gunhandle.Transparency = debugtransparency
gunhandle.Anchored = true

gunbarrel = Instance.new("Part",stuff)
gunbarrel.Size = Vector3.new(1,2,1)
gunbarrel.CanCollide = false
gunbarrel.Transparency = debugtransparency
gunbarrel.Anchored = true


ra = character["Right Arm"]
ra.Parent = nil
ra.Parent = character
ra.Transparency = 1

function join(hat,part)
	local handle = hat.Handle
	handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
	handle.AccessoryWeld:Destroy()
	spawn(function()
		while task.wait() do
			handle.CFrame = part.CFrame * CFrame.Angles(math.rad(90),0,0)
		end
	end)
end

join(character.Hat1,fakearm)
join(character["Pal Hair"],gunhandle)
join(character.Robloxclassicred,gunbarrel)

handles = {}
for i,v in pairs(character:GetChildren()) do
	if v:IsA("Accessory") and v.Name ~= "Hat1" and v.Name ~= "Pal Hair" and v.Name ~= "Robloxclassicred" then
		handles[#handles+1] = v.Handle
		v.Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
		v.Handle.AccessoryWeld:Destroy()
		local obj = Instance.new("ObjectValue",v.Handle)
		obj.Name = "bullet"
	end
end

function changeammo(number)
	ammo = number
	ammocount.Text = tostring(ammo).."/7"
end

changeammo(7)

filter = OverlapParams.new()
filter.FilterType = Enum.RaycastFilterType.Blacklist 
filter.FilterDescendantsInstances = {character,bullets}

mouse.Button1Down:Connect(function()
	if ammo > 0 and gunequpped == true and vbreak ~= true then
		changeammo(ammo-1)
		local bullet = Instance.new("Part",bullets)
		bullet.Size = Vector3.new(1,1,1)
		bullet.CFrame = gunbarrel.CFrame
		bullet.CanCollide = false
		bullet.Transparency = debugtransparency
		local bodyForce = Instance.new('BodyForce',bullet)
		bodyForce.Force = Vector3.new(0,bullet:GetMass()*workspace.Gravity,0)
		local obj = Instance.new("ObjectValue",bullet)
		obj.Name = "handle"
		local forwardforce = Instance.new("VectorForce",bullet)
		forwardforce.Force = Vector3.new(0,-500,0)
		forwardforce.Attachment0 = Instance.new("Attachment",bullet)
		wait(0.1)
		forwardforce:Destroy()
		while bullet.Parent ~= nil do
			task.wait()
			local touchedpart = workspace:GetPartsInPart(bullet,filter)[1]
			if touchedpart ~= nil then
				local weld = Instance.new("WeldConstraint",bullet)
				weld.Part0 = touchedpart
				weld.Part1 = bullet
				break
			end
		end
	end
end)

handleframe = CFrame.new()
barrelframe = CFrame.new()

guntool.Changed:Connect(function()
	if guntool.Parent ~= player.Backpack then do
			gunequpped = true
			frame.Visible = true
			handleframe = CFrame.new(0,0,1.5) * CFrame.Angles(math.rad(90),0,0)
			barrelframe = CFrame.new(0,2.5,.5)
		end else
		gunequpped = false
		frame.Visible = false
		handleframe = CFrame.new()
		barrelframe = CFrame.new()
	end
end)

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "(RS) Glue Gun",
	Text = "Made by Rouxhaver",
	Icon = "rbxassetid://12997341656"
})

input.InputBegan:Connect(function(key)
	if key.KeyCode == Enum.KeyCode.R and gunequpped == true and vbreak ~= true then
		changeammo(7)
		for i,v in pairs(bullets:GetChildren()) do
			v:Destroy()
		end
	end
end)


while task.wait() do
	if vbreak == true then break end
	if gunequpped == true then do
			la = CFrame.lookAt(torso.Position + torso.CFrame.RightVector*1.5 + torso.CFrame.UpVector*.5, mouse.Hit.Position) * CFrame.Angles(math.rad(90),0,0)
			fakearm.CFrame = la + la.UpVector * -.5
			gunbarrel.CFrame = la + la.UpVector * -2.5 + la.LookVector *.5
			gunhandle.CFrame = la * CFrame.Angles(math.rad(-90),0,0) + la.UpVector * -1.5
		end else
		fakearm.CFrame = ra.CFrame
		gunbarrel.CFrame = ra.CFrame
		gunhandle.CFrame = ra.CFrame
	end

	for i,handle in pairs(handles) do
		if handle.Parent == nil then
			guntool:Destroy()
			stuff:Destroy()
			vbreak = true
			character.Humanoid.Health = 0
			gunequpped = false
			break
		end
		if handle.bullet.Value == nil or handle.bullet.Value.Parent == nil then do
				for i,bullet in pairs(bullets:GetChildren()) do
					if bullet.handle.Value == nil then
						handle.bullet.Value = bullet
						bullet.handle.Value = handle
						break
					end
				end
				handle.Position = gunbarrel.Position
				handle.Orientation = gunbarrel.Orientation
			end else
			handle.Position = handle.bullet.Value.Position
			handle.Orientation = handle.bullet.Value.Orientation
		end
	end
end
