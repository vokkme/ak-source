local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FriendDetectorPro"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -200)
MainFrame.Size = UDim2.new(0, 280, 0, 400)
MainFrame.Active = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Parent = ScreenGui
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.7
Shadow.BorderSizePixel = 0
Shadow.Position = UDim2.new(0.5, -142, 0.5, -198)
Shadow.Size = UDim2.new(0, 284, 0, 404)
Shadow.ZIndex = MainFrame.ZIndex - 1

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 12)
ShadowCorner.Parent = Shadow

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 45)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Parent = Header
HeaderFix.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
HeaderFix.BorderSizePixel = 0
HeaderFix.Position = UDim2.new(0, 0, 0.7, 0)
HeaderFix.Size = UDim2.new(1, 0, 0.3, 0)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0.75, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Friend Checker"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextYAlignment = Enum.TextYAlignment.Center

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = Header
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -30, 0.5, -10)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local StatusBar = Instance.new("Frame")
StatusBar.Name = "StatusBar"
StatusBar.Parent = MainFrame
StatusBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
StatusBar.BorderSizePixel = 0
StatusBar.Position = UDim2.new(0, 0, 0, 45)
StatusBar.Size = UDim2.new(1, 0, 0, 30)

local PlayerCount = Instance.new("TextLabel")
PlayerCount.Name = "PlayerCount"
PlayerCount.Parent = StatusBar
PlayerCount.BackgroundTransparency = 1
PlayerCount.Position = UDim2.new(0, 10, 0, 0)
PlayerCount.Size = UDim2.new(0.35, 0, 1, 0)
PlayerCount.Font = Enum.Font.Gotham
PlayerCount.Text = "Players: 0"
PlayerCount.TextColor3 = Color3.fromRGB(180, 180, 180)
PlayerCount.TextSize = 12
PlayerCount.TextXAlignment = Enum.TextXAlignment.Left
PlayerCount.TextYAlignment = Enum.TextYAlignment.Center

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = StatusBar
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.35, 0, 0, 0)
StatusLabel.Size = UDim2.new(0.35, 0, 1, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Loading..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.TextYAlignment = Enum.TextYAlignment.Center

local FriendsFound = Instance.new("TextLabel")
FriendsFound.Name = "FriendsFound"
FriendsFound.Parent = StatusBar
FriendsFound.BackgroundTransparency = 1
FriendsFound.Position = UDim2.new(0.7, 0, 0, 0)
FriendsFound.Size = UDim2.new(0.3, -10, 1, 0)
FriendsFound.Font = Enum.Font.Gotham
FriendsFound.Text = "Friends: 0"
FriendsFound.TextColor3 = Color3.fromRGB(0, 255, 150)
FriendsFound.TextSize = 12
FriendsFound.TextXAlignment = Enum.TextXAlignment.Right
FriendsFound.TextYAlignment = Enum.TextYAlignment.Center

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 8, 0, 83)
ScrollFrame.Size = UDim2.new(1, -16, 1, -91)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 162, 255)

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ScrollFrame
ListLayout.Padding = UDim.new(0, 3)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local FriendPopup = Instance.new("Frame")
FriendPopup.Name = "FriendPopup"
FriendPopup.Parent = ScreenGui
FriendPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
FriendPopup.BorderSizePixel = 0
FriendPopup.Position = UDim2.new(0.5, -120, 0.5, -100)
FriendPopup.Size = UDim2.new(0, 240, 0, 200)
FriendPopup.Visible = false
FriendPopup.ZIndex = 10
FriendPopup.Active = true

local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 12)
PopupCorner.Parent = FriendPopup

local PopupHeader = Instance.new("Frame")
PopupHeader.Name = "PopupHeader"
PopupHeader.Parent = FriendPopup
PopupHeader.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PopupHeader.BorderSizePixel = 0
PopupHeader.Size = UDim2.new(1, 0, 0, 35)

local PopupHeaderCorner = Instance.new("UICorner")
PopupHeaderCorner.CornerRadius = UDim.new(0, 12)
PopupHeaderCorner.Parent = PopupHeader

local PopupHeaderFix = Instance.new("Frame")
PopupHeaderFix.Parent = PopupHeader
PopupHeaderFix.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PopupHeaderFix.BorderSizePixel = 0
PopupHeaderFix.Position = UDim2.new(0, 0, 0.7, 0)
PopupHeaderFix.Size = UDim2.new(1, 0, 0.3, 0)

local PopupTitle = Instance.new("TextLabel")
PopupTitle.Name = "PopupTitle"
PopupTitle.Parent = PopupHeader
PopupTitle.BackgroundTransparency = 1
PopupTitle.Position = UDim2.new(0, 10, 0, 0)
PopupTitle.Size = UDim2.new(0.8, 0, 1, 0)
PopupTitle.Font = Enum.Font.GothamBold
PopupTitle.Text = "Friends in Server"
PopupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PopupTitle.TextSize = 14
PopupTitle.TextXAlignment = Enum.TextXAlignment.Left
PopupTitle.TextYAlignment = Enum.TextYAlignment.Center

local PopupClose = Instance.new("TextButton")
PopupClose.Name = "PopupClose"
PopupClose.Parent = PopupHeader
PopupClose.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
PopupClose.BorderSizePixel = 0
PopupClose.Position = UDim2.new(1, -25, 0.5, -8)
PopupClose.Size = UDim2.new(0, 16, 0, 16)
PopupClose.Font = Enum.Font.GothamBold
PopupClose.Text = "×"
PopupClose.TextColor3 = Color3.fromRGB(255, 255, 255)
PopupClose.TextSize = 12

local PopupCloseCorner = Instance.new("UICorner")
PopupCloseCorner.CornerRadius = UDim.new(1, 0)
PopupCloseCorner.Parent = PopupClose

local PopupScrollFrame = Instance.new("ScrollingFrame")
PopupScrollFrame.Name = "PopupScrollFrame"
PopupScrollFrame.Parent = FriendPopup
PopupScrollFrame.BackgroundTransparency = 1
PopupScrollFrame.Position = UDim2.new(0, 5, 0, 40)
PopupScrollFrame.Size = UDim2.new(1, -10, 1, -45)
PopupScrollFrame.ScrollBarThickness = 3
PopupScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 162, 255)

local PopupListLayout = Instance.new("UIListLayout")
PopupListLayout.Parent = PopupScrollFrame
PopupListLayout.Padding = UDim.new(0, 3)
PopupListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local PlayerData = {}
local PlayerEntries = {}

local function MakeDraggable(frame, shadow, header)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    local shadowStartPos = nil
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        if shadow then
            shadow.Position = UDim2.new(shadowStartPos.X.Scale, shadowStartPos.X.Offset + delta.X, shadowStartPos.Y.Scale, shadowStartPos.Y.Offset + delta.Y)
        end
    end
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            if shadow then
                shadowStartPos = shadow.Position
            end
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                updateInput(input)
            end
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateInput(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)
end

MakeDraggable(MainFrame, Shadow, Header)
MakeDraggable(FriendPopup, nil, PopupHeader)

local function CreatePlayerEntry(player, hasFriends)
    local PlayerEntry = Instance.new("Frame")
    PlayerEntry.Name = "PlayerEntry_" .. player.Name
    PlayerEntry.Parent = ScrollFrame
    PlayerEntry.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    PlayerEntry.BorderSizePixel = 0
    PlayerEntry.Size = UDim2.new(1, -8, 0, 50)
    
    local EntryCorner = Instance.new("UICorner")
    EntryCorner.CornerRadius = UDim.new(0, 6)
    EntryCorner.Parent = PlayerEntry
    
    local Avatar = Instance.new("ImageLabel")
    Avatar.Name = "Avatar"
    Avatar.Parent = PlayerEntry
    Avatar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Avatar.BorderSizePixel = 0
    Avatar.Position = UDim2.new(0, 8, 0.5, -16)
    Avatar.Size = UDim2.new(0, 32, 0, 32)
    Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(0, 6)
    AvatarCorner.Parent = Avatar
    
    local displayName = player.DisplayName
    local userName = player.Name
    
    if displayName and displayName ~= "" and displayName ~= userName then
        local DisplayName = Instance.new("TextLabel")
        DisplayName.Name = "DisplayName"
        DisplayName.Parent = PlayerEntry
        DisplayName.BackgroundTransparency = 1
        DisplayName.Position = UDim2.new(0, 48, 0, 5)
        DisplayName.Size = UDim2.new(1, -85, 0, 20)
        DisplayName.Font = Enum.Font.GothamBold
        DisplayName.Text = displayName
        DisplayName.TextColor3 = Color3.fromRGB(255, 255, 255)
        DisplayName.TextSize = 13
        DisplayName.TextXAlignment = Enum.TextXAlignment.Left
        DisplayName.TextYAlignment = Enum.TextYAlignment.Center
        
        local PlayerName = Instance.new("TextLabel")
        PlayerName.Name = "PlayerName"
        PlayerName.Parent = PlayerEntry
        PlayerName.BackgroundTransparency = 1
        PlayerName.Position = UDim2.new(0, 48, 0, 25)
        PlayerName.Size = UDim2.new(1, -85, 0, 16)
        PlayerName.Font = Enum.Font.Gotham
        PlayerName.Text = "@" .. userName
        PlayerName.TextColor3 = Color3.fromRGB(150, 150, 150)
        PlayerName.TextSize = 11
        PlayerName.TextXAlignment = Enum.TextXAlignment.Left
        PlayerName.TextYAlignment = Enum.TextYAlignment.Center
    else
        local PlayerName = Instance.new("TextLabel")
        PlayerName.Name = "PlayerName"
        PlayerName.Parent = PlayerEntry
        PlayerName.BackgroundTransparency = 1
        PlayerName.Position = UDim2.new(0, 48, 0, 0)
        PlayerName.Size = UDim2.new(1, -85, 1, 0)
        PlayerName.Font = Enum.Font.GothamBold
        PlayerName.Text = userName
        PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayerName.TextSize = 13
        PlayerName.TextXAlignment = Enum.TextXAlignment.Left
        PlayerName.TextYAlignment = Enum.TextYAlignment.Center
    end
    
    if hasFriends then
        local FriendIndicator = Instance.new("Frame")
        FriendIndicator.Name = "FriendIndicator"
        FriendIndicator.Parent = PlayerEntry
        FriendIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        FriendIndicator.BorderSizePixel = 0
        FriendIndicator.Position = UDim2.new(1, -20, 0.5, -4)
        FriendIndicator.Size = UDim2.new(0, 8, 0, 8)
        
        local IndicatorCorner = Instance.new("UICorner")
        IndicatorCorner.CornerRadius = UDim.new(1, 0)
        IndicatorCorner.Parent = FriendIndicator
        
        local ClickButton = Instance.new("TextButton")
        ClickButton.Name = "ClickButton"
        ClickButton.Parent = PlayerEntry
        ClickButton.BackgroundTransparency = 1
        ClickButton.Size = UDim2.new(1, 0, 1, 0)
        ClickButton.Text = ""
        
        ClickButton.MouseButton1Click:Connect(function()
            ShowFriendPopup(player)
        end)
        
        ClickButton.MouseEnter:Connect(function()
            TweenService:Create(PlayerEntry, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
        end)
        
        ClickButton.MouseLeave:Connect(function()
            TweenService:Create(PlayerEntry, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
        end)
    end
    
    PlayerEntries[player.UserId] = PlayerEntry
    return PlayerEntry
end

local function CreateFriendEntry(friendPlayer)
    local FriendEntry = Instance.new("Frame")
    FriendEntry.Name = "FriendEntry_" .. friendPlayer.Name
    FriendEntry.Parent = PopupScrollFrame
    FriendEntry.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    FriendEntry.BorderSizePixel = 0
    FriendEntry.Size = UDim2.new(1, -6, 0, 40)
    
    local FriendCorner = Instance.new("UICorner")
    FriendCorner.CornerRadius = UDim.new(0, 6)
    FriendCorner.Parent = FriendEntry
    
    local FriendAvatar = Instance.new("ImageLabel")
    FriendAvatar.Name = "FriendAvatar"
    FriendAvatar.Parent = FriendEntry
    FriendAvatar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    FriendAvatar.BorderSizePixel = 0
    FriendAvatar.Position = UDim2.new(0, 8, 0.5, -12)
    FriendAvatar.Size = UDim2.new(0, 24, 0, 24)
    FriendAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. friendPlayer.UserId .. "&width=150&height=150&format=png"
    
    local FriendAvatarCorner = Instance.new("UICorner")
    FriendAvatarCorner.CornerRadius = UDim.new(0, 4)
    FriendAvatarCorner.Parent = FriendAvatar
    
    local displayName = friendPlayer.DisplayName
    local userName = friendPlayer.Name
    
    if displayName and displayName ~= "" and displayName ~= userName then
        local FriendDisplayName = Instance.new("TextLabel")
        FriendDisplayName.Name = "FriendDisplayName"
        FriendDisplayName.Parent = FriendEntry
        FriendDisplayName.BackgroundTransparency = 1
        FriendDisplayName.Position = UDim2.new(0, 38, 0, 2)
        FriendDisplayName.Size = UDim2.new(1, -45, 0, 18)
        FriendDisplayName.Font = Enum.Font.GothamBold
        FriendDisplayName.Text = displayName
        FriendDisplayName.TextColor3 = Color3.fromRGB(255, 255, 255)
        FriendDisplayName.TextSize = 12
        FriendDisplayName.TextXAlignment = Enum.TextXAlignment.Left
        FriendDisplayName.TextYAlignment = Enum.TextYAlignment.Center
        
        local FriendName = Instance.new("TextLabel")
        FriendName.Name = "FriendName"
        FriendName.Parent = FriendEntry
        FriendName.BackgroundTransparency = 1
        FriendName.Position = UDim2.new(0, 38, 0, 20)
        FriendName.Size = UDim2.new(1, -45, 0, 15)
        FriendName.Font = Enum.Font.Gotham
        FriendName.Text = "@" .. userName
        FriendName.TextColor3 = Color3.fromRGB(0, 255, 150)
        FriendName.TextSize = 10
        FriendName.TextXAlignment = Enum.TextXAlignment.Left
        FriendName.TextYAlignment = Enum.TextYAlignment.Center
    else
        local FriendName = Instance.new("TextLabel")
        FriendName.Name = "FriendName"
        FriendName.Parent = FriendEntry
        FriendName.BackgroundTransparency = 1
        FriendName.Position = UDim2.new(0, 38, 0, 0)
        FriendName.Size = UDim2.new(1, -45, 1, 0)
        FriendName.Font = Enum.Font.GothamBold
        FriendName.Text = userName
        FriendName.TextColor3 = Color3.fromRGB(255, 255, 255)
        FriendName.TextSize = 12
        FriendName.TextXAlignment = Enum.TextXAlignment.Left
        FriendName.TextYAlignment = Enum.TextYAlignment.Center
    end
    
    return FriendEntry
end

function ShowFriendPopup(player)
    for _, child in pairs(PopupScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local displayName = player.DisplayName
    local userName = player.Name
    local titleText = displayName and displayName ~= "" and displayName ~= userName and displayName .. "'s Friends" or userName .. "'s Friends"
    PopupTitle.Text = titleText
    
    local friendsInServer = PlayerData[player.UserId] or {}
    for _, friendPlayer in pairs(friendsInServer) do
        CreateFriendEntry(friendPlayer)
    end
    
    local totalHeight = 0
    for _, child in pairs(PopupScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            totalHeight = totalHeight + child.Size.Y.Offset + 3
        end
    end
    PopupScrollFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(totalHeight, PopupScrollFrame.AbsoluteSize.Y))
    
    FriendPopup.Visible = true
end

local function UpdateScrollFrame()
    local totalHeight = 0
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            totalHeight = totalHeight + child.Size.Y.Offset + 3
        end
    end
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(totalHeight, ScrollFrame.AbsoluteSize.Y))
end

local function CheckIfPlayersFriends(player1, player2)
    local success, isFriend = pcall(function()
        return player1:IsFriendsWith(player2.UserId)
    end)
    return success and isFriend
end

local function LoadAllPlayersFirst()
    local allPlayers = Players:GetPlayers()
    PlayerCount.Text = "Players: " .. tostring(#allPlayers)
    
    for _, player in pairs(allPlayers) do
        if player ~= LocalPlayer then
            CreatePlayerEntry(player, false)
        end
    end
    UpdateScrollFrame()
end

local function FastCheckFriends()
    local allPlayers = Players:GetPlayers()
    local totalPlayers = 0
    for _, player in pairs(allPlayers) do
        if player ~= LocalPlayer then
            totalPlayers = totalPlayers + 1
        end
    end
    
    local currentPlayer = 0
    local playersWithFriends = 0
    
    StatusLabel.Text = "Checking..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    
    spawn(function()
        for _, player in pairs(allPlayers) do
            if player ~= LocalPlayer then
                currentPlayer = currentPlayer + 1
                StatusLabel.Text = "Checking " .. currentPlayer .. "/" .. totalPlayers
                
                local friendsInServer = {}
                for _, otherPlayer in pairs(allPlayers) do
                    if otherPlayer ~= player and otherPlayer ~= LocalPlayer then
                        if CheckIfPlayersFriends(player, otherPlayer) then
                            table.insert(friendsInServer, otherPlayer)
                        end
                    end
                end
                
                PlayerData[player.UserId] = friendsInServer
                
                if #friendsInServer > 0 then
                    playersWithFriends = playersWithFriends + 1
                    local oldEntry = PlayerEntries[player.UserId]
                    if oldEntry then
                        oldEntry:Destroy()
                    end
                    CreatePlayerEntry(player, true)
                    UpdateScrollFrame()
                end
                
                FriendsFound.Text = "Friends: " .. tostring(playersWithFriends)
                RunService.Heartbeat:Wait()
            end
        end
        
        StatusLabel.Text = "Complete"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    end)
end

Players.PlayerAdded:Connect(function(player)
    CreatePlayerEntry(player, false)
    PlayerCount.Text = "Players: " .. tostring(#Players:GetPlayers())
    UpdateScrollFrame()
end)

Players.PlayerRemoving:Connect(function(player)
    PlayerData[player.UserId] = nil
    local entry = PlayerEntries[player.UserId]
    if entry then
        entry:Destroy()
        PlayerEntries[player.UserId] = nil
    end
    
    PlayerCount.Text = "Players: " .. tostring(#Players:GetPlayers())
    local playersWithFriends = 0
    for _, data in pairs(PlayerData) do
        if #data > 0 then
            playersWithFriends = playersWithFriends + 1
        end
    end
    FriendsFound.Text = "Friends: " .. tostring(playersWithFriends)
    UpdateScrollFrame()
end)

CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(ScreenGui, TweenInfo.new(0.3), {Enabled = false}):Play()
    wait(0.3)
    ScreenGui:Destroy()
end)

PopupClose.MouseButton1Click:Connect(function()
    FriendPopup.Visible = false
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 105, 105)}):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 85, 85)}):Play()
end)

PopupClose.MouseEnter:Connect(function()
    TweenService:Create(PopupClose, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 105, 105)}):Play()
end)

PopupClose.MouseLeave:Connect(function()
    TweenService:Create(PopupClose, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 85, 85)}):Play()
end)

-- Initialize the GUI
LoadAllPlayersFirst()
FastCheckFriends()

-- Optional: Add keyboard shortcut to toggle GUI visibility
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Optional: Add refresh functionality
local RefreshButton = Instance.new("TextButton")
RefreshButton.Name = "RefreshButton"
RefreshButton.Parent = StatusBar
RefreshButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
RefreshButton.BorderSizePixel = 0
RefreshButton.Position = UDim2.new(1, -60, 0.5, -8)
RefreshButton.Size = UDim2.new(0, 50, 0, 16)
RefreshButton.Font = Enum.Font.Gotham
RefreshButton.Text = "Refresh"
RefreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshButton.TextSize = 10

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 4)
RefreshCorner.Parent = RefreshButton

RefreshButton.MouseButton1Click:Connect(function()
    -- Clear existing data
    for userId, _ in pairs(PlayerData) do
        PlayerData[userId] = nil
    end
    
    for userId, entry in pairs(PlayerEntries) do
        if entry then
            entry:Destroy()
            PlayerEntries[userId] = nil
        end
    end
    
    -- Reload everything
    LoadAllPlayersFirst()
    FastCheckFriends()
end)

RefreshButton.MouseEnter:Connect(function()
    TweenService:Create(RefreshButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 182, 255)}):Play()
end)

RefreshButton.MouseLeave:Connect(function()
    TweenService:Create(RefreshButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 162, 255)}):Play()
end)

-- Add minimize functionality
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = Header
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -55, 0.5, -10)
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = ""
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeButton

local isMinimized = false

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        -- Hide all content except header
        StatusBar.Visible = false
        ScrollFrame.Visible = false
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 45)}):Play()
        TweenService:Create(Shadow, TweenInfo.new(0.3), {Size = UDim2.new(0, 284, 0, 49)}):Play()
        MinimizeButton.Text = "+"
    else
        -- Show all content
        StatusBar.Visible = true
        ScrollFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 400)}):Play()
        TweenService:Create(Shadow, TweenInfo.new(0.3), {Size = UDim2.new(0, 284, 0, 404)}):Play()
        MinimizeButton.Text = ""
    end
end)

MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 220, 30)}):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 200, 0)}):Play()
end)

-- Handle window focus/blur effects
ScreenGui.ChildAdded:Connect(function(child)
    if child == MainFrame then
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
        TweenService:Create(Shadow, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
    end
end)

-- Add some polish with entrance animation
MainFrame.BackgroundTransparency = 1
Shadow.BackgroundTransparency = 1

spawn(function()
    wait(0.1)
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    TweenService:Create(Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.7}):Play()
end)
