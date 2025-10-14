local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local prefixCharacter = "  "
local suffixCharacter = "  "

local letters = {
    ["A"] = "ส",
    ["B"] = "B",
    ["C"] = "ϲ",
    ["D"] = "D",
    ["E"] = "e",
    ["F"] = "ӻ",
    ["G"] = "G",
    ["H"] = "ɧ",
    ["I"] = "เ",
    ["J"] = "J",
    ["K"] = "ҟ",
    ["L"] = "Ɩ",
    ["M"] = "M",
    ["N"] = "ถ",
    ["O"] = "o",
    ["P"] = "p",
    ["Q"] = "Q",
    ["R"] = "ꞅ",
    ["S"] = "ธ",
    ["T"] = "t",
    ["U"] = "ม",
    ["V"] = "v",
    ["W"] = "w",
    ["X"] = "X",
    ["Y"] = "y",
    ["Z"] = "Z",

    ["a"] = "ส",
    ["b"] = "b",
    ["c"] = "ϲ",
    ["d"] = "d",
    ["e"] = "e",
    ["f"] = "ӻ",
    ["g"] = "g",
    ["h"] = "ɧ",
    ["i"] = "เ",
    ["j"] = "j",
    ["k"] = "ҟ",
    ["l"] = "Ɩ",
    ["m"] = "m",
    ["n"] = "ถ",
    ["o"] = "o",
    ["p"] = "p",
    ["q"] = "q",
    ["r"] = "ꞅ",
    ["s"] = "ธ",
    ["t"] = "t",
    ["u"] = "ม",
    ["v"] = "v",
    ["w"] = "w",
    ["x"] = "x",
    ["y"] = "y",
    ["z"] = "z",

    [" "] = "  "
}

local wordReplacements = {
    ["nigger"] = "ถเ่ggeꞅ",
    ["fuck"] = "fมϲҟ",
    ["nigga"] = "ถเ่ggส",
    ["faggot"] = "ӻสggot",
    ["slut"] = "ริῐนิṭ",
    ["slave"] = "ธƖสve",
    ["ass"] = "สธธ",
    ["retard"] = "ꞅetสꞅd",
    ["kill yourself"] = "kiII yoꜗꜗuꜗrꜗself",
    ["pussy"] = "pมธธу",
    ["whore"] = "wꜗɧoꞅe",
    ["bitch"] = "bเtϲɧ",
    ["damn"] = "dสmถ",
    ["shit"] = "ธɧเt",
    ["bastard"] = "bสธtสꞅd",
    ["cunt"] = "ϲมถt",
    ["dick"] = "dเϲҟ",
    ["piss"] = "pเธธ",
    ["hell"] = "ɧeƖƖ",
    ["gay"] = "gสy",
    ["lesbian"] = "Ɩeธbเสถ",
    ["stupid"] = "ธtมpเd",
    ["idiot"] = "เdเot",
    ["moron"] = "moꞅoถ",
    ["loser"] = "Ɩoธeꞅ",
    ["noob"] = "ถoob",
    ["trash"] = "tꞅสธɧ",
    ["toxic"] = "toxเϲ",
    ["rape"] = "ꞅสpe",
    ["sex"] = "ธex",
    ["porn"] = "poꞅถ",
    ["naked"] = "ถสҟed",
    ["nude"] = "ถมde",
    ["die"] = "dเe",
    ["kill"] = "kเƖƖ",
    ["hate"] = "ɧสte",
    ["ugly"] = "มgƖy",
    ["fat"] = "ӻสt",
    ["retarded"] = "ꞅetสꞅded",
    ["dumbass"] = "dมmbสธธ",
    ["jackass"] = "jสϲkสธธ",
    ["butthole"] = "bมttɧoƖe",
    ["boobs"] = "booبธ",
    ["penis"] = "peถเธ",
    ["vagina"] = "vสgเถส",
    ["suck"] = "ธมϲҟ",
    ["blow"] = "bƖow",
    ["horny"] = "ɧoꞅถy",
    ["masturbate"] = "mสธtมꞅbสte",
    ["orgasm"] = "oꞅgสธm",
    ["cum"] = "ϲมm",
    ["sperm"] = "ธpeꞅm",
    ["condom"] = "ϲoถdom",
    ["virgin"] = "vเꞅgเถ",
    ["prostitute"] = "pꞅoธtเtมte",
    ["stripper"] = "ธtꞅเppeꞅ",
    ["escort"] = "eธϲoꞅt",
    ["hooker"] = "ɧooҟeꞅ",
    ["threesome"] = "tɧꞅeeธome",
    ["orgy"] = "oꞅgy",
    ["bondage"] = "boถdสge",
    ["kinky"] = "kเถky",
    ["fetish"] = "ӻetเธɧ",
    ["sadist"] = "ธสdเธt",
    ["masochist"] = "mสธoϲɧเธt",
    ["pervert"] = "peꞅveꞅt",
    ["creep"] = "ϲꞅeep",
    ["pedophile"] = "pedopɧเƖe",
    ["molest"] = "moƖeธt",
    ["abuse"] = "สbมธe",
    ["violent"] = "vเoƖeถt",
    ["murder"] = "mมꞅdeꞅ",
    ["suicide"] = "ธมเϲเde",
    ["terrorist"] = "teꞅꞅoꞅเธt",
    ["bomb"] = "bomb",
    ["explosion"] = "expƖoธเoถ",
    ["weapon"] = "weสpoถ",
    ["gun"] = "gมถ",
    ["knife"] = "kถเӻe",
    ["drugs"] = "dꞅมgธ",
    ["cocaine"] = "ϲoϲสเถe",
    ["heroin"] = "ɧeꞅoเถ",
    ["marijuana"] = "mสꞅเjมสถส",
    ["weed"] = "weed",
    ["crack"] = "ϲꞅสϲҟ",
    ["meth"] = "metɧ",
    ["alcohol"] = "สƖϲoɧoƖ",
    ["drunk"] = "dꞅมถҟ",
    ["beer"] = "beeꞅ",
    ["vodka"] = "vodkส",
    ["whiskey"] = "wɧเธkey",
    ["cigarette"] = "ϲเgสꞅette",
    ["smoke"] = "ธmoҟe",
    ["addiction"] = "สddเϲtเoถ",
    ["dealer"] = "deสƖeꞅ",
    ["junkie"] = "jมถkเe",
    ["addict"] = "สddเϲt",
    ["overdose"] = "oveꞅdoธe",
    ["inject"] = "เถjeϲt",
    ["needle"] = "ถeedƖe",
    ["syringe"] = "ธyꞅเถge",
    ["snort"] = "ธถoꞅt",
    ["inhale"] = "เถɧสƖe"
}

-- File path for saving phrases
local PHRASES_FILE = "ChatBypass_SavedPhrases.json"

-- Saved phrases table
local savedPhrases = {}

local function replace(str, find_str, replace_str)
    local escaped_find_str = find_str:gsub("[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
    return str:gsub(escaped_find_str, replace_str)
end

local function applyWordReplacements(message)
    local convertedMessage = message
    for word, replacement in pairs(wordReplacements) do
        convertedMessage = convertedMessage:gsub("%f[%w]" .. word:gsub("[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0") .. "%f[%W]", replacement)
    end
    return convertedMessage
end

local function filter(message, tableToUse, prefix, suffix)
    local convertedMessage = applyWordReplacements(message)
    
    for letter, replacement in pairs(tableToUse) do
        convertedMessage = replace(convertedMessage, letter, replacement)
    end
    return prefix .. convertedMessage .. suffix
end

local function showNotification(title, text)
    Notification:Notify(
        {Title = title, Description = text},
        {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 3, Type = "default"}
    )
end

-- File operations for saving/loading phrases
local function savePhrases()
    local success, err = pcall(function()
        local jsonData = game:GetService("HttpService"):JSONEncode(savedPhrases)
        writefile(PHRASES_FILE, jsonData)
    end)
    
    if success then
        showNotification("Phrases Saved", "Successfully saved " .. #savedPhrases .. " phrases")
    else
        showNotification("Save Error", "Failed to save phrases: " .. tostring(err))
    end
end

local function loadPhrases()
    local success, result = pcall(function()
        if isfile(PHRASES_FILE) then
            local jsonData = readfile(PHRASES_FILE)
            return game:GetService("HttpService"):JSONDecode(jsonData)
        else
            return {}
        end
    end)
    
    if success then
        savedPhrases = result or {}
        showNotification("Phrases Loaded", "Loaded " .. #savedPhrases .. " saved phrases")
        return savedPhrases
    else
        savedPhrases = {}
        showNotification("Load Error", "Failed to load phrases, starting fresh")
        return {}
    end
end

local function sendChat(msg)
    local converted = filter(msg, letters, prefixCharacter, suffixCharacter)
    
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
            local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            if chatEvents and chatEvents:FindFirstChild("SayMessageRequest") then
                chatEvents.SayMessageRequest:FireServer(converted, "All")
            end
        else
            if TextChatService.ChatInputBarConfiguration and TextChatService.ChatInputBarConfiguration.TargetTextChannel then
                TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(converted)
            end
        end
    end)
end

local GUI = Instance.new("ScreenGui")
GUI.Name = "ProfessionalChatBypass"
GUI.ResetOnSpawn = false
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 300)
MainFrame.Position = UDim2.new(1, -290, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.4 -- Made more transparent
MainFrame.BorderSizePixel = 0
MainFrame.Parent = GUI

local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Image = "rbxassetid://6014257812"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.3 -- Made more transparent
Shadow.Parent = MainFrame

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12) -- Made more rounded
Corner.Parent = MainFrame

-- Title bar is now invisible but still functional for dragging
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundTransparency = 1 -- Made invisible
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Title moved to center and made more visible
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 30, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.Text = "AK CHAT BYPASSER"
Title.TextXAlignment = Enum.TextXAlignment.Center -- Centered the title
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -27, 0, 3)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.BackgroundTransparency = 0.4 -- Made more transparent
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8) -- Made more rounded
CloseCorner.Parent = CloseButton

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
MinimizeButton.Position = UDim2.new(1, -54, 0, 3)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
MinimizeButton.BackgroundTransparency = 0.4 -- Made more transparent
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 8) -- Made more rounded
MinimizeCorner.Parent = MinimizeButton

local InputBox = Instance.new("TextBox")
InputBox.Name = "InputBox"
InputBox.Size = UDim2.new(1, -20, 0, 30)
InputBox.Position = UDim2.new(0, 10, 0, 40)
InputBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- Made more black
InputBox.BackgroundTransparency = 0.3 -- Made more transparent
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
InputBox.PlaceholderText = "Enter message..."
InputBox.TextSize = 14
InputBox.Font = Enum.Font.Gotham
InputBox.ClearTextOnFocus = true
InputBox.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8) -- Made more rounded
InputCorner.Parent = InputBox

-- Button container for Send and Save buttons
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(1, -20, 0, 26)
ButtonContainer.Position = UDim2.new(0, 10, 0, 80)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local SendButton = Instance.new("TextButton")
SendButton.Name = "SendButton"
SendButton.Size = UDim2.new(0, 125, 1, 0)
SendButton.Position = UDim2.new(0, 0, 0, 0)
SendButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Made more black
SendButton.BackgroundTransparency = 0.4 -- Made more transparent
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.Text = "Send"
SendButton.TextSize = 14
SendButton.Font = Enum.Font.GothamBold
SendButton.Parent = ButtonContainer

local SendCorner = Instance.new("UICorner")
SendCorner.CornerRadius = UDim.new(0, 8) -- Made more rounded
SendCorner.Parent = SendButton

local SaveButton = Instance.new("TextButton")
SaveButton.Name = "SaveButton"
SaveButton.Size = UDim2.new(0, 125, 1, 0)
SaveButton.Position = UDim2.new(1, -125, 0, 0)
SaveButton.BackgroundColor3 = Color3.fromRGB(0, 80, 0) -- Made more black
SaveButton.BackgroundTransparency = 0.4 -- Made more transparent
SaveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveButton.Text = "💾 Save"
SaveButton.TextSize = 14
SaveButton.Font = Enum.Font.GothamBold
SaveButton.Parent = ButtonContainer

local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 8) -- Made more rounded
SaveCorner.Parent = SaveButton

-- Saved Phrases Section
local PhrasesLabel = Instance.new("TextLabel")
PhrasesLabel.Name = "PhrasesLabel"
PhrasesLabel.Size = UDim2.new(1, -20, 0, 20)
PhrasesLabel.Position = UDim2.new(0, 10, 0, 115)
PhrasesLabel.BackgroundTransparency = 1
PhrasesLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PhrasesLabel.TextSize = 12
PhrasesLabel.Font = Enum.Font.GothamBold
PhrasesLabel.Text = "SAVED PHRASES:"
PhrasesLabel.TextXAlignment = Enum.TextXAlignment.Left
PhrasesLabel.Parent = MainFrame

local PhrasesFrame = Instance.new("ScrollingFrame")
PhrasesFrame.Name = "PhrasesFrame"
PhrasesFrame.Size = UDim2.new(1, -20, 0, 155)
PhrasesFrame.Position = UDim2.new(0, 10, 0, 135)
PhrasesFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5) -- Made more black
PhrasesFrame.BackgroundTransparency = 0.4 -- Made more transparent
PhrasesFrame.BorderSizePixel = 0
PhrasesFrame.ScrollBarThickness = 6
PhrasesFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
PhrasesFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PhrasesFrame.Parent = MainFrame

local PhrasesCorner = Instance.new("UICorner")
PhrasesCorner.CornerRadius = UDim.new(0, 8) -- Made more rounded
PhrasesCorner.Parent = PhrasesFrame

local PhrasesLayout = Instance.new("UIListLayout")
PhrasesLayout.SortOrder = Enum.SortOrder.LayoutOrder
PhrasesLayout.Padding = UDim.new(0, 2)
PhrasesLayout.Parent = PhrasesFrame

local StatusIndicator = Instance.new("Frame")
StatusIndicator.Name = "StatusIndicator"
StatusIndicator.Size = UDim2.new(0, 6, 0, 6)
StatusIndicator.Position = UDim2.new(0, 12, 0, 12)
StatusIndicator.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
StatusIndicator.BackgroundTransparency = 0.4 -- Made more transparent
StatusIndicator.Parent = TitleBar

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(1, 0)
StatusCorner.Parent = StatusIndicator

-- Function to create button effects (moved before createPhraseButton)
local function createButtonEffect(button)
    local originalColor = button.BackgroundColor3
    local originalTransparency = button.BackgroundTransparency

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = originalColor:Lerp(Color3.fromRGB(50, 50, 50), 0.3),
            BackgroundTransparency = originalTransparency * 0.8
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = originalColor,
            BackgroundTransparency = originalTransparency
        }):Play()
    end)

    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = originalTransparency * 0.5
        }):Play()
    end)

    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = originalColor,
            BackgroundTransparency = originalTransparency
        }):Play()
    end)
end

-- Function to create phrase buttons
local function createPhraseButton(originalPhrase, convertedPhrase, index)
    local phraseButton = Instance.new("TextButton")
    phraseButton.Name = "PhraseButton" .. index
    phraseButton.Size = UDim2.new(1, -10, 0, 25)
    phraseButton.Position = UDim2.new(0, 5, 0, 0)
    phraseButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Made more black
    phraseButton.BackgroundTransparency = 0.4 -- Made more transparent
    phraseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    phraseButton.TextSize = 11
    phraseButton.Font = Enum.Font.Gotham
    phraseButton.TextXAlignment = Enum.TextXAlignment.Left
    phraseButton.TextTruncate = Enum.TextTruncate.AtEnd
    
    -- Show original phrase but truncated if too long
    local displayText = originalPhrase
    if string.len(displayText) > 35 then
        displayText = string.sub(displayText, 1, 32) .. "..."
    end
    phraseButton.Text = "  " .. displayText
    
    phraseButton.Parent = PhrasesFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8) -- Made more rounded
    buttonCorner.Parent = phraseButton
    
    -- Delete button
    local deleteButton = Instance.new("TextButton")
    deleteButton.Name = "DeleteButton"
    deleteButton.Size = UDim2.new(0, 20, 0, 20)
    deleteButton.Position = UDim2.new(1, -22, 0, 2.5)
    deleteButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    deleteButton.BackgroundTransparency = 0.4 -- Made more transparent
    deleteButton.Text = "×"
    deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    deleteButton.TextSize = 12
    deleteButton.Font = Enum.Font.GothamBold
    deleteButton.Parent = phraseButton
    
    local deleteCorner = Instance.new("UICorner")
    deleteCorner.CornerRadius = UDim.new(0, 6) -- Made more rounded
    deleteCorner.Parent = deleteButton
    
    -- Button effects
    createButtonEffect(phraseButton)
    createButtonEffect(deleteButton)
    
    -- Send phrase directly when clicked
    phraseButton.MouseButton1Click:Connect(function()
        sendChat(originalPhrase)
        showNotification("Message Sent", "Sent: " .. (string.len(originalPhrase) > 20 and string.sub(originalPhrase, 1, 20) .. "..." or originalPhrase))
    end)
    
    -- Delete phrase when delete button clicked
    deleteButton.MouseButton1Click:Connect(function()
        -- Find the current index of this phrase to delete it properly
        local phraseToDelete = nil
        for i, phraseData in ipairs(savedPhrases) do
            if phraseData.original == originalPhrase then
                phraseToDelete = i
                break
            end
        end
        
        if phraseToDelete then
            table.remove(savedPhrases, phraseToDelete)
            savePhrases()
            updatePhrasesList()
            showNotification("Phrase Deleted", "Phrase removed from saved list")
        end
    end)
    
    return phraseButton
end

-- Function to update the phrases list display
function updatePhrasesList()
    -- Clear existing phrase buttons
    for _, child in pairs(PhrasesFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Create new phrase buttons with proper indexing
    for i, phraseData in ipairs(savedPhrases) do
        createPhraseButton(phraseData.original, phraseData.converted, i)
    end
    
    -- Update canvas size
    PhrasesFrame.CanvasSize = UDim2.new(0, 0, 0, #savedPhrases * 27)
end

local function enableDragging(frame, handle)
    local dragging = false
    local dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
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

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                         input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local targetPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            TweenService:Create(frame, tweenInfo, {Position = targetPos}):Play()
        end
    end)
end

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 280, 0, 30) or UDim2.new(0, 280, 0, 300)
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    TweenService:Create(MainFrame, tweenInfo, {Size = targetSize}):Play()
    TweenService:Create(Shadow, tweenInfo, {Size = UDim2.new(1, 30, targetSize.Y.Scale, targetSize.Y.Offset + 30)}):Play()

    InputBox.Visible = not minimized
    ButtonContainer.Visible = not minimized
    PhrasesLabel.Visible = not minimized
    PhrasesFrame.Visible = not minimized
end)

local function processText()
    local inputText = InputBox.Text
    if inputText ~= "" then
       sendChat(inputText)
       InputBox.Text = ""
    end
end

local function saveCurrentPhrase()
    local inputText = InputBox.Text
    if inputText ~= "" and string.len(inputText) > 0 then
        local convertedText = filter(inputText, letters, prefixCharacter, suffixCharacter)
        
        -- Check if phrase already exists
        local alreadyExists = false
        for _, phraseData in ipairs(savedPhrases) do
            if phraseData.original == inputText then
                alreadyExists = true
                break
            end
        end
        
        if not alreadyExists then
            table.insert(savedPhrases, {
                original = inputText,
                converted = convertedText
            })
            savePhrases()
            updatePhrasesList()
            showNotification("Phrase Saved", "Added to saved phrases!")
        else
            showNotification("Already Saved", "This phrase is already in your saved list")
        end
    else
        showNotification("No Text", "Enter a message to save")
    end
end

SendButton.MouseButton1Click:Connect(processText)
SaveButton.MouseButton1Click:Connect(saveCurrentPhrase)

InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        processText()
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local fadeOut = TweenService:Create(MainFrame, tweenInfo, {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset)
    })

    fadeOut.Completed:Connect(function()
        GUI:Destroy()
    end)
    fadeOut:Play()
end)

createButtonEffect(SendButton)
createButtonEffect(SaveButton)
createButtonEffect(CloseButton)
createButtonEffect(MinimizeButton)

enableDragging(MainFrame, TitleBar)

InputBox.Focused:Connect(function()
    TweenService:Create(InputBox, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BackgroundTransparency = 0.1
    }):Play()
end)

InputBox.FocusLost:Connect(function()
    TweenService:Create(InputBox, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(10, 10, 10),
        BackgroundTransparency = 0.3
    }):Play()
end)

-- Load saved phrases on startup
loadPhrases()
updatePhrasesList()
