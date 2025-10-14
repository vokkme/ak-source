-- Roblox Teleport + Notification Script (MIC UP Game Only)
-- Only works in MIC UP game (PlaceId: 6884319169)
-- Teleports to coordinates (628, 8152, 3489) and shows "Pshht 🤫" notification

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- MIC UP Game PlaceId
local TARGET_PLACE_ID = 6884319169
local CURRENT_PLACE_ID = game.PlaceId

-- Function to show notification (works for both success and error)
local function showNotification(message, isError)
    -- Create the main ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- Create the notification frame
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "NotificationFrame"
    notificationFrame.Size = UDim2.new(0, 300, 0, 80)
    notificationFrame.Position = UDim2.new(0.5, -150, 0.5, -40) -- Center of screen
    notificationFrame.BackgroundColor3 = isError and Color3.fromRGB(139, 0, 0) or Color3.fromRGB(0, 0, 0) -- Red for error, black for success
    notificationFrame.BackgroundTransparency = 1 -- Start invisible
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui

    -- Add rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = notificationFrame

    -- Create the text label
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "NotificationText"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextTransparency = 1 -- Start invisible
    textLabel.Parent = notificationFrame

    -- Add text size constraint
    local textSizeConstraint = Instance.new("UITextSizeConstraint")
    textSizeConstraint.MaxTextSize = 20
    textSizeConstraint.MinTextSize = 12
    textSizeConstraint.Parent = textLabel

    -- Fade-in animation
    local fadeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local targetTransparency = isError and 0.2 or 0.3
    local fadeInTween = TweenService:Create(notificationFrame, fadeInfo, {BackgroundTransparency = targetTransparency})
    local textFadeInTween = TweenService:Create(textLabel, fadeInfo, {TextTransparency = 0})

    -- Play fade-in
    fadeInTween:Play()
    textFadeInTween:Play()

    -- Auto-remove after 3 seconds (longer for error message)
    local displayTime = isError and 4 or 2
    wait(displayTime)
    
    local fadeOutTween = TweenService:Create(notificationFrame, fadeInfo, {BackgroundTransparency = 1})
    local textFadeOutTween = TweenService:Create(textLabel, fadeInfo, {TextTransparency = 1})

    fadeOutTween:Play()
    textFadeOutTween:Play()

    fadeOutTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

-- Function to teleport the player
local function teleportPlayer()
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart
        local targetPosition = Vector3.new(628, 8152, 3489)
        
        -- Teleport the character
        humanoidRootPart.CFrame = CFrame.new(targetPosition)
        print("Teleported to coordinates: " .. tostring(targetPosition))
        return true
    else
        warn("Player character or HumanoidRootPart not found!")
        return false
    end
end

-- Main execution
if CURRENT_PLACE_ID == TARGET_PLACE_ID then
    -- We're in MIC UP game, proceed with teleport
    if teleportPlayer() then
        spawn(function()
            showNotification("Pshht 🤫", false)
        end)
    else
        spawn(function()
            showNotification("Character not found!", true)
        end)
    end
else
    -- Wrong game, show error message
    spawn(function()
        showNotification("This script only works in MIC UP game!", true)
    end)
    print("Current PlaceId: " .. CURRENT_PLACE_ID .. " | Required PlaceId: " .. TARGET_PLACE_ID)
end
