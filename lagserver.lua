local localPlayer = game.Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Fire tool event immediately (non-blocking)
spawn(function()
    local args = {
        "DangerKnife"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Tool"):FireServer(unpack(args))
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ToolManagerGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 140)
mainFrame.Position = UDim2.new(0.8, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.BackgroundTransparency = 0.5

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0, 100, 0, 30)
titleText.Position = UDim2.new(0, 10, 0, 5)
titleText.BackgroundTransparency = 1
titleText.Text = "Lag Server"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = mainFrame

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 24, 0, 24)
minimizeButton.Position = UDim2.new(1, -52, 0, 8)
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 14
minimizeButton.Parent = mainFrame

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.Position = UDim2.new(1, -26, 0, 8)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -40)
contentFrame.Position = UDim2.new(0, 10, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 180, 0, 30)
toggleButton.Position = UDim2.new(0.5, -90, 0, 5)
toggleButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamSemibold
toggleButton.TextSize = 14
toggleButton.Parent = contentFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = toggleButton

-- Lag Spike Frame (above Anti Lag)
local lagSpikeFrame = Instance.new("Frame")
lagSpikeFrame.Name = "LagSpikeFrame"
lagSpikeFrame.Size = UDim2.new(1, 0, 0, 25)
lagSpikeFrame.Position = UDim2.new(0, 0, 0, 45)
lagSpikeFrame.BackgroundTransparency = 1
lagSpikeFrame.Parent = contentFrame

local lagSpikeCheckbox = Instance.new("Frame")
lagSpikeCheckbox.Name = "LagSpikeCheckbox"
lagSpikeCheckbox.Size = UDim2.new(0, 20, 0, 20)
lagSpikeCheckbox.Position = UDim2.new(0, 0, 0.5, -10)
lagSpikeCheckbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
lagSpikeCheckbox.BorderSizePixel = 0
lagSpikeCheckbox.Parent = lagSpikeFrame

local lagSpikeCheckboxCorner = Instance.new("UICorner")
lagSpikeCheckboxCorner.CornerRadius = UDim.new(0, 4)
lagSpikeCheckboxCorner.Parent = lagSpikeCheckbox

local lagSpikeIndicator = Instance.new("Frame")
lagSpikeIndicator.Name = "LagSpikeIndicator"
lagSpikeIndicator.Size = UDim2.new(0.7, 0, 0.7, 0)
lagSpikeIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
lagSpikeIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
lagSpikeIndicator.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
lagSpikeIndicator.BorderSizePixel = 0
lagSpikeIndicator.Visible = false
lagSpikeIndicator.Parent = lagSpikeCheckbox

local lagSpikeIndicatorCorner = Instance.new("UICorner")
lagSpikeIndicatorCorner.CornerRadius = UDim.new(0, 2)
lagSpikeIndicatorCorner.Parent = lagSpikeIndicator

local lagSpikeLabel = Instance.new("TextLabel")
lagSpikeLabel.Name = "LagSpikeLabel"
lagSpikeLabel.Size = UDim2.new(1, -30, 1, 0)
lagSpikeLabel.Position = UDim2.new(0, 30, 0, 0)
lagSpikeLabel.BackgroundTransparency = 1
lagSpikeLabel.Text = "Lag Spike"
lagSpikeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
lagSpikeLabel.Font = Enum.Font.Gotham
lagSpikeLabel.TextSize = 12
lagSpikeLabel.TextXAlignment = Enum.TextXAlignment.Left
lagSpikeLabel.Parent = lagSpikeFrame

local auraFrame = Instance.new("Frame")
auraFrame.Name = "AuraFrame"
auraFrame.Size = UDim2.new(1, 0, 0, 25)
auraFrame.Position = UDim2.new(0, 0, 0, 75)
auraFrame.BackgroundTransparency = 1
auraFrame.Parent = contentFrame

local auraCheckbox = Instance.new("Frame")
auraCheckbox.Name = "AuraCheckbox"
auraCheckbox.Size = UDim2.new(0, 20, 0, 20)
auraCheckbox.Position = UDim2.new(0, 0, 0.5, -10)
auraCheckbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
auraCheckbox.BorderSizePixel = 0
auraCheckbox.Parent = auraFrame

local checkboxCorner = Instance.new("UICorner")
checkboxCorner.CornerRadius = UDim.new(0, 4)
checkboxCorner.Parent = auraCheckbox

local checkboxIndicator = Instance.new("Frame")
checkboxIndicator.Name = "CheckboxIndicator"
checkboxIndicator.Size = UDim2.new(0.7, 0, 0.7, 0)
checkboxIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
checkboxIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
checkboxIndicator.BackgroundColor3 = Color3.fromRGB(40, 180, 120)
checkboxIndicator.BorderSizePixel = 0
checkboxIndicator.Visible = false
checkboxIndicator.Parent = auraCheckbox

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(0, 2)
indicatorCorner.Parent = checkboxIndicator

local auraLabel = Instance.new("TextLabel")
auraLabel.Name = "AuraLabel"
auraLabel.Size = UDim2.new(1, -30, 1, 0)
auraLabel.Position = UDim2.new(0, 30, 0, 0)
auraLabel.BackgroundTransparency = 1
auraLabel.Text = "Anti Lag"
auraLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
auraLabel.Font = Enum.Font.Gotham
auraLabel.TextSize = 12
auraLabel.TextXAlignment = Enum.TextXAlignment.Left
auraLabel.Parent = auraFrame

local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(0, 80, 0, 12)
statusText.Position = UDim2.new(1, -90, 1, -15)
statusText.BackgroundTransparency = 1
statusText.Text = "Ready"
statusText.TextColor3 = Color3.fromRGB(150, 150, 150)
statusText.Font = Enum.Font.Gotham
statusText.TextSize = 9
statusText.TextXAlignment = Enum.TextXAlignment.Right
statusText.Parent = contentFrame

-- Professional notification GUI for MIC UP
local notificationGui = Instance.new("ScreenGui")
notificationGui.Name = "MicUpNotification"
notificationGui.ResetOnSpawn = false
notificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
notificationGui.Parent = playerGui

local notificationFrame = Instance.new("Frame")
notificationFrame.Name = "NotificationFrame"
notificationFrame.Size = UDim2.new(0, 280, 0, 60)
notificationFrame.Position = UDim2.new(0.5, -140, 0, -70)
notificationFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
notificationFrame.BorderSizePixel = 0
notificationFrame.Parent = notificationGui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 8)
notifCorner.Parent = notificationFrame

local notifStroke = Instance.new("UIStroke")
notifStroke.Color = Color3.fromRGB(70, 130, 255)
notifStroke.Thickness = 1
notifStroke.Parent = notificationFrame

local notifIcon = Instance.new("TextLabel")
notifIcon.Name = "NotifIcon"
notifIcon.Size = UDim2.new(0, 24, 0, 24)
notifIcon.Position = UDim2.new(0, 10, 0, 8)
notifIcon.BackgroundTransparency = 1
notifIcon.Text = "ℹ"
notifIcon.TextColor3 = Color3.fromRGB(70, 130, 255)
notifIcon.Font = Enum.Font.GothamBold
notifIcon.TextSize = 18
notifIcon.Parent = notificationFrame

local notifTitle = Instance.new("TextLabel")
notifTitle.Name = "NotifTitle"
notifTitle.Size = UDim2.new(1, -80, 0, 16)
notifTitle.Position = UDim2.new(0, 40, 0, 8)
notifTitle.BackgroundTransparency = 1
notifTitle.Text = "Feature Notice"
notifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
notifTitle.Font = Enum.Font.GothamBold
notifTitle.TextSize = 12
notifTitle.TextXAlignment = Enum.TextXAlignment.Left
notifTitle.Parent = notificationFrame

local notifText = Instance.new("TextLabel")
notifText.Name = "NotifText"
notifText.Size = UDim2.new(1, -80, 0, 28)
notifText.Position = UDim2.new(0, 40, 0, 24)
notifText.BackgroundTransparency = 1
notifText.Text = "Lag Spike feature only works in MIC UP game"
notifText.TextColor3 = Color3.fromRGB(200, 200, 200)
notifText.Font = Enum.Font.Gotham
notifText.TextSize = 10
notifText.TextXAlignment = Enum.TextXAlignment.Left
notifText.TextYAlignment = Enum.TextYAlignment.Top
notifText.TextWrapped = true
notifText.Parent = notificationFrame

local notifClose = Instance.new("TextButton")
notifClose.Name = "NotifClose"
notifClose.Size = UDim2.new(0, 20, 0, 20)
notifClose.Position = UDim2.new(1, -28, 0, 8)
notifClose.BackgroundTransparency = 1
notifClose.Text = "×"
notifClose.TextColor3 = Color3.fromRGB(150, 150, 150)
notifClose.Font = Enum.Font.GothamBold
notifClose.TextSize = 14
notifClose.Parent = notificationFrame

-- Notification animation and auto-hide
spawn(function()
    local tweenService = game:GetService("TweenService")
    local slideIn = tweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -140, 0, 20)})
    slideIn:Play()
    
    task.wait(5) -- Show for 5 seconds
    
    local slideOut = tweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -140, 0, -70)})
    slideOut:Play()
    slideOut.Completed:Connect(function()
        notificationGui:Destroy()
    end)
end)

notifClose.MouseButton1Click:Connect(function()
    local tweenService = game:GetService("TweenService")
    local slideOut = tweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -140, 0, -70)})
    slideOut:Play()
    slideOut.Completed:Connect(function()
        notificationGui:Destroy()
    end)
end)

local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 120, 0, 30)
minimizedFrame.Position = UDim2.new(0.8, 0, 0.5, 0)
minimizedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimizedFrame.BorderSizePixel = 0
minimizedFrame.Visible = false
minimizedFrame.Parent = screenGui

local minimizedCorner = Instance.new("UICorner")
minimizedCorner.CornerRadius = UDim.new(0, 8)
minimizedCorner.Parent = minimizedFrame

local minimizedText = Instance.new("TextLabel")
minimizedText.Name = "MinimizedText"
minimizedText.Size = UDim2.new(0.7, 0, 1, 0)
minimizedText.BackgroundTransparency = 1
minimizedText.Text = "Lag Server"
minimizedText.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizedText.Font = Enum.Font.GothamBold
minimizedText.TextSize = 12
minimizedText.Parent = minimizedFrame

local restoreButton = Instance.new("TextButton")
restoreButton.Name = "RestoreButton"
restoreButton.Size = UDim2.new(0, 24, 0, 24)
restoreButton.Position = UDim2.new(1, -26, 0.5, -12)
restoreButton.AnchorPoint = Vector2.new(0, 0)
restoreButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
restoreButton.BorderSizePixel = 0
restoreButton.Text = "◾"
restoreButton.TextColor3 = Color3.fromRGB(200, 200, 200)
restoreButton.Font = Enum.Font.GothamBold
restoreButton.TextSize = 14
restoreButton.Parent = minimizedFrame

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 6)
restoreCorner.Parent = restoreButton

local toolsEquipped = false
local removeAuras = false
local lagSpikeActive = false
local tools = {}
local auraRemovalConnection
local lagSpikeConnection
local isMinimized = false
local toolConnection

local ModifyEvent
local ToolEvent
local ToggleDisallowEvent
local SizePresetEvent

-- Load events in background (non-blocking)
spawn(function()
    pcall(function()
        ModifyEvent = ReplicatedStorage:WaitForChild("EventInputModify", 10)
    end)
    
    pcall(function()
        ToolEvent = ReplicatedStorage:WaitForChild("Tool", 10)
    end)
    
    pcall(function()
        ToggleDisallowEvent = ReplicatedStorage:WaitForChild("ToggleDisallowEvent", 10)
    end)
    
    pcall(function()
        SizePresetEvent = ReplicatedStorage:WaitForChild("SizePreset", 10)
    end)
end)

local titleDragArea = Instance.new("Frame")
titleDragArea.Name = "TitleDragArea"
titleDragArea.Size = UDim2.new(1, -80, 0, 35)
titleDragArea.Position = UDim2.new(0, 0, 0, 0)
titleDragArea.BackgroundTransparency = 1
titleDragArea.Parent = mainFrame

local dragging = false
local dragInput
local dragStart
local startPos
local minimizedDragging = false
local minimizedDragStart
local minimizedStartPos

local function updateDrag(input, object, dragStartPos, startPosition)
    local delta = input.Position - dragStartPos
    local newPosition = UDim2.new(
        startPosition.X.Scale, 
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale, 
        startPosition.Y.Offset + delta.Y
    )
    
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = tweenService:Create(object, tweenInfo, {Position = newPosition})
    tween:Play()
end

titleDragArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            titleDragArea.Parent.BackgroundTransparency = 0.6
        end
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                titleDragArea.Parent.BackgroundTransparency = 0.5
            end
        end)
    end
end)

minimizedFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local inputPosition = input.Position
        local guiObjects = screenGui:GetGuiObjectsAtPosition(inputPosition.X, inputPosition.Y)
        
        local canDrag = true
        for _, obj in pairs(guiObjects) do
            if obj == restoreButton then
                canDrag = false
                break
            end
        end
        
        if canDrag then
            minimizedDragging = true
            minimizedDragStart = input.Position
            minimizedStartPos = minimizedFrame.Position
            
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                minimizedFrame.BackgroundTransparency = 0.1
            end
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    minimizedDragging = false
                    minimizedFrame.BackgroundTransparency = 0
                end
            end)
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            updateDrag(input, mainFrame, dragStart, startPos)
        end
        
        if minimizedDragging then
            updateDrag(input, minimizedFrame, minimizedDragStart, minimizedStartPos)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        minimizedDragging = false
        mainFrame.BackgroundTransparency = 0.5
        minimizedFrame.BackgroundTransparency = 0
    end
end)

local function removeAuraItems()
    if not removeAuras or not localPlayer.Character then return end
    
    local auraItemsFound = false
    for _, item in pairs(localPlayer.Character:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Tool") or item:IsA("BasePart") or item:IsA("Shirt") or item:IsA("Pants") then
            if string.find(string.lower(item.Name), "aura") then
                item:Destroy()
                auraItemsFound = true
            end
        end
    end
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= localPlayer and otherPlayer.Character then
            for _, item in pairs(otherPlayer.Character:GetChildren()) do
                if item:IsA("Accessory") or item:IsA("Tool") or item:IsA("BasePart") or item:IsA("Shirt") or item:IsA("Pants") then
                    if string.find(string.lower(item.Name), "aura") then
                        item:Destroy()
                        auraItemsFound = true
                    end
                end
            end
        end
    end
end

local function startAuraRemoval()
    if auraRemovalConnection then
        auraRemovalConnection:Disconnect()
    end
    
    if removeAuras then
        auraRemovalConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if removeAuras then
                removeAuraItems()
            end
        end)
    end
end

local function stopAuraRemoval()
    if auraRemovalConnection then
        auraRemovalConnection:Disconnect()
        auraRemovalConnection = nil
    end
end

local function fireLagSpike()
    if not SizePresetEvent then
        local success, result = pcall(function()
            return ReplicatedStorage:WaitForChild("SizePreset", 2)
        end)
        if success and result then
            SizePresetEvent = result
        else
            return
        end
    end
    
    pcall(function()
        local args1 = {"Huge"}
        SizePresetEvent:FireServer(unpack(args1))
        
        local args2 = {"ARegular"}
        SizePresetEvent:FireServer(unpack(args2))
    end)
end

local function stopLagSpike()
    if not SizePresetEvent then
        local success, result = pcall(function()
            return ReplicatedStorage:WaitForChild("SizePreset", 2)
        end)
        if success and result then
            SizePresetEvent = result
        else
            return
        end
    end
    
    -- Fire ARegular to properly stop lag spike
    pcall(function()
        local args = {"ARegular"}
        SizePresetEvent:FireServer(unpack(args))
    end)
end

local function startLagSpike()
    if lagSpikeConnection then
        lagSpikeConnection:Disconnect()
    end
    
    if lagSpikeActive then
        lagSpikeConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if lagSpikeActive then
                fireLagSpike()
            end
        end)
    end
end

local function stopLagSpikeConnection()
    if lagSpikeConnection then
        lagSpikeConnection:Disconnect()
        lagSpikeConnection = nil
    end
    -- Fire the stop event
    stopLagSpike()
end

-- Function to update status text properly
local function updateStatusText()
    if lagSpikeActive then
        statusText.Text = "Lag Spike Active"
        statusText.TextColor3 = Color3.fromRGB(220, 20, 60)
    elseif toolsEquipped then
        statusText.Text = "Running"
        statusText.TextColor3 = Color3.fromRGB(40, 180, 120)
    else
        statusText.Text = "Ready"
        statusText.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end

-- Start systems
startAuraRemoval()
startLagSpike()

-- Lag Spike toggle functionality
local function toggleLagSpike()
    lagSpikeActive = not lagSpikeActive
    lagSpikeIndicator.Visible = lagSpikeActive
    
    if lagSpikeActive then
        startLagSpike()
    else
        stopLagSpikeConnection()
    end
    
    updateStatusText()
end

lagSpikeCheckbox.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleLagSpike()
    end
end)

lagSpikeLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleLagSpike()
    end
end)

-- Anti Lag toggle functionality
local function toggleAntiLag()
    removeAuras = not removeAuras
    checkboxIndicator.Visible = removeAuras
    
    if removeAuras then
        startAuraRemoval()
    else
        stopAuraRemoval()
    end
    
    updateStatusText()
end

auraCheckbox.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleAntiLag()
    end
end)

auraLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleAntiLag()
    end
end)

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedFrame.Visible = true
    isMinimized = true
    minimizedFrame.Position = UDim2.new(mainFrame.Position.X.Scale, mainFrame.Position.X.Offset, mainFrame.Position.Y.Scale, mainFrame.Position.Y.Offset)
end)

restoreButton.MouseButton1Click:Connect(function()
    minimizedFrame.Visible = false
    mainFrame.Visible = true
    isMinimized = false
    mainFrame.Position = UDim2.new(minimizedFrame.Position.X.Scale, minimizedFrame.Position.X.Offset, minimizedFrame.Position.Y.Scale, minimizedFrame.Position.Y.Offset)
end)

closeButton.MouseButton1Click:Connect(function()
    -- Properly stop all connections and reset states
    toolsEquipped = false
    removeAuras = false
    lagSpikeActive = false
    
    if toolConnection then
        toolConnection:Disconnect()
        toolConnection = nil
    end
    
    stopAuraRemoval()
    stopLagSpikeConnection()
    
    -- Fire cleanup events
    pcall(function()
        if ToggleDisallowEvent then
            ToggleDisallowEvent:FireServer()
        end
    end)
    
    pcall(function()
        if ModifyEvent then
            ModifyEvent:FireServer(localPlayer.Name)
        end
    end)
    
    screenGui:Destroy()
end)

local function fireModifyUsername()
    if not ModifyEvent then
        local success, result = pcall(function()
            return ReplicatedStorage:WaitForChild("EventInputModify", 2)
        end)
        if success and result then
            ModifyEvent = result
        else
            return false
        end
    end
    
    local success = pcall(function()
        ModifyEvent:FireServer("24k_mxtty1")
    end)
    
    return success
end

local function fireToolEvent(toolName)
    if not ToolEvent then
        local success, result = pcall(function()
            return ReplicatedStorage:WaitForChild("Tool", 2)
        end)
        if success and result then
            ToolEvent = result
        else
            return false
        end
    end
    
    local success = pcall(function()
        ToolEvent:FireServer(toolName)
    end)
    
    return success
end

local function fireToggleDisallowEvent()
    if not ToggleDisallowEvent then
        local success, result = pcall(function()
            return ReplicatedStorage:WaitForChild("ToggleDisallowEvent", 2)
        end)
        if success and result then
            ToggleDisallowEvent = result
        else
            return false
        end
    end
    
    local success = pcall(function()
        ToggleDisallowEvent:FireServer()
    end)
    
    return success
end

local function fireModifyUserEvent()
    local success, result = pcall(function()
        local modifyEvent = ReplicatedStorage:WaitForChild("Modify", 2)
        local args = { localPlayer.Name }
        modifyEvent:FireServer(unpack(args))
    end)
    
    return success
end

local function startToolManagement()
    if toolConnection then
        toolConnection:Disconnect()
    end
    
    if toolsEquipped then
        toolConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not toolsEquipped then return end
            
            fireModifyUsername()
            
            tools = {}
            for _, tool in pairs(localPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(tools, tool)
                end
            end
            
            if #tools > 0 and localPlayer.Character then
                for _, tool in pairs(tools) do
                    if not toolsEquipped then break end
                    tool.Parent = localPlayer.Character
                end
            end
            
            if localPlayer.Character then
                for _, tool in pairs(localPlayer.Character:GetChildren()) do
                    if not toolsEquipped then break end
                    if tool:IsA("Tool") then
                        tool.Parent = localPlayer.Backpack
                    end
                end
            end
        end)
    end
end

local function stopToolManagement()
    if toolConnection then
        toolConnection:Disconnect()
        toolConnection = nil
    end
    
    -- Fire cleanup events
    pcall(function()
        fireToggleDisallowEvent()
        fireModifyUserEvent()
        task.wait(0.1)
        fireToggleDisallowEvent()
    end)
end

toggleButton.MouseButton1Click:Connect(function()
    toolsEquipped = not toolsEquipped
    
    if toolsEquipped then
        toggleButton.Text = "ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(40, 180, 120)
        
        startToolManagement()
        fireModifyUsername()
        fireToolEvent("Motor")
        
    else
        toggleButton.Text = "OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
        
        stopToolManagement()
    end
    
    updateStatusText()
end)

-- Fire initial tool event immediately when GUI loads
spawn(function()
    local args = {
        "DangerKnife"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Tool"):FireServer(unpack(args))
end)
