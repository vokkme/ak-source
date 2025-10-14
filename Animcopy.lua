local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local RealAnimate = LocalPlayer.Character.Animate

local bodyParts = {"Head","UpperTorso","LowerTorso","LeftUpperArm","LeftLowerArm","LeftHand","RightUpperArm","RightLowerArm","RightHand","LeftUpperLeg","LeftLowerLeg","LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot"}

local ghostEnabled,originalCharacter,ghostClone,originalCFrame,originalAnimate,updateConn,preservedGuis,selectedPlayer,offsetDistance,minimized,searchText = false,nil,nil,nil,nil,nil,{},nil,2,false,""

-- New position mode variable
local positionMode = "right" -- "right", "left", "back", "front"

local function preserveGuis()
local pg = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
if not pg then return end
for _, gui in ipairs(pg:GetChildren()) do
if gui:IsA("ScreenGui") and gui.Name ~= "ReanimationGui" and gui.ResetOnSpawn then
table.insert(preservedGuis, gui)
gui.ResetOnSpawn = false
end
end
end

local function restoreGuis()
for _, gui in ipairs(preservedGuis) do
if gui and gui.Parent then gui.ResetOnSpawn = true end
end
table.clear(preservedGuis)
end

local function getPositionOffset(hrp)
if not hrp then return Vector3.new() end

local offset = Vector3.new()
if positionMode == "right" then
offset = hrp.CFrame.RightVector * offsetDistance
elseif positionMode == "left" then
offset = hrp.CFrame.RightVector * -offsetDistance
elseif positionMode == "back" then
offset = hrp.CFrame.LookVector * -offsetDistance
elseif positionMode == "front" then
offset = hrp.CFrame.LookVector * offsetDistance
end

return offset
end

local function updateRagdoll()
if not (ghostEnabled and originalCharacter and ghostClone and selectedPlayer and selectedPlayer.Character) then
if updateConn then updateConn:Disconnect() end
updateConn = nil
return
end

local tgt = selectedPlayer.Character
local hrp = tgt:FindFirstChild("HumanoidRootPart")
local posOffset = getPositionOffset(hrp)

local originalHRP = originalCharacter:FindFirstChild("HumanoidRootPart")
if originalHRP and hrp then
originalHRP.CFrame = hrp.CFrame + posOffset
originalHRP.AssemblyLinearVelocity = Vector3.zero
originalHRP.AssemblyAngularVelocity = Vector3.zero
end

for _, name in ipairs(bodyParts) do
local partO = originalCharacter:FindFirstChild(name)
local partT = tgt:FindFirstChild(name) or hrp
if partO and partT and partO:IsA("BasePart") and partT:IsA("BasePart") then
partO.CFrame = partT.CFrame + posOffset
partO.AssemblyLinearVelocity = Vector3.zero
partO.AssemblyAngularVelocity = Vector3.zero
end
end

if Workspace.CurrentCamera then
local hum = originalCharacter:FindFirstChildWhichIsA("Humanoid")
end
end

local function setGhost(state)
ghostEnabled = state
if state then
local ch = LocalPlayer.Character
if not (ch and ch:FindFirstChildWhichIsA("Humanoid") and ch:FindFirstChild("HumanoidRootPart")) or originalCharacter then return end

originalCharacter, originalCFrame = ch, ch.HumanoidRootPart.CFrame

ch.Archivable = true
ghostClone = ch:Clone()
ch.Archivable = false
ghostClone.Name = ch.Name .. "_ghost"

local gHum = ghostClone:FindFirstChildWhichIsA("Humanoid")
if gHum then gHum:ChangeState(Enum.HumanoidStateType.Physics) end
for _, d in ipairs(ghostClone:GetDescendants()) do
if d:IsA("BasePart") then d.Transparency, d.Anchored = 1, false
elseif d:IsA("Decal") then d.Transparency = 1
elseif d:IsA("Accessory") then
local h = d:FindFirstChild("Handle")
if h then h.Transparency = 1 end
end
end

originalAnimate = ch:FindFirstChild("Animate")
if originalAnimate then
originalAnimate.Disabled = true
originalAnimate:Clone().Parent = ghostClone
end

preserveGuis()
ghostClone.Parent = Workspace
LocalPlayer.Character = ghostClone
restoreGuis()

local args = {"Ball"}
game:GetService("ReplicatedStorage"):WaitForChild("Ragdoll"):FireServer(unpack(args))

updateConn = RunService.Heartbeat:Connect(updateRagdoll)
else
if updateConn then updateConn:Disconnect() end
updateConn = nil
if ReplicatedStorage:FindFirstChild("Unragdoll") then
for i = 1, 3 do
ReplicatedStorage.Unragdoll:FireServer()
task.wait(0.1)
end
end

local endCF = nil
if ghostClone and ghostClone:FindFirstChild("HumanoidRootPart") then
endCF = ghostClone.HumanoidRootPart.CFrame
end

if originalAnimate then
originalAnimate.Disabled = false
task.delay(0.1, function()
if originalAnimate and originalAnimate.Parent then
originalAnimate.Disabled = true
task.wait(0.05)
originalAnimate.Disabled = false
task.wait(0.05)
originalAnimate.Disabled = true
task.wait(0.05)
originalAnimate.Disabled = false
local hum = originalCharacter and originalCharacter:FindFirstChildWhichIsA("Humanoid")
if hum then
hum:ChangeState(Enum.HumanoidStateType.Landed)
task.wait(0.05)
hum:ChangeState(Enum.HumanoidStateType.GettingUp)
task.wait(0.05)
hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
end
end
end)
end

if ghostClone then
ghostClone:Destroy()
ghostClone = nil
end

if originalCharacter then
local root = originalCharacter:FindFirstChild("HumanoidRootPart")
if root and endCF then
root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
end

local hum = originalCharacter:FindFirstChildWhichIsA("Humanoid")
preserveGuis()
LocalPlayer.Character = originalCharacter
if hum then
hum:ChangeState(Enum.HumanoidStateType.GettingUp)
end
restoreGuis()
end

originalCharacter, originalAnimate = nil, nil
end
end

local function toggleMinimize(frame, content)
minimized = not minimized
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local targetSize = minimized and UDim2.new(0, 220, 0, 28) or UDim2.new(0, 220, 0, 380)
local sizeTween = TweenService:Create(frame, tweenInfo, {Size = targetSize})
sizeTween:Play()
sizeTween.Completed:Connect(function()
content.Visible = not minimized
end)
if not minimized then
content.Visible = true
end
end

local function matchesSearch(player)
if searchText == "" then return true end
local lower = searchText:lower()
return player.Name:lower():find(lower) or (player.DisplayName and player.DisplayName:lower():find(lower))
end

local function makeGui()
local pg = LocalPlayer:WaitForChild("PlayerGui")
local existingGui = pg:FindFirstChild("ReanimationGui")
if existingGui then existingGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "ReanimationGui"
gui.ResetOnSpawn = false
gui.DisplayOrder = 10
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = pg

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 380)
frame.Position = UDim2.new(0, 20, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.BackgroundTransparency = 0.7
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Name = "MainFrame"
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local taskbar = Instance.new("Frame")
taskbar.Size = UDim2.new(1, 0, 0, 32)
taskbar.Position = UDim2.new(0, 0, 0, 0)
taskbar.BackgroundTransparency = 1
taskbar.BorderSizePixel = 0
taskbar.Name = "Taskbar"
taskbar.Parent = frame

-- AK ADMIN label (top left, smaller)
local akLabel = Instance.new("TextLabel")
akLabel.Size = UDim2.new(0, 80, 0, 14)
akLabel.Position = UDim2.new(0, 8, 0, 2)
akLabel.BackgroundTransparency = 1
akLabel.Text = "AK ADMIN"
akLabel.TextColor3 = Color3.fromRGB(240,240,240)
akLabel.Font = Enum.Font.GothamBold
akLabel.TextSize = 9
akLabel.TextXAlignment = Enum.TextXAlignment.Left
akLabel.Parent = taskbar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -110, 0, 16)
title.Position = UDim2.new(0, 55, 0, 16)
title.BackgroundTransparency = 1
title.Text = "Anim Copier"
title.TextColor3 = Color3.fromRGB(240,240,240)
title.Font = Enum.Font.GothamSemibold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = taskbar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -50, 0, 4)
minBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
minBtn.BackgroundTransparency = 0.7
minBtn.Text = "−"
minBtn.TextSize = 14
minBtn.Font = Enum.Font.GothamBold
minBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
minBtn.BorderSizePixel = 0
minBtn.Name = "MinimizeButton"
minBtn.Parent = taskbar

local minBtnCorner = Instance.new("UICorner")
minBtnCorner.CornerRadius = UDim.new(0, 4)
minBtnCorner.Parent = minBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -26, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
closeBtn.BackgroundTransparency = 0.7
closeBtn.Text = "×"
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = taskbar

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 4)
closeBtnCorner.Parent = closeBtn

local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 1, -32)
content.Position = UDim2.new(0, 0, 0, 32)
content.BackgroundTransparency = 1
content.Name = "Content"
content.Parent = frame

-- Position Mode Selection
local lblPosition = Instance.new("TextLabel")
lblPosition.Size = UDim2.new(1, -16, 0, 16)
lblPosition.Position = UDim2.new(0, 8, 0, 8)
lblPosition.BackgroundTransparency = 1
lblPosition.Text = "Position: " .. positionMode:upper()
lblPosition.TextColor3 = Color3.fromRGB(200,200,200)
lblPosition.Font = Enum.Font.Gotham
lblPosition.TextSize = 11
lblPosition.Parent = content

-- Position buttons frame
local positionFrame = Instance.new("Frame")
positionFrame.Size = UDim2.new(1, -16, 0, 22)
positionFrame.Position = UDim2.new(0, 8, 0, 28)
positionFrame.BackgroundTransparency = 1
positionFrame.Parent = content

local positions = {"right", "left", "back", "front"}
local positionButtons = {}

for i, pos in ipairs(positions) do
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.23, 0, 0, 20)
btn.Position = UDim2.new((i-1) * 0.25, 0, 0, 0)
btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
btn.BackgroundTransparency = positionMode == pos and 0.5 or 0.7
btn.BorderSizePixel = 0
btn.Text = pos:upper()
btn.TextColor3 = Color3.fromRGB(240,240,240)
btn.Font = Enum.Font.GothamSemibold
btn.TextSize = 9
btn.Parent = positionFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btn

positionButtons[pos] = btn

btn.MouseButton1Click:Connect(function()
positionMode = pos
lblPosition.Text = "Position: " .. pos:upper()

-- Update button colors
for mode, button in pairs(positionButtons) do
button.BackgroundTransparency = mode == pos and 0.5 or 0.7
end
end)
end

local lblOffset = Instance.new("TextLabel")
lblOffset.Size = UDim2.new(1, -16, 0, 16)
lblOffset.Position = UDim2.new(0, 8, 0, 58)
lblOffset.BackgroundTransparency = 1
lblOffset.Text = string.format("Offset: %.1f", offsetDistance)
lblOffset.TextColor3 = Color3.fromRGB(200,200,200)
lblOffset.Font = Enum.Font.Gotham
lblOffset.TextSize = 11
lblOffset.Parent = content

local sliderBg = Instance.new("Frame")
sliderBg.Size = UDim2.new(1, -16, 0, 8)
sliderBg.Position = UDim2.new(0, 8, 0, 78)
sliderBg.BackgroundColor3 = Color3.fromRGB(0,0,0)
sliderBg.BackgroundTransparency = 0.6
sliderBg.BorderSizePixel = 0
sliderBg.Parent = content

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 4)
sliderCorner.Parent = sliderBg

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(offsetDistance/10, 0, 1, 0)
sliderFill.BorderSizePixel = 0
sliderFill.BackgroundColor3 = Color3.fromRGB(100,180,240)
sliderFill.BackgroundTransparency = 0.3
sliderFill.Parent = sliderBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 4)
fillCorner.Parent = sliderFill

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0, 16, 0, 16)
knob.Position = UDim2.new(offsetDistance/10, -8, 0.5, -8)
knob.BackgroundColor3 = Color3.fromRGB(180,180,180)
knob.BackgroundTransparency = 0.2
knob.BorderSizePixel = 0
knob.Parent = sliderBg

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(0, 8)
knobCorner.Parent = knob

local draggingKnob = false

knob.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
draggingKnob = true
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
draggingKnob = false
end
end)
end
end)

UserInputService.InputChanged:Connect(function(input)
if not draggingKnob then return end
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
local x = math.clamp(input.Position.X - sliderBg.AbsolutePosition.X, 0, sliderBg.AbsoluteSize.X)
local pct = x / sliderBg.AbsoluteSize.X
offsetDistance = math.floor((pct * 10)*10+0.5)/10
lblOffset.Text = string.format("Offset: %.1f", offsetDistance)
sliderFill.Size = UDim2.new(pct, 0, 1, 0)
knob.Position = UDim2.new(pct, -8, 0.5, -8)
end
end)

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -16, 0, 24)
searchBox.Position = UDim2.new(0, 8, 0, 94)
searchBox.BackgroundColor3 = Color3.fromRGB(0,0,0)
searchBox.BackgroundTransparency = 0.6
searchBox.BorderSizePixel = 0
searchBox.Text = ""
searchBox.PlaceholderText = "Search players..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150,150,150)
searchBox.TextColor3 = Color3.fromRGB(240,240,240)
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 11
searchBox.Parent = content

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 4)
searchCorner.Parent = searchBox

local scroll = Instance.new("ScrollingFrame")
scroll.Name = "PlayerList"
scroll.Size = UDim2.new(1, -16, 0, 180)
scroll.Position = UDim2.new(0, 8, 0, 126)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
scroll.ElasticBehavior = Enum.ElasticBehavior.Always
scroll.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 3)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 4)
end)

local function rebuild()
for _, child in pairs(scroll:GetChildren()) do
if child:IsA("TextButton") then
child:Destroy()
end
end

for _, pl in ipairs(Players:GetPlayers()) do
if pl ~= LocalPlayer and matchesSearch(pl) then
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -8, 0, 38)
btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
btn.BackgroundTransparency = 0.7
btn.BorderSizePixel = 0
btn.Text = ""
btn.LayoutOrder = pl.UserId
btn.AutoButtonColor = true
btn.Parent = scroll

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 4)
btnCorner.Parent = btn

local img = Instance.new("ImageLabel")
img.Size = UDim2.new(0, 28, 0, 28)
img.Position = UDim2.new(0, 5, 0.5, -14)
img.BackgroundTransparency = 1
img.Parent = btn

spawn(function()
pcall(function()
local thumb = Players:GetUserThumbnailAsync(pl.UserId,
Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
img.Image = thumb
end)
end)

local nameLbl = Instance.new("TextLabel")
nameLbl.Text = pl.DisplayName or pl.Name
nameLbl.Size = UDim2.new(0, 150, 0, 16)
nameLbl.Position = UDim2.new(0, 38, 0, 5)
nameLbl.BackgroundTransparency = 1
nameLbl.TextColor3 = Color3.fromRGB(240,240,240)
nameLbl.Font = Enum.Font.GothamSemibold
nameLbl.TextSize = 11
nameLbl.TextXAlignment = Enum.TextXAlignment.Left
nameLbl.Parent = btn

local userLbl = Instance.new("TextLabel")
userLbl.Text = "@"..pl.Name
userLbl.Size = UDim2.new(0, 150, 0, 13)
userLbl.Position = UDim2.new(0, 38, 0, 20)
userLbl.BackgroundTransparency = 1
userLbl.TextColor3 = Color3.fromRGB(150,150,150)
userLbl.Font = Enum.Font.Gotham
userLbl.TextSize = 9
userLbl.TextXAlignment = Enum.TextXAlignment.Left
userLbl.Parent = btn

btn.MouseButton1Click:Connect(function()
selectedPlayer = pl
for _, c in ipairs(scroll:GetChildren()) do
if c:IsA("TextButton") then
c.BackgroundColor3 = Color3.fromRGB(0,0,0)
c.BackgroundTransparency = 0.7
end
end
btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
btn.BackgroundTransparency = 0.5

if ghostEnabled then
if Workspace.CurrentCamera and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("UpperTorso") then
Workspace.CurrentCamera.CameraSubject = selectedPlayer.Character.UpperTorso
end
end
end)
end
end

scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 4)
end

searchBox.Changed:Connect(function()
if searchBox.Text ~= searchText then
searchText = searchBox.Text
rebuild()
end
end)

local btnToggle = Instance.new("TextButton")
btnToggle.Size = UDim2.new(1, -16, 0, 32)
btnToggle.Position = UDim2.new(0, 8, 0, 314)
btnToggle.Text = "Start Animation Copy"
btnToggle.Font = Enum.Font.GothamSemibold
btnToggle.TextSize = 12
btnToggle.TextColor3 = Color3.new(1,1,1)
btnToggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
btnToggle.BackgroundTransparency = 0.7
btnToggle.Active = false
btnToggle.AutoButtonColor = false
btnToggle.Parent = content

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btnToggle

btnToggle.MouseButton1Click:Connect(function()
if not selectedPlayer then
btnToggle.Text = "Select a player first"
wait(1)
btnToggle.Text = "Start Animation Copy"
return
end

setGhost(not ghostEnabled)
btnToggle.Text = ghostEnabled and "Stop Animation Copy" or "Start Animation Copy"

if not ghostEnabled then
RealAnimate.Disabled = true
RealAnimate.Enabled = false
wait(0.1)
RealAnimate.Disabled = false
RealAnimate.Enabled = true
wait(0.1)
RealAnimate.Disabled = true
RealAnimate.Enabled = false
wait(0.1)
RealAnimate.Disabled = false
RealAnimate.Enabled = true
end

btnToggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
btnToggle.BackgroundTransparency = 0.7
if ghostEnabled then
wait(2)
if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("UpperTorso") then
Workspace.CurrentCamera.CameraSubject = selectedPlayer.Character.UpperTorso
end
else
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
end
end
end)

local dragging, dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
if draggingKnob then return end

if (input.UserInputType == Enum.UserInputType.MouseButton1 or 
input.UserInputType == Enum.UserInputType.Touch) then
dragging = true
dragStart = input.Position
startPos = frame.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)

frame.InputChanged:Connect(function(input)
if draggingKnob then return end

if input.UserInputType == Enum.UserInputType.MouseMovement or
input.UserInputType == Enum.UserInputType.Touch then
dragInput = input
end
end)

UserInputService.InputChanged:Connect(function(input)
if draggingKnob then return end

if input == dragInput and dragging then
local delta = input.Position - dragStart
frame.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)

minBtn.MouseButton1Click:Connect(function()
toggleMinimize(frame, content)
end)

closeBtn.MouseButton1Click:Connect(function()
setGhost(false)
gui:Destroy()
end)

Players.PlayerAdded:Connect(rebuild)
Players.PlayerRemoving:Connect(function(pl)
if pl == selectedPlayer then 
selectedPlayer = nil
btnToggle.Text = "Start Animation Copy"
btnToggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
btnToggle.BackgroundTransparency = 0.7
btnToggle.Active = false
btnToggle.AutoButtonColor = false
end
rebuild()
end)

task.spawn(rebuild)

return gui
end

local gui = makeGui()

script.Destroying:Connect(function()
if ghostEnabled then setGhost(false) end
if gui then gui:Destroy() end
if updateConn then updateConn:Disconnect() end
end)
