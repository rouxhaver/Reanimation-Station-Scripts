--Made by rouxhaver

--REQUIRED HAIR:
--https://www.roblox.com/catalog/63690008/Pal-Hair
--Wear any 9 other hats/hair

player = game:GetService("Players").LocalPlayer

RA = player.Character["Right Arm"]
Mouse = player:GetMouse()

Torso = player.Character.Torso

RA.Parent = nil
RA.Transparency = 1
RA.Parent = player.Character

NRA = player.Character["Pal Hair"].Handle
NRA.Mesh:Destroy()
NRA.AccessoryWeld:Destroy()

Pointing = false

coroutine.wrap(function()
	while task.wait() do
		if Pointing == true then do
				local LA = CFrame.lookAt(Torso.Position + Torso.CFrame.RightVector * 1.5 + Torso.CFrame.UpVector * 0.5,Mouse.Hit.Position)
				NRA.CFrame = LA + LA.LookVector * 0.5
			end else
			NRA.CFrame = RA.CFrame * CFrame.Angles(math.rad(90),0,0)
		end
	end
end)()


Mouse.Button1Down:Connect(function()
	Pointing = true
end)

Mouse.Button1Up:Connect(function()
	Pointing = false
end)

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "(RS) Laser Arm",
	Text = "Made by Rouxhaver",
	Icon = "rbxassetid://12997341656"
})

function RNG(Min,Max) 
	return math.random(Min*1000000,Max*1000000)/1000000
end

for i,hat in pairs(player.Character:GetChildren()) do
	if hat:IsA("Accessory") and hat ~= NRA.Parent then
		local Handle = hat.Handle
		Handle.AccessoryWeld:Destroy()
		Handle:FindFirstChildWhichIsA("SpecialMesh"):Destroy()
		coroutine.wrap(function()
			while task.wait() do
				if Pointing == true then do
						Handle.CFrame = (NRA.CFrame + NRA.CFrame.LookVector):Lerp(Mouse.Hit, RNG(0.1,1)) * CFrame.Angles(math.rad(RNG(0,360)),math.rad(RNG(0,360)),math.rad(RNG(0,360)))
					end else
					Handle.CFrame = player.Character.Head.CFrame - Vector3.new(0,20,0)
				end
			end
		end)()
	end
end
