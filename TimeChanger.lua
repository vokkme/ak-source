if game.CoreGui:FindFirstChild("TimeSliderGui") then game.CoreGui.TimeSliderGui:Destroy() end
local sg = Instance.new("ScreenGui")
sg.Name = "TimeSliderGui"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = game.CoreGui

local mf = Instance.new("Frame")
mf.Name = "MainFrame"
mf.Size = UDim2.new(0, 180, 0, 100)
mf.Position = UDim2.new(0.5, 0, 0, 20)
mf.AnchorPoint = Vector2.new(0.5, 0)
mf.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mf.BackgroundTransparency = 0.5
mf.BorderSizePixel = 0
mf.Parent = sg

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0, 10)
c1.Parent = mf

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -8, 0, 4)
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mf

local c5 = Instance.new("UICorner")
c5.CornerRadius = UDim.new(1, 0)
c5.Parent = closeBtn

local tl = Instance.new("TextLabel")
tl.Name = "TimeLabel"
tl.Size = UDim2.new(1, -20, 0, 25)
tl.Position = UDim2.new(0, 10, 0, 10)
tl.BackgroundTransparency = 1
tl.Text = "Time: 12:00"
tl.TextSize = 16
tl.TextColor3 = Color3.fromRGB(255, 255, 255)
tl.Font = Enum.Font.GothamBold
tl.TextXAlignment = Enum.TextXAlignment.Center
tl.Parent = mf

local st = Instance.new("Frame")
st.Name = "SliderTrack"
st.Size = UDim2.new(1, -40, 0, 4)
st.Position = UDim2.new(0, 20, 0, 48)
st.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
st.BorderSizePixel = 0
st.Parent = mf

local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(1, 0)
c2.Parent = st

local sb = Instance.new("TextLabel")
sb.Name = "SliderButton"
sb.Size = UDim2.new(0, 16, 0, 16)
sb.Position = UDim2.new(0, 20, 0, 42)
sb.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
sb.BorderSizePixel = 0
sb.Text = "🕒"
sb.TextSize = 14
sb.TextColor3 = Color3.fromRGB(255, 255, 255)
sb.Font = Enum.Font.SourceSans
sb.Parent = mf

local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(1, 0)
c3.Parent = sb

local cb = Instance.new("TextButton")
cb.Name = "CycleButton"
cb.Size = UDim2.new(0, 70, 0, 24)
cb.Position = UDim2.new(0.5, 0, 0, 68)
cb.AnchorPoint = Vector2.new(0.5, 0)
cb.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
cb.BorderSizePixel = 0
cb.Text = "Real Time"
cb.TextSize = 13
cb.TextColor3 = Color3.fromRGB(255, 255, 255)
cb.Font = Enum.Font.GothamBold
cb.Parent = mf

local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 6)
c4.Parent = cb

-- Dragging variables
local dragging = false
local dragInput
local dragStart
local startPos

local d = false
local t = 12
local cy = false
local cc = nil
local realTimeConnection = nil

local uis = game:GetService("UserInputService")

-- Real-time update function
local function updateRealTime()
	local dt = os.date("*t")
	local currentTime = dt.hour + (dt.min / 60) + (dt.sec / 3600)
	t = currentTime
	
	local trackWidth = st.AbsoluteSize.X
	local p = t / 24
	sb.Position = UDim2.new(0, st.Position.X.Offset + (p * trackWidth) - 8, 0, 42)
	local h = math.floor(t)
	local m = math.floor((t - h) * 60)
	tl.Text = string.format("Time: %02d:%02d", h, m)
end

local function u(v)
	t = math.clamp(v, 0, 24)
	if t == 24 then t = 0 end
	game.Lighting.ClockTime = t
	local trackWidth = st.AbsoluteSize.X
	local p = t / 24
	sb.Position = UDim2.new(0, st.Position.X.Offset + (p * trackWidth) - 8, 0, 42)
	local h = math.floor(t)
	local m = math.floor((t - h) * 60)
	tl.Text = string.format("Time: %02d:%02d", h, m)
end

local function tc()
	cy = not cy
	if cy then
		cb.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
		cb.Text = "Stop"
		
		-- Start real-time sync
		realTimeConnection = game:GetService("RunService").Heartbeat:Connect(function()
			updateRealTime()
			game.Lighting.ClockTime = t
		end)
	else
		cb.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		cb.Text = "Real Time"
		if realTimeConnection then
			realTimeConnection:Disconnect()
			realTimeConnection = nil
		end
	end
end

cb.MouseButton1Click:Connect(tc)

-- Close button functionality
closeBtn.MouseButton1Click:Connect(function()
	if realTimeConnection then
		realTimeConnection:Disconnect()
	end
	sg:Destroy()
end)

-- Dragging functionality
local function updateDrag(input)
	local delta = input.Position - dragStart
	mf.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mf.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
    if d then return end
        dragging = true
		dragStart = input.Position
		startPos = mf.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mf.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

uis.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		updateDrag(input)
	end
end)

-- Slider functionality
sb.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		d = true
		if cy then tc() end
	end
end)

st.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		d = true
		if cy then tc() end
		local mp = uis:GetMouseLocation().X
		local rp = (mp - st.AbsolutePosition.X) / st.AbsoluteSize.X
		local nt = rp * 24
		u(nt)
	end
end)

uis.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		d = false
	end
end)

uis.InputChanged:Connect(function(i)
	if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
		local mp = uis:GetMouseLocation().X
		local rp = (mp - st.AbsolutePosition.X) / st.AbsoluteSize.X
		local nt = rp * 24
		u(nt)
	end
end)

u(12)
