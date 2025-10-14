local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Constants
local DEFAULTS = {
    REACH = 3.5,
    SHAPE = "Sphere",
    TRANSPARENCY = 0.6,
    GUI_COLOR = Color3.fromRGB(0, 0, 0),
    ACCENT_COLOR = Color3.fromRGB(255, 70, 70),
    TEXT_COLOR = Color3.fromRGB(255, 255, 255),
    SECONDARY_COLOR = Color3.fromRGB(0, 0, 0),
    GUI_TRANSPARENCY = 0.7,
    BUTTON_TRANSPARENCY = 0.7
}

-- State Management
local State = {
    active = true,
    reach = DEFAULTS.REACH,
    shape = DEFAULTS.SHAPE,
    damageEnabled = true,
    visualizerEnabled = false,
    autoEquipEnabled = false,
    targetEnabled = false,
	killAfterRespawnEnabled = false,
    minimized = false,
    targetedPlayers = {}
}

-- Utility Functions
local function createDraggable(gui)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local lastUpdateTime = tick()
    local THROTTLE_TIME = 0.01  -- Throttle updates to every 0.01 seconds

    local function update(input)
        if tick() - lastUpdateTime < THROTTLE_TIME then return end
        lastUpdateTime = tick()
        
        local delta = input.Position - dragStart
        local targetPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        
        -- Smooth movement using TweenService
        TweenService:Create(gui, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            Position = targetPosition
        }):Play()
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Create Enhanced Visualizer
local function createVisualizer()
    local visualizer = Instance.new("Part")
    visualizer.Name = "ReachVisualizer"
    visualizer.BrickColor = BrickColor.new("Really blue")
    visualizer.Material = Enum.Material.Neon
    visualizer.Transparency = DEFAULTS.TRANSPARENCY
    visualizer.Anchored = true
    visualizer.CanCollide = false
    visualizer.Size = Vector3.new(0.5, 0.5, 0.5)
    visualizer.BottomSurface = Enum.SurfaceType.Smooth
    visualizer.TopSurface = Enum.SurfaceType.Smooth

    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 0.9
    highlight.OutlineTransparency = 0.5
    highlight.Parent = visualizer

    return visualizer
end

-- Create Enhanced GUI
local function createEnhancedGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ReachGui"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999999999
    ScreenGui.ResetOnSpawn = false

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = DEFAULTS.GUI_COLOR
    MainFrame.BackgroundTransparency = DEFAULTS.GUI_TRANSPARENCY
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0, 20, 0.5, -100)
    MainFrame.Size = UDim2.new(0, 250, 0, 310)
    MainFrame.Parent = ScreenGui
    MainFrame.ClipsDescendants = true

    -- Add smooth corners and shadow
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = -1
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.3
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.Parent = MainFrame

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.BackgroundTransparency = 1
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.Parent = MainFrame

    -- AK ADMIN Label (Top Left in GUI)
    local AKAdminLabel = Instance.new("TextLabel")
    AKAdminLabel.Name = "AKAdminLabel"
    AKAdminLabel.BackgroundTransparency = 1
    AKAdminLabel.Position = UDim2.new(0, 10, 0, 0)
    AKAdminLabel.Size = UDim2.new(0, 80, 1, 0)
    AKAdminLabel.Font = Enum.Font.GothamBold
    AKAdminLabel.Text = "AK ADMIN"
    AKAdminLabel.TextColor3 = DEFAULTS.TEXT_COLOR
    AKAdminLabel.TextSize = 10
    AKAdminLabel.TextXAlignment = Enum.TextXAlignment.Left
    AKAdminLabel.Parent = TitleBar

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 90, 0, 0)
    Title.Size = UDim2.new(1, -180, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Reach Controls"
    Title.TextColor3 = DEFAULTS.TEXT_COLOR
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.Parent = TitleBar

    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeButton.BackgroundTransparency = DEFAULTS.BUTTON_TRANSPARENCY
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = DEFAULTS.TEXT_COLOR
    MinimizeButton.TextSize = 14
    MinimizeButton.Parent = TitleBar

    local MinimizeUICorner = Instance.new("UICorner")
    MinimizeUICorner.CornerRadius = UDim.new(0, 4)
    MinimizeUICorner.Parent = MinimizeButton

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.BackgroundTransparency = DEFAULTS.BUTTON_TRANSPARENCY
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = DEFAULTS.TEXT_COLOR
    CloseButton.TextSize = 14
    CloseButton.Parent = TitleBar

    local CloseUICorner = Instance.new("UICorner")
    CloseUICorner.CornerRadius = UDim.new(0, 4)
    CloseUICorner.Parent = CloseButton

    -- Content Container (for minimize animation)
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 0, 0, 30)
    ContentContainer.Size = UDim2.new(1, 0, 1, -30)
    ContentContainer.Parent = MainFrame

    -- Settings Container
    local SettingsContainer = Instance.new("Frame")
    SettingsContainer.Name = "SettingsContainer"
    SettingsContainer.BackgroundTransparency = 1
    SettingsContainer.Position = UDim2.new(0, 10, 0, 10)
    SettingsContainer.Size = UDim2.new(1, -20, 1, -20)
    SettingsContainer.Parent = ContentContainer

    -- Create settings
    local function createSetting(name, yPos, defaultValue, settingType)
        local container = Instance.new("Frame")
        container.BackgroundTransparency = 1
        container.Position = UDim2.new(0, 0, 0, yPos)
        container.Size = UDim2.new(1, 0, 0, 30)
        container.Parent = SettingsContainer

        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0.1, 0, 0, 0)
        label.Size = UDim2.new(0.5, 0, 1, 0)
        label.Font = Enum.Font.Gotham
        label.Text = name
        label.TextColor3 = DEFAULTS.TEXT_COLOR
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container

        local control
        if settingType == "input" then
            control = Instance.new("TextBox")
            control.BackgroundColor3 = DEFAULTS.SECONDARY_COLOR
            control.BackgroundTransparency = DEFAULTS.BUTTON_TRANSPARENCY
            control.BorderSizePixel = 0
            control.Position = UDim2.new(0.5, 0, 0, 0)
            control.Size = UDim2.new(0.5, -5, 1, 0)
            control.Font = Enum.Font.GothamSemibold
            control.Text = tostring(defaultValue)
            control.TextColor3 = DEFAULTS.ACCENT_COLOR
            control.TextSize = 14
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = control
        elseif settingType == "toggle" then
            control = Instance.new("TextButton")
            control.BackgroundColor3 = DEFAULTS.SECONDARY_COLOR
            control.BackgroundTransparency = DEFAULTS.BUTTON_TRANSPARENCY
            control.BorderSizePixel = 0
            control.Position = UDim2.new(0.5, 0, 0.15, 0)
            control.Size = UDim2.new(0, 40, 0, 20)
            control.Text = ""
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = control
            
            local toggleCircle = Instance.new("Frame")
            toggleCircle.BackgroundColor3 = DEFAULTS.TEXT_COLOR
            toggleCircle.BackgroundTransparency = 0
            toggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
            toggleCircle.Size = UDim2.new(0, 16, 0, 16)
            toggleCircle.Name = "Circle"
            toggleCircle.Parent = control
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = toggleCircle
        elseif settingType == "button" then
            control = Instance.new("TextButton")
            control.BackgroundColor3 = DEFAULTS.SECONDARY_COLOR
            control.BackgroundTransparency = DEFAULTS.BUTTON_TRANSPARENCY
            control.BorderSizePixel = 0
            control.Position = UDim2.new(0.5, 0, 0, 0)
            control.Size = UDim2.new(0.5, -5, 1, 0)
            control.Font = Enum.Font.GothamSemibold
            control.Text = tostring(defaultValue)
            control.TextColor3 = DEFAULTS.TEXT_COLOR
            control.TextSize = 14
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = control
        end
        
        control.Parent = container
        return control
    end

    -- Create settings
    local reachInput = createSetting("Reach", 0, State.reach, "input")
    local shapeButton = createSetting("Shape", 40, State.shape, "button")
    local damageToggle = createSetting("Damage", 80, State.damageEnabled, "toggle")
    local visualizerToggle = createSetting("Visualizer", 120, State.visualizerEnabled, "toggle")
    local autoEquipToggle = createSetting("Auto Equip", 160, State.autoEquipEnabled, "toggle")
    local targetToggle = createSetting("Target", 200, State.targetEnabled, "toggle")
	local killAfterRespawnToggle = createSetting("Auto Reset", 240, State.killAfterRespawnEnabled, "toggle")

    -- Make GUI draggable
    createDraggable(MainFrame)

    -- Target Frame
    local TargetFrame = Instance.new("Frame")
    TargetFrame.Name = "TargetFrame"
    TargetFrame.BackgroundColor3 = DEFAULTS.GUI_COLOR
    TargetFrame.BackgroundTransparency = DEFAULTS.GUI_TRANSPARENCY
    TargetFrame.BorderSizePixel = 0
    TargetFrame.Position = UDim2.new(0.5, -120, 0.5, -150)
    TargetFrame.Size = UDim2.new(0, 240, 0, 300)
    TargetFrame.Visible = false
    TargetFrame.Parent = ScreenGui
    TargetFrame.ClipsDescendants = true
    
    createDraggable(TargetFrame)
        
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = TargetFrame

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = -1
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.3
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.Parent = TargetFrame

    -- Target Title Bar
    local TargetTitleBar = Instance.new("Frame")
    TargetTitleBar.Name = "TargetTitleBar"
    TargetTitleBar.BackgroundTransparency = 1
    TargetTitleBar.BorderSizePixel = 0
    TargetTitleBar.Size = UDim2.new(1, 0, 0, 30)
    TargetTitleBar.Parent = TargetFrame

    -- Target Title
    local TargetTitle = Instance.new("TextLabel")
    TargetTitle.Name = "TargetTitle"
    TargetTitle.BackgroundTransparency = 1
    TargetTitle.Position = UDim2.new(0, 10, 0, 0)
    TargetTitle.Size = UDim2.new(1, -40, 1, 0)
    TargetTitle.Font = Enum.Font.GothamBold
    TargetTitle.Text = "Target Players"
    TargetTitle.TextColor3 = DEFAULTS.TEXT_COLOR
    TargetTitle.TextSize = 14
    TargetTitle.TextXAlignment = Enum.TextXAlignment.Center
    TargetTitle.Parent = TargetTitleBar

    -- Target Close Button
    local TargetCloseButton = Instance.new("TextButton")
    TargetCloseButton.Name = "TargetCloseButton"
    TargetCloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TargetCloseButton.BackgroundTransparency = DEFAULTS.BUTTON_TRANSPARENCY
    TargetCloseButton.BorderSizePixel = 0
    TargetCloseButton.Position = UDim2.new(1, -30, 0, 5)
    TargetCloseButton.Size = UDim2.new(0, 20, 0, 20)
    TargetCloseButton.Font = Enum.Font.GothamBold
    TargetCloseButton.Text = "X"
    TargetCloseButton.TextColor3 = DEFAULTS.TEXT_COLOR
    TargetCloseButton.TextSize = 14
    TargetCloseButton.Parent = TargetTitleBar

    local TargetCloseUICorner = Instance.new("UICorner")
    TargetCloseUICorner.CornerRadius = UDim.new(0, 4)
    TargetCloseUICorner.Parent = TargetCloseButton
    
    -- Target Content
    local TargetContent = Instance.new("ScrollingFrame")
    TargetContent.Name = "TargetContent"
    TargetContent.BackgroundTransparency = 1
    TargetContent.Position = UDim2.new(0, 0, 0, 30)
    TargetContent.Size = UDim2.new(1, 0, 1, -30)
    TargetContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TargetContent.ScrollBarThickness = 6
    TargetContent.ScrollBarImageColor3 = DEFAULTS.SECONDARY_COLOR
    TargetContent.ScrollBarImageTransparency = 0.3
    TargetContent.Parent = TargetFrame
    
    TargetCloseButton.MouseButton1Click:Connect(function()
        TargetFrame.Visible = false
    end)
        
    return {
        gui = ScreenGui,
        mainFrame = MainFrame,
        contentContainer = ContentContainer,
        settingsContainer = SettingsContainer,
        reachInput = reachInput,
        shapeButton = shapeButton,
        damageToggle = damageToggle,
        visualizerToggle = visualizerToggle,
        autoEquipToggle = autoEquipToggle,
        targetToggle = targetToggle,
		killAfterRespawnToggle = killAfterRespawnToggle,
        minimizeButton = MinimizeButton,
        closeButton = CloseButton,
        targetFrame = TargetFrame,
        targetContent = TargetContent
    }
end

-- Initialize
local visualizer = createVisualizer()
local gui = createEnhancedGui()
gui.gui.Parent = CoreGui

local function updatePlayerList()
    local targetContent = gui.targetContent
    for _, child in ipairs(targetContent:GetChildren()) do
        if child:IsA("Frame") then
           child:Destroy()
        end
    end
    targetContent.CanvasSize = UDim2.new(0,0,0,0)
    
    local yOffset = 0
    for _, player in ipairs(Players:GetPlayers()) do
        local container = Instance.new("Frame")
        container.BackgroundTransparency = 1
        container.Size = UDim2.new(1, 0, 0, 30)
        container.Position = UDim2.new(0,0,0,yOffset)
        container.Parent = targetContent
    
        -- Profile Picture
        local profilePicture = Instance.new("ImageLabel")
        profilePicture.Size = UDim2.new(0, 25, 0, 25)
        profilePicture.Position = UDim2.new(0.05, 0, 0.5, -12)
        profilePicture.BackgroundTransparency = 1
        profilePicture.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
        profilePicture.Parent = container

        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0.2, 0, 0, 0)
        label.Size = UDim2.new(0.5, 0, 1, 0)
        label.Font = Enum.Font.Gotham
        label.Text = player.Name
        label.TextColor3 = DEFAULTS.TEXT_COLOR
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container

        local control = Instance.new("TextButton")
        control.BackgroundColor3 = DEFAULTS.SECONDARY_COLOR
        control.BackgroundTransparency = DEFAULTS.BUTTON_TRANSPARENCY
        control.BorderSizePixel = 0
        control.Position = UDim2.new(0.65, 0, 0.15, 0)
        control.Size = UDim2.new(0, 40, 0, 20)
        control.Text = ""
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = control
        
        local toggleCircle = Instance.new("Frame")
        toggleCircle.BackgroundColor3 = table.find(State.targetedPlayers, player.Name) and DEFAULTS.ACCENT_COLOR or DEFAULTS.TEXT_COLOR
        toggleCircle.BackgroundTransparency = 0
        toggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
        toggleCircle.Size = UDim2.new(0, 16, 0, 16)
        toggleCircle.Name = "Circle"
        toggleCircle.Parent = control
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = toggleCircle
        control.Parent = container
        
        control.MouseButton1Click:Connect(function()
            local playerName = player.Name
            if table.find(State.targetedPlayers, playerName) then
               for i, v in ipairs(State.targetedPlayers) do
                    if v == playerName then
                        table.remove(State.targetedPlayers, i)
                        break
                    end
               end
            else
                table.insert(State.targetedPlayers, playerName)
            end
            toggleCircle.BackgroundColor3 = table.find(State.targetedPlayers, player.Name) and DEFAULTS.ACCENT_COLOR or DEFAULTS.TEXT_COLOR
        end)
    
    yOffset = yOffset + 30
    end
    
    if yOffset > 270 then
       targetContent.Size = UDim2.new(1, 0, 0.9, -30)
       targetContent.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    else
        targetContent.Size = UDim2.new(1, 0, 1, -30)
        targetContent.CanvasSize = UDim2.new(0, 0, 0, yOffset)
     end
end

-- Auto Equip Function
local function startAutoEquip()
     local equipped = false

    local function equipTool(character)
         if equipped then return end
        
        local backpack = Players.LocalPlayer:WaitForChild("Backpack")
        
        if character and backpack then
            local currentTool = character:FindFirstChildOfClass("Tool")
            if not currentTool then
                local tool = backpack:FindFirstChildOfClass("Tool")
                if tool then
                   if tool:FindFirstChild("Handle") then
                        tool.Parent = character
                        equipped = true
                    end
                end
            end
        end
    end
    
    local equipOnCharacterRemoval
    equipOnCharacterRemoval = Players.PlayerRemoving:Connect(function(player)
        if player == Players.LocalPlayer and State.autoEquipEnabled then
            local character = Players.LocalPlayer.Character
            if character then
                equipped = false
                wait(0.5)
                equipTool(character)
            end
        end
    end)
    
    Players.LocalPlayer.CharacterAdded:Connect(function(character)
        if State.autoEquipEnabled then
            equipped = false
            wait(0.5)
            equipTool(character)
        end
    end)
    
    local character = Players.LocalPlayer.Character
    if character and State.autoEquipEnabled then
        equipTool(character)
    end
end

-- Event Handlers
gui.damageToggle.MouseButton1Click:Connect(function()
    State.damageEnabled = not State.damageEnabled
    TweenService:Create(gui.damageToggle.Circle, TweenInfo.new(0.2), {
        Position = State.damageEnabled and UDim2.new(0.55, 0, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    }):Play()
    gui.damageToggle.BackgroundColor3 = State.damageEnabled and DEFAULTS.ACCENT_COLOR or DEFAULTS.SECONDARY_COLOR
end)

gui.visualizerToggle.MouseButton1Click:Connect(function()
    State.visualizerEnabled = not State.visualizerEnabled
    TweenService:Create(gui.visualizerToggle.Circle, TweenInfo.new(0.2), {
        Position = State.visualizerEnabled and UDim2.new(0.55, 0, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    }):Play()
    gui.visualizerToggle.BackgroundColor3 = State.visualizerEnabled and DEFAULTS.ACCENT_COLOR or DEFAULTS.SECONDARY_COLOR
end)

gui.autoEquipToggle.MouseButton1Click:Connect(function()
    State.autoEquipEnabled = not State.autoEquipEnabled
    TweenService:Create(gui.autoEquipToggle.Circle, TweenInfo.new(0.2), {
        Position = State.autoEquipEnabled and UDim2.new(0.55, 0, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    }):Play()
    gui.autoEquipToggle.BackgroundColor3 = State.autoEquipEnabled and DEFAULTS.ACCENT_COLOR or DEFAULTS.SECONDARY_COLOR
    startAutoEquip()
end)

gui.targetToggle.MouseButton1Click:Connect(function()
    State.targetEnabled = not State.targetEnabled
    TweenService:Create(gui.targetToggle.Circle, TweenInfo.new(0.2), {
        Position = State.targetEnabled and UDim2.new(0.55, 0, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    }):Play()
    gui.targetToggle.BackgroundColor3 = State.targetEnabled and DEFAULTS.ACCENT_COLOR or DEFAULTS.SECONDARY_COLOR
    
    gui.targetFrame.Visible = State.targetEnabled
    if State.targetEnabled then
       updatePlayerList()
    end
end)

gui.killAfterRespawnToggle.MouseButton1Click:Connect(function()
    State.killAfterRespawnEnabled = not State.killAfterRespawnEnabled
    TweenService:Create(gui.killAfterRespawnToggle.Circle, TweenInfo.new(0.2), {
        Position = State.killAfterRespawnEnabled and UDim2.new(0.55, 0, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    }):Play()
    gui.killAfterRespawnToggle.BackgroundColor3 = State.killAfterRespawnEnabled and DEFAULTS.ACCENT_COLOR or DEFAULTS.SECONDARY_COLOR
end)

gui.shapeButton.MouseButton1Click:Connect(function()
    State.shape = State.shape == "Sphere" and "Line" or "Sphere"
    gui.shapeButton.Text = State.shape
end)

gui.minimizeButton.MouseButton1Click:Connect(function()
    State.minimized = not State.minimized

    if State.minimized then
        -- Add constraint
        local aspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        aspectRatioConstraint.AspectRatio = 250/30
        aspectRatioConstraint.Parent = gui.mainFrame

        for _, object in pairs(gui.settingsContainer:GetChildren()) do
            object.Visible = false
        end
        
        -- Animate main frame
        TweenService:Create(gui.mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 250, 0, 30)
        }):Play()

        -- Animate content container
        TweenService:Create(gui.contentContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, 0, 0, 0)
        }):Play()

    else
        -- Remove Constraint
        for _, object in pairs(gui.mainFrame:GetChildren()) do
            if object:IsA("UIAspectRatioConstraint") then
                object:Destroy()
            end
        end

        for _, object in pairs(gui.settingsContainer:GetChildren()) do
            object.Visible = true
        end

        -- Animate the content container
        TweenService:Create(gui.contentContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size =  UDim2.new(1, 0, 1, -30)
        }):Play()
        -- Animate the main frame
        TweenService:Create(gui.mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 250, 0, 330)
        }):Play()
    end

    -- Change minimize button text
    gui.minimizeButton.Text = State.minimized and "+" or "-"
end)

gui.closeButton.MouseButton1Click:Connect(function()
    State.active = false
    gui.gui:Destroy()
    if visualizer then visualizer:Destroy() end
end)

-- Hit Detection Logic
local function onHit(hit, handle)
    local victim = hit.Parent:FindFirstChildOfClass("Humanoid")
    if victim and victim.Parent.Name ~= Players.LocalPlayer.Name then
        if not State.targetEnabled or table.find(State.targetedPlayers, victim.Parent.Name) then
            if State.damageEnabled then
                for _, v in pairs(hit.Parent:GetChildren()) do
                    if v:IsA("Part") then
                        firetouchinterest(v, handle, 0)
                        firetouchinterest(v, handle, 1)
                    end
                end
            end
        end
    end
end

-- Kill after respawn logic
local function startKillAfterRespawn()
	local function killPlayer(character)
		if State.killAfterRespawnEnabled then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.Health = 0
			end
		end
	end
	
	local charAddedConnection
	charAddedConnection = Players.LocalPlayer.CharacterAdded:Connect(function(character)
		if State.killAfterRespawnEnabled then
			delay(3, function()
				killPlayer(character)
			end)
		end
	end)
		
	local charRemovingConnection
    charRemovingConnection = Players.PlayerRemoving:Connect(function(player)
		if player == Players.LocalPlayer then
			if charAddedConnection then
				charAddedConnection:Disconnect()
			end
		    if charRemovingConnection then
				charRemovingConnection:Disconnect()
			end
		end
    end)
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    if not State.active then return end
    
    local character = Players.LocalPlayer.Character
    local tool = character and character:FindFirstChildOfClass("Tool")
    
    if not tool then 
        visualizer.Parent = nil
        return 
    end
    
    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part")
    if not handle then return end
    
    if State.visualizerEnabled then
        visualizer.Parent = workspace
    else
        visualizer.Parent = nil
    end
    
    local reach = tonumber(gui.reachInput.Text) or DEFAULTS.REACH
    
    if State.shape == "Sphere" then
        visualizer.Shape = Enum.PartType.Ball
        visualizer.Size = Vector3.new(reach, reach, reach)
        visualizer.CFrame = handle.CFrame
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
               if hrp and (hrp.Position - handle.Position).Magnitude <= reach then
                    onHit(hrp, handle)
               end
            end
        end
    else
        local origin = (handle.CFrame * CFrame.new(0, 0, -2)).Position
        local direction = handle.CFrame.LookVector * -reach
        local ray = Ray.new(origin, direction)
        
        visualizer.Shape = Enum.PartType.Block
        visualizer.Size = Vector3.new(1, 0.8, reach)
        visualizer.CFrame = handle.CFrame * CFrame.new(0, 0, (reach/2) + 2)
        
        local whitelist = {}
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                local character = player.Character
                if character then
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("Part") then
                            table.insert(whitelist, part)
                        end
                    end
                end
            end
        end
        
        local part = workspace:FindPartOnRayWithWhitelist(ray, whitelist)
        if part then
            onHit(part, handle)
        end
    end
end)

-- Keybind to toggle GUI
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        gui.gui.Enabled = not gui.gui.Enabled
    end
end)

-- Start Kill After Respawn Logic
startKillAfterRespawn()
