local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ModifyEvent = ReplicatedStorage:WaitForChild("Modify")
local EventInputModifyEvent = ReplicatedStorage:WaitForChild("EventInputModify")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local SAVED_FILE = "saved_usernames.txt"
local KEYBIND_FILE = "username_keybinds.txt"

-- File Operations
local function saveUsername(username)
    if not pcall(function() readfile(SAVED_FILE) end) then
        writefile(SAVED_FILE, username)
    else
        local existing = readfile(SAVED_FILE)
        if not existing:find(username) then
            writefile(SAVED_FILE, existing.."\n"..username)
        end
    end
end

local function loadUsernames()
    if pcall(function() readfile(SAVED_FILE) end) then
        local usernames = {}
        for username in readfile(SAVED_FILE):gmatch("[^\n]+") do
            if username ~= "" then table.insert(usernames, username) end
        end
        return usernames
    end
    return {}
end

local function deleteUsername(username)
    if pcall(function() readfile(SAVED_FILE) end) then
        local usernames = {}
        for name in readfile(SAVED_FILE):gmatch("[^\n]+") do
            if name ~= username then table.insert(usernames, name) end
        end
        writefile(SAVED_FILE, table.concat(usernames, "\n"))
        
        -- Also delete keybind
        if pcall(function() readfile(KEYBIND_FILE) end) then
            local keybindContent = readfile(KEYBIND_FILE)
            local lines = {}
            for line in string.gmatch(keybindContent, "[^\n]+") do
                local storedUsername = line:match("^(.-):")
                if storedUsername ~= username then
                    table.insert(lines, line)
                end
            end
            writefile(KEYBIND_FILE, table.concat(lines, "\n"))
        end
    end
end

local function saveKeybind(username, keyCode)
    local content = ""
    if pcall(function() content = readfile(KEYBIND_FILE) end) then
        local lines = {}
        for line in string.gmatch(content, "[^\n]+") do
            local storedUsername = line:match("^(.-):")
            if storedUsername ~= username then
                table.insert(lines, line)
            end
        end
        content = table.concat(lines, "\n")
        if #content > 0 then content = content .. "\n" end
    end
    content = content .. username .. ":" .. tostring(keyCode.Value)
    writefile(KEYBIND_FILE, content)
end

local function getKeybindForUsername(username)
    if pcall(function() readfile(KEYBIND_FILE) end) then
        local content = readfile(KEYBIND_FILE)
        for line in string.gmatch(content, "[^\n]+") do
            local storedUsername, keyCodeValue = line:match("^(.-):(%d+)$")
            if storedUsername == username then
                return tonumber(keyCodeValue)
            end
        end
    end
    return nil
end

local function loadKeybinds()
    local keybinds = {}
    if pcall(function() readfile(KEYBIND_FILE) end) then
        local content = readfile(KEYBIND_FILE)
        for line in string.gmatch(content, "[^\n]+") do
            local username, keyCodeValue = line:match("^(.-):(%d+)$")
            if username and keyCodeValue then
                keybinds[tonumber(keyCodeValue)] = username
            end
        end
    end
    return keybinds
end

-- GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FitChangerPro"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 240, 0, 320)
main.Position = UDim2.new(0.5, -120, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BackgroundTransparency = 0.4
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 60)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.5
mainStroke.Parent = main

local isMinimized = false
local originalSize = main.Size

-- Header Section
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundTransparency = 1
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 30, 0, 0)
title.BackgroundTransparency = 1
title.Text = "FIT CHANGER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center
title.Parent = header

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 20, 0, 20)
minimizeBtn.Position = UDim2.new(1, -50, 0.5, -10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
minimizeBtn.BackgroundTransparency = 0.3
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 12
minimizeBtn.Parent = header
local minimizeBtnCorner = Instance.new("UICorner")
minimizeBtnCorner.CornerRadius = UDim.new(0, 4)
minimizeBtnCorner.Parent = minimizeBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -25, 0.5, -10)
closeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeBtn.BackgroundTransparency = 0.3
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.Parent = header
local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 4)
closeBtnCorner.Parent = closeBtn

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -40)
content.Position = UDim2.new(0, 10, 0, 35)
content.BackgroundTransparency = 1
content.Parent = main

-- Input Section
local inputSection = Instance.new("Frame")
inputSection.Size = UDim2.new(1, 0, 0, 45)
inputSection.Position = UDim2.new(0, 0, 0, 0)
inputSection.BackgroundTransparency = 1
inputSection.Parent = content

local inputLabel = Instance.new("TextLabel")
inputLabel.Size = UDim2.new(1, 0, 0, 12)
inputLabel.Position = UDim2.new(0, 0, 0, 0)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "USERNAME"
inputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
inputLabel.Font = Enum.Font.Gotham
inputLabel.TextSize = 9
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = inputSection

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, 0, 0, 22)
inputBox.Position = UDim2.new(0, 0, 0, 15)
inputBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
inputBox.BackgroundTransparency = 0.5
inputBox.BorderSizePixel = 0
inputBox.PlaceholderText = "Enter username..."
inputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
inputBox.Text = ""
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 11
inputBox.Parent = inputSection
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 4)
inputCorner.Parent = inputBox

-- Action Buttons Section
local actionsSection = Instance.new("Frame")
actionsSection.Size = UDim2.new(1, 0, 0, 70)
actionsSection.Position = UDim2.new(0, 0, 0, 55)
actionsSection.BackgroundTransparency = 1
actionsSection.Parent = content

local actionsLabel = Instance.new("TextLabel")
actionsLabel.Size = UDim2.new(1, 0, 0, 12)
actionsLabel.Position = UDim2.new(0, 0, 0, 0)
actionsLabel.BackgroundTransparency = 1
actionsLabel.Text = "ACTIONS"
actionsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
actionsLabel.Font = Enum.Font.Gotham
actionsLabel.TextSize = 9
actionsLabel.TextXAlignment = Enum.TextXAlignment.Left
actionsLabel.Parent = actionsSection

local changeBtn = Instance.new("TextButton")
changeBtn.Size = UDim2.new(0.48, 0, 0, 20)
changeBtn.Position = UDim2.new(0, 0, 0, 15)
changeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
changeBtn.BackgroundTransparency = 0.5
changeBtn.BorderSizePixel = 0
changeBtn.Text = "Change Fit"
changeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
changeBtn.Font = Enum.Font.Gotham
changeBtn.TextSize = 10
changeBtn.Parent = actionsSection
local changeBtnCorner = Instance.new("UICorner")
changeBtnCorner.CornerRadius = UDim.new(0, 4)
changeBtnCorner.Parent = changeBtn

local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.48, 0, 0, 20)
resetBtn.Position = UDim2.new(0.52, 0, 0, 15)
resetBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
resetBtn.BackgroundTransparency = 0.5
resetBtn.BorderSizePixel = 0
resetBtn.Text = "Reset Fit"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.Font = Enum.Font.Gotham
resetBtn.TextSize = 10
resetBtn.Parent = actionsSection
local resetBtnCorner = Instance.new("UICorner")
resetBtnCorner.CornerRadius = UDim.new(0, 4)
resetBtnCorner.Parent = resetBtn

local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.48, 0, 0, 20)
saveBtn.Position = UDim2.new(0, 0, 0, 40)
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
saveBtn.BackgroundTransparency = 0.5
saveBtn.BorderSizePixel = 0
saveBtn.Text = "Save Username"
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.Font = Enum.Font.Gotham
saveBtn.TextSize = 10
saveBtn.Parent = actionsSection
local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0, 4)
saveBtnCorner.Parent = saveBtn

local useMyBtn = Instance.new("TextButton")
useMyBtn.Size = UDim2.new(0.48, 0, 0, 20)
useMyBtn.Position = UDim2.new(0.52, 0, 0, 40)
useMyBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
useMyBtn.BackgroundTransparency = 0.5
useMyBtn.BorderSizePixel = 0
useMyBtn.Text = "Use My Name"
useMyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
useMyBtn.Font = Enum.Font.Gotham
useMyBtn.TextSize = 10
useMyBtn.Parent = actionsSection
local useMyBtnCorner = Instance.new("UICorner")
useMyBtnCorner.CornerRadius = UDim.new(0, 4)
useMyBtnCorner.Parent = useMyBtn

-- Saved Section
local savedSection = Instance.new("Frame")
savedSection.Size = UDim2.new(1, 0, 0, 130)
savedSection.Position = UDim2.new(0, 0, 0, 135)
savedSection.BackgroundTransparency = 1
savedSection.Parent = content

local savedLabel = Instance.new("TextLabel")
savedLabel.Size = UDim2.new(1, 0, 0, 12)
savedLabel.Position = UDim2.new(0, 0, 0, 0)
savedLabel.BackgroundTransparency = 1
savedLabel.Text = "SAVED USERNAMES"
savedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
savedLabel.Font = Enum.Font.Gotham
savedLabel.TextSize = 9
savedLabel.TextXAlignment = Enum.TextXAlignment.Left
savedLabel.Parent = savedSection

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 0, 110)
scrollFrame.Position = UDim2.new(0, 0, 0, 15)
scrollFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
scrollFrame.BackgroundTransparency = 0.6
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 2
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
scrollFrame.Parent = savedSection
local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 4)
scrollCorner.Parent = scrollFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 2)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrollFrame

-- Keybind system variables
local currentBindingUsername = nil
local keybindConnection = nil

-- Notification
local function notify(message)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1, -20, 0, 18)
    notif.Position = UDim2.new(0, 10, 1, -25)
    notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notif.BackgroundTransparency = 0.3
    notif.BorderSizePixel = 0
    notif.Parent = main
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 4)
    notifCorner.Parent = notif
    
    local notifText = Instance.new("TextLabel")
    notifText.Size = UDim2.new(1, -10, 1, 0)
    notifText.Position = UDim2.new(0, 5, 0, 0)
    notifText.BackgroundTransparency = 1
    notifText.Text = message
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.Font = Enum.Font.Gotham
    notifText.TextSize = 9
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.TextYAlignment = Enum.TextYAlignment.Center
    notifText.Parent = notif
    
    wait(1.5)
    TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TweenService:Create(notifText, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    wait(0.3)
    notif:Destroy()
end

local function updateList()
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    for i, username in ipairs(loadUsernames()) do
        local item = Instance.new("Frame")
        item.Size = UDim2.new(1, -3, 0, 18)
        item.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        item.BackgroundTransparency = 0.7
        item.BorderSizePixel = 0
        item.LayoutOrder = i
        item.Parent = scrollFrame
        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 3)
        itemCorner.Parent = item
        
        local nameBtn = Instance.new("TextButton")
        nameBtn.Size = UDim2.new(0.45, 0, 1, 0)
        nameBtn.Position = UDim2.new(0, 5, 0, 0)
        nameBtn.BackgroundTransparency = 1
        nameBtn.Text = username
        nameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameBtn.Font = Enum.Font.Gotham
        nameBtn.TextSize = 9
        nameBtn.TextXAlignment = Enum.TextXAlignment.Left
        nameBtn.TextYAlignment = Enum.TextYAlignment.Center
        nameBtn.Parent = item
        
        local keyCodeValue = getKeybindForUsername(username)
        local keybindText = "Key"
        if keyCodeValue then
            for _, enum in pairs(Enum.KeyCode:GetEnumItems()) do
                if enum.Value == keyCodeValue then
                    keybindText = enum.Name
                    break
                end
            end
        end
        
        -- Check if this username is currently being bound
        if currentBindingUsername == username then
            keybindText = "..."
        end
        
        local keybindBtn = Instance.new("TextButton")
        keybindBtn.Size = UDim2.new(0.25, -2, 0, 12)
        keybindBtn.Position = UDim2.new(0.45, 0, 0.5, -6)
        keybindBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        keybindBtn.BackgroundTransparency = 0.5
        keybindBtn.BorderSizePixel = 0
        keybindBtn.Text = keybindText
        keybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        keybindBtn.Font = Enum.Font.Gotham
        keybindBtn.TextSize = 8
        keybindBtn.Parent = item
        local keybindCorner = Instance.new("UICorner")
        keybindCorner.CornerRadius = UDim.new(0, 2)
        keybindCorner.Parent = keybindBtn
        
        local deleteBtn = Instance.new("TextButton")
        deleteBtn.Size = UDim2.new(0.25, -3, 0, 12)
        deleteBtn.Position = UDim2.new(0.75, 0, 0.5, -6)
        deleteBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        deleteBtn.BackgroundTransparency = 0.5
        deleteBtn.BorderSizePixel = 0
        deleteBtn.Text = "Delete"
        deleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        deleteBtn.Font = Enum.Font.Gotham
        deleteBtn.TextSize = 8
        deleteBtn.Parent = item
        local deleteBtnCorner = Instance.new("UICorner")
        deleteBtnCorner.CornerRadius = UDim.new(0, 2)
        deleteBtnCorner.Parent = deleteBtn
        
        nameBtn.MouseButton1Click:Connect(function()
            if username == player.Name then
                ModifyEvent:FireServer(player.Name)
                spawn(function() notify("Reset to original fit") end)
            else
                EventInputModifyEvent:FireServer(username)
                spawn(function() notify("Changed to " .. username) end)
            end
        end)
        
        keybindBtn.MouseButton1Click:Connect(function()
            -- Cancel any existing keybind operation
            if keybindConnection then
                keybindConnection:Disconnect()
                keybindConnection = nil
            end
            
            -- Start new keybind operation
            currentBindingUsername = username
            updateList() -- Refresh to show "..." text
            spawn(function() notify("Press key to bind to " .. username) end)
            
            keybindConnection = UserInputService.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    saveKeybind(username, input.KeyCode)
                    currentBindingUsername = nil
                    keybindConnection:Disconnect()
                    keybindConnection = nil
                    updateList() -- Refresh to show the new key
                    spawn(function() notify("Bound " .. username .. " to " .. input.KeyCode.Name) end)
                end
            end)
        end)
        
        deleteBtn.MouseButton1Click:Connect(function()
            deleteUsername(username)
            updateList()
            spawn(function() notify("Deleted " .. username) end)
        end)
        
        item.MouseEnter:Connect(function()
            TweenService:Create(item, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
        end)
        
        item.MouseLeave:Connect(function()
            TweenService:Create(item, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
        end)
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 3)
end

-- Events
minimizeBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        TweenService:Create(main, TweenInfo.new(0.3), {Size = originalSize}):Play()
        content.Visible = true
        minimizeBtn.Text = "–"
    else
        TweenService:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0, 240, 0, 30)}):Play()
        content.Visible = false
        minimizeBtn.Text = "+"
    end
    isMinimized = not isMinimized
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

changeBtn.MouseButton1Click:Connect(function()
    local username = inputBox.Text:gsub("^%s*(.-)%s*$", "%1")
    if username ~= "" then
        if username == player.Name then
            ModifyEvent:FireServer(player.Name)
            spawn(function() notify("Reset to original fit") end)
        else
            EventInputModifyEvent:FireServer(username)
            spawn(function() notify("Changed to " .. username) end)
        end
    else
        spawn(function() notify("Enter a username") end)
    end
end)

resetBtn.MouseButton1Click:Connect(function()
    ModifyEvent:FireServer(player.Name)
    spawn(function() notify("Reset to original fit") end)
end)

saveBtn.MouseButton1Click:Connect(function()
    local username = inputBox.Text:gsub("^%s*(.-)%s*$", "%1")
    if username ~= "" then
        saveUsername(username)
        updateList()
        spawn(function() notify("Saved " .. username) end)
    else
        spawn(function() notify("Enter a username") end)
    end
end)

useMyBtn.MouseButton1Click:Connect(function()
    inputBox.Text = player.Name
    spawn(function() notify("Set to your name") end)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Don't process keybinds if we're currently binding a key
    if currentBindingUsername then return end
    
    if input.KeyCode == Enum.KeyCode.Return and inputBox:IsFocused() then
        local username = inputBox.Text:gsub("^%s*(.-)%s*$", "%1")
        if username ~= "" then
            if username == player.Name then
                ModifyEvent:FireServer(player.Name)
                spawn(function() notify("Reset to original fit") end)
            else
                EventInputModifyEvent:FireServer(username)
                spawn(function() notify("Changed to " .. username) end)
            end
        end
    else
        local keybinds = loadKeybinds()
        local username = keybinds[input.KeyCode.Value]
        if username then
            if username == player.Name then
                ModifyEvent:FireServer(player.Name)
                spawn(function() notify("Reset to original fit (Key: " .. input.KeyCode.Name .. ")") end)
            else
                EventInputModifyEvent:FireServer(username)
                spawn(function() notify("Changed to " .. username .. " (Key: " .. input.KeyCode.Name .. ")") end)
            end
        end
    end
end)

-- Hover effects
for _, btn in pairs({changeBtn, resetBtn, saveBtn, useMyBtn, minimizeBtn, closeBtn}) do
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)
end

updateList()
