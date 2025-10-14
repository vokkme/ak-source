local localPlayer = game.Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ToolManagerGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 120)
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
titleText.Text = "Lag Server 2"
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

local auraFrame = Instance.new("Frame")
auraFrame.Name = "AuraFrame"
auraFrame.Size = UDim2.new(1, 0, 0, 30)
auraFrame.Position = UDim2.new(0, 0, 0, 45)
auraFrame.BackgroundTransparency = 1
auraFrame.Parent = contentFrame

local auraCheckbox = Instance.new("Frame")
auraCheckbox.Name = "AuraCheckbox"
auraCheckbox.Size = UDim2.new(0, 24, 0, 24)
auraCheckbox.Position = UDim2.new(0, 0, 0.5, -12)
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
auraLabel.Size = UDim2.new(1, -34, 1, 0)
auraLabel.Position = UDim2.new(0, 34, 0, 0)
auraLabel.BackgroundTransparency = 1
auraLabel.Text = "Anti Lag"
auraLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
auraLabel.Font = Enum.Font.Gotham
auraLabel.TextSize = 14
auraLabel.TextXAlignment = Enum.TextXAlignment.Left
auraLabel.Parent = auraFrame

local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(0.7, 0, 0, 15)
statusText.Position = UDim2.new(0.3, 0, 1, -18)
statusText.BackgroundTransparency = 1
statusText.Text = "Ready"
statusText.TextColor3 = Color3.fromRGB(150, 150, 150)
statusText.Font = Enum.Font.Gotham
statusText.TextSize = 10
statusText.Parent = contentFrame

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
minimizedText.Text = "Lag Server 2"
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
restoreButton.Text = "â¢"
restoreButton.TextColor3 = Color3.fromRGB(200, 200, 200)
restoreButton.Font = Enum.Font.GothamBold
restoreButton.TextSize = 14
restoreButton.Parent = minimizedFrame

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 6)
restoreCorner.Parent = restoreButton

local toolsEquipped = false
local removeAuras = false
local auraRemovalConnection
local toolConnection
local notificationShown = false
local auraLinks = {
    "https://www.roblox.com/catalog/13948001865/1-0-Purple-Meteor-Aura",
    "https://www.roblox.com/catalog/13948000252/1-0-Blue-Meteor-Aura",
    "https://www.roblox.com/catalog/13947998257/1-0-Teal-Meteor-Aura",
    "https://www.roblox.com/catalog/13833174562/1-0-Blue-Aura",
    "https://www.roblox.com/catalog/13947995442/1-0-Pink-Meteor-Aura",
    "https://www.roblox.com/catalog/13947992462/1-0-Blue-Meteor-Aura",
    "https://www.roblox.com/catalog/13833184062/1-0-Pink-Aura"
}

local function createNotificationGui()
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "NotificationGui"
    notifGui.Parent = playerGui
    
    local notifFrame = Instance.new("Frame")
    notifFrame.Size = UDim2.new(0, 400, 0, 340)
    notifFrame.Position = UDim2.new(0.5, -200, 0.5, -170)
    notifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notifFrame.BorderSizePixel = 0
    notifFrame.Parent = notifGui
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 10)
    notifCorner.Parent = notifFrame
    
    local notifTitle = Instance.new("TextLabel")
    notifTitle.Size = UDim2.new(1, -20, 0, 30)
    notifTitle.Position = UDim2.new(0, 10, 0, 10)
    notifTitle.BackgroundTransparency = 1
    notifTitle.Text = "Recommended Auras"
    notifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextSize = 16
    notifTitle.Parent = notifFrame
    
    local notifDesc = Instance.new("TextLabel")
    notifDesc.Size = UDim2.new(1, -20, 0, 60)
    notifDesc.Position = UDim2.new(0, 10, 0, 45)
    notifDesc.BackgroundTransparency = 1
    notifDesc.Text = "For optimal performance, consider having these auras equipped. You also need at least 1 tool to use this script:"
    notifDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
    notifDesc.Font = Enum.Font.Gotham
    notifDesc.TextSize = 12
    notifDesc.TextWrapped = true
    notifDesc.Parent = notifFrame
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -20, 1, -170)
    scrollFrame.Position = UDim2.new(0, 10, 0, 110)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.Parent = notifFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = scrollFrame
    
    for i, link in ipairs(auraLinks) do
        local linkFrame = Instance.new("Frame")
        linkFrame.Size = UDim2.new(1, -10, 0, 25)
        linkFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        linkFrame.BorderSizePixel = 0
        linkFrame.Parent = scrollFrame
        
        local linkCorner = Instance.new("UICorner")
        linkCorner.CornerRadius = UDim.new(0, 5)
        linkCorner.Parent = linkFrame
        
        local linkText = Instance.new("TextLabel")
        linkText.Size = UDim2.new(1, -10, 1, 0)
        linkText.Position = UDim2.new(0, 5, 0, 0)
        linkText.BackgroundTransparency = 1
        linkText.Text = link
        linkText.TextColor3 = Color3.fromRGB(100, 150, 255)
        linkText.Font = Enum.Font.Gotham
        linkText.TextSize = 10
        linkText.TextXAlignment = Enum.TextXAlignment.Left
        linkText.TextScaled = true
        linkText.Parent = linkFrame
    end
    
    local copyButton = Instance.new("TextButton")
    copyButton.Size = UDim2.new(0, 100, 0, 30)
    copyButton.Position = UDim2.new(0, 10, 1, -40)
    copyButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    copyButton.BorderSizePixel = 0
    copyButton.Text = "Copy All"
    copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyButton.Font = Enum.Font.GothamSemibold
    copyButton.TextSize = 12
    copyButton.Parent = notifFrame
    
    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 6)
    copyCorner.Parent = copyButton
    
    local closeNotifButton = Instance.new("TextButton")
    closeNotifButton.Size = UDim2.new(0, 80, 0, 30)
    closeNotifButton.Position = UDim2.new(1, -90, 1, -40)
    closeNotifButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    closeNotifButton.BorderSizePixel = 0
    closeNotifButton.Text = "Close"
    closeNotifButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeNotifButton.Font = Enum.Font.GothamSemibold
    closeNotifButton.TextSize = 12
    closeNotifButton.Parent = notifFrame
    
    local closeNotifCorner = Instance.new("UICorner")
    closeNotifCorner.CornerRadius = UDim.new(0, 6)
    closeNotifCorner.Parent = closeNotifButton
    
    copyButton.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(table.concat(auraLinks, "\n"))
            copyButton.Text = "Copied!"
            copyButton.BackgroundColor3 = Color3.fromRGB(40, 180, 120)
            task.wait(1)
            copyButton.Text = "Copy All"
            copyButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
        end
    end)
    
    closeNotifButton.MouseButton1Click:Connect(function()
        notifGui:Destroy()
    end)
    
    task.wait(5)
    if notifGui.Parent then
        notifGui:Destroy()
    end
end

local requiredAuras = {13948001865, 13948000252, 13947998257, 13833174562, 13947995442, 13947992462, 13833184062}
local allowedGameIds = {6884319169, 15546218972}
local titleDragArea = Instance.new("Frame")
titleDragArea.Size = UDim2.new(1, -80, 0, 35)
titleDragArea.Position = UDim2.new(0, 0, 0, 0)
titleDragArea.BackgroundTransparency = 1
titleDragArea.Parent = mainFrame

local dragging = false
local dragStart
local startPos
local minimizedDragging = false
local minimizedDragStart
local minimizedStartPos

local function updateDrag(input, object, dragStartPos, startPosition)
    local delta = input.Position - dragStartPos
    local newPosition = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    local tweenService = game:GetService("TweenService")
    local tween = tweenService:Create(object, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = newPosition})
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

local function hasAllAuras()
    if not localPlayer.Character then return false end
    local foundAuras = {}
    for _, item in pairs(localPlayer.Character:GetChildren()) do
        if item:IsA("Accessory") and item:FindFirstChild("Handle") then
            local mesh = item.Handle:FindFirstChild("SpecialMesh")
            if mesh and mesh.MeshId then
                local meshId = tonumber(mesh.MeshId:match("%d+"))
                if meshId then
                    for _, requiredId in pairs(requiredAuras) do
                        if meshId == requiredId then
                            foundAuras[requiredId] = true
                        end
                    end
                end
            end
        end
    end
    return #foundAuras == #requiredAuras
end

local function isInAllowedGame()
    local gameId = game.PlaceId
    for _, allowedId in pairs(allowedGameIds) do
        if gameId == allowedId then
            return true
        end
    end
    return false
end

local function removeAuraItems()
    if not removeAuras then return end
    local auraItemsFound = false
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            for _, item in pairs(player.Character:GetChildren()) do
                if item:IsA("Accessory") or item:IsA("Tool") or item:IsA("BasePart") or item:IsA("Shirt") or item:IsA("Pants") then
                    if string.find(string.lower(item.Name), "aura") then
                        item:Destroy()
                        auraItemsFound = true
                    end
                end
            end
        end
    end
    if auraItemsFound then
        statusText.Text = "Aura items removed"
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(0.01)
        statusText.Text = toolsEquipped and "Running" or "Ready"
        statusText.TextColor3 = toolsEquipped and Color3.fromRGB(40, 180, 120) or Color3.fromRGB(150, 150, 150)
    end
end

local function startAuraRemoval()
    if auraRemovalConnection then
        auraRemovalConnection:Disconnect()
    end
    auraRemovalConnection = RunService.Heartbeat:Connect(function()
        if removeAuras then
            removeAuraItems()
        end
    end)
end

local function startToolSpam()
    if toolConnection then
        toolConnection:Disconnect()
    end
    toolConnection = RunService.Heartbeat:Connect(function()
        if toolsEquipped and localPlayer.Character then
            for _, tool in pairs(localPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = localPlayer.Character
                end
            end
            for _, tool in pairs(localPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = localPlayer.Backpack
                end
            end
        end
    end)
end

startAuraRemoval()

local function toggleAura(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        removeAuras = not removeAuras
        checkboxIndicator.Visible = removeAuras
        if removeAuras then
            statusText.Text = "Anti Lag active"
            statusText.TextColor3 = Color3.fromRGB(40, 180, 120)
        else
            statusText.Text = "Anti Lag off"
            statusText.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        task.wait(0.01)
        if toolsEquipped then
            statusText.Text = "Running"
            statusText.TextColor3 = Color3.fromRGB(40, 180, 120)
        else
            statusText.Text = "Ready"
            statusText.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
end

auraCheckbox.InputBegan:Connect(toggleAura)
auraLabel.InputBegan:Connect(toggleAura)

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedFrame.Visible = true
    minimizedFrame.Position = UDim2.new(mainFrame.Position.X.Scale, mainFrame.Position.X.Offset, mainFrame.Position.Y.Scale, mainFrame.Position.Y.Offset)
end)

restoreButton.MouseButton1Click:Connect(function()
    minimizedFrame.Visible = false
    mainFrame.Visible = true
    mainFrame.Position = UDim2.new(minimizedFrame.Position.X.Scale, minimizedFrame.Position.X.Offset, minimizedFrame.Position.Y.Scale, minimizedFrame.Position.Y.Offset)
end)

closeButton.MouseButton1Click:Connect(function()
    if toolConnection then
        toolConnection:Disconnect()
    end
    if auraRemovalConnection then
        auraRemovalConnection:Disconnect()
    end
    screenGui:Destroy()
    toolsEquipped = false
end)

toggleButton.MouseButton1Click:Connect(function()
    if not hasAllAuras() or not isInAllowedGame() then
        if not notificationShown then
            notificationShown = true
            createNotificationGui()
        end
    end
    
    toolsEquipped = not toolsEquipped
    if toolsEquipped then
        toggleButton.Text = "ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(40, 180, 120)
        statusText.Text = "Running"
        statusText.TextColor3 = Color3.fromRGB(40, 180, 120)
        startToolSpam()
    else
        toggleButton.Text = "OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
        statusText.Text = "Ready"
        statusText.TextColor3 = Color3.fromRGB(150, 150, 150)
        if toolConnection then
            toolConnection:Disconnect()
        end
    end
end)
