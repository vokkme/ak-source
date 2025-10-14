
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer


local nameTagsEnabled = true 
local isBlinking = false


local function createDisappearEffect(position)
    local part = Instance.new("Part")
    part.Name = "ParticleEffectPart"
    part.Size = Vector3.new(0.1, 0.1, 0.1)
    part.Position = position
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Parent = workspace
    
    
    local particles = Instance.new("ParticleEmitter")
    particles.Parent = part
    
    
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Rate = 0 
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Speed = NumberRange.new(2, 5)
    particles.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 200))
    }
    particles.Size = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0.2),
        NumberSequenceKeypoint.new(1, 0)
    }
    particles.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.8, 0.5),
        NumberSequenceKeypoint.new(1, 1)
    }
    
    
    particles:Emit(50)
    
    
    task.spawn(function()
        task.wait(2)
        part:Destroy()
    end)
end


local function getNameTagPosition(nameTag)
    if nameTag.Adornee and nameTag.Adornee.Parent then
        
        if nameTag.Adornee:IsA("BasePart") then
            return nameTag.Adornee.Position + Vector3.new(0, 2, 0)
        elseif nameTag.Adornee:IsA("Model") and nameTag.Adornee.PrimaryPart then
            return nameTag.Adornee.PrimaryPart.Position + Vector3.new(0, 2, 0)
        end
    end
    
    
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    if nameTag.Parent == playerGui then
        
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                return plr.Character.Head.Position + Vector3.new(0, 2, 0)
            end
        end
    end
    
    
    return Vector3.new(0, 10, 0)
end


local function disableNameTags()
    nameTagsEnabled = false
    
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("BillboardGui") and gui.Name == "RankTag" and gui.Enabled then
            
            local position = getNameTagPosition(gui)
            task.spawn(function()
                createDisappearEffect(position)
            end)
            gui.Enabled = false
        end
    end
    
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("BillboardGui") and child.Name == "RankTag" and child.Enabled then
                    
                    local position = head.Position + Vector3.new(0, 2, 0)
                    task.spawn(function()
                        createDisappearEffect(position)
                    end)
                    child.Enabled = false
                end
            end
        end
    end
    
    return false
end


local function enableNameTags()
    nameTagsEnabled = true
    
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("BillboardGui") and gui.Name == "RankTag" then
            gui.Enabled = true
        end
    end
    
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("BillboardGui") and child.Name == "RankTag" then
                    child.Enabled = true
                end
            end
        end
    end
    
    return true
end


local function onNameTagAdded(nameTag)
    if not nameTagsEnabled then
        nameTag.Enabled = false
    end
end


local function setupNameTagMonitoring()
    
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    playerGui.ChildAdded:Connect(function(child)
        if child:IsA("BillboardGui") and child.Name == "RankTag" then
            onNameTagAdded(child)
        end
    end)
    
    
    local function onPlayerAdded(plr)
        plr.CharacterAdded:Connect(function(character)
            local head = character:WaitForChild("Head", 5)
            if head then
                head.ChildAdded:Connect(function(child)
                    if child:IsA("BillboardGui") and child.Name == "RankTag" then
                        onNameTagAdded(child)
                    end
                end)
            end
        end)
        
        
        if plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head then
                head.ChildAdded:Connect(function(child)
                    if child:IsA("BillboardGui") and child.Name == "RankTag" then
                        onNameTagAdded(child)
                    end
                end)
            end
        end
    end
    
    
    Players.PlayerAdded:Connect(onPlayerAdded)
    for _, plr in ipairs(Players:GetPlayers()) do
        onPlayerAdded(plr)
    end
end


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NametagToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui


local mainButton = Instance.new("ImageButton")
mainButton.Size = UDim2.new(0, 45, 0, 45)
mainButton.Position = UDim2.new(1, -245, 0, -54)
mainButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainButton.BackgroundTransparency = 0.5
mainButton.BorderSizePixel = 0
mainButton.Image = "rbxassetid://129832748765176"
mainButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainButton


local function startBlinking()
    if isBlinking then return end
    isBlinking = true
    
    task.spawn(function()
        local blinkCount = 0
        while isBlinking and blinkCount < 4 do 
            local targetColor = nameTagsEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            
            
            local fadeIn = TweenService:Create(mainButton, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
                BackgroundColor3 = targetColor,
                BackgroundTransparency = 0.2
            })
            fadeIn:Play()
            fadeIn.Completed:Wait()
            
            
            local fadeOut = TweenService:Create(mainButton, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
                BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                BackgroundTransparency = 0.5
            })
            fadeOut:Play()
            fadeOut.Completed:Wait()
            
            blinkCount = blinkCount + 1
        end
        
        isBlinking = false
    end)
end


local function toggleNameTags()
    if nameTagsEnabled then
        disableNameTags()
    else
        enableNameTags()
    end
    
    startBlinking()
end

mainButton.MouseButton1Click:Connect(toggleNameTags)
setupNameTagMonitoring()