local a = game:GetService("Players").LocalPlayer
repeat
    task.wait()
until game:IsLoaded() and game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character and
    game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate") and
    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
    game:GetService("Players").LocalPlayer.Character.Humanoid:FindFirstChild("Animator")
local b = game:GetService("Players").LocalPlayer.Character.Animate
local c = "http://www.roblox.com/asset/?id="
local d
local e = game.Workspace
if not getgenv().OrigLighting then
    getgenv().OrigLighting = game.Lighting.ClockTime
end
if not getgenv().AlreadyLoaded then
    getgenv().AlreadyLoaded = false
end
game.StarterPlayer.AllowCustomAnimations = true
e:SetAttribute("RbxLegacyAnimationBlending", true)
if not getgenv().OriginalAnimations then
    getgenv().OriginalAnimations = {}
    if b:FindFirstChild("pose") then
        local f = game:GetService("Players").LocalPlayer.Character.Animate.pose:FindFirstChildOfClass("Animation")
        if f then
            OriginalAnimations[3] = f.AnimationId
        end
    end
    OriginalAnimations[1] = b.idle.Animation1.AnimationId
    OriginalAnimations[2] = b.idle.Animation2.AnimationId
    OriginalAnimations[4] = b.walk:FindFirstChildOfClass("Animation").AnimationId
    OriginalAnimations[5] = b.run:FindFirstChildOfClass("Animation").AnimationId
    OriginalAnimations[6] = b.jump:FindFirstChildOfClass("Animation").AnimationId
    OriginalAnimations[7] = b.climb:FindFirstChildOfClass("Animation").AnimationId
    OriginalAnimations[8] = b.fall:FindFirstChildOfClass("Animation").AnimationId
    if b:FindFirstChild("swim") then
        OriginalAnimations[9] = b.swim:FindFirstChildOfClass("Animation").AnimationId
        OriginalAnimations[10] = b.swimidle:FindFirstChildOfClass("Animation").AnimationId
    end
end
local function g(h)
    return getgenv().OriginalAnimations[h]
end
if syn and syn.queue_on_teleport and not getgenv().AlreadyLoaded then
    syn.queue_on_teleport(
        "loadstring(game:HttpGet('https://raw.githubusercontent.com/Eazvy/public-scripts/main/Universal_Animations_Emotes.lua'))()"
    )
elseif queue_on_teleport and not getgenv().AlreadyLoaded then
    queue_on_teleport(
        "loadstring(game:HttpGet('https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua',true))()\nloadstring(game:HttpGet('https://raw.githubusercontent.com/Eazvy/public-scripts/main/Universal_Animations_Emotes.lua'))()"
    )
end
local i = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(
    function()
        i:Button2Down(Vector2.new(0, 0), e.CurrentCamera.CFrame)
        wait(1)
        i:Button2Up(Vector2.new(0, 0), e.CurrentCamera.CFrame)
    end
)
local j = 0
local k = 0
getgenv().Settings = {
    Favorite = {},
    Custom = {
        Name = nil,
        Idle = nil,
        Idle2 = nil,
        Idle3 = nil,
        Walk = nil,
        Run = nil,
        Jump = nil,
        Climb = nil,
        Fall = nil,
        Swim = nil,
        SwimIdle = nil,
        Wave = 9527883498,
        Laugh = 507770818,
        Cheer = 507770677,
        Point = 507770453,
        Sit = 2506281703,
        Dance = 507771019,
        Dance2 = 507776043,
        Dance3 = 507777268,
        Weight = 9,
        Weight2 = 1
    },
    Chat = false,
    Day = false,
    Spy = false,
    Player,
    EmoteChat = false,
    Animate = false,
    RandomAnim = false,
    Refresh = false,
    DeathPosition,
    Noclip = false,
    RapePlayer = false,
    TwerkAss = false,
    TwerkAss2 = false,
    RandomEmote = false,
    Goto = false,
    Annoy = false,
    CopyMovement = false,
    SyncAnimations = false,
    PlayAlways = false,
    Platform = false,
    FlySpeed = 50,
    InfJump = false,
    ClickTeleport = false,
    ClickToSelect = false,
    SyncEmote = false,
    PlayerSync,
    AnimationSpeedToggle = false,
    CurrentAnimation = "",
    FreezeAnimation = false,
    FreezeEmote = false,
    EmotePrefix = "/em",
    AnimationPrefix = "/a",
    EmoteSpeed = 1,
    AnimationSpeed = 1,
    ReverseSpeed = -1,
    SelectedAnimation = "",
    LastEmote = "",
    Looped = false,
    Reversed = false,
    Time = false,
    TimePosition = 1
}
if makefolder and not isfile("Eazvy-Hub") then
    makefolder("Eazvy-Hub")
end
if isfile and not isfile("Eazvy-Hub/Animations_Settings.txt") and writefile then
    writefile("Eazvy-Hub/Animations_Settings.txt", game:GetService("HttpService"):JSONEncode(getgenv().Settings))
end
function UpdateFile()
    if writefile then
        writefile("Eazvy-Hub/Animations_Settings.txt", game:GetService("HttpService"):JSONEncode(getgenv().Settings))
    end
end
if readfile and isfile("Eazvy-Hub/Animations_Settings.txt") then
    getgenv().Settings = game:GetService("HttpService"):JSONDecode(readfile("Eazvy-Hub/Animations_Settings.txt"))
    if Settings.EmotePrefix and Settings.EmotePrefix == "/e" then
        Settings.EmotePrefix = "/em"
        UpdateFile()
    end
end
local l = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
local m = game:GetService("HttpService")
local function n()
    local o = {}
    local p =
        l(
        {
            Url = "https://games.roblox.com/v1/games/" ..
                tostring(game.PlaceId) .. "/servers/Public?sortOrder=Desc&limit=100"
        }
    )
    local q = m:JSONDecode(p.Body)
    if q and q.data then
        for r, s in next, q.data do
            if type(s) == "table" and tonumber(s.playing) and tonumber(s.maxPlayers) and s.playing < s.maxPlayers then
                table.insert(o, 1, s.id)
            end
        end
    end
    if #o > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            o[math.random(1, #o)],
            game.Players.LocalPlayer
        )
    end
    game:GetService("TeleportService").TeleportInitFailed:Connect(
        function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(
                game.PlaceId,
                o[math.random(1, #o)],
                game.Players.LocalPlayer
            )
        end
    )
end
function getPlayersByName(t)
    local t, u, v = string.lower(t), #t, {}
    for w, s in pairs(game:GetService("Players"):GetPlayers()) do
        if s.Name ~= game:GetService("Players").LocalPlayer then
            if t:sub(0, 1) == "@" then
                if string.sub(string.lower(s.Name), 1, u - 1) == t:sub(2) then
                    return s
                end
            else
                if string.sub(string.lower(s.Name), 1, u) == t or string.sub(string.lower(s.DisplayName), 1, u) == t then
                    return s
                end
            end
        end
    end
end
local x = loadstring(game:HttpGet("https://raw.githubusercontent.com/Eazvy/Eazvy-Hub/main/Content/UILibrary.lua"))()
local function y(z, A)
    x:MakeNotification(
        {Name = "Animation - Error", Content = z .. "\n" .. A, Image = "rbxassetid://161551681", Time = 4}
    )
end
local function B(z, A)
    x:MakeNotification(
        {Name = "Animation - Success", Content = z .. "\n" .. A, Image = "rbxassetid://4914902889", Time = 4}
    )
end
local function C(z, A, D)
    x:MakeNotification(
        {Name = "Animation - Success", Content = z .. "\n" .. A, Image = "rbxassetid://4914902889", Time = D}
    )
end
task.spawn(
    function()
        if getgenv().Teleported and game.CoreGui:FindFirstChild("Orion") then
            game.CoreGui.Orion.Enabled = false
            B(
                "Successfully Loaded Animations Script",
                "Press Q to Toggle UI we've minimized it because you're coming from a different server."
            )
        end
    end
)
local E = {
    ["Fashion"] = 3333331310,
    ["Baby Dance"] = 4265725525,
    ["Cha-Cha"] = 6862001787,
    ["Monkey"] = 3333499508,
    ["Shuffle"] = 4349242221,
    ["Top Rock"] = 3361276673,
    ["Around Town"] = 3303391864,
    ["Fancy Feet"] = 3333432454,
    ["Hype Dance"] = 3695333486,
    ["Bodybuilder"] = 3333387824,
    ["Idol"] = 4101966434,
    ["Curtsy"] = 4555816777,
    ["Happy"] = 4841405708,
    ["Quiet Waves"] = 7465981288,
    ["Sleep"] = 4686925579,
    ["Floss Dance"] = 5917459365,
    ["Shy"] = 3337978742,
    ["Godlike"] = 3337994105,
    ["Hero Landing"] = 5104344710,
    ["High Wave"] = 5915690960,
    ["Cower"] = 4940563117,
    ["Bored"] = 5230599789,
    ["Show Dem Wrists -KSI"] = 7198989668,
    ["Celebrate"] = 3338097973,
    ["Dash"] = 582855105,
    ["Beckon"] = 5230598276,
    ["Haha"] = 3337966527,
    ["Lasso Turn - Tai Verdes"] = 7942896991,
    ["Line Dance"] = 4049037604,
    ["Shrug"] = 3334392772,
    ["Point2"] = 3344585679,
    ["Stadium"] = 3338055167,
    ["Confused"] = 4940561610,
    ["Side to Side"] = 3333136415,
    ['Old Town Road Dance - Lil Nas X"'] = 5937560570,
    ["Hello"] = 3344650532,
    ["Dolphin Dance"] = 5918726674,
    ["Samba"] = 6869766175,
    ["Break Dance"] = 5915648917,
    ["Hips Poppin' - Zara Larsson"] = 6797888062,
    ["Wake Up Call - KSI"] = 7199000883,
    ["Greatest"] = 3338042785,
    ["On The Outside - Twenty One"] = 7422779536,
    ["Boxing Punch - KSI"] = 7202863182,
    ["Sad"] = 4841407203,
    ["Flowing Breeze"] = 7465946930,
    ["Twirl"] = 3334968680,
    ["Jumping Wave"] = 4940564896,
    ["HOLIDAY Dance - Lil Nas X (LNX)"] = 5937558680,
    ["Take Me Under - Zara Larsson"] = 6797890377,
    ["Shuffle"] = 4349242221,
    ["Dizzy"] = 3361426436,
    ["Dancing' Shoes - Twenty One"] = 7404878500,
    ["Fashionable"] = 3333331310,
    ["Fast Hands"] = 4265701731,
    ["Tree"] = 4049551434,
    ["Agree"] = 4841397952,
    ["Power Blast"] = 4841403964,
    ["Swoosh"] = 3361481910,
    ["Jumping Cheer"] = 5895324424,
    ["Disagree"] = 4841401869,
    ["Rodeo Dance - Lil Nas X (LNX)"] = 5918728267,
    ["It Ain't My Fault - Zara Larsson"] = 6797891807,
    ["Rock On"] = 5915714366,
    ["Block Partier"] = 6862022283,
    ["Dorky Dance"] = 4212455378,
    ["Zombie"] = 4210116953,
    ["AOK - Tai Verdes"] = 7942885103,
    ["T"] = 3338010159,
    ["Cobra Arms - Tai   Verdes"] = 7942890105,
    ["Panini Dance - Lil Nas X (LNX)"] = 5915713518,
    ["Fishing"] = 3334832150,
    ["Robot"] = 3338025566,
    ["Around Town"] = 3303391864,
    ["Saturday Dance - Twenty One"] = 7422807549,
    ["Top Rock"] = 3361276673,
    ["Keeping Time"] = 4555808220,
    ["Air Dance"] = 4555782893,
    ["Fancy Feet"] = 3333432454,
    ["Rock Guitar - Royal Blood"] = 6532134724,
    ["Borock's Rage"] = 3236842542,
    ["Ud'zal's Summoning"] = 3303161675,
    ["Y"] = 4349285876,
    ["Swan Dance"] = 7465997989,
    ["Louder"] = 3338083565,
    ["Up and Down - Twenty One"] = 7422797678,
    ["Swish"] = 3361481910,
    ["Drummer Moves - Twenty One"] = 7422527690,
    ["Sneaky"] = 3334424322,
    ["Heisman Pose"] = 3695263073,
    ["Jacks"] = 3338066331,
    ["Cha-Cha 2"] = 3695322025,
    ["BURBERRY LOLA ATTITUDE - NIMBUS"] = 10147821284,
    ["BURBERRY LOLA  ATTITUDE - GEM"] = 10147815602,
    ["BURBERRY LOLA ATTITUDE - HYDRO"] = 10147823318,
    ["BURBERRY LOLA ATTITUDE - BLOOM"] = 10147817997,
    ["Superhero Reveal"] = 3695373233,
    ["Air Guitar"] = 3695300085,
    ["Dismissive Wave"] = 3333272779,
    ["Country Line  Dance - Lil Nas X"] = 5915712534,
    ["Salute"] = 3333474484,
    ["Applaud"] = 5915693819,
    ["Get Out"] = 3333272779,
    ["Hwaiting (화이팅)"] = 9527885267,
    ["Annyeong (안녕)"] = 9527883498,
    ["Bunny Hop"] = 4641985101,
    ["Sandwich Dance"] = 4406555273,
    ["Hyperfast  5G Dance Move"] = 9408617181,
    ["Victory - 24kGoldn"] = 9178377686,
    ["Tantrum"] = 5104341999,
    ["Rock Star - Royal Blood"] = 10714400171,
    ["Drum Solo - Royal Blood"] = 6532839007,
    ["Drum Master - Royal Blood"] = 6531483720,
    ["High Hands"] = 9710985298,
    ["Tilt"] = 3334538554,
    ["Gashina - SUNMI"] = 9527886709,
    ["Chicken Dance"] = 4841399916,
    ["You can't sit with us - Sunmi"] = 9983520970,
    ["Frosty Flair - Tommy Hilfiger"] = 10214311282,
    ["Floor Rock Freeze - Tommy Hilfiger"] = 10214314957,
    ["Boom Boom Clap - George Ezra"] = 10370346995,
    ["Cartwheel - George Ezra"] = 10370351535,
    ["Chill Vibes - George Ezra"] = 10370353969,
    ["Sidekicks - George Ezra"] = 10370362157,
    ["The Conductor - George Ezra"] = 10370359115,
    ["Super Charge"] = 10478338114,
    ["Swag Walk"] = 10478341260,
    ["Mean Mug - Tommy Hilfiger"] = 10214317325,
    ["V Pose - Tommy Hilfiger"] = 10214319518,
    ["Uprise - Tommy Hilfiger"] = 10275008655,
    ["2 Baddies Dance Move - NCT 127"] = 12259828678,
    ["Kick It Dance Move - NCT 127"] = 12259826609,
    ["Sticker Dance Move - NCT 127"] = 12259825026,
    ["Elton John - Rock Out"] = 11753474067,
    ["Elton John - Heart Skip"] = 11309255148,
    ["Elton John - Still Standing"] = 11444443576,
    ["Elton John - Elevate"] = 11394033602,
    ["Elton John - Cat Man"] = 11444441914,
    ["Elton John - Piano Jump"] = 11453082181,
    ["Alo Yoga Pose - Triangle"] = 12507084541,
    ["Alo Yoga Pose - Warrior II"] = 12507083048,
    ["Alo Yoga Pose - Lotus Position"] = 12507085924,
    ["Alo Yoga Pose - Warrior II"] = 12507083048,
    ["Alo Yoga Pose - Triangle"] = 12507084541,
    ["TWICE-Moonlight-Sunrise"] = 12714233242,
    ["TWICE-Set-Me-Free-Dance-1"] = 12714228341,
    ["TWICE-Set-Me-Free-Dance-2"] = 12714231087,
    ["Ay-Yo-Dance-Move-NCT-127"] = 12804157977,
    ["TWICE-The-Feels"] = 12874447851,
    ["Zombie"] = 10714089137,
    ["Rise-Above-The-Chainsmokers"] = 12992262118,
    ["TWICE-What-Is-Love"] = 13327655243,
    ["Man-City-Bicycle-Kick"] = 13421057998,
    ["TWICE-Fancy"] = 13520524517,
    ["TWICE Pop by Nayeon"] = 13768941455,
    ["Tommy - Archer"] = 13823324057,
    ["TWICE-Pop-by-Nayeon"] = 13768941455,
    ["Man City Backflip"] = 13694100677,
    ["Man-City-Scorpion-Kick"] = 13694096724,
    ["Arm Twist"] = 10713968716,
    ["Tommy - Archer"] = 13823324057,
    ["YUNGBLUD – HIGH KICK"] = 14022936101,
    ["TWICE Like Ooh-Ahh"] = 14123781004,
    ["Baby Queen - Air Guitar & Knee Slide"] = 14352335202,
    ["Baby Queen - Dramatic Bow"] = 14352337694,
    ["Baby Queen - Face Frame"] = 14352340648,
    ["Baby Queen - Bouncy Twirl"] = 14352343065,
    ["Baby Queen - Strut"] = 14352362059,
    ["BLACKPINK Pink Venom - Get em Get em Get em"] = 14548619594,
    ["BLACKPINK Pink Venom - I Bring the Pain Like…"] = 14548620495,
    ["BLACKPINK Pink Venom - Straight to Ya Dome"] = 14548621256,
    ["TWICE LIKEY"] = 14899979575,
    ["TWICE Feel Special"] = 14899980745,
    ["BLACKPINK Shut Down - Part 1"] = 14901306096,
    ["BLACKPINK Shut Down - Part 2"] = 14901308987,
    ["Bone Chillin' Bop"] = 15122972413,
    ["Paris Hilton - Sliving For The Groove"] = 15392759696,
    ["Paris Hilton - Iconic IT-Grrrl"] = 15392756794,
    ["Paris Hilton - Checking My Angles"] = 15392752812,
    ["BLACKPINK JISOO Flower"] = 15439354020,
    ["BLACKPINK JENNIE You and Me"] = 15439356296,
    ["Rock n Roll"] = 15505458452,
    ["Air Guitar"] = 15505454268,
    ["Victory Dance"] = 15505456446,
    ["Flex Walk"] = 15505459811,
    ["Olivia Rodrigo Head Bop"] = 15517864808,
    ["Olivia Rodrigo good 4 u"] = 15517862739,
    ["Olivia Rodrigo Fall Back to Float"] = 15549124879,
    ["Nicki Minaj That's That Super Bass"] = 15571446961,
    ["Nicki Minaj Boom Boom Boom"] = 15571448688,
    ["Nicki Minaj Anaconda"] = 15571450952,
    ["Nicki Minaj Starships"] = 15571453761,
    ["Yungblud Happier Jump"] = 15609995579,
    ["Festive Dance"] = 15679621440,
    ["BLACKPINK LISA Money"] = 15679623052,
    ["BLACKPINK ROSÉ On The Ground"] = 15679624464,
    ["Imagine Dragons - “Bones” Dance"] = 15689279687,
    ['GloRilla - "Tomorrow" Dance'] = 15689278184,
    ["d4vd - Backflip"] = 15693621070,
    ["ericdoa - dance"] = 15698402762,
    ["Cuco - Levitate"] = 15698404340,
    ["Mean Girls Dance Break"] = 15963314052,
    ["Paris Hilton Sanasa"] = 16126469463,
    ["BLACKPINK Ice Cream"] = 16181797368,
    ["BLACKPINK Kill This Love"] = 16181798319,
    ["TWICE I GOT YOU part 1"] = 16215030041,
    ["TWICE I GOT YOU part 2"] = 16256203246,
    ["Dave's Spin Move - Glass Animals"] = 16272432203,
    ["Sol de Janeiro - Samba"] = 16270690701,
    ["Beauty Touchdown"] = 16302968986,
    ["Skadoosh Emote - Kung Fu Panda 4"] = 16371217304,
    ["Jawny - Stomp"] = 16392075853,
    ["Mae Stephens - Piano Hands"] = 16553163212,
    ["BLACKPINK Boombayah Emote"] = 16553164850,
    ["BLACKPINK DDU-DU DDU-DU"] = 16553170471,
    ["HIPMOTION - Amaarae"] = 16572740012,
    ["Mae Stephens – Arm Wave"] = 16584481352,
    ["Wanna play?"] = 16646423316,
    ["BLACKPINK-How-You-Like-That"] = 16874470507,
    ["BLACKPINK - Lovesick Girls"] = 16874472321,
    ["Mini Kong"] = 17000021306,
    ["HUGO Let's Drive!"] = 17360699557,
    ["Wisp - air guitar"] = 17370775305,
    ["Vans Ollie"] = 18305395285,
    ["Sturdy Dance - Ice Spice"] = 17746180844,
    ["Shuffle"] = 17748314784,
    ["Rolling Stones Guitar Strum"] = 18148804340,
    ["Rock Out - Bebe Rexha"] = 18225053113,
    ["SpongeBob Imaginaaation 🌈"] = 18443237526,
    ["SpongeBob Dance"] = 18443245017,
    ["Shrek Roar"] = 18524313628,
    ["Team USA Breaking Emote"] = 18526288497,
    ["NBA WNBA Fadeaway"] = 18526362841,
    ["Vroom Vroom"] = 18526397037,
    ["TMNT Dance"] = 18665811005,
    ["Olympic Dismount"] = 18665825805,
    ["BLACKPINK As If It's Your Last"] = 18855536648,
    ["BLACKPINK Don't know what to do"] = 18855531354,
    ["TWICE ABCD by Nayeon"] = 18933706381,
    ["Charli xcx - Apple Dance"] = 18946844622,
    ["The Zabb"] = 129470135909814,
    ["Fashion Klossette - Runway my way"] = 80995190624232,
    ["ALTÉGO - Couldn’t Care Less"] = 107875941017127,
    ["Fashion Roadkill"] = 136831243854748,
    ["Skibidi Toilet - Titan Speakerman Laser Spin"] = 134283166482394,
    ["Chappell Roan HOT TO GO!"] = 85267023718407,
    ["Secret Handshake Dance"] = 71243990877913,
    ["KATSEYE - Touch"] = 135876612109535,
    ["Fashion Spin"] = 131669256082047,
    ["TWICE Strategy"] = 97311229290836,
    ["NBA Monster Dunk"] = 132748833449150,
    ["DearALICE - Ariana"] = 134318425949290,
    ["The Weeknd Starboy Strut"] = 71105746210464,
    ["The Weeknd Opening Night"] = 133110725387025,
    ["Robot M3GAN"] = 125803725853577,
    ["M3GAN's Dance"] = 99649534578309,
    ["Rasputin – Boney M."] = 114872820353992,
    ["Thanos Happy Jump - Squid Game"] = 97611664803614,
    ["Young-hee Head Spin - Squid Game"] = 112011282168475,
    ["TWICE Takedown"] = 140182843839424,
    ["Stray Kids Walkin On Water"] = 125064469983655
}
local F = {
    Emotes = {Weight = 9, Weight2 = 1},
    Stylish = {
        Idle = 616136790,
        Idle2 = 616138447,
        Idle3 = 886888594,
        Walk = 616146177,
        Run = 616140816,
        Jump = 616139451,
        Climb = 616133594,
        Fall = 616134815,
        Swim = 616143378,
        SwimIdle = 616144772,
        Weight = 9,
        Weight2 = 1
    },
    Zombie = {
        Idle = 616158929,
        Idle2 = 616160636,
        Idle3 = 885545458,
        Walk = 616168032,
        Run = 616163682,
        Jump = 616161997,
        Climb = 616156119,
        Fall = 616157476,
        Swim = 616165109,
        SwimIdle = 616166655,
        Weight = 9,
        Weight2 = 1
    },
    Robot = {
        Idle = 616088211,
        Idle2 = 616089559,
        Idle3 = 885531463,
        Walk = 616095330,
        Run = 616091570,
        Jump = 616090535,
        Climb = 616086039,
        Fall = 616087089,
        Swim = 616092998,
        SwimIdle = 616094091,
        Weight = 9,
        Weight2 = 1
    },
    Toy = {
        Idle = 782841498,
        Idle2 = 782845736,
        Idle3 = 980952228,
        Walk = 782843345,
        Run = 782842708,
        Jump = 782847020,
        Climb = 782843869,
        Fall = 782846423,
        Swim = 782844582,
        SwimIdle = 782845186,
        Weight = 9,
        Weight2 = 1
    },
    Cartoony = {
        Idle = 742637544,
        Idle2 = 742638445,
        Idle3 = 885477856,
        Walk = 742640026,
        Run = 742638842,
        Jump = 742637942,
        Climb = 742636889,
        Fall = 742637151,
        Swim = 742639220,
        SwimIdle = 742639812,
        Weight = 9,
        Weight2 = 1
    },
    Superhero = {
        Idle = 616111295,
        Idle2 = 616113536,
        Idle3 = 885535855,
        Walk = 616122287,
        Run = 616117076,
        Jump = 616115533,
        Climb = 616104706,
        Fall = 616108001,
        Swim = 616119360,
        SwimIdle = 616120861,
        Weight = 9,
        Weight2 = 1
    },
    Mage = {
        Idle = 707742142,
        Idle2 = 707855907,
        Idle3 = 885508740,
        Walk = 707897309,
        Run = 707861613,
        Jump = 707853694,
        Climb = 707826056,
        Fall = 707829716,
        Swim = 707876443,
        SwimIdle = 707894699,
        Weight = 9,
        Weight2 = 1
    },
    Levitation = {
        Idle = 616006778,
        Idle2 = 616008087,
        Idle3 = 886862142,
        Walk = 616013216,
        Run = 616010382,
        Jump = 616008936,
        Climb = 616003713,
        Fall = 616005863,
        Swim = 616011509,
        SwimIdle = 616012453,
        Weight = 9,
        Weight2 = 1
    },
    Vampire = {
        Idle = 1083445855,
        Idle2 = 1083450166,
        Idle3 = 1088037547,
        Walk = 1083473930,
        Run = 1083462077,
        Jump = 1083455352,
        Climb = 1083439238,
        Fall = 1083443587,
        Swim = 1083464683,
        SwimIdle = 1083467779,
        Weight = 9,
        Weight2 = 1
    },
    Elder = {
        Idle = 845397899,
        Idle2 = 845400520,
        Idle3 = 901160519,
        Walk = 845403856,
        Run = 845386501,
        Jump = 845398858,
        Climb = 845392038,
        Fall = 845396048,
        Swim = 845401742,
        SwimIdle = 845403127,
        Weight = 9,
        Weight2 = 1
    },
    Werewolf = {
        Idle = 1083195517,
        Idle2 = 1083214717,
        Idle3 = 1099492820,
        Walk = 1083178339,
        Run = 1083216690,
        Jump = 1083218792,
        Climb = 1083182000,
        Fall = 1083189019,
        Swim = 1083222527,
        SwimIdle = 1083225406,
        Weight = 9,
        Weight2 = 1
    },
    Knight = {
        Idle = 657595757,
        Idle2 = 657568135,
        Idle3 = 885499184,
        Walk = 657552124,
        Run = 657564596,
        Jump = 658409194,
        Climb = 658360781,
        Fall = 657600338,
        Swim = 657560551,
        SwimIdle = 657557095,
        Weight = 9,
        Weight2 = 1
    },
    Bold = {
        Idle = 16738333868,
        Idle2 = 16738334710,
        Idle3 = 16738335517,
        Walk = 16738340646,
        Run = 16738337225,
        Jump = 16738336650,
        Climb = 16738332169,
        Fall = 16738333171,
        Swim = 16738339158,
        SwimIdle = 16738339817,
        Weight = 9,
        Weight2 = 1
    },
    Astronaut = {
        Idle = 891621366,
        Idle2 = 891633237,
        Idle3 = 1047759695,
        Walk = 891667138,
        Run = 891636393,
        Jump = 891627522,
        Climb = 891609353,
        Fall = 891617961,
        Swim = 891639666,
        SwimIdle = 891663592,
        Weight = 9,
        Weight2 = 1
    },
    Bubbly = {
        Idle = 910004836,
        Idle2 = 910009958,
        Idle3 = 1018536639,
        Walk = 910034870,
        Run = 910025107,
        Jump = 910016857,
        Climb = 909997997,
        Fall = 910001910,
        Swim = 910028158,
        SwimIdle = 910030921,
        Weight = 9,
        Weight2 = 1
    },
    Pirate = {
        Idle = 750781874,
        Idle2 = 750782770,
        Idle3 = 885515365,
        Walk = 750785693,
        Run = 750783738,
        Jump = 750782230,
        Climb = 750779899,
        Fall = 750780242,
        Swim = 750784579,
        SwimIdle = 750785176,
        Weight = 9,
        Weight2 = 1
    },
    Rthro = {
        Idle = 2510196951,
        Idle2 = 2510197257,
        Idle3 = 3711062489,
        Walk = 2510202577,
        Run = 2510198475,
        Jump = 2510197830,
        Climb = 2510192778,
        Fall = 2510195892,
        Swim = 2510199791,
        SwimIdle = 2510201162,
        Weight = 9,
        Weight2 = 1
    },
    Ninja = {
        Idle = 656117400,
        Idle2 = 656118341,
        Idle3 = 886742569,
        Walk = 656121766,
        Run = 656118852,
        Jump = 656117878,
        Climb = 656114359,
        Fall = 656115606,
        Swim = 656119721,
        SwimIdle = 656121397,
        Weight = 9,
        Weight2 = 1
    },
    Oldschool = {
        Idle = 5319828216,
        Idle2 = 5319831086,
        Idle3 = 5392107832,
        Walk = 5319847204,
        Run = 5319844329,
        Jump = 5319841935,
        Climb = 5319816685,
        Fall = 5319839762,
        Swim = 5319850266,
        SwimIdle = 5319852613,
        Weight = 9,
        Weight2 = 1
    },
    ["No Boundaries"] = {
        Idle = 18747067405,
        Idle2 = 18747063918,
        Idle3 = 18747063918,
        Walk = 18747074203,
        Run = 18747070484,
        Jump = 18747069148,
        Climb = 18747060903,
        Fall = 18747062535,
        Swim = 18747073181,
        SwimIdle = 18747071682,
        Weight = 9,
        Weight2 = 1
    },
    ["NFL Animation"] = {
        Idle = 92080889861410,
        Idle2 = 74451233229259,
        Idle3 = 80884010501210,
        Walk = 110358958299415,
        Run = 117333533048078,
        Jump = 119846112151352,
        Climb = 134630013742019,
        Fall = 129773241321032,
        Swim = 132697394189921,
        SwimIdle = 79090109939093,
        Weight = 9,
        Weight2 = 1
    },
    ["Adidas Sports"] = {
        Idle = 18537376492,
        Idle2 = 18537371272,
        Idle3 = 18537374150,
        Walk = 18537392113,
        Run = 18537384940,
        Jump = 18537380791,
        Climb = 18537363391,
        Fall = 18537367238,
        Swim = 18537389531,
        SwimIdle = 18537387180,
        Weight = 9,
        Weight2 = 1
    },
    ["Wickled Popular"] = {
        Idle = 118832222982049,
        Idle2 = 76049494037641,
        Idle3 = 138255200176080,
        Walk = 92072849924640,
        Run = 72301599441680,
        Jump = 104325245285198,
        Climb = 131326830509784,
        Fall = 121152442762481,
        Swim = 99384245425157,
        SwimIdle = 113199415118199,
        Weight = 9,
        Weight2 = 1
    },
    ["Catwalk Glam"] = {
        Idle = 133806214992291,
        Idle2 = 94970088341563,
        Idle3 = 87105332133518,
        Walk = 109168724482748,
        Run = 81024476153754,
        Jump = 116936326516985,
        Climb = 119377220967554,
        Fall = 92294537340807,
        Swim = 134591743181628,
        SwimIdle = 98854111361360,
        Weight = 9,
        Weight2 = 1
    },
    Princess = {
        Idle = 941003647,
        Idle2 = 941013098,
        Idle3 = 1159195712,
        Walk = 941028902,
        Run = 941015281,
        Jump = 0941008832,
        Climb = 940996062,
        Fall = 941000007,
        Swim = 941018893,
        SwimIdle = 941025398,
        Weight = 9,
        Weight2 = 1
    },
    Confident = {
        Idle = 1069977950,
        Idle2 = 1069987858,
        Idle3 = 1116160740,
        Walk = 1070017263,
        Run = 1070001516,
        Jump = 1069984524,
        Climb = 1069946257,
        Fall = 1069973677,
        Swim = 1070009914,
        SwimIdle = 1070012133,
        Weight = 9,
        Weight2 = 1
    },
    Popstar = {
        Idle = 1212900985,
        Idle2 = 1150842221,
        Idle3 = 1239733474,
        Walk = 1212980338,
        Run = 1212980348,
        Jump = 1212954642,
        Climb = 1213044953,
        Fall = 1212900995,
        Swim = 1212852603,
        SwimIdle = 1070012133,
        Weight = 9,
        Weight2 = 1
    },
    Patrol = {
        Idle = 1149612882,
        Idle2 = 1150842221,
        Idle3 = 1159573567,
        Walk = 1151231493,
        Run = 1150967949,
        Jump = 1150944216,
        Climb = 1148811837,
        Fall = 1148863382,
        Swim = 1151204998,
        SwimIdle = 1151221899,
        Weight = 9,
        Weight2 = 1
    },
    Sneaky = {
        Idle = 1132473842,
        Idle2 = 1132477671,
        Idle3 = "None",
        Walk = 1132510133,
        Run = 1132494274,
        Jump = 1132489853,
        Climb = 1132461372,
        Fall = 1132469004,
        Swim = 1132500520,
        SwimIdle = 1132506407,
        Weight = 9,
        Weight2 = 1
    },
    Cowboy = {
        Idle = 1014390418,
        Idle2 = 1014398616,
        Idle3 = 1159487651,
        Walk = 1014421541,
        Run = 1014401683,
        Jump = 1014394726,
        Climb = 1014380606,
        Fall = 1014384571,
        Swim = 1014406523,
        SwimIdle = 1014411816,
        Weight = 9,
        Weight2 = 1
    },
    Ghost = {
        Idle = 616006778,
        Idle2 = 616008087,
        Idle3 = 616008087,
        Walk = 616013216,
        Run = 616013216,
        Jump = 616008936,
        Climb = 0,
        Fall = 616005863,
        Swim = 616011509,
        SwimIdle = 616012453,
        Weight = 9,
        Weight2 = 1
    },
    ["Ghost 2"] = {
        Idle = 1151221899,
        Idle2 = 1151221899,
        Idle3 = "None",
        Walk = 1151221899,
        Run = 1151221899,
        Jump = 1151221899,
        Climb = 0,
        Fall = 1151221899,
        Swim = 16738339158,
        SwimIdle = 1151221899,
        Weight = 9,
        Weight2 = 1
    },
    ["Mr. Toilet"] = {
        Idle = 4417977954,
        Idle2 = 4417978624,
        Idle3 = 4441285342,
        Walk = 2510202577,
        Run = 4417979645,
        Jump = 2510197830,
        Climb = 2510192778,
        Fall = 2510195892,
        Swim = 2510199791,
        SwimIdle = 2510201162,
        Weight = 9,
        Weight2 = 1
    },
    Udzal = {
        Idle = 3303162274,
        Idle2 = 3303162549,
        Idle3 = 3710161342,
        Walk = 3303162967,
        Run = 3236836670,
        Jump = 2510197830,
        Climb = 2510192778,
        Fall = 2510195892,
        Swim = 2510199791,
        SwimIdle = 2510201162,
        Weight = 9,
        Weight2 = 1
    },
    ["Oinan Thickhoof"] = {
        Idle = 657595757,
        Idle2 = 657568135,
        Idle3 = 885499184,
        Walk = 2510202577,
        Run = 3236836670,
        Jump = 2510197830,
        Climb = 2510192778,
        Fall = 2510195892,
        Swim = 2510199791,
        SwimIdle = 2510201162,
        Weight = 9,
        Weight2 = 1
    },
    Borock = {
        Idle = 3293641938,
        Idle2 = 3293642554,
        Idle3 = 3710131919,
        Walk = 2510202577,
        Run = 3236836670,
        Jump = 2510197830,
        Climb = 2510192778,
        Fall = 2510195892,
        Swim = 2510199791,
        SwimIdle = 2510201162,
        Weight = 9,
        Weight2 = 1
    },
    ["Blocky Mech"] = {
        Idle = 4417977954,
        Idle2 = 4417978624,
        Idle3 = 4441285342,
        Walk = 2510202577,
        Run = 4417979645,
        Jump = 2510197830,
        Climb = 2510192778,
        Fall = 2510195892,
        Swim = 2510199791,
        SwimIdle = 2510201162,
        Weight = 9,
        Weight2 = 1
    },
    ["Stylized Female"] = {
        Idle = 4708191566,
        Idle2 = 4708192150,
        Idle3 = 121221,
        Walk = 4708193840,
        Run = 4708192705,
        Jump = 4708188025,
        Climb = 4708184253,
        Fall = 4708186162,
        Swim = 4708189360,
        SwimIdle = 4708190607,
        Weight = 9,
        Weight2 = 1
    },
    R15 = {
        Idle = 4211217646,
        Idle2 = 4211218409,
        Idle3 = "None",
        Walk = 4211223236,
        Run = 4211220381,
        Jump = 4211219390,
        Climb = 4211214992,
        Fall = 4211216152,
        Swim = 4211221314,
        SwimIdle = 4374694239,
        Weight = 9,
        Weight2 = 1
    },
    Mocap = {
        Idle = 913367814,
        Idle2 = 913373430,
        Idle3 = "None",
        Walk = 913402848,
        Run = 913376220,
        Jump = 913370268,
        Climb = 913362637,
        Fall = 913365531,
        Swim = 913384386,
        SwimIdle = 913389285,
        Weight = 9,
        Weight2 = 1
    }
}
local G = {"/e dance3", "/e dance2", "/e dance", "/e cheer", "/e wave", "/e laugh", "/e point"}
local function H(string)
    if table.find(G, string) then
        return true
    else
        return false
    end
end
local I = {
    ["Balloon Float"] = {Emote = 148840371, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Idle"] = {Emote = 180435571, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Arm Turbine"] = {Emote = 259438880, Speed = 1.5, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Floating Head"] = {Emote = 121572214, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Insane Rotation"] = {Emote = 121572214, Speed = 99, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Scream"] = {Emote = 180611870, Speed = 1.5, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Party Time"] = {Emote = 33796059, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Chop"] = {Emote = 33169596, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Weird Sway"] = {Emote = 248336677, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Goal!"] = {Emote = 28488254, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Rotation"] = {Emote = 136801964, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Spin"] = {Emote = 188632011, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Weird Float"] = {Emote = 248336459, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Pinch Nose"] = {Emote = 30235165, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Cry"] = {Emote = 180612465, Speed = 1.5, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Penguin Slide"] = {Emote = 282574440, Speed = 0, Time = 0, Weight = 1, Loop = true, R6 = true, Priority = 2},
    ["Zombie Arms"] = {Emote = 183294396, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Flying"] = {Emote = 46196309, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Stab"] = {Emote = 66703241, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Dance"] = {Emote = 35654637, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Random"] = {Emote = 48977286, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Hmmm"] = {Emote = 33855276, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Sword"] = {Emote = 35978879, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Arms Out"] = {Emote = 27432691, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Kick"] = {Emote = 45737360, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Insane Legs"] = {Emote = 87986341, Speed = 99, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Head Detach"] = {Emote = 35154961, Speed = 0, Time = 3, Weight = 1, Loop = true, Priority = 2},
    ["Moon Walk"] = {Emote = 30196114, Speed = 0, Time = 3, Weight = 1, Loop = true, Priority = 2},
    ["Crouch"] = {Emote = 287325678, Speed = 0, Time = 3, Weight = 1, Loop = true, Priority = 2},
    ["Beat Box"] = {Emote = 45504977, Speed = 0, Time = 3, Weight = 1, Loop = true, Priority = 2},
    ["Big Guns"] = {Emote = 161268368, Speed = 0, Time = 3, Weight = 1, Loop = true, Priority = 2},
    ["Bigger Guns"] = {Emote = 225975820, Speed = 0, Time = 3, Weight = 1, Loop = true, Priority = 2},
    ["Charleston"] = {Emote = 429703734, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Moon Dance"] = {Emote = 27789359, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Roar"] = {Emote = 163209885, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Weird Pose"] = {Emote = 248336163, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Spin Dance 2"] = {Emote = 186934910, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Bow Down"] = {Emote = 204292303, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Sword Slam"] = {Emote = 204295235, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Glitch Levitate"] = {Emote = 313762630, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Full Swing"] = {Emote = 218504594, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Full Punch"] = {Emote = 204062532, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Faint"] = {Emote = 181526230, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Floor Faint"] = {Emote = 181525546, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Crouch"] = {Emote = 182724289, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Jumping Jacks"] = {Emote = 429681631, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Spin Dance"] = {Emote = 429730430, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Arm Detach"] = {Emote = 33169583, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Mega Insane"] = {Emote = 184574340, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Dino Walk"] = {Emote = 204328711, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Tilt Head"] = {Emote = 283545583, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Dab"] = {Emote = 183412246, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Float Sit"] = {Emote = 179224234, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2},
    ["Clone Illusion"] = {Emote = 215384594, Speed = 1e7, Time = .5, Weight = 1, Loop = true, Priority = 2},
    ["Hero Jump"] = {Emote = 184574340, Speed = 1, Time = 0, Weight = 1, Loop = true, Priority = 2}
}
local J = {}
for r, s in pairs(I) do
    table.insert(J, r)
end
local K = {}
for r, s in pairs(F) do
    if r ~= "Weight" and r ~= "Weight2" and r ~= "Custom" and r ~= "Emotes" then
        table.insert(K, r)
        k = k + 1
    end
end
local L = {}
for r, s in pairs(E) do
    table.insert(L, r)
    j = j + 1
end
task.spawn(
    function()
        C("Eazvy | Emotes & Animations", "Loaded " .. k .. " Animations and " .. j .. " Emotes!", 9)
    end
)
table.sort(
    K,
    function(M, N)
        return M:lower() < N:lower()
    end
)
table.sort(
    L,
    function(M, N)
        return M:lower() < N:lower()
    end
)
table.sort(
    J,
    function(M, N)
        return M:lower() < N:lower()
    end
)
local function O()
    do
        if not getgenv().AlreadyLoaded then
            return
        end
        repeat
            wait()
        until game:GetService("Players").LocalPlayer.Character and
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate") and
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
            game:GetService("Players").LocalPlayer.Character.Humanoid:FindFirstChild("Animator")
        local P =
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass(
            "Animator"
        )
        for r, s in ipairs(P:GetPlayingAnimationTracks()) do
            s:Stop()
        end
    end
end
local function Q()
    do
        if not getgenv().AlreadyLoaded then
            return
        end
        repeat
            wait()
        until game:GetService("Players").LocalPlayer.Character and
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate") and
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
            game:GetService("Players").LocalPlayer.Character.Humanoid:FindFirstChild("Animator")
        local P = game:GetService("Players").LocalPlayer.Character:WaitForChild("Animate")
        P.Disabled = true
        for r, s in ipairs(
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks(

            )
        ) do
            s:AdjustSpeed(Settings.AnimationSpeed)
            s:Stop()
        end
        P.Disabled = false
    end
end
local function R(S, T, U, V, W, X, Y, Z, _, a0, a1, a2)
    do
        repeat
            wait()
        until game:GetService("Players").LocalPlayer.Character and
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate")
        local b = game:GetService("Players").LocalPlayer.Character.Animate
        if b:FindFirstChild("idle") then
            b.idle.Animation1.AnimationId = c .. S
            b.idle.Animation1.Weight.Value = tostring(a1)
            b.idle.Animation2.Weight.Value = tostring(a2)
            b.idle.Animation2.AnimationId = c .. T
        end
        if U and b:FindFirstChild("pose") then
            b.pose:FindFirstChildOfClass("Animation").AnimationId = c .. U
        end
        b.walk:FindFirstChildOfClass("Animation").AnimationId = c .. V
        b.run:FindFirstChildOfClass("Animation").AnimationId = c .. W
        b.jump:FindFirstChildOfClass("Animation").AnimationId = c .. X
        b.climb:FindFirstChildOfClass("Animation").AnimationId = c .. Y
        b.fall:FindFirstChildOfClass("Animation").AnimationId = c .. Z
        if b:FindFirstChild("swim") then
            b.swim:FindFirstChildOfClass("Animation").AnimationId = c .. _
            b.swimidle:FindFirstChildOfClass("Animation").AnimationId = c .. a0
        end
    end
end
local function a3(a4, a5)
    repeat
        wait()
    until game:GetService("Players").LocalPlayer.Character and
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate")
    local b = game:GetService("Players").LocalPlayer.Character.Animate
    if a4:match("idle") then
        if b:FindFirstChild("pose") then
            b.pose:FindFirstChildOfClass("Animation").AnimationId = c .. a5
        end
    end
    if a4 == "idle1" then
        b.idle.Animation1.AnimationId = c .. a5
    elseif a4 == "idle2" then
        b.idle.Animation2.AnimationId = c .. a5
    elseif a4:match("dance") then
        for w, s in pairs(b[a4]:GetChildren()) do
            if s:IsA("Animation") then
                s.AnimationId = c .. a5
            end
        end
    else
        local a6
        for w, s in pairs(b:GetChildren()) do
            if s.Name == a4 then
                a6 = s
                break
            end
        end
        if a6 then
            a6:FindFirstChildOfClass("Animation").AnimationId = c .. a5
        end
    end
    Q()
end
local function a7(a5)
    local a8 = Instance.new("Animation")
    a8.AnimationId = "rbxassetid://" .. a5
    _G.LoadAnim = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(a8)
    _G.LoadAnim.Priority = Enum.AnimationPriority.Idle
    if not Settings.PlayAlways then
        _G.LoadAnim:Stop()
    end
    if Settings.Reversed then
        _G.LoadAnim:Play(0)
        _G.LoadAnim:AdjustSpeed(Settings.ReverseSpeed)
    else
        _G.LoadAnim:Play(0)
        _G.LoadAnim:AdjustSpeed(Settings.EmoteSpeed)
    end
    if Settings.Looped then
        _G.LoadAnim.Looped = Settings.Looped
    end
    if Settings.Time then
        _G.LoadAnim.TimePosition = _G.LoadAnim.TimePosition - Settings.TimePosition
    end
    if not game:GetService("Players").LocalPlayer.Character.Animate.Disabled then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
    end
end
local function a9()
    local aa =
        game:GetService("Players").LocalPlayer.Character and
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if aa and aa.RigType == Enum.HumanoidRigType.R15 then
        return "R15"
    else
        return "R6"
    end
end
local function ab()
    if
        not Settings.Player and not Settings.Player.Character and
            not Settings.Player.Character:FindFirstChildOfClass("Humanoid")
     then
        return
    end
    local aa = Settings.Player.Character and Settings.Player.Character:FindFirstChildOfClass("Humanoid")
    if aa and aa.RigType == Enum.HumanoidRigType.R15 then
        return "R15"
    else
        return "R6"
    end
end
local function ac(ad)
    a7(E[ad])
end
local function ae(af)
    for r, s in pairs(F) do
        lower_string = string.lower(r)
        lower_emote = string.lower(af)
        if string.find(r, af) or string.find(lower_string, lower_emote) then
            return r
        end
    end
end
local function ag(af)
    local ah = {}
    for r, s in pairs(E) do
        upper_string = string.upper(r)
        upper_emote = string.upper(af)
        if upper_string == upper_emote then
            if not table.find(ah, r) then
                table.insert(ah, r)
            end
        end
    end
    for r, s in pairs(E) do
        lower_string = string.lower(r)
        lower_emote = string.lower(af)
        if string.find(r, af) or string.find(lower_string, lower_emote) then
            if not table.find(ah, r) then
                table.insert(ah, r)
            end
        end
    end
    return ah
end
local function ai(af)
    for r, s in pairs(E) do
        upper_string = string.upper(r)
        upper_emote = string.upper(af)
        if upper_string == upper_emote then
            return r
        end
    end
    for r, s in pairs(E) do
        lower_string = string.lower(r)
        lower_emote = string.lower(af)
        if string.find(r, af) or string.find(lower_string, lower_emote) then
            return r
        end
    end
end
if Settings.SelectedAnimation and Settings.SelectedAnimation ~= "" then
    repeat
        wait()
    until game:GetService("Players").LocalPlayer.Character and
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate")
    if Settings.SelectedAnimation == "Custom" and a9() == "R15" then
        O()
        R(
            Settings.Custom.Idle or g(1),
            Settings.Custom.Idle2 or g(2),
            Settings.Custom.Idle3 or g(3),
            Settings.Custom.Walk or g(4),
            Settings.Custom.Run or g(5),
            Settings.Custom.Jump or g(6),
            Settings.Custom.Climb or g(7),
            Settings.Custom.Fall or g(8),
            Settings.Custom.Swim or g(9),
            Settings.Custom.SwimIdle or g(10),
            Settings.Custom.Weight,
            Settings.Custom.Weight2
        )
        if Settings.Custom.Wave then
            a3("wave", Settings.Custom.Wave)
        end
        if Settings.Custom.Laugh then
            a3("laugh", Settings.Custom.Laugh)
        end
        if Settings.Custom.Cheer then
            a3("cheer", Settings.Custom.Cheer)
        end
        if Settings.Custom.Point then
            a3("point", Settings.Custom.Point)
        end
        if Settings.Custom.Sit then
            a3("sit", Settings.Custom.Sit)
        end
        if Settings.Custom.Dance then
            a3("dance", Settings.Custom.Dance)
        end
        if Settings.Custom.Dance2 then
            a3("dance2", Settings.Custom.Dance2)
        end
        if Settings.Custom.Dance3 then
            a3("dance3", Settings.Custom.Dance3)
        end
    elseif a9() == "R15" then
        O()
        R(
            F[Settings.SelectedAnimation].Idle,
            F[Settings.SelectedAnimation].Idle2,
            F[Settings.SelectedAnimation].Idle3,
            F[Settings.SelectedAnimation].Walk,
            F[Settings.SelectedAnimation].Run,
            F[Settings.SelectedAnimation].Jump,
            F[Settings.SelectedAnimation].Climb,
            F[Settings.SelectedAnimation].Fall,
            F[Settings.SelectedAnimation].Swim,
            F[Settings.SelectedAnimation].SwimIdle,
            F[Settings.SelectedAnimation].Weight,
            F[Settings.SelectedAnimation].Weight2
        )
        if Settings.Custom.Wave then
            a3("wave", Settings.Custom.Wave)
        end
        if Settings.Custom.Laugh then
            a3("laugh", Settings.Custom.Laugh)
        end
        if Settings.Custom.Cheer then
            a3("cheer", Settings.Custom.Cheer)
        end
        if Settings.Custom.Point then
            a3("point", Settings.Custom.Point)
        end
        if Settings.Custom.Sit then
            a3("sit", Settings.Custom.Sit)
        end
        if Settings.Custom.Dance then
            a3("dance", Settings.Custom.Dance)
        end
        if Settings.Custom.Dance2 then
            a3("dance2", Settings.Custom.Dance2)
        end
        if Settings.Custom.Dance3 then
            a3("dance3", Settings.Custom.Dance3)
        end
        Q()
        local aa =
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
        local aj = aa:GetPlayingAnimationTracks()
        for w, s in pairs(aj) do
            s:AdjustSpeed(Settings.AnimationSpeed)
        end
    end
end
game.TextChatService.OnIncomingMessage = function(z)
    local ak = tostring(z.TextSource)
    local al = tostring(z.Text)
    if
        ak == game.Players.LocalPlayer.Name and Settings.Chat and al:match(Settings.EmotePrefix) or
            ak == game.Players.LocalPlayer.Name and Settings.Animate and al:match(Settings.AnimationPrefix)
     then
        z.Status = Enum.TextChatMessageStatus.InvalidTextChannelPermissions
    end
end
local function am()
    if _G.LoadAnim and _G.LoadAnim.TimePosition then
        return tostring(math.floor(_G.LoadAnim.TimePosition))
    end
    return "0"
end
local function an()
    if _G.LoadAnim and _G.LoadAnim.Looped then
        return tostring(_G.LoadAnim.Looped)
    end
    return "false"
end
if game.TextChatService:FindFirstChild("TextChannels") and not getgenv().AlreadyLoaded then
    game.TextChatService.TextChannels.RBXGeneral.MessageReceived:Connect(
        function(z)
            local ak = tostring(z.TextSource)
            local al = tostring(z.Text)
            if Settings.Player and ak == Settings.Player.Name and Settings.CopyMovement then
                game.TextChatService.TextChannels.RBXGeneral:SendAsync(al)
            end
        end
    )
end
if game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and not getgenv().AlreadyLoaded then
    local ao = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
    ao.OnMessageDoneFiltering.OnClientEvent:Connect(
        function(ap)
            local ak = ap.FromSpeaker
            local al = ap.Message or ""
            if Settings.Player and ak == Settings.Player.Name and Settings.CopyMovement then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(al, "All")
            end
        end
    )
end
local aq =
    x:MakeWindow(
    {
        Name = "Eazvy Hub | Animations & Emotes",
        HidePremium = true,
        SaveConfig = false,
        ConfigFolder = "EazvyHub",
        IntroEnabled = false,
        IntroText = "Eazvy Hub - Animations/Emotes",
        IntroIcon = "rbxassetid://10932910166",
        Icon = "rbxassetid://4914902889"
    }
)
game:GetService("Players").LocalPlayer.OnTeleport:Connect(
    function(ar)
        if ar == Enum.TeleportState.Started and queue_on_teleport then
            queue_on_teleport("repeat task.wait() until game:IsLoaded() getgenv().Teleported = true")
        end
    end
)
local as = aq:MakeTab({Name = "Main", Icon = "rbxassetid://10507357657", PremiumOnly = false})
if
    game:GetService("Players").LocalPlayer.Character and
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("UpperTorso")
 then
    local at = aq:MakeTab({Name = "Trolling", Icon = "rbxassetid://8855392706", PremiumOnly = false})
    if a9() == "R15" then
        local au = at:AddSection({Name = " // Player Section"})
        at:AddTextbox(
            {Name = "Enter Player (Name)", Default = "", TextDisappear = true, Callback = function(av)
                    Settings.Player = getPlayersByName(av)
                end}
        )
        at:AddButton(
            {
                Name = "Goto",
                Callback = function()
                    if not Settings.Player then
                        return
                    end
                    x:MakeNotification(
                        {
                            Name = "Eazvy Hub - Success",
                            Content = "Teleported to " .. Settings.Player.DisplayName .. " @" .. Settings.Player.Name,
                            Image = "rbxassetid://4914902889",
                            Time = 3
                        }
                    )
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                        Settings.Player.Character.HumanoidRootPart.CFrame
                    return
                end
            }
        )
        at:AddButton(
            {
                Name = "Inspect",
                Callback = function()
                    if not Settings.Player then
                        return
                    end
                    x:MakeNotification(
                        {
                            Name = "Eazvy Hub - Success",
                            Content = "Inspecting " .. Settings.Player.DisplayName .. " @" .. Settings.Player.Name,
                            Image = "rbxassetid://4914902889",
                            Time = 3
                        }
                    )
                    game:GetService("GuiService"):CloseInspectMenu()
                    game:GetService("GuiService"):InspectPlayerFromUserId(Settings.Player.UserId)
                    return
                end
            }
        )
        at:AddToggle(
            {
                Name = "Annoy",
                Default = false,
                Callback = function(aw)
                    Settings.Annoy = aw
                    if Settings.Annoy then
                        local M = Instance.new("Part", game:GetService("Lighting"))
                        M.Name = "niggaAnnoy"
                        Settings.PlayAlways = aw
                        local ax = ai("Clap")
                        Q()
                        ac(ax)
                        _G.LoadAnim:AdjustSpeed(100)
                    elseif game:GetService("Lighting"):FindFirstChild("niggaAnnoy") then
                        game:GetService("Lighting"):FindFirstChild("niggaAnnoy"):Destroy()
                        Q()
                    end
                    while Settings.Annoy do
                        task.wait()
                        if
                            game:GetService("Players").LocalPlayer.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player and
                                Settings.Player.Character and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame =
                                Settings.Player.Character.HumanoidRootPart.CFrame
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Spy",
                Default = false,
                Callback = function(aw)
                    Settings.Spy = aw
                    if Settings.Spy then
                        x:MakeNotification(
                            {
                                Name = "Eazvy Hub - Success",
                                Content = "Spying on " .. Settings.Player.DisplayName .. " @" .. Settings.Player.Name,
                                Image = "rbxassetid://4914902889",
                                Time = 3
                            }
                        )
                        game:GetService("SoundService"):SetListener(
                            Enum.ListenerType.ObjectPosition,
                            Settings.Player.Character.HumanoidRootPart
                        )
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "nigga3"
                    elseif not Settings.Spy and game.Lighting:FindFirstChild("nigga3") then
                        game:GetService("SoundService"):SetListener(Enum.ListenerType.Camera)
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "View",
                Default = false,
                Callback = function(aw)
                    if
                        not Settings.Player and aw == true or
                            Settings.Player and not Settings.Player.Character and aw == true
                     then
                        y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                    end
                    if aw == true and Settings.Player then
                        if e:FindFirstChild("ViewNIG") then
                            e.ViewNIG:Destroy()
                        end
                        local M = Instance.new("Part", e)
                        M.Name = "ViewNIG"
                        game:GetService("Workspace").CurrentCamera.CameraSubject = Settings.Player.Character
                        x:MakeNotification(
                            {
                                Name = "Eazvy Hub - Success",
                                Content = "Viewing " .. Settings.Player.DisplayName .. " @" .. Settings.Player.Name,
                                Image = "rbxassetid://4914902889",
                                Time = 3
                            }
                        )
                        return
                    elseif e:FindFirstChild("ViewNIG") then
                        e.ViewNIG:Destroy()
                        game:GetService("Workspace").CurrentCamera.CameraSubject =
                            game:GetService("Players").LocalPlayer.Character
                        x:MakeNotification(
                            {
                                Name = "Eazvy Hub - Success",
                                Content = "Unviewed " .. Settings.Player.DisplayName .. " @" .. Settings.Player.Name,
                                Image = "rbxassetid://4914902889",
                                Time = 3
                            }
                        )
                        return
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Goto",
                Default = false,
                Callback = function(aw)
                    LoopGoTo = aw
                    while LoopGoTo == true do
                        task.wait()
                        if
                            Settings.Player and Settings.Player.Character and game.Players.LocalPlayer.Character and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart") and
                                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                         then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                Settings.Player.Character.HumanoidRootPart.CFrame
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Rape",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Gem")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 8
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What"
                    elseif game.Lighting:FindFirstChild("What") then
                        game.Lighting:FindFirstChild("What"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, 2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, 3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Rape 2",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Boom Boom Clap")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 8
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What1"
                    elseif game.Lighting:FindFirstChild("What1") then
                        game.Lighting:FindFirstChild("What1")
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, 2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, 3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Rape 3",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Dolphin Dance")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 26 / 100 * _G.LoadAnim.Length
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What2"
                    elseif game.Lighting:FindFirstChild("What2") then
                        game.Lighting:FindFirstChild("What2"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, -1, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, -1, 2)
                            _G.LoadAnim.TimePosition = 26 / 100 * _G.LoadAnim.Length
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Rape 4",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("AOK - Tai Verdes")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 5 / 100 * _G.LoadAnim.Length
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What3"
                    elseif game.Lighting:FindFirstChild("What3") then
                        game.Lighting:FindFirstChild("What3"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, 2)
                            _G.LoadAnim.TimePosition = 15 / 100 * _G.LoadAnim.Length
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        local ax = ai("Sleep")
                        Q()
                        ac(ax)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What4"
                    elseif game.Lighting:FindFirstChild("What4") then
                        game.Lighting:FindFirstChild("What4"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 2",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Gem")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 8
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What5"
                    elseif game.Lighting:FindFirstChild("What5") then
                        game.Lighting:FindFirstChild("What5"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 3",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Scorpion")
                        Q()
                        ac(ax)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What6"
                    elseif game.Lighting:FindFirstChild("What6") then
                        game.Lighting:FindFirstChild("What6"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            _G.LoadAnim.TimePosition = 83
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -1)
                            task.wait(.15)
                            _G.LoadAnim.TimePosition = 84
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -2)
                            _G.LoadAnim.TimePosition = 83
                            task.wait(.15)
                            _G.LoadAnim.TimePosition = 84
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 4",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("BURBERRY LOLA  ATTITUDE - GEM")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 60
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What7"
                    elseif game.Lighting:FindFirstChild("What7") then
                        game.Lighting:FindFirstChild("What7"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 5",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("BURBERRY LOLA  ATTITUDE - GEM")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 38
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What8"
                    elseif game.Lighting:FindFirstChild("What8") then
                        game.Lighting:FindFirstChild("What8"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 6",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Alo Yoga Pose - Warrior II")
                        Q()
                        ac(ax)
                        task.wait(.15)
                        _G.LoadAnim.TimePosition = 10 / 100 * _G.LoadAnim.Length
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What9"
                    elseif game.Lighting:FindFirstChild("What9") then
                        game.Lighting:FindFirstChild("What9"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 7",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Break Dance")
                        Q()
                        ac(ax)
                        task.wait(.15)
                        _G.LoadAnim.TimePosition = 53 / 100 * _G.LoadAnim.Length
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What10"
                    elseif game.Lighting:FindFirstChild("What10") then
                        game.Lighting:FindFirstChild("What10"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 0)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 2)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 8",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Team USA Breaking Emote")
                        Q()
                        ac(ax)
                        task.wait(.15)
                        _G.LoadAnim.TimePosition = 15 / 100 * _G.LoadAnim.Length
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "WhatNigga"
                    elseif game.Lighting:FindFirstChild("WhatNigga") then
                        game.Lighting:FindFirstChild("WhatNigga"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.Angles(0, -math.pi / 2, 0) * CFrame.new(-2, 0, 0)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, -math.pi / 2, 0) * CFrame.new(-3, 0, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, -math.pi / 2, 0) * CFrame.new(-4, 0, 2)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 9",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Olympic Dismount")
                        Q()
                        ac(ax)
                        task.wait(.15)
                        _G.LoadAnim.TimePosition = 15 / 100 * _G.LoadAnim.Length
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "WhatNigga4"
                    elseif game.Lighting:FindFirstChild("WhatNigga4") then
                        game.Lighting:FindFirstChild("WhatNigga4"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 0)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 2)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 10",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Olympic Dismount")
                        Q()
                        ac(ax)
                        task.wait(.15)
                        _G.LoadAnim.TimePosition = 28 / 100 * _G.LoadAnim.Length
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "WhatNigga5"
                    elseif game.Lighting:FindFirstChild("WhatNigga5") then
                        game.Lighting:FindFirstChild("WhatNigga5"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 11",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Olympic Dismount")
                        Q()
                        ac(ax)
                        task.wait(.15)
                        _G.LoadAnim.TimePosition = 27 / 100 * _G.LoadAnim.Length
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "WhatNigga6"
                    elseif game.Lighting:FindFirstChild("WhatNigga6") then
                        game.Lighting:FindFirstChild("WhatNigga6"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, -1, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, -1, 2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, -1, 3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 12",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("TMNT Dance")
                        Q()
                        ac(ax)
                        task.wait(.15)
                        _G.LoadAnim.TimePosition = 70 / 100 * _G.LoadAnim.Length
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "WhatNigga7"
                    elseif game.Lighting:FindFirstChild("WhatNigga7") then
                        game.Lighting:FindFirstChild("WhatNigga7"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(0, 0, -3)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Get Raped 13",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Team USA Breaking Emote")
                        Q()
                        ac(ax)
                        task.wait(.15)
                        _G.LoadAnim.TimePosition = 45 / 100 * _G.LoadAnim.Length
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "WhatNigga3"
                    elseif game.Lighting:FindFirstChild("WhatNigga3") then
                        game.Lighting:FindFirstChild("WhatNigga3"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(1, 0, 1)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(1, 0, 2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(1, 0, 3)
                        end
                    end
                end
            }
        )
        local au = at:AddSection({Name = " // Other Animations"})
        at:AddToggle(
            {
                Name = "Slap Ass",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Beauty Touchdown")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = -1
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What11"
                    elseif game.Lighting:FindFirstChild("What11") then
                        game.Lighting:FindFirstChild("What11"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.new(-2, 0, 2)
                            task.wait(.15)
                            _G.LoadAnim.TimePosition = -1
                            ay.CFrame = az.CFrame * CFrame.new(-2, 0, 3)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.new(-2, 0, 4)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Blowjob",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Gem")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 8
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What12"
                    elseif game.Lighting:FindFirstChild("What12") then
                        game.Lighting:FindFirstChild("What12"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 2)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 3)
                            task.wait(.15)
                            ay.CFrame = az.CFrame * CFrame.Angles(0, math.pi, 0) * CFrame.new(0, 0, 4)
                        end
                    end
                end
            }
        )
        at:AddToggle(
            {
                Name = "Stalk",
                Default = false,
                Callback = function(aw)
                    Settings.RapePlayer = aw
                    if Settings.RapePlayer then
                        if not Settings.Player or Settings.Player and not Settings.Player.Character then
                            y("Failed!", "Player was not found! Please enter player-name in textbox above.")
                        end
                        Settings.PlayAlways = true
                        Settings.Time = true
                        local ax = ai("Gem")
                        Q()
                        ac(ax)
                        _G.LoadAnim.TimePosition = 8
                        _G.LoadAnim:AdjustSpeed(0)
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "What45"
                    elseif game.Lighting:FindFirstChild("What45") then
                        game.Lighting:FindFirstChild("What45"):Destroy()
                        Q()
                        Settings.PlayAlways = false
                    end
                    while Settings.RapePlayer do
                        task.wait()
                        pcall(
                            function()
                                if
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit
                                 then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                        false
                                end
                            end
                        )
                        if
                            game:GetService("Players").LocalPlayer.Character and Settings.Player.Character and
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                                Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                         then
                            local ay =
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local az = Settings.Player.Character:FindFirstChild("HumanoidRootPart")
                            if ay.Position.Y < az.Position.Y then
                                if not platform then
                                    platform = Instance.new("Part")
                                    platform.Size = Vector3.new(5, 0.1, 5)
                                    platform.Transparency = 1
                                    platform.Anchored = true
                                    platform.Position = az.Position + Vector3.new(0, 2, 0)
                                    platform.Parent = game.Workspace
                                end
                            else
                                if platform then
                                    platform:Destroy()
                                    platform = nil
                                end
                            end
                            local aA = (ay.Position - az.Position).unit
                            local aB = aA * 3
                            ay.CFrame = CFrame.new(az.Position + aB, az.Position)
                        end
                    end
                end
            }
        )
        local au = at:AddSection({Name = " // Character Animation Toggles"})
        at:AddTextbox(
            {
                Name = "Custom Emote (ID)",
                Default = "",
                TextDisappear = true,
                Callback = function(av)
                    UpdateFile()
                    a7(av)
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                end
            }
        )
    end
end
local a = aq:MakeTab({Name = "LocalPlayer", Icon = "rbxassetid://3609827161", PremiumOnly = false})
local aC
local aD
if
    game:GetService("Players").LocalPlayer.Character and
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("UpperTorso")
 then
    aC = aq:MakeTab({Name = "Animations", Icon = "rbxassetid://9405928221", PremiumOnly = false})
    aD =
        aC:AddParagraph(
        "Animation Information",
        "Selected Animation: " .. Settings.SelectedAnimation or
            "" .. " // Speed: " .. tostring(Settings.AnimationSpeed or "") .. " // Frozen: " .. Settings.FreezeAnimation
    )
end
a:AddSlider(
    {
        Name = "Walkspeed",
        Min = 16,
        Max = 250,
        Default = 16,
        Color = Color3.fromRGB(0, 128, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(av)
            game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = av
        end
    }
)
a:AddSlider(
    {
        Name = "Jumppower",
        Min = 50,
        Max = 550,
        Default = 50,
        Color = Color3.fromRGB(0, 191, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(av)
            game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = av
        end
    }
)
a:AddSlider(
    {
        Name = "Gravity",
        Min = 196,
        Max = 250,
        Default = 196,
        Color = Color3.fromRGB(0, 128, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(av)
            if av > 196 then
                game:GetService("Workspace").Gravity = -av
            else
                game:GetService("Workspace").Gravity = av
            end
        end
    }
)
a:AddSlider(
    {
        Name = "Hipheight",
        Min = game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight,
        Max = 300,
        Default = game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight,
        Color = Color3.fromRGB(0, 191, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(av)
            game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight = av
        end
    }
)
a:AddSlider(
    {
        Name = "Fly Speed",
        Min = 1,
        Max = 500,
        Default = 50,
        Color = Color3.fromRGB(0, 128, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(av)
            Settings.FlySpeed = av
        end
    }
)
a:AddSlider(
    {
        Name = "Fov",
        Min = 70,
        Max = 120,
        Default = game:GetService("Workspace").CurrentCamera.FieldOfView,
        Color = Color3.fromRGB(0, 128, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(av)
            game:GetService("Workspace").CurrentCamera.FieldOfView = av
        end
    }
)
if game.Players.LocalPlayer then
    a:AddSlider(
        {
            Name = "Zoom",
            Min = game.Players.LocalPlayer.CameraMaxZoomDistance,
            Max = 1000,
            Default = game.Players.LocalPlayer.CameraMaxZoomDistance,
            Color = Color3.fromRGB(0, 128, 255),
            Increment = 1,
            ValueName = "",
            Callback = function(av)
                game.Players.LocalPlayer.CameraMaxZoomDistance = av
            end
        }
    )
end
if setfpscap then
    a:AddSlider(
        {
            Name = "FPS",
            Min = 1,
            Max = 240,
            Default = 60,
            Color = Color3.fromRGB(0, 128, 255),
            Increment = 1,
            ValueName = "",
            Callback = function(av)
                setfpscap(av)
            end
        }
    )
end
local aE
local aF
local aG
local aH
local aI
local aJ
local aK = Client
local aL = {W = false, S = false, A = false, D = false, Moving = false}
local aM = function()
    if
        not game:GetService("Players").LocalPlayer.Character or
            not game:GetService("Players").LocalPlayer.Character.Head or
            aJ
     then
        return
    end
    aE = game:GetService("Players").LocalPlayer.Character
    aF = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    aF.PlatformStand = true
    aI = e:WaitForChild("Camera")
    aG = Instance.new("BodyVelocity")
    aH = Instance.new("BodyAngularVelocity")
    aG.Velocity, aG.MaxForce, aG.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
    aH.AngularVelocity, aH.MaxTorque, aH.P = Vector3.new(0, 0, 0), Vector3.new(10000, 10000, 10000), 1000
    aG.Parent = aE.Head
    aH.Parent = aE.Head
    aJ = true
    aF.Died:connect(
        function()
            aJ = false
        end
    )
end
local aN = function()
    if not game:GetService("Players").LocalPlayer.Character or not aJ then
        return
    end
    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    aG:Destroy()
    aH:Destroy()
    aJ = false
end
game:GetService("UserInputService").InputBegan:connect(
    function(aO, aP)
        if
            aO.UserInputType == Enum.UserInputType.MouseButton1 and
                game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and
                Settings.ClickTeleport
         then
            game:GetService("Players").LocalPlayer.Character:MoveTo(game.Players.LocalPlayer:GetMouse().Hit.p)
        end
        if aP then
            return
        end
        for r, aQ in pairs(aL) do
            if r ~= "Moving" and aO.KeyCode == Enum.KeyCode[r] then
                aL[r] = true
                aL.Moving = true
            end
        end
    end
)
game:GetService("UserInputService").InputEnded:connect(
    function(aO, aP)
        if aP then
            return
        end
        local M = false
        for r, aQ in pairs(aL) do
            if r ~= "Moving" then
                if aO.KeyCode == Enum.KeyCode[r] then
                    aL[r] = false
                end
                if aL[r] then
                    M = true
                end
            end
        end
        aL.Moving = M
    end
)
local aR = function(aS)
    return aS * (Settings.FlySpeed or 50) / aS.Magnitude
end
game:GetService("RunService").Heartbeat:connect(
    function(aT)
        if aJ and aE and aE.PrimaryPart then
            local aK = aE.PrimaryPart.Position
            local aU = aI.CFrame
            local aV, aW, aX = aU:toEulerAnglesXYZ()
            aE:SetPrimaryPartCFrame(CFrame.new(aK.x, aK.y, aK.z) * CFrame.Angles(aV, aW, aX))
            if aL.Moving then
                local aw = Vector3.new()
                if aL.W then
                    aw = aw + aR(aU.lookVector)
                end
                if aL.S then
                    aw = aw - aR(aU.lookVector)
                end
                if aL.A then
                    aw = aw - aR(aU.rightVector)
                end
                if aL.D then
                    aw = aw + aR(aU.rightVector)
                end
                aE:TranslateBy(aw * aT)
            end
        end
    end
)
a:AddToggle(
    {Name = "Fly", Default = false, Callback = function(aw)
            Fly = aw
            if Fly == true then
                local M = Instance.new("Part", game:GetService("Lighting"))
                M.Name = "NiggaFly"
                for aY, aZ in next, getconnections(game.Players.LocalPlayer.Character.Head.ChildAdded) do
                    aZ:Disable()
                end
                aM()
            elseif game:GetService("Lighting"):FindFirstChild("NiggaFly") then
                game:GetService("Lighting"):FindFirstChild("NiggaFly"):Destroy()
                aN()
            end
        end}
)
local a_ = nil
a:AddToggle(
    {Name = "Noclip", Default = false, Callback = function(aw)
            Settings.Noclip = aw
            if Settings.Noclip then
                local M = Instance.new("Part", game:GetService("Lighting"))
                M.Name = "niggANOclip"
                local function b0()
                    if game:GetService("Players").LocalPlayer.Character and Settings.Noclip then
                        for w, b1 in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                            if b1:IsA("BasePart") and b1.CanCollide and Settings.Noclip then
                                b1.CanCollide = false
                            end
                        end
                    end
                end
                if a_ then
                    a_:Disconnect()
                end
                a_ = game:GetService("RunService").RenderStepped:Connect(b0)
            elseif game:GetService("Lighting"):FindFirstChild("niggANOclip") then
                game:GetService("Lighting"):FindFirstChild("niggANOclip"):Destroy()
                if a_ then
                    a_:Disconnect()
                    a_ = nil
                end
                if game:GetService("Players").LocalPlayer.Character then
                    for w, b1 in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                        if b1:IsA("BasePart") then
                            b1.CanCollide = true
                        end
                    end
                end
            end
        end}
)
a:AddToggle(
    {
        Name = "Platform",
        Default = false,
        Callback = function(aw)
            Settings.Platform = aw
            if Settings.Platform then
                local b2 = game.Players.LocalPlayer
                local b3 = b2.Character or b2.CharacterAdded:Wait()
                local platform = Instance.new("Part", e)
                platform.Transparency = 1
                platform.Name = tostring(math.random(1, 1115))
                platform.Material = "Plastic"
                platform.Size = Vector3.new(300, 1, 300)
                platform.Anchored = true
                platform.CanCollide = true
                spawn(
                    function()
                        if b3 and b3:FindFirstChild("HumanoidRootPart") then
                            local b4 = b3.HumanoidRootPart
                            platform.Position =
                                Vector3.new(
                                b4.Position.X,
                                b4.Position.Y - b4.Size.Y / 2 - platform.Size.Y / 2,
                                b4.Position.Z
                            )
                        end
                        while Settings.Platform do
                            task.wait()
                        end
                        platform:Destroy()
                    end
                )
            end
        end
    }
)
a:AddToggle(
    {Name = "Sit", Default = false, Callback = function(aw)
            if
                game.Players.LocalPlayer.Character and
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
             then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = aw
            end
        end}
)
a:AddToggle(
    {
        Name = "Refresh",
        Default = false,
        Callback = function(aw)
            Settings.Refresh = aw
            if Settings.Refresh then
                B("When you reset your character, you'll respawn in the same position you", "died in.")
            end
            if
                Settings.Refresh and game.Players.LocalPlayer.Character and
                    game.Players.LocalPlayer.Character:FindFirstChild("Head") and
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
             then
                game.Players.LocalPlayer.Character.Humanoid.Died:Connect(
                    function()
                        Settings.DeathPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                )
                local b5 =
                    game.Players.LocalPlayer.Character and
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid", true)
                local b6 = b5 and b5.RootPart and b5.RootPart.CFrame
                local b7 = e.CurrentCamera.CFrame
                local b8 = game.Players.LocalPlayer.Character
                task.spawn(
                    function()
                        local b9 = game.Players.LocalPlayer.CharacterAdded:Wait()
                        if Settings.Refresh then
                            b9:WaitForChild("Humanoid").RootPart.CFrame, e.CurrentCamera.CFrame = b6, wait() and b7
                        end
                    end
                )
            end
        end
    }
)
local ba = e.Gravity
local bb
local bc
a:AddToggle(
    {
        Name = "Swim",
        Default = false,
        Callback = function(aw)
            if aw == true then
                local M = Instance.new("Part", e)
                M.Name = "Swimaaaaa"
                e.Gravity = 0
                local bd = function()
                    e.Gravity = ba
                end
                local be = game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                bc = be.Died:Connect(bd)
                local bf = Enum.HumanoidStateType:GetEnumItems()
                table.remove(bf, table.find(bf, Enum.HumanoidStateType.None))
                for r, s in pairs(bf) do
                    be:SetStateEnabled(s, false)
                end
                be:ChangeState(Enum.HumanoidStateType.Swimming)
                bb =
                    game:GetService("RunService").Heartbeat:Connect(
                    function()
                        pcall(
                            function()
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity =
                                    (be.MoveDirection ~= Vector3.new() or
                                    game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space)) and
                                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity or
                                    Vector3.new()
                            end
                        )
                    end
                )
            elseif e:FindFirstChild("Swimaaaaa") then
                e.Swimaaaaa:Destroy()
                e.Gravity = ba
                if bc then
                    bc:Disconnect()
                end
                if bb ~= nil then
                    bb:Disconnect()
                    bb = nil
                end
                local aa = game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                local bf = Enum.HumanoidStateType:GetEnumItems()
                table.remove(bf, table.find(bf, Enum.HumanoidStateType.None))
                for r, s in pairs(bf) do
                    aa:SetStateEnabled(s, true)
                end
            end
        end
    }
)
a:AddToggle(
    {
        Name = "Click Teleport",
        Default = false,
        Callback = function(aw)
            Settings.ClickTeleport = aw
            if Settings.ClickTeleport then
                x:MakeNotification(
                    {
                        Name = "Eazvy Hub - Success",
                        Content = "Click-Teleport has been enabled; Keybind: CTRL + Click",
                        Image = "rbxassetid://4914902889",
                        Time = 10
                    }
                )
            end
        end
    }
)
a:AddToggle(
    {Name = "Infinite Jump", Default = false, Callback = function(aw)
            Settings.InfJump = aw
        end}
)
local au = a:AddSection({Name = " // LP Buttons"})
a:AddButton(
    {Name = "Jump", Default = false, Callback = function()
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end}
)
a:AddButton(
    {
        Name = "Sit",
        Default = false,
        Callback = function()
            pcall(
                function()
                    if not game.Players.LocalPlayer.Character.Humanoid.Sit then
                        game.Players.LocalPlayer.Character.Humanoid.Sit = true
                    else
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    end
                end
            )
        end
    }
)
a:AddButton(
    {
        Name = "Skydive",
        Default = false,
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 500, 0)
        end
    }
)
a:AddButton(
    {Name = "Reset", Default = false, Callback = function()
            game.Players.LocalPlayer.Character.Head.Parent = nil
        end}
)
game.Players.LocalPlayer:GetMouse().KeyDown:Connect(
    function(bg)
        if Settings.InfJump and bg == " " then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
        end
    end
)
game:GetService("UserInputService").InputBegan:connect(
    function(aO, aP)
        if
            aO.UserInputType == Enum.UserInputType.MouseButton1 and
                game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and
                Settings.ClickToSelect
         then
            local bh = game.Players.LocalPlayer:GetMouse().Target
            if bh and bh.Parent then
                local bi = game.Players:GetPlayerFromCharacter(bh.Parent)
                if bi and bi ~= game.Players.LocalPlayer and Settings.ClickToSelect then
                    if Settings.Player ~= bi then
                        B("Selected:", bi.Name)
                    else
                        y(bi.Name, "has already been selected!")
                    end
                    Settings.Player = bi
                    d = bi
                end
            end
        end
        if
            aO.UserInputType == Enum.UserInputType.MouseButton1 and
                game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) and
                Settings.ClickTeleport
         then
            game:GetService("Players").LocalPlayer.Character:MoveTo(game.Players.LocalPlayer:GetMouse().Hit.p)
        end
        if aP then
            return
        end
        for r, aQ in pairs(aL) do
            if r ~= "Moving" and aO.KeyCode == Enum.KeyCode[r] then
                aL[r] = true
                aL.Moving = true
            end
        end
    end
)
local Status =
    as:AddParagraph(
    "Emote Information",
    "Previous Emote: " ..
        Settings.LastEmote ..
            " // Speed: " .. tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
)
if
    game:GetService("Players").LocalPlayer.Character and
        not game:GetService("Players").LocalPlayer.Character:FindFirstChild("UpperTorso")
 then
    as:AddDropdown(
        {
            Name = "Emotes (R6)",
            Default = "",
            Options = J,
            Callback = function(SAnimation)
                if a9() ~= "R15" then
                    O()
                    a7(
                        I[SAnimation].Emote,
                        I[SAnimation].Speed,
                        I[SAnimation].Time,
                        I[SAnimation].Weight,
                        I[SAnimation].Loop
                    )
                    Settings.LastEmote = SAnimation
                    UpdateFile()
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                end
            end
        }
    )
end
local bj
if
    game:GetService("Players").LocalPlayer.Character and
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("UpperTorso")
 then
    as:AddTextbox(
        {
            Name = "Play Emote / Search (Name)",
            Default = "",
            TextDisappear = true,
            Callback = function(av)
                if Settings.EmoteChat then
                    local bk = ag(av)
                    if #bk >= 1 then
                        B("Found " .. #bk .. " Emotes!", 'with search-term "' .. av .. '"' .. ".")
                    end
                    bj:Refresh(bk, true)
                end
                if Settings.EmoteChat then
                    return
                end
                local ax = ai(av)
                if ax and string.len(av) > 2 then
                    O()
                    ac(ax)
                    Settings.LastEmote = ax
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                    UpdateFile()
                end
            end
        }
    )
    as:AddTextbox(
        {
            Name = "Sync Emote (Player)",
            Default = "",
            TextDisappear = true,
            Callback = function(av)
                Settings.PlayerSync = getPlayersByName(av)
                if
                    Settings.PlayerSync and Settings.PlayerSync.Character and
                        Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid") and
                        game:GetService("Players").LocalPlayer.Character and
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                 then
                    local P =
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Animator
                    local bl =
                        Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid").Animator:GetPlayingAnimationTracks(

                    )
                    for w, s in pairs(bl) do
                        _G.LoadAnim = P:LoadAnimation(s.Animation)
                        _G.LoadAnim.TimePosition = s.TimePosition
                        _G.LoadAnim:Play(0.100000001, s.WeightCurrent, s.Speed)
                        _G.LoadAnim.Priority = Enum.AnimationPriority.Action
                    end
                    B(
                        "Syncing Emotes with ",
                        Settings.PlayerSync.Name ..
                            " @" ..
                                Settings.PlayerSync.DisplayName ..
                                    " it may not be synced, on your client but it is on the network."
                    )
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                    UpdateFile()
                    task.spawn(
                        function()
                            _G.LoadAnim.Stopped:Wait()
                            if not Settings.PlayAlways then
                                _G.LoadAnim:Stop()
                            end
                        end
                    )
                    Settings.PlayerSync.Character.Humanoid.Running:Wait()
                    if not Settings.PlayAlways then
                        _G.LoadAnim:Stop()
                    end
                end
            end
        }
    )
    local au = as:AddSection({Name = " // Emote Dropdowns"})
    as:AddDropdown(
        {
            Name = "Emotes (R15)",
            Default = "",
            Options = L,
            Callback = function(av)
                if a9() ~= "R6" then
                    O()
                    Settings.LastEmote = av
                    ac(av)
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                    UpdateFile()
                end
            end
        }
    )
    bj =
        as:AddDropdown(
        {
            Name = "Emotes (Search)",
            Default = "",
            Options = {},
            Callback = function(av)
                if a9() ~= "R6" then
                    O()
                    Settings.LastEmote = av
                    ac(av)
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                    UpdateFile()
                end
            end
        }
    )
end
local bm
if a9() == "R15" then
    bm =
        as:AddDropdown(
        {
            Name = "Emotes (Favorite)",
            Default = "",
            Options = {},
            Callback = function(av)
                if a9() ~= "R6" then
                    O()
                    Settings.LastEmote = av
                    ac(av)
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                    UpdateFile()
                end
            end
        }
    )
end
if Settings.Favorite and #Settings.Favorite >= 1 and a9() == "R15" then
    bm:Refresh(Settings.Favorite, true)
end
as:AddButton(
    {
        Name = "Play Last Emote",
        Callback = function()
            if Settings.LastEmote and a9() == "R15" then
                a7(E[Settings.LastEmote])
                Status:Set(
                    "Current Emote: " ..
                        Settings.LastEmote ..
                            " // Speed: " ..
                                tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
                )
                UpdateFile()
            end
            if a9() == "R6" then
                O()
                a7(
                    I[Settings.LastEmote].Emote,
                    I[Settings.LastEmote].Speed,
                    I[Settings.LastEmote].Time,
                    I[Settings.LastEmote].Weight,
                    I[Settings.LastEmote].Loop
                )
            end
        end
    }
)
function RefreshDropdown()
    local bn = {}
    for w, af in ipairs(Settings.Favorite) do
        if not table.find(bn, af) then
            table.insert(bn, af)
        end
    end
    bm:Refresh(bn, true)
end
if a9() == "R15" then
    as:AddButton(
        {Name = "Favorite/Unfavorite Emote", Callback = function()
                local bo = table.find(Settings.Favorite, Settings.LastEmote)
                if not bo then
                    table.insert(Settings.Favorite, Settings.LastEmote)
                    RefreshDropdown()
                    UpdateFile()
                    B("Successfully Favorited", Settings.LastEmote)
                else
                    table.remove(Settings.Favorite, bo)
                    UpdateFile()
                    RefreshDropdown()
                end
            end}
    )
end
as:AddButton(
    {
        Name = "Stop Emote",
        Callback = function()
            if _G.LoadAnim then
                _G.LoadAnim:Stop()
                Q()
                Status:Set(
                    "Current Emote: " ..
                        Settings.LastEmote ..
                            " // Speed: " ..
                                tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
                )
                UpdateFile()
            end
        end
    }
)
local au = as:AddSection({Name = " // Emote Settings"})
if a9() == "R15" then
    as:AddToggle(
        {Name = "Emote Chat", Default = false, Callback = function(aw)
                Settings.Chat = aw
                if Settings.Chat then
                    B("Enabled Emote-Chat", "Prefix is: " .. Settings.EmotePrefix)
                    UpdateFile()
                end
            end}
    )
end
if a9() == "R15" then
    as:AddToggle(
        {Name = "Emote Search", Default = false, Callback = function(aw)
                Settings.EmoteChat = aw
                UpdateFile()
            end}
    )
end
local function bp()
    local bq
    local br = 0
    for w in pairs(E) do
        br = br + 1
    end
    local bs = math.random(1, br)
    br = 0
    for bt, w in pairs(E) do
        br = br + 1
        if br == bs then
            bq = bt
            break
        end
    end
    return bq, E[bq]
end
if a9() == "R15" then
    as:AddToggle(
        {
            Name = "Random Emote",
            Default = false,
            Callback = function(aw)
                Settings.RandomEmote = aw
                if Settings.RandomEmote then
                    local M = Instance.new("Part", game:GetService("Lighting"))
                    M.Name = "niggaLighting"
                end
                if not Settings.RandomEmote and game:GetService("Lighting"):FindFirstChild("niggaLighting") then
                    game:GetService("Lighting").niggaLighting:Destroy()
                    Q()
                end
                while Settings.RandomEmote do
                    Q()
                    local bu, bv = bp()
                    Settings.LastEmote = bu
                    a7(bv)
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                    repeat
                        task.wait()
                    until _G.LoadAnim.Length ~= 0 or not Settings.RandomEmote or
                        not game:GetService("Players").LocalPlayer.Character or
                        game:GetService("Players").LocalPlayer.Character and
                            not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or
                        game:GetService("Players").LocalPlayer.Character and
                            not game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    task.wait(_G.LoadAnim.Length + .5 or 5.6)
                end
            end
        }
    )
end
as:AddToggle(
    {
        Name = "Time-Position",
        Default = false,
        Callback = function(aw)
            Settings.Time = aw
            Status:Set(
                "Current Emote: " ..
                    Settings.LastEmote ..
                        " // Speed: " ..
                            tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
            )
            UpdateFile()
        end
    }
)
as:AddToggle(
    {Name = "Always Play", Default = false, Callback = function(aw)
            Settings.PlayAlways = aw
            UpdateFile()
        end}
)
if a9() == "R15" then
    as:AddToggle(
        {
            Name = "Always Sync-Emotes",
            Default = false,
            Callback = function(aw)
                Settings.SyncEmote = aw
                while Settings.SyncEmote do
                    task.wait()
                    if
                        Settings.SyncEmote and Settings.PlayerSync and Settings.PlayerSync.Character and
                            Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid") and
                            game:GetService("Players").LocalPlayer.Character and
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                     then
                        local P =
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Animator
                        local bl =
                            Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid").Animator:GetPlayingAnimationTracks(

                        )
                        for w, s in pairs(bl) do
                            _G.LoadAnim = P:LoadAnimation(s.Animation)
                            _G.LoadAnim.Priority = Enum.AnimationPriority.Action
                            _G.LoadAnim:Play(0.100000001, s.WeightCurrent, s.Speed)
                            _G.LoadAnim.TimePosition = s.TimePosition
                            _G.LoadAnim:AdjustSpeed(s.Speed)
                        end
                        task.spawn(
                            function()
                                _G.LoadAnim.Stopped:Wait()
                                if not Settings.PlayAlways then
                                    _G.LoadAnim:Stop()
                                end
                            end
                        )
                        Status:Set(
                            "Current Emote: " ..
                                Settings.LastEmote ..
                                    " // Speed: " ..
                                        tostring(Settings.EmoteSpeed) ..
                                            " // Time Position: " .. am() .. " // Looped: " .. an()
                        )
                    end
                end
            end
        }
    )
end
as:AddToggle(
    {
        Name = "Loop Emote",
        Default = false,
        Callback = function(aw)
            Settings.Looped = aw
            Status:Set(
                "Current Emote: " ..
                    Settings.LastEmote ..
                        " // Speed: " ..
                            tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
            )
            UpdateFile()
        end
    }
)
as:AddToggle(
    {
        Name = "Reverse Emote",
        Default = false,
        Callback = function(aw)
            Settings.Reversed = aw
            UpdateFile()
            if
                Settings.Reversed and game:GetService("Players").LocalPlayer.Character and
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
             then
                _G.LoadAnim:AdjustSpeed(Settings.ReverseSpeed)
                Status:Set(
                    "Current Emote: " ..
                        Settings.LastEmote ..
                            " // Speed: " ..
                                tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
                )
            end
        end
    }
)
as:AddToggle(
    {
        Name = "Freeze Emote",
        Default = false,
        Callback = function(aw)
            Settings.FreezeEmote = aw
            if
                aw == true and game:GetService("Players").LocalPlayer.Character and
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
                    _G.LoadAnim
             then
                _G.LoadAnim:AdjustSpeed(0)
                Status:Set(
                    "Current Emote: " ..
                        Settings.LastEmote ..
                            " // Speed: " ..
                                tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
                )
            elseif
                aw == false and game:GetService("Players").LocalPlayer.Character and
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
                    _G.LoadAnim
             then
                _G.LoadAnim:AdjustSpeed(1)
                Status:Set(
                    "Current Emote: " ..
                        Settings.LastEmote ..
                            " // Speed: " ..
                                tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
                )
            end
        end
    }
)
if a9() == "R15" then
    as:AddToggle(
        {
            Name = "Sync Emote",
            Default = false,
            Callback = function(aw)
                if Settings.Player and Settings.Player.Character then
                    Settings.PlayerSync = Settings.Player
                elseif not Settings.PlayerSync then
                    return
                end
                if aw == true then
                    local M = Instance.new("Part", game:GetService("Lighting"))
                    M.Name = "niggasync"
                end
                if
                    Settings.PlayerSync and Settings.PlayerSync.Character and
                        Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid") and
                        game:GetService("Players").LocalPlayer.Character and
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
                        aw == true
                 then
                    local P =
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Animator
                    local bl =
                        Settings.PlayerSync.Character:FindFirstChildOfClass("Humanoid").Animator:GetPlayingAnimationTracks(

                    )
                    for w, s in pairs(bl) do
                        _G.LoadAnim = P:LoadAnimation(s.Animation)
                        _G.LoadAnim.TimePosition = s.TimePosition
                        _G.LoadAnim:Play(0.100000001, s.WeightCurrent, s.Speed)
                        _G.LoadAnim.Priority = Enum.AnimationPriority.Action
                    end
                    B(
                        "Syncing Emotes with ",
                        Settings.PlayerSync.Name ..
                            " @" ..
                                Settings.PlayerSync.DisplayName ..
                                    " it may not be synced, on your client but it is on the network."
                    )
                    Status:Set(
                        "Current Emote: " ..
                            Settings.LastEmote ..
                                " // Speed: " ..
                                    tostring(Settings.EmoteSpeed) ..
                                        " // Time Position: " .. am() .. " // Looped: " .. an()
                    )
                    UpdateFile()
                    task.spawn(
                        function()
                            _G.LoadAnim.Stopped:Wait()
                            if not Settings.PlayAlways then
                                _G.LoadAnim:Stop()
                            end
                        end
                    )
                    Settings.PlayerSync.Character.Humanoid.Running:Wait()
                    if not Settings.PlayAlways then
                        _G.LoadAnim:Stop()
                    end
                elseif game:GetService("Lighting"):FindFirstChild("niggasync") then
                    O()
                    Q()
                end
            end
        }
    )
end
as:AddSlider(
    {
        Name = "Emote Speed",
        Min = 0,
        Max = 100,
        Default = 1,
        Color = Color3.fromRGB(0, 128, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(av)
            Settings.EmoteSpeed = av
            if
                _G.LoadAnim and game:GetService("Players").LocalPlayer.Character and
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
             then
                _G.LoadAnim:AdjustSpeed(av)
                Status:Set(
                    "Current Emote: " ..
                        Settings.LastEmote ..
                            " // Speed: " ..
                                tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
                )
            end
        end
    }
)
as:AddSlider(
    {
        Name = "Time Position",
        Min = 0,
        Max = 100,
        Default = 0,
        Color = Color3.fromRGB(0, 128, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(av)
            UpdateFile()
            if Settings.Time then
                Settings.TimePosition = av
                _G.LoadAnim.TimePosition = av / 100 * _G.LoadAnim.Length
                Status:Set(
                    "Current Emote: " ..
                        Settings.LastEmote ..
                            " // Speed: " ..
                                tostring(Settings.EmoteSpeed) .. " // Time Position: " .. am() .. " // Looped: " .. an()
                )
            end
        end
    }
)
function GetRandomAnimation(bw)
    local bx = {}
    for bt, w in pairs(bw) do
        table.insert(bx, bt)
    end
    local bq = bx[math.random(1, #bx)]
    return bw[bq]
end
if
    game:GetService("Players").LocalPlayer.Character and
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("UpperTorso")
 then
    aC:AddDropdown(
        {
            Name = "Select Animation",
            Default = "",
            Options = K,
            Callback = function(SAnimation)
                Settings.SelectedAnimation = SAnimation
                UpdateFile()
                O()
                R(
                    F[SAnimation].Idle,
                    F[SAnimation].Idle2,
                    F[SAnimation].Idle3,
                    F[SAnimation].Walk,
                    F[SAnimation].Run,
                    F[SAnimation].Jump,
                    F[SAnimation].Climb,
                    F[SAnimation].Fall,
                    F[SAnimation].Swim,
                    F[SAnimation].SwimIdle,
                    F[SAnimation].Weight,
                    F[SAnimation].Weight2
                )
                Q()
                local aa =
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
                local aj = aa:GetPlayingAnimationTracks()
                for w, s in pairs(aj) do
                    s:AdjustSpeed(Settings.AnimationSpeed)
                end
                aD:Set(
                    "Current Animation: " ..
                        Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed)
                )
            end
        }
    )
    aC:AddTextbox(
        {
            Name = "Play Animation (Name)",
            Default = "",
            TextDisappear = true,
            Callback = function(av)
                local by = ae(av)
                if by and string.len(av) > 2 then
                    O()
                    Settings.SelectedAnimation = by
                    Settings.LastEmote = "Play"
                    R(
                        F[by].Idle,
                        F[by].Idle2,
                        F[by].Idle3,
                        F[by].Walk,
                        F[by].Run,
                        F[by].Jump,
                        F[by].Climb,
                        F[by].Fall,
                        F[by].Swim,
                        F[by].SwimIdle,
                        F[by].Weight,
                        F[by].Weight2
                    )
                    UpdateFile()
                    aD:Set(
                        "Current Animation: " ..
                            Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed)
                    )
                    Q()
                end
            end
        }
    )
    local bz
    aC:AddToggle(
        {Name = "Animation Chat", Default = false, Callback = function(aw)
                Settings.Animate = aw
                UpdateFile()
                if Settings.Animate then
                    B("Enabled Animation-Chat", "Prefix is: " .. Settings.AnimationPrefix)
                end
            end}
    )
    aC:AddToggle(
        {
            Name = "Random Animation",
            Default = false,
            Callback = function(aw)
                Settings.RandomAnim = aw
                UpdateFile()
                while Settings.RandomAnim do
                    task.wait()
                    if
                        game:GetService("Players").LocalPlayer.Character and
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
                            Settings.RandomAnim
                     then
                        Settings.Custom = GetRandomAnimation(F)
                        O()
                        R(
                            Settings.Custom.Idle,
                            Settings.Custom.Idle2,
                            Settings.Custom.Idle3,
                            Settings.Custom.Walk,
                            Settings.Custom.Run,
                            Settings.Custom.Jump,
                            Settings.Custom.Climb,
                            Settings.Custom.Fall,
                            Settings.Custom.Swim,
                            Settings.Custom.SwimIdle,
                            Settings.Custom.Weight,
                            Settings.Custom.Weight2
                        )
                        Settings.SelectedAnimation = "Custom"
                        local aa =
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass(
                                "AnimationController"
                            )
                        local aj = aa:GetPlayingAnimationTracks()
                        for w, s in pairs(aj) do
                            s:AdjustSpeed(Settings.AnimationSpeed)
                        end
                        aD:Set(
                            "Current Animation: " ..
                                Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed)
                        )
                        Q()
                        task.wait(6.35)
                    end
                end
            end
        }
    )
    aC:AddButton(
        {Name = "Reset Animations", Callback = function()
                O()
                Settings.Custom.Custom = {}
                UpdateFile()
                local b = game:GetService("Players").LocalPlayer.Character.Animate
                b.idle.Animation1.AnimationId = OriginalAnimations[1] or ""
                b.idle.Animation2.AnimationId = OriginalAnimations[2] or ""
                if b:FindFirstChild("pose") then
                    local f =
                        game:GetService("Players").LocalPlayer.Character.Animate.pose:FindFirstChildOfClass("Animation")
                    if f then
                        f.AnimationId = OriginalAnimations[3] or ""
                    end
                end
                b.walk:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[4] or ""
                b.run:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[5] or ""
                b.jump:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[6] or ""
                b.climb:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[7] or ""
                b.fall:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[8] or ""
                b.swim:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[9] or ""
                b.swimidle:FindFirstChildOfClass("Animation").AnimationId = OriginalAnimations[10] or ""
                Q()
            end}
    )
    local au = aC:AddSection({Name = " // Animation Settings"})
    aC:AddSlider(
        {
            Name = "Animation Speed",
            Min = 0,
            Max = 100,
            Default = 1,
            Color = Color3.fromRGB(0, 128, 255),
            Increment = 1,
            ValueName = "",
            Callback = function(av)
                Settings.AnimationSpeed = av
                aD:Set(
                    "Current Animation: " ..
                        Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed)
                )
            end
        }
    )
    aC:AddToggle(
        {Name = "Animation Speed", Default = false, Callback = function(aw)
                Settings.AnimationSpeedToggle = aw
                UpdateFile()
            end}
    )
    local bz
    local bA
    local function bB(b2)
        if bz then
            bz:Disconnect()
            bz = nil
        end
        if
            b2 and b2.Character and b2.Character:FindFirstChildOfClass("Humanoid") and
                b2.Character:FindFirstChild("Animate")
         then
            bz =
                b2.Character.Humanoid.AnimationPlayed:Connect(
                function(bC)
                    if
                        Settings.SyncAnimations and game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
                            game.Players.LocalPlayer.Character:FindFirstChild("Animate")
                     then
                        local bD = bC.Animation.AnimationId
                        for w, bE in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                            bE:Stop()
                        end
                        Q()
                        local bF = Instance.new("Animation")
                        bF.AnimationId = bD
                        local bG = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(bF)
                        bG:Play()
                        bG:AdjustWeight(10)
                        bG.Stopped:Connect(
                            function()
                                game.Players.LocalPlayer.Character.Animate.Disabled = false
                            end
                        )
                        aD:Set(
                            "Current Animation: " ..
                                Settings.SelectedAnimation .. " // Speed: " .. tostring(Settings.AnimationSpeed)
                        )
                        UpdateFile()
                    end
                end
            )
        end
    end
    local function bH(b2)
        if bA then
            bA:Disconnect()
            bA = nil
        end
        bA =
            b2.CharacterAdded:Connect(
            function(b3)
                repeat
                    task.wait()
                until b3:FindFirstChildOfClass("Humanoid") and b3:FindFirstChild("Animate") and Settings.SyncAnimations
                bB(b2)
            end
        )
    end
    aC:AddToggle(
        {
            Name = "Sync Animations",
            Default = false,
            Callback = function(aw)
                Settings.SyncAnimations = aw
                UpdateFile()
                if Settings.SyncAnimations then
                    Q()
                    O()
                    task.spawn(
                        function()
                            repeat
                                task.wait()
                            until not Settings.Player or not Settings.SyncAnimations
                            Q()
                        end
                    )
                    if not game.Lighting:FindFirstChild("SyncNigga") then
                        local M = Instance.new("Part", game.Lighting)
                        M.Name = "SyncNigga"
                    end
                    local b = game.Players.LocalPlayer.Character:FindFirstChild("Animate")
                    local bI = Settings.Player.Character:FindFirstChild("Animate")
                    local a9 = ab()
                    if not a9 then
                        return
                    elseif a9 == "R6" then
                        SAnimation = "Rthro"
                        R(
                            F[SAnimation].Idle,
                            F[SAnimation].Idle2,
                            F[SAnimation].Idle3,
                            F[SAnimation].Walk,
                            F[SAnimation].Run,
                            F[SAnimation].Jump,
                            F[SAnimation].Climb,
                            F[SAnimation].Fall,
                            F[SAnimation].Swim,
                            F[SAnimation].SwimIdle,
                            F[SAnimation].Weight,
                            F[SAnimation].Weight2
                        )
                    end
                    if b and bI then
                        O()
                        if not a9 == "R6" then
                            local bJ = {
                                b.idle.Animation1.AnimationId,
                                b.idle.Animation2.AnimationId,
                                b.walk:FindFirstChildOfClass("Animation").AnimationId,
                                b.run:FindFirstChildOfClass("Animation").AnimationId,
                                b.jump:FindFirstChildOfClass("Animation").AnimationId,
                                b.climb:FindFirstChildOfClass("Animation").AnimationId,
                                b.fall:FindFirstChildOfClass("Animation").AnimationId,
                                b.swim:FindFirstChildOfClass("Animation").AnimationId,
                                b.swimidle:FindFirstChildOfClass("Animation").AnimationId
                            }
                            b.idle.Animation1.AnimationId = bI.idle.Animation1.AnimationId or bJ[1]
                            b.idle.Animation2.AnimationId = bI.idle.Animation2.AnimationId or bJ[2]
                            b.walk:FindFirstChildOfClass("Animation").AnimationId =
                                bI.walk:FindFirstChildOfClass("Animation").AnimationId or bJ[3]
                            b.run:FindFirstChildOfClass("Animation").AnimationId =
                                bI.run:FindFirstChildOfClass("Animation").AnimationId or bJ[4]
                            b.jump:FindFirstChildOfClass("Animation").AnimationId =
                                bI.jump:FindFirstChildOfClass("Animation").AnimationId or bJ[5]
                            b.climb:FindFirstChildOfClass("Animation").AnimationId =
                                bI.climb:FindFirstChildOfClass("Animation").AnimationId or bJ[6]
                            b.fall:FindFirstChildOfClass("Animation").AnimationId =
                                bI.fall:FindFirstChildOfClass("Animation").AnimationId or bJ[7]
                            b.swim:FindFirstChildOfClass("Animation").AnimationId =
                                bI.swim:FindFirstChildOfClass("Animation").AnimationId or bJ[8]
                            b.swimidle:FindFirstChildOfClass("Animation").AnimationId =
                                bI.swimidle:FindFirstChildOfClass("Animation").AnimationId or bJ[9]
                            if b:FindFirstChild("pose") and bI:FindFirstChild("pose") then
                                local f = b.pose:FindFirstChildOfClass("Animation")
                                local bK = bI.pose:FindFirstChildOfClass("Animation")
                                if f and bK then
                                    f.AnimationId = bK.AnimationId or bJ[10]
                                end
                            end
                            Q()
                        end
                    end
                elseif not Settings.SyncAnimations and game.Lighting:FindFirstChild("SyncNigga") then
                    game.Lighting.SyncNigga:Destroy()
                    if bz then
                        bz:Disconnect()
                        bz = nil
                    end
                    if bA then
                        bA:Disconnect()
                        bA = nil
                    end
                end
                if
                    Settings.Player and Settings.Player.Character and
                        Settings.Player.Character:FindFirstChildOfClass("Humanoid")
                 then
                    bH(Settings.Player)
                    bB(Settings.Player)
                end
            end
        }
    )
    local bL = game:GetService("Players")
    local bM = game:GetService("RunService")
    local bN = bL.LocalPlayer
    local bO, bP, bQ, bR
    local function bS(bi)
        if bO then
            bO:Disconnect()
        end
        if bP then
            bP:Disconnect()
        end
        if bQ then
            bQ:Disconnect()
        end
        if bR then
            bR:Disconnect()
        end
        local function bT(b2)
            return b2.Character and b2.Character:FindFirstChildOfClass("Humanoid")
        end
        local function bU(b2)
            return b2.Character and b2.Character:FindFirstChild("HumanoidRootPart")
        end
        local function bV(b2)
            local bW = bT(b2)
            return bW and bW.Health > 0
        end
        if not (bi and bT(bi) and bU(bi)) then
            return
        end
        bP =
            bT(bi):GetPropertyChangedSignal("Jump"):Connect(
            function()
                if Settings.CopyMovement and bV(bN) then
                    bT(bN).Jump = bT(bi).Jump
                end
            end
        )
        bQ =
            bT(bi).StateChanged:Connect(
            function(w, bX)
                if Settings.CopyMovement and bV(bN) then
                    local bY = bT(bN)
                    if bY:GetState() ~= bX then
                        pcall(
                            function()
                                bY:ChangeState(bX)
                            end
                        )
                    end
                end
            end
        )
        bR =
            bM.Heartbeat:Connect(
            function()
                if Settings.CopyMovement and bV(bN) and bV(bi) then
                    local bZ = bT(bi)
                    local b_ = bT(bN)
                    b_:Move(bZ.MoveDirection, false)
                    local c0 = bU(bi)
                    local c1 = bU(bN)
                    if c0 and c1 then
                        local c2 = c0.CFrame.LookVector
                        local c3 = c1.Position
                        c1.CFrame = CFrame.new(c3, c3 + Vector3.new(c2.X, 0, c2.Z))
                    end
                end
            end
        )
        bO =
            bM.Stepped:Connect(
            function()
                if Settings.CopyMovement and bV(bN) and bV(bi) then
                    local c4 = bU(bi)
                    local c1 = bU(bN)
                    if c4 and c1 then
                        c1.CFrame = c4.CFrame
                    end
                    local c5 = bi.Character:FindFirstChildOfClass("Tool")
                    local c6 = bN.Character:FindFirstChildOfClass("Tool")
                    if not c5 and c6 then
                        bT(bN):UnequipTools()
                    elseif c5 and c6 and c5.Name ~= c6.Name then
                        bT(bN):UnequipTools()
                    end
                    if c5 and not c6 then
                        local c7 = c5.Name
                        local c8 = bN.Backpack:FindFirstChild(c7)
                        if c8 then
                            bT(bN):EquipTool(c8)
                        end
                    end
                end
            end
        )
    end
    aC:AddToggle(
        {Name = "Copy Movement", Default = false, Callback = function(aw)
                Settings.CopyMovement = aw
                UpdateFile()
                if Settings.CopyMovement and d and d.Character and d.Character:FindFirstChildOfClass("Humanoid") then
                    bS(d)
                    local M = Instance.new("Part", game:GetService("Lighting"))
                    M.Name = "CopyMovementNigga"
                elseif game:GetService("Lighting"):FindFirstChild("CopyMovementNigga") then
                    game:GetService("Lighting"):FindFirstChild("CopyMovementNigga"):Destroy()
                    if bO then
                        bO:Disconnect()
                    end
                    if bP then
                        bP:Disconnect()
                    end
                    if bQ then
                        bQ:Disconnect()
                    end
                    if bR then
                        bR:Disconnect()
                    end
                end
                if d and Settings.CopyMovement then
                    Settings.Player = d
                end
            end}
    )
    aC:AddToggle(
        {
            Name = "Freeze Animation",
            Default = false,
            Callback = function(aw)
                Settings.FreezeAnimation = aw
                UpdateFile()
                if Settings.FreezeAnimation then
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "freezenigga"
                end
                if
                    not Settings.FreezeAnimation and
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
                        game:GetService("Lighting"):FindFirstChild("freezenigga") or
                        not Settings.FreezeAnimation and
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass(
                                "AnimationController"
                            ) and
                            game:GetService("Lighting"):FindFirstChild("freezenigga")
                 then
                    game.Lighting.freezenigga:Destroy()
                    local aa =
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
                    local aj = aa:GetPlayingAnimationTracks()
                    for w, s in pairs(aj) do
                        s:AdjustSpeed(1)
                    end
                    Q()
                end
                while Settings.FreezeAnimation do
                    task.wait()
                    if
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass(
                                "AnimationController"
                            )
                     then
                        local aa =
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass(
                                "AnimationController"
                            )
                        local aj = aa:GetPlayingAnimationTracks()
                        for w, s in pairs(aj) do
                            s:AdjustSpeed(0)
                        end
                    end
                end
            end
        }
    )
    local au = aC:AddSection({Name = " // Emote Toggles"})
    aC:AddToggle(
        {
            Name = "Sit",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Lotus")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 45 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What13"
                elseif game.Lighting:FindFirstChild("What13") then
                    game.Lighting:FindFirstChild("What13"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    local c9 = 2.1
    if
        game:GetService("Players").LocalPlayer.Character and
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
     then
        c9 = game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight
    end
    aC:AddToggle(
        {
            Name = "Sit 2",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Bicycle")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 72 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What14"
                elseif game.Lighting:FindFirstChild("What14") then
                    game.Lighting:FindFirstChild("What14"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Sit 3",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Quiet Waves")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 12 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What16"
                elseif game.Lighting:FindFirstChild("What16") then
                    game.Lighting:FindFirstChild("What16"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Sit 4",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Skadoosh")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 77 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What17"
                elseif game.Lighting:FindFirstChild("What17") then
                    game.Lighting:FindFirstChild("What17"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Float",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Fall Back to Float")
                    ac(ax)
                    game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight = 4
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 72 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What18"
                elseif game.Lighting:FindFirstChild("What18") then
                    game.Lighting:FindFirstChild("What18"):Destroy()
                    game:GetService("Players").LocalPlayer.Character.Humanoid.HipHeight = c9
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Float 2",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Skadoosh")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 43 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What19"
                elseif game.Lighting:FindFirstChild("What19") then
                    game.Lighting:FindFirstChild("What19"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Float 3",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Cuco - Levitate")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 7 / 100 * _G.LoadAnim.Length
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What20"
                elseif game.Lighting:FindFirstChild("What20") then
                    game.Lighting:FindFirstChild("What20"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                task.spawn(
                    function()
                        while Settings.RapePlayer do
                            _G.LoadAnim.TimePosition = 7 / 100 * _G.LoadAnim.Length
                            task.wait(6)
                        end
                    end
                )
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Upside Down",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Hero Landing")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 24.15 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What21"
                elseif game.Lighting:FindFirstChild("What21") then
                    game.Lighting:FindFirstChild("What21"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Upside Down 2",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Skadoosh")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 44 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What22"
                elseif game.Lighting:FindFirstChild("What22") then
                    game.Lighting:FindFirstChild("What22"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Lay Down",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Bicycle")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 57 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What23"
                elseif game.Lighting:FindFirstChild("What23") then
                    game.Lighting:FindFirstChild("What23"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Twerk Ass",
            Default = false,
            Callback = function(aw)
                Settings.TwerkAss = aw
                if Settings.TwerkAss then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Scorpion")
                    ac(ax)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What24"
                elseif game.Lighting:FindFirstChild("What24") then
                    game.Lighting:FindFirstChild("What24"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.TwerkAss do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                    _G.LoadAnim.TimePosition = 83
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 83
                    _G.LoadAnim.TimePosition = 83
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 83
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Twerk Ass 2",
            Default = false,
            Callback = function(aw)
                Settings.TwerkAss2 = aw
                if Settings.TwerkAss2 then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Scorpion")
                    ac(ax)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What25"
                elseif game.Lighting:FindFirstChild("What25") then
                    game.Lighting:FindFirstChild("What25"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.TwerkAss2 do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                    _G.LoadAnim.TimePosition = 82
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 83
                    _G.LoadAnim.TimePosition = 82
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 83
                end
            end
        }
    )
    aC:AddToggle(
        {
            Name = "Strech",
            Default = false,
            Callback = function(aw)
                Settings.RapePlayer = aw
                if Settings.RapePlayer then
                    Settings.PlayAlways = true
                    Settings.Time = true
                    Q()
                    local ax = ai("Quiet Waves")
                    ac(ax)
                    task.wait(.15)
                    _G.LoadAnim.TimePosition = 52 / 100 * _G.LoadAnim.Length
                    _G.LoadAnim:AdjustSpeed(0)
                    local M = Instance.new("Part", game.Lighting)
                    M.Name = "What26"
                elseif game.Lighting:FindFirstChild("What26") then
                    game.Lighting:FindFirstChild("What26"):Destroy()
                    Q()
                    Settings.PlayAlways = false
                end
                while Settings.RapePlayer do
                    task.wait()
                    pcall(
                        function()
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit =
                                    false
                            end
                        end
                    )
                end
            end
        }
    )
end
if
    game:GetService("Players").LocalPlayer.Character and
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("UpperTorso")
 then
    local ca = aq:MakeTab({Name = "Custom Anims", Icon = "rbxassetid://12403104094", PremiumOnly = false})
    local au = ca:AddSection({Name = " // Custom Emotes"})
    ca:AddDropdown(
        {
            Name = "Emotes (Animation)",
            Default = "",
            Options = {
                "Idle",
                "Idle 2",
                "Walk",
                "Run",
                "Jump",
                "Climb",
                "Fall",
                "Swim Idle",
                "Swim",
                "Wave",
                "Laugh",
                "Cheer",
                "Point",
                "Sit",
                "Dance",
                "Dance 2",
                "Dance 3"
            },
            Callback = function(av)
                if Settings.LastEmote == "" then
                    y("Failed!", "Selected an Emote First from the (Main) Tab!")
                    return
                end
                if av == "Idle" then
                    a3("idle1", E[Settings.LastEmote])
                    Settings.Custom.Idle = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Idle 2" then
                    a3("idle2", E[Settings.LastEmote])
                    Settings.Custom.Idle2 = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Walk" then
                    a3("walk", E[Settings.LastEmote])
                    Settings.Custom.Walk = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Run" then
                    a3("run", E[Settings.LastEmote])
                    Settings.Custom.Run = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Jump" then
                    a3("jump", E[Settings.LastEmote])
                    Settings.Custom.Jump = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Climb" then
                    a3("climb", E[Settings.LastEmote])
                    Settings.Custom.Climb = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Fall" then
                    a3("fall", E[Settings.LastEmote])
                    Settings.Custom.Fall = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Swim Idle" then
                    a3("swimidle", E[Settings.LastEmote])
                    Settings.Custom.SwimIdle = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Swim" then
                    a3("swim", E[Settings.LastEmote])
                    Settings.Custom.Swim = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Wave" then
                    a3("wave", E[Settings.LastEmote])
                    Settings.Custom.Wave = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Laugh" then
                    a3("laugh", E[Settings.LastEmote])
                    Settings.Custom.Laugh = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Cheer" then
                    a3("cheer", E[Settings.LastEmote])
                    Settings.Custom.Cheer = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Point" then
                    a3("point", E[Settings.LastEmote])
                    Settings.Custom.Point = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Sit" then
                    a3("sit", E[Settings.LastEmote])
                    Settings.Custom.Sit = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Dance" then
                    a3("dance", E[Settings.LastEmote])
                    Settings.Custom.Dance = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Dance 2" then
                    a3("dance2", E[Settings.LastEmote])
                    Settings.Custom.Dance2 = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                elseif av == "Dance 3" then
                    a3("dance3", E[Settings.LastEmote])
                    Settings.Custom.Dance3 = E[Settings.LastEmote]
                    Settings.SelectedAnimation = "Custom"
                    UpdateFile()
                end
            end
        }
    )
    ca:AddButton(
        {
            Name = "Select Random Animations",
            Callback = function()
                Settings.Custom.Custom = {}
                Q()
                UpdateFile()
                for r = 1, 10 do
                    task.wait()
                    Settings.Custom.Idle = GetRandomAnimation(F).Idle
                    Settings.Custom.Idle2 = GetRandomAnimation(F).Idle2
                    Settings.Custom.Idle3 = GetRandomAnimation(F).Idle3
                    Settings.Custom.Walk = GetRandomAnimation(F).Walk
                    Settings.Custom.Run = GetRandomAnimation(F).Run
                    Settings.Custom.Jump = GetRandomAnimation(F).Jump
                    Settings.Custom.Climb = GetRandomAnimation(F).Climb
                    Settings.Custom.Fall = GetRandomAnimation(F).Fall
                    Settings.Custom.Swim = GetRandomAnimation(F).Swim
                    Settings.Custom.SwimIdle = GetRandomAnimation(F).SwimIdle
                    Settings.Custom.Weight = GetRandomAnimation(F).Weight
                    Settings.Custom.Weight2 = GetRandomAnimation(F).Weight2
                end
                R(
                    Settings.Custom.Idle,
                    Settings.Custom.Idle2,
                    Settings.Custom.Idle3,
                    Settings.Custom.Walk,
                    Settings.Custom.Run,
                    Settings.Custom.Jump,
                    Settings.Custom.Climb,
                    Settings.Custom.Fall,
                    Settings.Custom.Swim,
                    Settings.Custom.SwimIdle,
                    Settings.Custom.Weight,
                    Settings.Custom.Weight2
                )
                UpdateFile()
                Q()
                Settings.SelectedAnimation = "Custom"
            end
        }
    )
    ca:AddButton(
        {
            Name = "Select Random Emote Animations",
            Callback = function()
                Settings.Custom.Custom = {}
                Q()
                UpdateFile()
                for r = 1, 10 do
                    task.wait()
                    local bu, bv = bp()
                    if r == 1 then
                        Settings.Custom.Idle = bv
                    elseif r == 2 then
                        Settings.Custom.Idle2 = bv
                    elseif r == 3 then
                        Settings.Custom.Idle3 = bv
                    elseif r == 4 then
                        Settings.Custom.Walk = bv
                    elseif r == 5 then
                        Settings.Custom.Run = bv
                    elseif r == 6 then
                        Settings.Custom.Jump = bv
                    elseif r == 7 then
                        Settings.Custom.Climb = bv
                    elseif r == 8 then
                        Settings.Custom.Fall = bv
                    elseif r == 9 then
                        Settings.Custom.Swim = bv
                    elseif r == 10 then
                        Settings.Custom.SwimIdle = bv
                    end
                end
                R(
                    Settings.Custom.Idle,
                    Settings.Custom.Idle2,
                    Settings.Custom.Idle3,
                    Settings.Custom.Walk,
                    Settings.Custom.Run,
                    Settings.Custom.Jump,
                    Settings.Custom.Climb,
                    Settings.Custom.Fall,
                    Settings.Custom.Swim,
                    Settings.Custom.SwimIdle,
                    Settings.Custom.Weight,
                    Settings.Custom.Weight2
                )
                UpdateFile()
                Q()
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = "Emotes"
            end
        }
    )
    local au = ca:AddSection({Name = " // Custom-Selection Dropdowns"})
    ca:AddDropdown(
        {Name = "Set Idle1 Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("idle1", F[SAnimation].Idle)
                Settings.Custom.Idle = F[SAnimation].Idle
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
    ca:AddDropdown(
        {Name = "Set Idle2 Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("idle2", F[SAnimation].Idle2)
                Settings.Custom.Idle2 = F[SAnimation].Idle2
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
    ca:AddDropdown(
        {Name = "Set Walk Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("walk", F[SAnimation].Walk)
                Settings.Custom.Walk = F[SAnimation].Walk
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
    ca:AddDropdown(
        {Name = "Set Run Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("run", F[SAnimation].Run)
                Settings.Custom.Run = F[SAnimation].Run
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
    ca:AddDropdown(
        {Name = "Set Jump Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("jump", F[SAnimation].Jump)
                Settings.Custom.Jump = F[SAnimation].Jump
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
    ca:AddDropdown(
        {Name = "Set Climb Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("climb", F[SAnimation].Climb)
                Settings.Custom.Climb = F[SAnimation].Climb
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
    ca:AddDropdown(
        {Name = "Set Fall Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("fall", F[SAnimation].Fall)
                Settings.Custom.Fall = F[SAnimation].Fall
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
    ca:AddDropdown(
        {Name = "Set Swim-Idle Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("swimidle", F[SAnimation].SwimIdle)
                Settings.Custom.SwimIdle = F[SAnimation].SwimIdle
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
    ca:AddDropdown(
        {Name = "Set Swim Animation", Default = "", Options = K, Callback = function(SAnimation)
                Settings.SelectedAnimation = ""
                a3("swim", F[SAnimation].Swim)
                Settings.Custom.Swim = F[SAnimation].Swim
                Settings.SelectedAnimation = "Custom"
                Settings.Custom.Name = SAnimation
                UpdateFile()
            end}
    )
end
local cb = aq:MakeTab({Name = "Settings", Icon = "rbxassetid://8382597378", PremiumOnly = false})
cb:AddButton(
    {Name = "Rejoin", Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end}
)
cb:AddButton(
    {Name = "Serverhop", Callback = function()
            game:GetService("TeleportService"):TeleportCancel()
            game:GetService("Players").LocalPlayer:Kick("Serverhopping please wait... | This is to avoid bans in-game.")
            task.wait(.15)
            n()
        end}
)
cb:AddButton(
    {
        Name = "Save Current Animations (File)",
        Callback = function()
            if
                game:GetService("Players").LocalPlayer.Character ~= nil and
                    game:GetService("Players").LocalPlayer.Character.Animate ~= nil
             then
                local b = game:GetService("Players").LocalPlayer.Character.Animate
                local cc = math.random(9e9, 8e8)
                if writefile then
                    writefile(
                        game:GetService("Players").LocalPlayer.Name .. "_Animations_" .. cc .. ".lua",
                        "local Animate = game:GetService('Players').LocalPlayer.Character.Animate" ..
                            "\n" ..
                                "Animate.idle.Animation1.AnimationId = " ..
                                    "'" ..
                                        b.idle.Animation1.AnimationId ..
                                            "'" ..
                                                "\n" ..
                                                    "Animate.idle.Animation2.AnimationId = " ..
                                                        "'" ..
                                                            b.idle.Animation2.AnimationId ..
                                                                "'" ..
                                                                    "\n" ..
                                                                        "Animate.run:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                            "'" ..
                                                                                b.run:FindFirstChildOfClass("Animation").AnimationId ..
                                                                                    "'" ..
                                                                                        "\n" ..
                                                                                            "Animate.walk:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                "'" ..
                                                                                                    b.walk:FindFirstChildOfClass(
                                                                                                        "Animation"
                                                                                                    ).AnimationId ..
                                                                                                        "'" ..
                                                                                                            "\n" ..
                                                                                                                "Animate.jump:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                    "'" ..
                                                                                                                        b.jump:FindFirstChildOfClass(
                                                                                                                            "Animation"
                                                                                                                        ).AnimationId ..
                                                                                                                            "'" ..
                                                                                                                                "\n" ..
                                                                                                                                    "Animate.climb:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                        "'" ..
                                                                                                                                            b.climb:FindFirstChildOfClass(
                                                                                                                                                "Animation"
                                                                                                                                            ).AnimationId ..
                                                                                                                                                "'" ..
                                                                                                                                                    "\n" ..
                                                                                                                                                        "Animate.fall:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                            "'" ..
                                                                                                                                                                b.fall:FindFirstChildOfClass(
                                                                                                                                                                    "Animation"
                                                                                                                                                                ).AnimationId ..
                                                                                                                                                                    "'" ..
                                                                                                                                                                        "\n" ..
                                                                                                                                                                            "Animate.swim:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                                                "'" ..
                                                                                                                                                                                    b.swim:FindFirstChildOfClass(
                                                                                                                                                                                        "Animation"
                                                                                                                                                                                    ).AnimationId ..
                                                                                                                                                                                        "'" ..
                                                                                                                                                                                            "\n" ..
                                                                                                                                                                                                "Animate.swimidle:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                                                                    "'" ..
                                                                                                                                                                                                        b.swimidle:FindFirstChildOfClass(
                                                                                                                                                                                                            "Animation"
                                                                                                                                                                                                        ).AnimationId ..
                                                                                                                                                                                                            "'"
                    )
                    B(
                        game:GetService("Players").LocalPlayer.Name ..
                            " @" .. game:GetService("Players").LocalPlayer.DisplayName .. " Animations",
                        "saved to workspace folder!"
                    )
                else
                    B(
                        game:GetService("Players").LocalPlayer.Name ..
                            " @" .. game:GetService("Players").LocalPlayer.DisplayName .. " Animations",
                        "set to clipboard"
                    )
                    setclipboard(
                        "local Animate = game:GetService('Players').LocalPlayer.Character.Animate" ..
                            "\n" ..
                                "Animate.idle.Animation1.AnimationId = " ..
                                    "'" ..
                                        b.idle.Animation1.AnimationId ..
                                            "'" ..
                                                "\n" ..
                                                    "Animate.idle.Animation2.AnimationId = " ..
                                                        "'" ..
                                                            b.idle.Animation2.AnimationId ..
                                                                "'" ..
                                                                    "\n" ..
                                                                        "Animate.run:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                            "'" ..
                                                                                b.run:FindFirstChildOfClass("Animation").AnimationId ..
                                                                                    "'" ..
                                                                                        "\n" ..
                                                                                            "Animate.walk:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                "'" ..
                                                                                                    b.walk:FindFirstChildOfClass(
                                                                                                        "Animation"
                                                                                                    ).AnimationId ..
                                                                                                        "'" ..
                                                                                                            "\n" ..
                                                                                                                "Animate.jump:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                    "'" ..
                                                                                                                        b.jump:FindFirstChildOfClass(
                                                                                                                            "Animation"
                                                                                                                        ).AnimationId ..
                                                                                                                            "'" ..
                                                                                                                                "\n" ..
                                                                                                                                    "Animate.climb:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                        "'" ..
                                                                                                                                            b.climb:FindFirstChildOfClass(
                                                                                                                                                "Animation"
                                                                                                                                            ).AnimationId ..
                                                                                                                                                "'" ..
                                                                                                                                                    "\n" ..
                                                                                                                                                        "Animate.fall:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                            "'" ..
                                                                                                                                                                b.fall:FindFirstChildOfClass(
                                                                                                                                                                    "Animation"
                                                                                                                                                                ).AnimationId ..
                                                                                                                                                                    "'" ..
                                                                                                                                                                        "\n" ..
                                                                                                                                                                            "Animate.swim:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                                                "'" ..
                                                                                                                                                                                    b.swim:FindFirstChildOfClass(
                                                                                                                                                                                        "Animation"
                                                                                                                                                                                    ).AnimationId ..
                                                                                                                                                                                        "'" ..
                                                                                                                                                                                            "\n" ..
                                                                                                                                                                                                "Animate.swimidle:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                                                                    "'" ..
                                                                                                                                                                                                        b.swimidle:FindFirstChildOfClass(
                                                                                                                                                                                                            "Animation"
                                                                                                                                                                                                        ).AnimationId ..
                                                                                                                                                                                                            "'"
                    )
                end
            end
        end
    }
)
cb:AddTextbox(
    {
        Name = "Save Animations File (Player)",
        Default = "",
        TextDisappear = true,
        Callback = function(av)
            d = getPlayersByName(av)
            local b = game:GetService("Players")[d].Character.Animate
            local cc = math.random(9e9, 8e8)
            writefile(
                game:GetService("Players")[d].Name .. "_Animations_" .. cc .. ".lua",
                "local Players = game:GetService('Players')" ..
                    "\n" ..
                        "local Animate = Players[" ..
                            d ..
                                "].Character.Animate" ..
                                    "\n" ..
                                        "Animate.idle.Animation1.AnimationId = " ..
                                            "'" ..
                                                b.idle.Animation1.AnimationId ..
                                                    "'" ..
                                                        "\n" ..
                                                            "Animate.idle.Animation2.AnimationId = " ..
                                                                "'" ..
                                                                    b.idle.Animation2.AnimationId ..
                                                                        "'" ..
                                                                            "\n" ..
                                                                                "Animate.run:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                    "'" ..
                                                                                        b.run:FindFirstChildOfClass(
                                                                                            "Animation"
                                                                                        ).AnimationId ..
                                                                                            "'" ..
                                                                                                "\n" ..
                                                                                                    "Animate.walk:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                        "'" ..
                                                                                                            b.walk:FindFirstChildOfClass(
                                                                                                                "Animation"
                                                                                                            ).AnimationId ..
                                                                                                                "'" ..
                                                                                                                    "\n" ..
                                                                                                                        "Animate.jump:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                            "'" ..
                                                                                                                                b.jump:FindFirstChildOfClass(
                                                                                                                                    "Animation"
                                                                                                                                ).AnimationId ..
                                                                                                                                    "'" ..
                                                                                                                                        "\n" ..
                                                                                                                                            "Animate.climb:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                "'" ..
                                                                                                                                                    b.climb:FindFirstChildOfClass(
                                                                                                                                                        "Animation"
                                                                                                                                                    ).AnimationId ..
                                                                                                                                                        "'" ..
                                                                                                                                                            "\n" ..
                                                                                                                                                                "Animate.fall:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                                    "'" ..
                                                                                                                                                                        b.fall:FindFirstChildOfClass(
                                                                                                                                                                            "Animation"
                                                                                                                                                                        ).AnimationId ..
                                                                                                                                                                            "'" ..
                                                                                                                                                                                "\n" ..
                                                                                                                                                                                    "Animate.swim:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                                                        "'" ..
                                                                                                                                                                                            b.swim:FindFirstChildOfClass(
                                                                                                                                                                                                "Animation"
                                                                                                                                                                                            ).AnimationId ..
                                                                                                                                                                                                "'" ..
                                                                                                                                                                                                    "\n" ..
                                                                                                                                                                                                        "Animate.swimidle:FindFirstChildOfClass('Animation').AnimationId = " ..
                                                                                                                                                                                                            "'" ..
                                                                                                                                                                                                                b.swimidle:FindFirstChildOfClass(
                                                                                                                                                                                                                    "Animation"
                                                                                                                                                                                                                ).AnimationId ..
                                                                                                                                                                                                                    "'"
            )
            B(
                game:GetService("Players")[d].Name .. " @" .. game:GetService("Players")[d].DisplayName .. " Animations",
                "saved to workspace folder!"
            )
        end
    }
)
if a9() == "R15" then
    cb:AddTextbox(
        {Name = "Emote Prefix", Default = "", TextDisappear = true, Callback = function(av)
                Settings.EmotePrefix = "/" .. av
                B("Changed", "Emote Prefix: " .. Settings.EmotePrefix)
            end}
    )
    cb:AddTextbox(
        {Name = "Animation Prefix", Default = "", TextDisappear = true, Callback = function(av)
                Settings.AnimationPrefix = "/" .. av
                B("Changed", "Animation Prefix: " .. Settings.AnimationPrefix)
            end}
    )
end
cb:AddToggle(
    {
        Name = "Click to Select",
        Default = false,
        Callback = function(aw)
            Settings.ClickToSelect = aw
            if Settings.ClickToSelect then
                x:MakeNotification(
                    {
                        Name = "Eazvy Hub - Success",
                        Content = "Click-to Select has been enabled; Keybind: CTRL + Click",
                        Image = "rbxassetid://4914902889",
                        Time = 10
                    }
                )
            end
        end
    }
)
cb:AddToggle(
    {Name = "Day/Night", Default = false, Callback = function(aw)
            Settings.Day = aw
            if Settings.Day then
                local M = Instance.new("Part", game.Lighting)
                M.Name = "nigga"
                game.Lighting.ClockTime = 0
            elseif game.Lighting:FindFirstChild("nigga") and not Settings.Day then
                game.Lighting.nigga:Destroy()
                game.Lighting.ClockTime = 14
            elseif game.Lighting.ClockTime == 0 and Settings.Day then
                game.Lighting.ClockTime = 14
            end
        end}
)
cb:AddToggle(
    {
        Name = "Hear Anywhere",
        Default = false,
        Callback = function(aw)
            if aw == true then
                local M = Instance.new("Part", game:GetService("Lighting"))
                M.Name = "hearNigga"
                local cd, b2 = game:GetService("SoundService"), game.Players.LocalPlayer
                local b8 = b2.Character or b2.CharacterAdded:Wait()
                local b4 = b8:WaitForChild("HumanoidRootPart")
                local ce = Instance.new("Part", e)
                ce.Name, ce.Size, ce.Anchored, ce.CanCollide, ce.Transparency, ce.CFrame =
                    "SoundInf",
                    Vector3.new(10e10, 10e10, 10e10),
                    true,
                    false,
                    1,
                    b4.CFrame
                cd:SetListener(Enum.ListenerType.ObjectPosition, ce)
            elseif game:GetService("Lighting"):FindFirstChild("hearNigga") then
                game:GetService("Lighting"):FindFirstChild("hearNigga"):Destroy()
                game:GetService("SoundService"):SetListener(Enum.ListenerType.Camera)
            end
        end
    }
)
cb:AddBind(
    {Name = "Toggle UI", Default = Enum.KeyCode.Q, Hold = false, Callback = function()
            if game:GetService("CoreGui").Orion.Enabled then
                game:GetService("CoreGui").Orion.Enabled = false
            else
                game:GetService("CoreGui").Orion.Enabled = true
            end
        end}
)
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal(
    "MoveDirection"
):Connect(
    function()
        if
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude >
                0
         then
            if a9() == "R15" then
                if _G.LoadAnim and not Settings.PlayAlways then
                    game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
                    _G.LoadAnim:Stop()
                end
            else
                if _G.LoadAnim and not Settings.PlayAlways then
                    _G.LoadAnim:Stop()
                    Q()
                end
            end
        end
    end
)
game.Players.LocalPlayer.CharacterAdded:Connect(
    function(cf)
        repeat
            wait()
        until game:GetService("Players").LocalPlayer.Character and
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate")
        cf.Humanoid.Died:Connect(
            function()
                Settings.DeathPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        )
        if
            Settings.Refresh and game.Players.LocalPlayer.Character and
                game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
                Settings.DeathPosition
         then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Settings.DeathPosition
        end
        wait(.15)
        O()
        if
            Settings.SelectedAnimation ~= "" and a9() == "R15" and Settings.SelectedAnimation ~= "Custom" or
                Settings.LastEmote == "Play" and a9() == "R15" and Settings.SelectedAnimation ~= "Custom"
         then
            R(
                F[Settings.SelectedAnimation].Idle or g(1),
                F[Settings.SelectedAnimation].Idle2 or g(2),
                F[Settings.SelectedAnimation].Idle3 or g(3),
                F[Settings.SelectedAnimation].Walk or g(4),
                F[Settings.SelectedAnimation].Run or g(5),
                F[Settings.SelectedAnimation].Jump or g(6),
                F[Settings.SelectedAnimation].Climb or g(7),
                F[Settings.SelectedAnimation].Fall or g(8),
                F[Settings.SelectedAnimation].Swim or g(9),
                F[Settings.SelectedAnimation].SwimIdle or g(10),
                F[Settings.SelectedAnimation].Weight,
                F[Settings.SelectedAnimation].Weight2
            )
            if Settings.Custom.Wave then
                a3("wave", Settings.Custom.Wave)
            end
            if Settings.Custom.Laugh then
                a3("laugh", Settings.Custom.Laugh)
            end
            if Settings.Custom.Cheer then
                a3("cheer", Settings.Custom.Cheer)
            end
            if Settings.Custom.Point then
                a3("point", Settings.Custom.Point)
            end
            if Settings.Custom.Sit then
                a3("sit", Settings.Custom.Sit)
            end
            if Settings.Custom.Dance then
                a3("dance", Settings.Custom.Dance)
            end
            if Settings.Custom.Dance2 then
                a3("dance2", Settings.Custom.Dance2)
            end
            if Settings.Custom.Dance3 then
                a3("dance3", Settings.Custom.Dance3)
            end
            Q()
            local aa =
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
            local aj = aa:GetPlayingAnimationTracks()
            for w, s in pairs(aj) do
                s:AdjustSpeed(Settings.AnimationSpeed)
            end
        elseif
            F[Settings.Custom.Name] and
                (Settings.Custom.Idle or Settings.Custom.Idle2 or Settings.Custom.Idle3 or Settings.Custom.Walk or
                    Settings.Custom.Run or
                    Settings.Custom.Jump or
                    Settings.Custom.Climb or
                    Settings.Custom.Fall or
                    Settings.Custom.Swim or
                    Settings.Custom.SwimIdle) and
                F[Settings.Custom.Name].Weight and
                F[Settings.Custom.Name].Weight2 and
                a9() == "R15"
         then
            R(
                Settings.Custom.Idle or OriginalAnimations[1],
                Settings.Custom.Idle2 or OriginalAnimations[2],
                Settings.Custom.Idle3 or OriginalAnimations[3] or nil,
                Settings.Custom.Walk or OriginalAnimations[4],
                Settings.Custom.Run or OriginalAnimations[5],
                Settings.Custom.Jump or OriginalAnimations[6],
                Settings.Custom.Climb or OriginalAnimations[7],
                Settings.Custom.Fall or OriginalAnimations[8],
                Settings.Custom.Swim or OriginalAnimations[9],
                Settings.Custom.SwimIdle or OriginalAnimations[10],
                F[Settings.Custom.Name].Weight,
                F[Settings.Custom.Name].Weight2
            )
            if Settings.Custom.Wave then
                a3("wave", Settings.Custom.Wave)
            end
            if Settings.Custom.Laugh then
                a3("laugh", Settings.Custom.Laugh)
            end
            if Settings.Custom.Cheer then
                a3("cheer", Settings.Custom.Cheer)
            end
            if Settings.Custom.Point then
                a3("point", Settings.Custom.Point)
            end
            if Settings.Custom.Sit then
                a3("sit", Settings.Custom.Sit)
            end
            if Settings.Custom.Dance then
                a3("dance", Settings.Custom.Dance)
            end
            if Settings.Custom.Dance2 then
                a3("dance2", Settings.Custom.Dance2)
            end
            if Settings.Custom.Dance3 then
                a3("dance3", Settings.Custom.Dance3)
            end
            Q()
            local aa =
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
            local aj = aa:GetPlayingAnimationTracks()
            for w, s in pairs(aj) do
                s:AdjustSpeed(Settings.AnimationSpeed)
            end
        end
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal(
            "MoveDirection"
        ):Connect(
            function()
                if
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude >
                        0
                 then
                    if a9() == "R15" then
                        if _G.LoadAnim and not Settings.PlayAlways then
                            game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
                            _G.LoadAnim:Stop()
                        end
                    else
                        if _G.LoadAnim and not Settings.PlayAlways then
                            _G.LoadAnim:Stop()
                            Q()
                        end
                    end
                end
            end
        )
    end
)
if not getgenv().AlreadyLoaded then
    task.spawn(
        function()
            while task.wait() do
                if
                    Settings.AnimationSpeedToggle and game:GetService("Players").LocalPlayer.Character and
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                        Settings.AnimationSpeedToggle and
                            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass(
                                "AnimationController"
                            )
                 then
                    local aa =
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("AnimationController")
                    local aj = aa:GetPlayingAnimationTracks()
                    for w, s in pairs(aj) do
                        s:AdjustSpeed(Settings.AnimationSpeed)
                    end
                end
            end
        end
    )
end
if not getgenv().AlreadyLoaded then
    getgenv().AlreadyLoaded = true
end
