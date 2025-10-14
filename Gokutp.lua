-- Client-Side Click Teleport Tool
-- Place this script in StarterPlayerScripts or run as a LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local backpack = localPlayer:WaitForChild("Backpack")

-- Create the tool
local tool = Instance.new("Tool")
tool.Name = "Goku TP"
tool.RequiresHandle = false
tool.Parent = backpack

-- Get mouse when tool is equipped
local mouse = localPlayer:GetMouse()

-- Configuration
local CONFIG = {
    TELEPORT_HEIGHT = 3    -- Height offset above clicked position
}

-- Teleport function with same effects as original
local function teleportToPosition(targetPosition)
    local character = localPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not (humanoid and hrp) then return end
    
    -- Calculate teleport position
    local teleportPosition = targetPosition + Vector3.new(0, CONFIG.TELEPORT_HEIGHT, 0)
    
    -- Create particle effect at current position
    local particlepart = Instance.new("Part", workspace)
    particlepart.Transparency = 1
    particlepart.Anchored = true
    particlepart.CanCollide = false
    particlepart.Position = hrp.Position
    
    local transmitter1 = Instance.new("ParticleEmitter")
    transmitter1.Texture = "http://www.roblox.com/asset/?id=89296104222585"
    transmitter1.Size = NumberSequence.new(4)
    transmitter1.Lifetime = NumberRange.new(0.15, 0.15)
    transmitter1.Rate = 100
    transmitter1.TimeScale = 0.25
    transmitter1.VelocityInheritance = 1
    transmitter1.Drag = 5
    transmitter1.Parent = particlepart
    
    -- Create particle effect at destination
    local particlepart2 = Instance.new("Part", workspace)
    particlepart2.Transparency = 1
    particlepart2.Anchored = true
    particlepart2.CanCollide = false
    particlepart2.Position = teleportPosition
    
    local transmitter2 = Instance.new("ParticleEmitter")
    transmitter2.Texture = "http://www.roblox.com/asset/?id=89296104222585"
    transmitter2.Size = NumberSequence.new(4)
    transmitter2.Lifetime = NumberRange.new(0.15, 0.15)
    transmitter2.Rate = 100
    transmitter2.TimeScale = 0.25
    transmitter2.VelocityInheritance = 1
    transmitter2.Drag = 5
    transmitter2.Parent = particlepart2
    
    -- Fade out character parts
    local fadeTime = 0.1
    local tweenInfo = TweenInfo.new(fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local meshParts = {}
    
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("MeshPart") or part:IsA("Part") then
            table.insert(meshParts, part)
        end
    end
    
    for _, part in ipairs(meshParts) do
        if part.Name == "HumanoidRootPart" then continue end
        local tween = TweenService:Create(part, tweenInfo, {Transparency = 1})
        tween:Play()
    end
    
    -- Wait for fade out
    task.wait(fadeTime)
    
    -- Teleport character
    hrp.CFrame = CFrame.new(teleportPosition)
    
    -- Play teleport sound
    local teleportSound = Instance.new("Sound")
    teleportSound.SoundId = "rbxassetid://5066021887"
    teleportSound.Parent = hrp
    teleportSound.Volume = 0.5
    teleportSound:Play()
    
    -- Fade in character parts
    for _, part in ipairs(meshParts) do
        if part.Name == "HumanoidRootPart" then continue end
        local tween = TweenService:Create(part, tweenInfo, {Transparency = 0})
        tween:Play()
    end
    
    -- Clean up
    game.Debris:AddItem(teleportSound, 2)
    game.Debris:AddItem(particlepart, 1)
    game.Debris:AddItem(particlepart2, 1)
end

-- Tool activation (click to teleport)
tool.Activated:Connect(function()
    local hit = mouse.Hit
    if hit then
        teleportToPosition(hit.Position)
    end
end)

-- Tool equipped message
tool.Equipped:Connect(function()
    -- Create instruction GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "TeleportGui"
    gui.Parent = playerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 40)
    frame.Position = UDim2.new(0.5, -100, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "Click to Teleport"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSans
    label.Parent = frame
    
    -- Auto-hide after 3 seconds
    task.spawn(function()
        task.wait(3)
        if gui and gui.Parent then
            gui:Destroy()
        end
    end)
end)

-- Clean up GUI when tool is unequipped
tool.Unequipped:Connect(function()
    local gui = playerGui:FindFirstChild("TeleportGui")
    if gui then
        gui:Destroy()
    end
end)
