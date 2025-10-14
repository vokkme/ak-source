local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer


local TEST_MODE = false


local function getHwid()
    local success, hwid = pcall(function()
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    return success and hwid or "Unknown"
end


local BlacklistedHWIDs = {
    "29101BB2-8621-49A8-AFB1-23D9DC10CC25",
    "E89361BE-0E78-4ABE-AC02-1516270C2613",
    "E271C7A9-D8B4-4EE0-83A9-6726A2CF42E6",
    "7F8F195F-0E9F-467F-AA2B-BA8F8E573CEA",
    "A811A8A8-9236-441D-8B50-E219CE54AD67",
    "253E51C9-7B38-4EF5-AF82-E35379BD92F2"
}

local function isBlacklisted(hwid)
    for _, blacklistedHwid in ipairs(BlacklistedHWIDs) do
        if hwid == blacklistedHwid then
            return true
        end
    end
    return false
end


local function showBlacklistScreen()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BlacklistScreen"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999999
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    background.BorderSizePixel = 0
    background.Parent = screenGui
    
    local bgGradient = Instance.new("UIGradient")
    bgGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 10, 12)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 5, 8))
    }
    bgGradient.Rotation = 45
    bgGradient.Parent = background
    
    
    local vignette = Instance.new("ImageLabel")
    vignette.Size = UDim2.new(1, 0, 1, 0)
    vignette.BackgroundTransparency = 1
    vignette.Image = "rbxasset://textures/ui/VignetteOverlay.png"
    vignette.ImageColor3 = Color3.fromRGB(0, 0, 0)
    vignette.ImageTransparency = 0.3
    vignette.Parent = background
    
    
    for i = 1, 20 do
        local drip = Instance.new("Frame")
        drip.Size = UDim2.new(0.002, 0, 0, 0)
        drip.Position = UDim2.new(math.random(0, 100) / 100, 0, 0, 0)
        drip.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
        drip.BorderSizePixel = 0
        drip.BackgroundTransparency = 0.3
        drip.ZIndex = 2
        drip.Parent = background
        
        local gradient = Instance.new("UIGradient")
        gradient.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0.9),
            NumberSequenceKeypoint.new(0.5, 0.3),
            NumberSequenceKeypoint.new(1, 1)
        }
        gradient.Rotation = 90
        gradient.Parent = drip
        
        task.spawn(function()
            task.wait(math.random(0, 30) / 10)
            while true do
                drip.Size = UDim2.new(0.002, 0, 0, 0)
                local length = math.random(20, 80) / 100
                local duration = math.random(30, 80) / 10
                
                local tween = TweenService:Create(drip, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    Size = UDim2.new(0.002, 0, length, 0)
                })
                tween:Play()
                
                task.wait(duration + math.random(20, 60) / 10)
            end
        end)
    end
    
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 480, 0, 320)
    container.Position = UDim2.new(0.5, 0, 0.5, 0)
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    container.BackgroundTransparency = 0.1
    container.BorderSizePixel = 0
    container.ZIndex = 3
    container.Parent = background
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 16)
    containerCorner.Parent = container
    
    
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1, 40, 1, 40)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/VignetteOverlay.png"
    glow.ImageColor3 = Color3.fromRGB(180, 0, 0)
    glow.ImageTransparency = 0.6
    glow.ZIndex = 2
    glow.Parent = container
    
    task.spawn(function()
        while true do
            TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageTransparency = 0.8
            }):Play()
            task.wait(1.5)
            TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageTransparency = 0.6
            }):Play()
            task.wait(1.5)
        end
    end)
    
    
    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(1, 0, 0, 2)
    accentLine.Position = UDim2.new(0, 0, 0, 0)
    accentLine.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    accentLine.BorderSizePixel = 0
    accentLine.ZIndex = 4
    accentLine.Parent = container
    
    local lineGradient = Instance.new("UIGradient")
    lineGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    lineGradient.Parent = accentLine
    
    
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, -40, 0, 50)
    header.Position = UDim2.new(0, 20, 0, 30)
    header.BackgroundTransparency = 1
    header.Text = "ACCESS DENIED"
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.TextSize = 28
    header.Font = Enum.Font.GothamBold
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.ZIndex = 4
    header.Parent = container
    
    
    local message = Instance.new("TextLabel")
    message.Size = UDim2.new(1, -40, 0, 80)
    message.Position = UDim2.new(0, 20, 0, 90)
    message.BackgroundTransparency = 1
    message.Text = "Your hardware identifier has been blacklisted from accessing this system."
    message.TextColor3 = Color3.fromRGB(200, 200, 200)
    message.TextSize = 16
    message.Font = Enum.Font.Gotham
    message.TextXAlignment = Enum.TextXAlignment.Left
    message.TextYAlignment = Enum.TextYAlignment.Top
    message.TextWrapped = true
    message.ZIndex = 4
    message.Parent = container
    
    
    local statusContainer = Instance.new("Frame")
    statusContainer.Size = UDim2.new(1, -40, 0, 50)
    statusContainer.Position = UDim2.new(0, 20, 0, 190)
    statusContainer.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
    statusContainer.BackgroundTransparency = 0.3
    statusContainer.BorderSizePixel = 0
    statusContainer.ZIndex = 4
    statusContainer.Parent = container
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 8)
    statusCorner.Parent = statusContainer
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 1, 0)
    statusLabel.Position = UDim2.new(0, 10, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = TEST_MODE and "STATUS: BLACKLISTED [TEST MODE]" or "STATUS: BLACKLISTED"
    statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.ZIndex = 5
    statusLabel.Parent = statusContainer
    
    
    local countdown = Instance.new("TextLabel")
    countdown.Size = UDim2.new(1, -40, 0, 30)
    countdown.Position = UDim2.new(0, 20, 1, -50)
    countdown.BackgroundTransparency = 1
    countdown.Text = TEST_MODE and "Testing screen display (no disconnect)" or "Disconnecting in 10 seconds..."
    countdown.TextColor3 = Color3.fromRGB(150, 150, 150)
    countdown.TextSize = 13
    countdown.Font = Enum.Font.Gotham
    countdown.TextXAlignment = Enum.TextXAlignment.Center
    countdown.ZIndex = 4
    countdown.Parent = container
    
    
    task.spawn(function()
        for i = 10, 1, -1 do
            if TEST_MODE then
                countdown.Text = "Test countdown: " .. i .. " second" .. (i > 1 and "s" or "") .. "..."
            else
                countdown.Text = "Disconnecting in " .. i .. " second" .. (i > 1 and "s" or "") .. "..."
            end
            if i <= 3 then
                countdown.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
            task.wait(1)
        end
        if TEST_MODE then
            countdown.Text = "Test complete - Screen will remain visible"
            countdown.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            countdown.Text = "Connection terminated."
            countdown.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
    end)
    
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
    sound.Volume = 0.3
    sound.PlaybackSpeed = 0.7
    sound.Parent = screenGui
    sound:Play()
    
    
    if not TEST_MODE then
        task.wait(10)
        
        while true do
            Instance.new("Part", workspace)
        end
    else
        print("🧪 TEST MODE: Crash disabled")
    end
end


local function main()
    if TEST_MODE then
        print("🧪 Running in TEST MODE")
        showBlacklistScreen()
    else
        local hwid = getHwid()
        
        if isBlacklisted(hwid) then
            showBlacklistScreen()
        else
            print("✅ HWID Check Passed - Not Blacklisted")
        end
    end
end


main()
