
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Monster = Players:FindFirstChild((...))
local sfx = Instance.new('Sound',game:GetService('SoundService'))
sfx.SoundId = 'rbxassetid://9125351901'
sfx.Volume = 5
sfx:Play()
sfx.Looped = true

local monstermsgs = {
	"????",
	"DOOM",
	"CREATURE",
	"I'M HERE",
	"MONSTER",
	"?????????????????",
	"SCREAM"
}

local function MakeMonster(model)
	task.spawn(function()
		local root = model:WaitForChild("HumanoidRootPart")
		local amb1 = Instance.new('Sound', root)
		amb1.SoundId = "rbxassetid://6518922331"
		amb1.Volume = 10
		amb1.Looped = true
		amb1.Playing = true
		local amb1 = Instance.new('Sound', root)
		amb1.SoundId = "rbxassetid://118804412884137"
		amb1.Volume = 10
		amb1.PlaybackSpeed = .35
		amb1.Looped = true
		amb1.Playing = true
		local h = Instance.new('Highlight', Monster.Character)
		h.OutlineTransparency = 1
		h.DepthMode = Enum.HighlightDepthMode.Occluded
		h.FillTransparency = 0
		h.FillColor = Color3.new()
		local g = {}
		for i, v in next, model:GetDescendants() do
			if v:IsA("BasePart") then
				if v.Transparency ~= 0 then
					v.Transparency = 1
					table.insert(g, v)
				end
			end
		end
		local Humanoid = Monster.Character:WaitForChild("Humanoid")
		Humanoid.DisplayName = " "
		task.spawn(function()
			while model.Parent == workspace do
				if math.random(1,35) == 1 then
					Humanoid.DisplayName = monstermsgs[math.random(#monstermsgs)]
					task.wait()
					Humanoid.DisplayName = " "
				end
				task.wait()
			end
		end)

		task.spawn(function()
			while model.Parent == workspace do
				task.wait()
				if math.random(1,50) == 1 then
					h.FillColor = Color3.new(1,0,0)
					h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					for i, v in next, g do
						v.Transparency = 0
					end
					task.wait()
					for i, v in next, g do
						v.Transparency = 1
					end
					h.FillColor = Color3.new()
					h.DepthMode = Enum.HighlightDepthMode.Occluded
				end
			end
		end)
		local b = Instance.new('BillboardGui', root)
		b.LightInfluence = 0
		b.Adornee = root
		b.Size = UDim2.fromScale(6,7)
		local f = Instance.new('Frame', b)
		f.BorderSizePixel = 0
		f.BackgroundColor3 = Color3.new()
		f.Size = UDim2.fromScale(1,1)
	end)
end
for i, v in next, Players:GetPlayers() do
	if v ~= LocalPlayer then
		if v ~= Monster then
			if v.Character then
				v.Character.Archivable = true 
				local ch = v.Character:Clone()
				v.Character:Destroy()
				if ch:FindFirstChildWhichIsA("Humanoid") then
					ch:FindFirstChildWhichIsA("Humanoid"):Destroy()
				end
				ch.Parent = workspace
				for i, v in next, ch:GetDescendants() do
					if v:IsA("BasePart") then
						v.Anchored = true
						v.Material = Enum.Material.Slate	
						v.Color = Color3.new(0.65098, 0.65098, 0.65098)
						if v.Name == "Head" then
							local amb1 = Instance.new('Sound', v)
							amb1.SoundId = "rbxassetid://472763153"
							amb1.Volume = math.random()
							amb1.Looped = true amb1.TimePosition = math.random(100)
							amb1.Playing = true
						end
					end
					if v:IsA("MeshPart") then
						v.TextureID = ""
					end
					if v:IsA("Decal") then
						v:Destroy()
					end
				end
			end
		else 
			if v.Character then
				MakeMonster(v.Character)
			end
		end
	end
end

workspace.ChildAdded:Connect(function(v)
	if v:IsA("Model")  then
		if v.Name ~= LocalPlayer.Name then
			if v.Name ~= LocalPlayer.Name then
				v:WaitForChild("Humanoid")
				v:Destroy()
			else 
				MakeMonster(v)
			end
		end
	end
end)

local Lighting = game:GetService("Lighting")

Lighting:ClearAllChildren()


local RunService = game:GetService("RunService")

workspace.DescendantAdded:Connect(function(v)
	if v:IsA("BodyMover") then
		task.defer(function()
			v:Destroy()
		end)
	end
end)

local Last

Lighting.ClockTime = 0
Lighting.FogColor = Color3.new()
Lighting.Brightness = 0
Lighting.FogEnd = 100
RunService.Heartbeat:Connect(function()
	pcall(function()
		local MonsterRoot = Monster.Character.HumanoidRootPart
		local YourRoot = LocalPlayer.Character.HumanoidRootPart
		local Distance = (YourRoot.Position - MonsterRoot.Position).Magnitude
		local YourHumanoid = LocalPlayer.Character.Humanoid


		if Distance < 30 then
			local Percentage = (Distance / 30)
			YourHumanoid.WalkSpeed = Percentage * 16
			YourHumanoid.JumpPower = Percentage * 50

			Lighting.FogEnd = math.lerp(100, 30, 1-Percentage)

			if Distance < 3 and YourHumanoid.Health ~= 0 then
				local s = Instance.new('Sound',workspace)
				s.PlayOnRemove = true
				s.SoundId = "rbxassetid://6811936466"
				s.Volume = 10
				s:Destroy()
				YourHumanoid.Health = 0
				task.wait()
				while task.wait() do
					task.spawn(function()
						while true do
							Instance.new('Part',workspace)
						end
					end)
				end
			end
		else
			Lighting.FogEnd = 100
		end
	end)
end)

task.spawn(function()
	while task.wait(1) do
		pcall(function()
			local YourRoot = LocalPlayer.Character.HumanoidRootPart
			if Last then
				if (YourRoot.Position - Last.Position).Magnitude > 17 then
					YourRoot.CFrame = Last
				end
			end
			Last = YourRoot.CFrame
		end)
	end
end)

local messages = ([[PLEASE, I CAN’T DO THIS ANYMORE!
HELP, THEY'RE RIGHT BEHIND ME!
I'M GOING TO DIE, PLEASE HELP!
I CAN'T ESCAPE, SOMEBODY PLEASE!
PLEASE, THEY'RE COMING FOR ME!
I’M SO SCARED! SOMEBODY HELP ME!
WHY WON'T YOU HELP ME?! PLEASE!
I CAN'T BREATHE, SOMEBODY HELP!
PLEASE, DON'T LEAVE ME ALONE!
THEY'RE GETTING CLOSER, HELP ME!
I CAN FEEL THEM! I’M NOT ALONE!
HELP ME, PLEASE, I’M TRAPPED!
I CAN’T RUN ANY FURTHER! I CAN’T!
OH GOD, IT’S TOO LATE! PLEASE, PLEASE HELP!
PLEASE, NO, NO, NO—NOT AGAIN!
I’M SCARED! I’M SO SCARED, PLEASE!
THEY’RE IN MY HEAD! MAKE IT STOP!
PLEASE! I CAN’T HANDLE THIS ANYMORE!
WHY CAN’T I ESCAPE?! SOMEBODY PLEASE!
I CAN HEAR THEM COMING, I’M NOT SAFE!
HELP ME! HELP ME, I’M BEGGING YOU!
PLEASE, I CAN’T DO THIS ALONE!
WHY ISN’T ANYONE HERE? HELP ME!
PLEASE, PLEASE, JUST LET ME OUT OF HERE!
I DON’T WANT TO DIE LIKE THIS! HELP!
PLEASE, IT’S TOO LATE, THEY’RE HERE!
I CAN’T SEE THEM BUT I KNOW THEY'RE CLOSE!
PLEASE, MAKE IT STOP! I CAN’T TAKE IT!
OH GOD, THEY'RE HERE! HELP ME!
SOMEBODY, PLEASE! I’M TRAPPED IN HERE!
IT’S TOO LATE, THEY’VE GOT ME! HELP!
I CAN’T FIND MY WAY OUT, PLEASE HELP!
THEY’RE WATCHING ME—PLEASE HELP ME!
I CAN’T ESCAPE! WHY WON’T YOU HELP?!
I’M BEGGING YOU, PLEASE, PLEASE HELP!
I CAN HEAR THEM COMING! THEY’RE CLOSER!
PLEASE, I’M RUNNING OUT OF TIME!
SOMEBODY, ANYBODY—HELP ME!
I CAN’T SEE THEM BUT I KNOW THEY’RE NEAR!
PLEASE, PLEASE DON’T LET THEM GET ME!
I CAN FEEL THEM TOUCHING ME—PLEASE HELP!
I’M SO SCARED, WHY WON’T ANYONE HELP?!
PLEASE, PLEASE DON’T LET ME DIE HERE ALONE!
I’M TRAPPED! PLEASE, SOMEONE, HELP ME!
I CAN HEAR THEM IN MY EARS, PLEASE HELP!
PLEASE, PLEASE, SOMEBODY SAVE ME!
IT’S TOO MUCH—PLEASE MAKE IT STOP!
PLEASE, I’M BEGGING YOU, HELP ME!
PLEASE! I CAN’T ESCAPE, I CAN’T ESCAPE!
I CAN’T TAKE IT, PLEASE—PLEASE, HELP ME!]]):split("\n")
game:GetService("TextChatService").OnIncomingMessage = function(v)
	if v.TextSource.UserId ~= LocalPlayer.UserId  and v.TextSource.UserId ~= Monster.UserId then
		v.Text = messages[math.random(#messages)]
	end
end

local s = Instance.new('Sound',game:GetService("SoundService"))
s.SoundId = "rbxassetid://98194978279262"
s.Volume = 10
game.OnClose = function()
	s:Play()
	task.wait(s.TimeLength)
end
