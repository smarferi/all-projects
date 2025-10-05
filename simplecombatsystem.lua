--simpler combat system i just imported from one of my games

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

-- Folder where your RemoteEvents are stored
local RemoteFolder = ReplicatedStorage:WaitForChild("Remotes")

-- RemoteEvent fired from the client when the player clicks to attack
local CombatClicked = RemoteFolder:WaitForChild("CombatClicked")

-- Store each player's combo data here (combo stage, timing, cooldown lock)
local playerCombos = {}

--  Clean up when a player leaves (remove their combo data)
Players.PlayerRemoving:Connect(function(player)
	playerCombos[player] = nil
end)

--  When a player joins the game
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		-- Wait for the character’s Humanoid to load
		local humanoid = char:WaitForChild("Humanoid")

		-- Initialize that player’s combo state
		playerCombos[player] = {
			stage = 1,      -- Which attack in the combo (1 = first punch)
			lastClick = 0,  -- When they last clicked (used for combo timing)
			isLocked = false -- Prevents spamming until animation finishes
		}

		-- Reset combo when the player dies
		humanoid.Died:Connect(function()
			playerCombos[player] = nil
		end)
	end)
end)

--  When the client fires "CombatClicked"
CombatClicked.OnServerEvent:Connect(function(player: Player)
	local char = player.Character
	if not char then return end

	-- Get humanoid and root part (used for animation + hitbox)
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not humanoid or not hrp then return end

	-- Get animator (needed to play animations)
	local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid:WaitForChild("Animator")
	if not animator then return end

	-- Initialize combo state if it doesn't exist yet
	if not playerCombos[player] then
		playerCombos[player] = {
			stage = 1,
			lastClick = 0,
			isLocked = false
		}
	end

	local combo = playerCombos[player]

	-- Reset combo if player waited too long (2 seconds)
	if tick() - combo.lastClick > 2 then
		combo.stage = 1
	end

	-- Prevent spamming — lock until current attack finishes
	if combo.isLocked then return end
	combo.isLocked = true
	combo.lastClick = tick()

	--  Define animation IDs for each combo stage
	local animations = {
		[1] = "rbxassetid://96272196354338",   -- Right punch
		[2] = "rbxassetid://84530904935988",   -- Left punch
		[3] = "rbxassetid://124543245151735"   -- Tornado kick (finisher)
	}

	-- Get the correct animation for this stage
	local animId = animations[combo.stage]

	-- Safety: if invalid, reset combo
	if not animId then
		combo.stage = 1
		combo.isLocked = false
		return
	end

	-- Create and load the animation into the animator
	local anim = Instance.new("Animation")
	anim.AnimationId = animId
	local track = animator:LoadAnimation(anim)
	track:Play() -- Play the attack animation

	--  Create a temporary hitbox part in front of the player
	local HitBoxClone = ReplicatedStorage:WaitForChild("HitBox"):Clone()

	-- Weld it to the player’s root part so it moves with them
	local Weld = Instance.new("Weld")
	Weld.Part0 = hrp
	Weld.Part1 = HitBoxClone
	Weld.C0 = CFrame.new(0, 0, -3) -- Position hitbox 3 studs in front
	Weld.Parent = HitBoxClone

	-- Make hitbox invisible (can set to visible for debugging)
	HitBoxClone.Transparency = 1
	-- Parent hitbox to workspace folder (so we can detect hits)
	HitBoxClone.Parent = workspace:WaitForChild("Hitboxes")

	--  Start detecting hits using OverlapParams (safer than Touched)
	task.spawn(function()
		local params = OverlapParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {char, workspace.Hitboxes}

		local AlreadyBeenHit = {} -- To prevent double-hitting same target

		while HitBoxClone.Parent do
			-- Get everything currently touching the hitbox
			local CollectedParts = workspace:GetPartsInPart(HitBoxClone, params)
			for _, part in CollectedParts do
				local targetChar = part.Parent
				-- Validate: must be another character with a humanoid
				if targetChar and targetChar ~= char and targetChar:FindFirstChild("Humanoid") then
					if AlreadyBeenHit[targetChar] then continue end
					AlreadyBeenHit[targetChar] = true -- mark hit once

					local targetHumanoid = targetChar:FindFirstChild("Humanoid")
					local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")

					if targetHumanoid and targetHRP then
						-- Small delay to sync with animation impact
						task.wait(0.1)

						-- Deal 5 damage
						targetHumanoid:TakeDamage(5)
						
						-- Deal damage but never die instantly
						-- Deal damage but never die instantly
						targetHumanoid.Health = math.max(targetHumanoid.Health - 5, 0)

						-- Disable movement if at 0 HP
						if targetHumanoid.Health == 0 then
							targetHumanoid.WalkSpeed = 0
							targetHumanoid.JumpPower = 0
							targetHumanoid.PlatformStand = true

							-- Optional: re-enable movement after a delay (temporary stun)
							task.delay(3, function()
								if targetHumanoid then
									targetHumanoid.WalkSpeed = 16
									targetHumanoid.JumpPower = 50
									targetHumanoid.PlatformStand = false
								end
							end)
						end



						--  Apply knockback only for Tornado Kick (combo 3)
						if combo.stage == 3 then
							-- Direction from player to target
							local direction = (targetHRP.Position - hrp.Position).Unit
							local knockbackForce = 15
							local upwardBoost = 30

							-- Reset target's velocity before applying knockback
							targetHRP.AssemblyLinearVelocity = Vector3.zero
							targetHRP.AssemblyLinearVelocity = direction * knockbackForce + Vector3.new(0, upwardBoost, 0)

							-- Temporarily disable movement for ragdoll-like effect
							targetHumanoid.PlatformStand = true
							task.delay(0.4, function()
								if targetHumanoid then
									targetHumanoid.PlatformStand = false
								end
							end)
						end
					end
				end
			end
			task.wait() -- Wait 1 frame before checking again
		end
	end)

	-- Automatically delete hitbox after 1 second
	Debris:AddItem(HitBoxClone, 1)

	-- Wait until animation finishes, then unlock attack
	track.Stopped:Wait()
	combo.isLocked = false

	-- Move to next combo stage (1 → 2 → 3 → 1)
	combo.stage += 1
	if combo.stage > 3 then
		combo.stage = 1
	end
end)
