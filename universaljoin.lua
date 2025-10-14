local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local API_BASE_URL = "https://nutte.alimaherkhammas.workers.dev"

local isExpanded = false
local currentTab = "current"
local serverData = {}
local filteredData = {}
local searchTerm = ""
local lastEntryTime = 0
local CHECK_INTERVAL = 600
local REFRESH_INTERVAL = 5

local SOUNDS = {
    success = 131961136,
    error = 131961162,
    notification = 131961140
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UsersJoinerGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 45, 0, 45)
mainButton.Position = UDim2.new(1, -295, 0, -54)
mainButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainButton.BackgroundTransparency = 0.5
mainButton.BorderSizePixel = 0
mainButton.Text = ""
mainButton.TextColor3 = Color3.fromRGB(200, 200, 200)
mainButton.Font = Enum.Font.Gotham
mainButton.Parent = screenGui

local buttonIcon = Instance.new("ImageLabel")
buttonIcon.Size = UDim2.new(0, 24, 0, 24)
buttonIcon.Position = UDim2.new(0.5, -12, 0.5, -12)
buttonIcon.BackgroundTransparency = 1
buttonIcon.Image = "rbxassetid://73030536000238"
buttonIcon.Parent = mainButton

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainButton

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 45, 0, 45)
mainFrame.Position = UDim2.new(1, -295, 0, -54)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
mainFrame.BackgroundTransparency = 0.5
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 150, 0, 25)
titleLabel.Position = UDim2.new(0, 15, 0, 15)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "JOIN AK USERS"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Visible = false
titleLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -40, 0, 15)
closeButton.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
closeButton.BackgroundTransparency = 0.6
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 200, 200)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Visible = false
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 15)
statusLabel.Position = UDim2.new(0, 10, 0, 45)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Loading..."
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
statusLabel.TextSize = 10
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Font = Enum.Font.Gotham
statusLabel.Visible = false
statusLabel.Parent = mainFrame

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -20, 0, 25)
searchBox.Position = UDim2.new(0, 10, 0, 65)
searchBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
searchBox.BackgroundTransparency = 0.5
searchBox.BorderSizePixel = 0
searchBox.PlaceholderText = "Search by username..."
searchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.TextSize = 12
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.Font = Enum.Font.Gotham
searchBox.Visible = false
searchBox.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 6)
searchCorner.Parent = searchBox

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -10, 0, 35)
tabFrame.Position = UDim2.new(0, 5, 0, 100)
tabFrame.BackgroundTransparency = 1
tabFrame.Visible = false
tabFrame.Parent = mainFrame

local currentGameTab = Instance.new("TextButton")
currentGameTab.Size = UDim2.new(0.5, -2, 1, 0)
currentGameTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
currentGameTab.BackgroundTransparency = 0.5
currentGameTab.BorderSizePixel = 0
currentGameTab.Text = "Current Game"
currentGameTab.TextColor3 = Color3.fromRGB(220, 220, 220)
currentGameTab.TextSize = 12
currentGameTab.Font = Enum.Font.Gotham
currentGameTab.Parent = tabFrame

local currentTabCorner = Instance.new("UICorner")
currentTabCorner.CornerRadius = UDim.new(0, 8)
currentTabCorner.Parent = currentGameTab

local universalTab = Instance.new("TextButton")
universalTab.Size = UDim2.new(0.5, -2, 1, 0)
universalTab.Position = UDim2.new(0.5, 2, 0, 0)
universalTab.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
universalTab.BackgroundTransparency = 0.7
universalTab.BorderSizePixel = 0
universalTab.Text = "All Games"
universalTab.TextColor3 = Color3.fromRGB(150, 150, 150)
universalTab.TextSize = 12
universalTab.Font = Enum.Font.Gotham
universalTab.Parent = tabFrame

local universalTabCorner = Instance.new("UICorner")
universalTabCorner.CornerRadius = UDim.new(0, 8)
universalTabCorner.Parent = universalTab

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -10, 1, -145)
contentFrame.Position = UDim2.new(0, 5, 0, 140)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 4
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
contentFrame.Visible = false
contentFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 5)
contentLayout.Parent = contentFrame

local function playSound(soundType)
    local soundId = SOUNDS[soundType]
    if soundId then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Volume = 0.5
        sound.Parent = SoundService
        
        pcall(function()
            sound:Play()
        end)
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
        
        task.spawn(function()
            task.wait(5)
            if sound.Parent then
                sound:Destroy()
            end
        end)
    end
end

local function updateStatus(text, color, soundType)
    statusLabel.Text = text
    statusLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    statusLabel.Visible = true
    
    if soundType then
        playSound(soundType)
    end
    
    task.spawn(function()
        task.wait(5)
        statusLabel.Visible = false
    end)
end

local function getPlaceName()
    local success, result = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    if success and result then
        return result
    else
        warn("Failed to get place name:", result)
        return "Unknown Place"
    end
end

local function checkIfPlayerExists()
    local data = fetchFromServer()
    
    if data and type(data) == "table" then
        for _, entry in pairs(data) do
            if type(entry) == "table" and 
               tonumber(entry.userId) == player.UserId and 
               tonumber(entry.placeId) == game.PlaceId and
               entry.jobId == game.JobId then
                return true
            end
        end
    end
    
    return false
end

local function sendToServer(data)
    local success, result = pcall(function()
        local headers = {
            ["Content-Type"] = "application/json",
            ["Accept"] = "application/json"
        }
        
        local response = HttpService:RequestAsync({
            Url = API_BASE_URL .. "/add",
            Method = "POST",
            Headers = headers,
            Body = HttpService:JSONEncode(data)
        })
        
        return response
    end)
    
    if success and result then
        if result.StatusCode == 200 or result.StatusCode == 201 then
            local success2, decoded = pcall(function()
                return HttpService:JSONDecode(result.Body)
            end)
            if success2 and decoded then
                lastEntryTime = os.time()
                return true
            else
                warn("Failed to decode response:", result.Body)
                updateStatus("⚠ Response decode error", Color3.fromRGB(255, 165, 0), "error")
            end
        else
            warn("HTTP Error:", result.StatusCode, result.Body)
            local errorMsg = "HTTP Error: " .. result.StatusCode
            local success3, decoded = pcall(function()
                return HttpService:JSONDecode(result.Body)
            end)
            if success3 and decoded and decoded.message then
                errorMsg = errorMsg .. " - " .. decoded.message
            elseif success3 and decoded and decoded.error then
                errorMsg = errorMsg .. " - " .. decoded.error
            end
            
            updateStatus("✗ " .. errorMsg, Color3.fromRGB(255, 0, 0), "error")
        end
    else
        warn("Request failed:", result)
        if string.find(tostring(result), "Http requests can only be executed by game server") then
            return false
        else
            updateStatus("✗ Network error", Color3.fromRGB(255, 0, 0), "error")
        end
    end
    return false
end

local function fetchFromServer()
    if not RunService:IsClient() then
        warn("HTTP requests can only be made from server-side scripts")
        return {}
    end
    
    local success, result = pcall(function()
        return game:HttpGet(API_BASE_URL .. "/entries")
    end)
    
    if success and result then
        local success2, decoded = pcall(function()
            return HttpService:JSONDecode(result)
        end)
        if success2 and type(decoded) == "table" then
            return decoded
        else
            warn("Failed to decode fetch response:", result)
        end
    else
        warn("Fetch request failed:", result)
        if string.find(tostring(result), "Http requests can only be executed by game server") then
        end
    end
    return {}
end

local function addOrUpdateEntry()
    local placeName = getPlaceName()
    
    local playerData = {
        userId = player.UserId,
        username = player.Name,
        displayName = player.DisplayName,
        profilePicture = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png",
        placeId = game.PlaceId,
        placeName = placeName,
        jobId = game.JobId or "",
        timestamp = os.time()
    }
    
    local success = sendToServer(playerData)
    
    if not success then
        playerData.userId = tostring(player.UserId)
        playerData.placeId = tostring(game.PlaceId)
        playerData.timestamp = tostring(os.time())
        
        success = sendToServer(playerData)
    end
    
    if not success then
        local minimalData = {
            username = player.Name,
            placeId = game.PlaceId,
            timestamp = os.time()
        }
        
        success = sendToServer(minimalData)
    end
    
    return success
end

local function createServerEntry(data)
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0, 60)
    entry.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    entry.BackgroundTransparency = 0.6
    entry.BorderSizePixel = 0
    
    local entryCorner = Instance.new("UICorner")
    entryCorner.CornerRadius = UDim.new(0, 6)
    entryCorner.Parent = entry
    
    local profilePic = Instance.new("ImageLabel")
    profilePic.Size = UDim2.new(0, 35, 0, 35)
    profilePic.Position = UDim2.new(0, 8, 0, 12)
    profilePic.BackgroundTransparency = 1
    profilePic.Image = data.profilePicture or ""
    profilePic.Parent = entry
    
    local picCorner = Instance.new("UICorner")
    picCorner.CornerRadius = UDim.new(0, 17)
    picCorner.Parent = profilePic
    
    local userInfo = Instance.new("Frame")
    userInfo.Size = UDim2.new(0, 100, 0, 40)
    userInfo.Position = UDim2.new(0, 48, 0, 10)
    userInfo.BackgroundTransparency = 1
    userInfo.Parent = entry
    
    local username = Instance.new("TextLabel")
    username.Size = UDim2.new(1, 0, 0, 14)
    username.Position = UDim2.new(0, 0, 0, 0)
    username.BackgroundTransparency = 1
    username.Text = data.displayName or data.username
    username.TextColor3 = Color3.fromRGB(240, 240, 240)
    username.TextSize = 11
    username.TextXAlignment = Enum.TextXAlignment.Left
    username.Font = Enum.Font.GothamBold
    username.TextTruncate = Enum.TextTruncate.AtEnd
    username.Parent = userInfo
    
    local atUsername = Instance.new("TextLabel")
    atUsername.Size = UDim2.new(1, 0, 0, 12)
    atUsername.Position = UDim2.new(0, 0, 0, 13)
    atUsername.BackgroundTransparency = 1
    atUsername.Text = "@" .. (data.username or "Unknown")
    atUsername.TextColor3 = Color3.fromRGB(160, 160, 160)
    atUsername.TextSize = 9
    atUsername.TextXAlignment = Enum.TextXAlignment.Left
    atUsername.Font = Enum.Font.Gotham
    atUsername.TextTruncate = Enum.TextTruncate.AtEnd
    atUsername.Parent = userInfo
    
    local placeName = Instance.new("TextLabel")
    placeName.Size = UDim2.new(1, 0, 0, 11)
    placeName.Position = UDim2.new(0, 0, 0, 27)
    placeName.BackgroundTransparency = 1
    placeName.Text = "🎮 " .. (data.placeName or "Unknown Place")
    placeName.TextColor3 = Color3.fromRGB(120, 120, 120)
    placeName.TextSize = 8
    placeName.TextXAlignment = Enum.TextXAlignment.Left
    placeName.Font = Enum.Font.Gotham
    placeName.TextTruncate = Enum.TextTruncate.AtEnd
    placeName.Parent = userInfo
    
    local rightInfo = Instance.new("Frame")
    rightInfo.Size = UDim2.new(0, 90, 0, 40)
    rightInfo.Position = UDim2.new(1, -95, 0, 10)
    rightInfo.BackgroundTransparency = 1
    rightInfo.Parent = entry
    
    local timeDiff = os.time() - (tonumber(data.timestamp) or 0)
    local timeText = timeDiff < 60 and "🟢 now" or timeDiff < 3600 and "🟡 " .. math.floor(timeDiff/60) .. "m ago" or "🔴 " .. math.floor(timeDiff/3600) .. "h ago"
    
    local timeAgo = Instance.new("TextLabel")
    timeAgo.Size = UDim2.new(1, 0, 0, 12)
    timeAgo.Position = UDim2.new(0, 0, 0, 0)
    timeAgo.BackgroundTransparency = 1
    timeAgo.Text = timeText
    timeAgo.TextColor3 = Color3.fromRGB(140, 140, 140)
    timeAgo.TextSize = 8
    timeAgo.TextXAlignment = Enum.TextXAlignment.Right
    timeAgo.Font = Enum.Font.Gotham
    timeAgo.Parent = rightInfo
    
    local entryPlaceId = tonumber(data.placeId)
    local currentPlaceId = game.PlaceId
    local isDifferentGame = entryPlaceId ~= currentPlaceId
    
    local joinButton = Instance.new("TextButton")
    joinButton.Size = UDim2.new(0, 85, 0, 24)
    joinButton.Position = UDim2.new(1, -85, 0, 16)
    joinButton.BorderSizePixel = 0
    joinButton.TextSize = 9
    joinButton.Font = Enum.Font.GothamBold
    joinButton.Parent = rightInfo
    
    if isDifferentGame then
        joinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        joinButton.BackgroundTransparency = 0.4
        joinButton.Text = "Join the game first"
        joinButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    else
        joinButton.BackgroundColor3 = Color3.fromRGB(30, 120, 50)
        joinButton.BackgroundTransparency = 0.4
        joinButton.Text = "JOIN"
        joinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        joinButton.MouseButton1Click:Connect(function()
            local placeId = tonumber(data.placeId)
            if placeId then
                playSound("notification")
                
                local success, result = pcall(function()
                    if data.jobId and data.jobId ~= "" then
                        TeleportService:TeleportToPlaceInstance(placeId, data.jobId, player)
                    else
                        TeleportService:Teleport(placeId, player)
                    end
                end)
                
                if not success then
                    warn("Teleportation failed:", result)
                    updateStatus("✗ Failed to join server", Color3.fromRGB(255, 0, 0), "error")
                end
            end
        end)
    end
    
    local joinCorner = Instance.new("UICorner")
    joinCorner.CornerRadius = UDim.new(0, 6)
    joinCorner.Parent = joinButton
    
    return entry
end

local existingEntries = {}

function updateContent()
    if not contentFrame.Visible then return end
    
    local data = fetchFromServer()
    if not data or type(data) ~= "table" then return end
    
    serverData = data
    local playerEntries = {}
    local seenPlayers = {}
    
    for _, entry in pairs(serverData) do
        if type(entry) == "table" then
            local entryPlaceId = tonumber(entry.placeId)
            local currentPlaceId = game.PlaceId
            local userId = tonumber(entry.userId) or tostring(entry.userId)
            
            local matchesTab = currentTab == "universal" or entryPlaceId == currentPlaceId
            local matchesSearch = searchTerm == "" or 
                (entry.username or ""):lower():find(searchTerm:lower(), 1, true) or 
                (entry.displayName or ""):lower():find(searchTerm:lower(), 1, true)
            
            if matchesTab and matchesSearch then
                local entryTime = tonumber(entry.timestamp) or 0
                
                if not seenPlayers[userId] or entryTime > (tonumber(playerEntries[userId].timestamp) or 0) then
                    seenPlayers[userId] = true
                    playerEntries[userId] = entry
                end
            end
        end
    end
    
    for userId, entry in pairs(playerEntries) do
        local entryKey = tostring(userId) .. "_" .. tostring(entry.placeId) .. "_" .. tostring(entry.jobId)
        
        if not existingEntries[entryKey] then
            local newEntry = createServerEntry(entry)
            newEntry.Parent = contentFrame
            newEntry.LayoutOrder = -(tonumber(entry.timestamp) or 0)
            existingEntries[entryKey] = {
                frame = newEntry,
                data = entry
            }
        end
    end
    
    for entryKey, entryInfo in pairs(existingEntries) do
        local stillExists = false
        for userId, entry in pairs(playerEntries) do
            local checkKey = tostring(userId) .. "_" .. tostring(entry.placeId) .. "_" .. tostring(entry.jobId)
            if checkKey == entryKey then
                stillExists = true
                break
            end
        end
        
        if not stillExists then
            if entryInfo.frame and entryInfo.frame.Parent then
                entryInfo.frame:Destroy()
            end
            existingEntries[entryKey] = nil
        end
    end
    
    RunService.Heartbeat:Wait()
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
end

local function expandGui()
    if isExpanded then return end
    isExpanded = true
    
    mainButton.Visible = false
    mainFrame.Visible = true
    
    local tween1 = TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 45, 0, 300)})
    tween1:Play()
    tween1.Completed:Connect(function()
        local tween2 = TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 300, 0, 300),
            Position = UDim2.new(1, -550, 0, -54)
        })
        tween2:Play()
        tween2.Completed:Connect(function()
            titleLabel.Visible = true
            closeButton.Visible = true
            searchBox.Visible = true
            tabFrame.Visible = true
            contentFrame.Visible = true
            updateContent()
        end)
    end)
end

local function collapseGui()
    if not isExpanded then return end
    isExpanded = false
    
    titleLabel.Visible = false
    closeButton.Visible = false
    searchBox.Visible = false
    tabFrame.Visible = false
    contentFrame.Visible = false
    
    local tween1 = TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
        Size = UDim2.new(0, 45, 0, 300),
        Position = UDim2.new(1, -295, 0, -54)
    })
    tween1:Play()
    tween1.Completed:Connect(function()
        local tween2 = TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 45, 0, 45)})
        tween2:Play()
        tween2.Completed:Connect(function()
            mainFrame.Visible = false
            mainButton.Visible = true
        end)
    end)
end

local function switchTab(tab)
    currentTab = tab
    
    if tab == "current" then
        currentGameTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        currentGameTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        universalTab.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        universalTab.TextColor3 = Color3.fromRGB(150, 150, 150)
    else
        universalTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        universalTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        currentGameTab.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        currentGameTab.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
    
    for _, child in pairs(contentFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    existingEntries = {}
    
    if isExpanded and contentFrame.Visible then
        updateContent()
    end
end

mainButton.MouseButton1Click:Connect(expandGui)
closeButton.MouseButton1Click:Connect(collapseGui)
currentGameTab.MouseButton1Click:Connect(function() switchTab("current") end)
universalTab.MouseButton1Click:Connect(function() switchTab("universal") end)

searchBox.FocusLost:Connect(function()
    searchTerm = searchBox.Text
    for _, child in pairs(contentFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    existingEntries = {}
    updateContent()
end)

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    if searchBox.Text == "" then
        searchTerm = ""
        for _, child in pairs(contentFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        existingEntries = {}
        updateContent()
    end
end)

task.spawn(function()
    while true do
        if not checkIfPlayerExists() then
            local success = addOrUpdateEntry()
            if not success then
            end
        end
        
        if isExpanded and contentFrame.Visible then
            updateContent()
        end
        
        task.wait(CHECK_INTERVAL)
    end
end)

task.spawn(function()
    while true do
        if isExpanded and contentFrame.Visible then
            updateContent()
        end
        task.wait(REFRESH_INTERVAL)
    end
end)

task.wait(2)
addOrUpdateEntry()
switchTab("current")
