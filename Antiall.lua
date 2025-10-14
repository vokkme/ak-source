local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Character, Humanoid, RootPart
local Camera = workspace.CurrentCamera
local IsVoiding = false
local AutoVoidEnabled = false

-- Prevent objects from being destroyed by the void
workspace.FallenPartsDestroyHeight = math.huge * -1

-- Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TitleBar = Instance.new("Frame")
local TitleCorner = Instance.new("UICorner")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local CloseCorner = Instance.new("UICorner")
local VoidButton = Instance.new("TextButton")
local VoidCorner = Instance.new("UICorner")
local ToggleButton = Instance.new("TextButton")
local ToggleCorner = Instance.new("UICorner")

ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.Name = "VoidGui"
ScreenGui.ResetOnSpawn = false

-- Main Frame Setup
MainFrame.Parent = ScreenGui
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 180, 0, 100)
MainFrame.Position = UDim2.new(0.5, -90, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.6
MainFrame.BorderSizePixel = 0

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 12)

-- Title Bar (Completely Invisible)
TitleBar.Parent = MainFrame
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundTransparency = 1
TitleBar.BorderSizePixel = 0

TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0, 12)

TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Anti All"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.Arial
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Close Button
CloseButton.Parent = TitleBar
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -23, 0, 2.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.BackgroundTransparency = 0.5
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.Arial
CloseButton.TextSize = 16

CloseCorner.Parent = CloseButton
CloseCorner.CornerRadius = UDim.new(0, 6)

-- Void Button
VoidButton.Parent = MainFrame
VoidButton.Name = "VoidButton"
VoidButton.Size = UDim2.new(0, 160, 0, 28)
VoidButton.Position = UDim2.new(0, 10, 0, 32)
VoidButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
VoidButton.BackgroundTransparency = 0.7
VoidButton.BorderSizePixel = 0
VoidButton.Text = "Kill Fucker"
VoidButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VoidButton.Font = Enum.Font.Arial
VoidButton.TextSize = 14

VoidCorner.Parent = VoidButton
VoidCorner.CornerRadius = UDim.new(0, 8)

-- Toggle Button
ToggleButton.Parent = MainFrame
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 160, 0, 28)
ToggleButton.Position = UDim2.new(0, 10, 0, 65)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.7
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "Auto: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.Arial
ToggleButton.TextSize = 14

ToggleCorner.Parent = ToggleButton
ToggleCorner.CornerRadius = UDim.new(0, 8)

-- Dragging System (Works for PC and Mobile)
local dragging = false
local dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Close Button Function
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Void Teleport Function
local function VoidTeleport()
    workspace.Camera.CameraType = Enum.CameraType.Fixed
    local HRoot = Player.Character.Humanoid.RootPart
    local Pos = HRoot.CFrame
    HRoot.CFrame = Pos + Vector3.new(0, -1e3, 0)
    task.wait(0.1)
    HRoot.CFrame = Pos
    workspace.Camera.CameraType = Enum.CameraType.Custom
end

local function VoidAndReturn()
    Character = Player.Character
    Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
    RootPart = Humanoid and Humanoid.RootPart
    
    if RootPart and Humanoid and not IsVoiding then
        IsVoiding = true
        VoidTeleport()
        task.wait(0.2)
        IsVoiding = false
    end
end

-- Manual Void Button
VoidButton.MouseButton1Click:Connect(VoidAndReturn)

-- Toggle Auto Void
ToggleButton.MouseButton1Click:Connect(function()
    AutoVoidEnabled = not AutoVoidEnabled
    
    if AutoVoidEnabled then
        ToggleButton.Text = "Auto: ON"
        ToggleButton.BackgroundTransparency = 0.5
    else
        ToggleButton.Text = "Auto: OFF"
        ToggleButton.BackgroundTransparency = 0.7
    end
end)

-- Improved Auto Void Detection with Region3 (Smaller Radius)
local lastTouchCheck = tick()
local touchCooldown = 0.1

local function IsPlayerTouching()
    if tick() - lastTouchCheck < touchCooldown then
        return false
    end
    
    Character = Player.Character
    if not Character then return false end
    
    RootPart = Character:FindFirstChild("HumanoidRootPart")
    if not RootPart then return false end
    
    -- Create a much smaller region around the character (0.5 studs)
    local region = Region3.new(
        RootPart.Position - Vector3.new(0.5, 0.5, 0.5),
        RootPart.Position + Vector3.new(0.5, 0.5, 0.5)
    )
    region = region:ExpandToGrid(4)
    
    -- Find all parts in region
    local partsInRegion = workspace:FindPartsInRegion3(region, Character, 100)
    
    for _, part in pairs(partsInRegion) do
        if part.Parent and part.Parent ~= Character then
            local otherHumanoid = part.Parent:FindFirstChildWhichIsA("Humanoid")
            if otherHumanoid and otherHumanoid.Health > 0 then
                local otherPlayer = Players:GetPlayerFromCharacter(part.Parent)
                if otherPlayer and otherPlayer ~= Player then
                    lastTouchCheck = tick()
                    return true
                end
            end
        end
    end
    
    return false
end

-- Auto Void Loop
RunService.Heartbeat:Connect(function()
    if AutoVoidEnabled and not IsVoiding then
        if IsPlayerTouching() then
            VoidAndReturn()
        end
    end
end)
