-- Enhanced Gui with Modern UI
-- Version: 4.0

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Instances
local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local Box = Instance.new("TextBox")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local Button = Instance.new("TextButton")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local ViewButton = Instance.new("TextButton")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")

-- Properties
Gui.Name = "UnanchoredFlingGUI"
Gui.Parent = gethui()
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.ResetOnSpawn = false

-- Main Frame
Main.Name = "Main"
Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BackgroundTransparency = 0.6
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.4, 0, 0.35, 0)
Main.Size = UDim2.new(0, 250, 0, 200)
Main.ClipsDescendants = true
Main.Active = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

-- Top Bar
TopBar.Name = "TopBar"
TopBar.Parent = Main
TopBar.BackgroundTransparency = 1
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.Active = true

-- Title
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Unanchor Fling"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Close Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.BackgroundTransparency = 0.4
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -30, 0.5, -10)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Minimize Button
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TopBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.BackgroundTransparency = 0.4
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -55, 0.5, -10)
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Content Frame
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = Main
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.Size = UDim2.new(1, 0, 1, -35)

-- Text Box
Box.Name = "Box"
Box.Parent = ContentFrame
Box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Box.BackgroundTransparency = 0.5
Box.BorderSizePixel = 0
Box.Position = UDim2.new(0.1, 0, 0.08, 0)
Box.Size = UDim2.new(0.8, 0, 0, 30)
Box.Font = Enum.Font.Gotham
Box.PlaceholderText = "Enter player name..."
Box.Text = ""
Box.TextColor3 = Color3.fromRGB(255, 255, 255)
Box.TextSize = 12
Box.ClearTextOnFocus = false

UITextSizeConstraint.Parent = Box
UITextSizeConstraint.MaxTextSize = 12

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = Box

-- Fling Button
Button.Name = "Button"
Button.Parent = ContentFrame
Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button.BackgroundTransparency = 0.5
Button.BorderSizePixel = 0
Button.Position = UDim2.new(0.1, 0, 0.35, 0)
Button.Size = UDim2.new(0.8, 0, 0, 35)
Button.Font = Enum.Font.GothamBold
Button.Text = "Unanchor Fling | Off"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextSize = 13

UITextSizeConstraint_2.Parent = Button
UITextSizeConstraint_2.MaxTextSize = 13

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = Button

-- View Button
ViewButton.Name = "ViewButton"
ViewButton.Parent = ContentFrame
ViewButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ViewButton.BackgroundTransparency = 0.5
ViewButton.BorderSizePixel = 0
ViewButton.Position = UDim2.new(0.1, 0, 0.65, 0)
ViewButton.Size = UDim2.new(0.8, 0, 0, 35)
ViewButton.Font = Enum.Font.GothamBold
ViewButton.Text = "View Target | Off"
ViewButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ViewButton.TextSize = 13

UITextSizeConstraint_3.Parent = ViewButton
UITextSizeConstraint_3.MaxTextSize = 13

local ViewButtonCorner = Instance.new("UICorner")
ViewButtonCorner.CornerRadius = UDim.new(0, 8)
ViewButtonCorner.Parent = ViewButton

-- Variables
local character
local humanoidRootPart
local isMinimized = false
local originalSize = Main.Size
local minimizedSize = UDim2.new(0, 250, 0, 35)

-- Enhanced Network Control (Stronger + Extended Range)
if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {},
		Velocity = Vector3.new(25, 25, 25), -- Increased from 14.46
		Force = 999999 -- Increased force
	}

	Network.RetainPart = function(Part)
		if Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
			table.insert(Network.BaseParts, Part)
			Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			Part.CanCollide = false
		end
	end

	local function EnablePartControl()
		LocalPlayer.ReplicationFocus = Workspace
		RunService.Heartbeat:Connect(function()
			sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
			sethiddenproperty(LocalPlayer, "MaxSimulationRadius", math.huge)
			for _, Part in pairs(Network.BaseParts) do
				if Part:IsDescendantOf(Workspace) then
					Part.Velocity = Network.Velocity
				end
			end
		end)
	end

	EnablePartControl()
end

-- Workspace Setup
local Folder = Instance.new("Folder", Workspace)
local Part = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", Part)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1

-- Enhanced Force Function (Stronger)
local function ForcePart(v)
	if v:IsA("BasePart") and not v.Anchored and not v.Parent:FindFirstChildOfClass("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
		if v:IsDescendantOf(LocalPlayer.Character) then
			return
		end
		for _, x in ipairs(v:GetChildren()) do
			if x:IsA("BodyMover") or x:IsA("RocketPropulsion") then
				x:Destroy()
			end
		end
		if v:FindFirstChild("Attachment") then
			v:FindFirstChild("Attachment"):Destroy()
		end
		if v:FindFirstChild("AlignPosition") then
			v:FindFirstChild("AlignPosition"):Destroy()
		end
		if v:FindFirstChild("Torque") then
			v:FindFirstChild("Torque"):Destroy()
		end
		v.CanCollide = false
		local Torque = Instance.new("Torque", v)
		Torque.Torque = Vector3.new(200000, 200000, 200000) -- Doubled torque
		local AlignPosition = Instance.new("AlignPosition", v)
		local Attachment2 = Instance.new("Attachment", v)
		Torque.Attachment0 = Attachment2
		AlignPosition.MaxForce = math.huge
		AlignPosition.MaxVelocity = math.huge
		AlignPosition.Responsiveness = 500 -- Increased from 200
		AlignPosition.Attachment0 = Attachment2
		AlignPosition.Attachment1 = Attachment1
	end
end

local blackHoleActive = false
local DescendantAddedConnection

local function toggleBlackHole()
	blackHoleActive = not blackHoleActive
	if blackHoleActive then
		Button.Text = "Unanchor Fling | On"
		Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Button.BackgroundTransparency = 0.3
		
		for _, v in ipairs(Workspace:GetDescendants()) do
			ForcePart(v)
		end

		DescendantAddedConnection = Workspace.DescendantAdded:Connect(function(v)
			if blackHoleActive then
				ForcePart(v)
			end
		end)

		spawn(function()
			while blackHoleActive and RunService.RenderStepped:Wait() do
				if humanoidRootPart then
					Attachment1.WorldCFrame = humanoidRootPart.CFrame
				end
			end
		end)
	else
		Button.Text = "Unanchor Fling | Off"
		Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Button.BackgroundTransparency = 0.5
		if DescendantAddedConnection then
			DescendantAddedConnection:Disconnect()
		end
	end
end

local function getPlayer(name)
	local lowerName = string.lower(name)
	local bestMatch = nil
	local bestMatchLength = math.huge

	for _, p in ipairs(Players:GetPlayers()) do
		local playerName = string.lower(p.Name)
		local lowerDisplayName = string.lower(p.DisplayName)

		if string.sub(playerName, 1, #lowerName) == lowerName or string.sub(lowerDisplayName, 1, #lowerName) == lowerName then
			local matchLength = math.min(#lowerName, #playerName)
			if matchLength < bestMatchLength then
				bestMatch = p
				bestMatchLength = matchLength
			end
		end
	end

	return bestMatch
end

local function onButtonClicked()
	local playerName = Box.Text
	if playerName ~= "" then
		local targetPlayer = getPlayer(playerName)
		if targetPlayer then
			Box.Text = targetPlayer.Name
			local function applyBallFling(targetCharacter)
				humanoidRootPart = targetCharacter:WaitForChild("HumanoidRootPart")
				toggleBlackHole()
			end

			local targetCharacter = targetPlayer.Character
			if targetCharacter then
				applyBallFling(targetCharacter)
			else
				Box.Text = "Player not found"
			end

			targetPlayer.CharacterAdded:Connect(function(newCharacter)
				applyBallFling(newCharacter)
			end)
		else
			Box.Text = "Player not found"
		end
	end
end

-- View functionality
local viewing = false
local camera = Workspace.CurrentCamera

ViewButton.MouseButton1Click:Connect(function()
	viewing = not viewing
	local playerName = Box.Text
	local targetPlayer = getPlayer(playerName)
	if viewing then
		if targetPlayer and targetPlayer.Character then
			ViewButton.Text = "View Target | On"
			ViewButton.BackgroundTransparency = 0.3
			camera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid")
			targetPlayer.CharacterAdded:Connect(function(newCharacter)
				if viewing then
					camera.CameraSubject = newCharacter:FindFirstChild("Humanoid")
				end
			end)
		else
			ViewButton.Text = "Player not found"
			viewing = false
		end
	else
		ViewButton.Text = "View Target | Off"
		ViewButton.BackgroundTransparency = 0.5
		camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
	end
end)

-- Minimize functionality with tween
MinimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	if isMinimized then
		local tween = TweenService:Create(Main, tweenInfo, {Size = minimizedSize})
		tween:Play()
		MinimizeButton.Text = "+"
		ContentFrame.Visible = false
	else
		local tween = TweenService:Create(Main, tweenInfo, {Size = originalSize})
		tween:Play()
		MinimizeButton.Text = "—"
		ContentFrame.Visible = true
	end
end)

-- Close functionality
CloseButton.MouseButton1Click:Connect(function()
	Gui:Destroy()
end)

-- Button click
Button.MouseButton1Click:Connect(onButtonClicked)

-- Dragging functionality (works for both PC and Mobile)
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TopBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragging then
			update(input)
		end
	end
end)

-- Hotkey to toggle GUI (Right Control)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessedEvent then
		Main.Visible = not Main.Visible
	end
end)
