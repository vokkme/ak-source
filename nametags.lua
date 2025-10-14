local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local crequest = syn and syn.request or request or fluxus and fluxus.request or http and http.request or http_request or sentinel and sentinel.request  or http_request or http.request or http and http.request or http_request or (crypt and crypt.request) or request or (SENTINEL_LOADED and request) or (syn and syn.request)  or (typeof(request) == "function" and request) or (typeof(http) == "table" and http.request)
local JSON_URL = "https://ichfickdeinemutta.pages.dev/Tags.json"
local MAX_RETRIES = 3

local function fetchJson(url2, maxRetries)
  local retries = 0
  local tagConfig = {}
  while retries < maxRetries do
    local success, result = pcall(function()
    return crequest({
      Url = url2,
      method = "GET"
    })
    end)
    if success then
      local decodeSuccess, decoded = pcall(function()
      return HttpService:JSONDecode(result.Body)
      end)
      if decodeSuccess then
        return true, decoded
      else
      end
    else
    end
    retries = retries + 1
    if retries < maxRetries then
      local delay = 2 ^ (retries - 1)
      task.wait(delay)
    end
  end
  return false, tagConfig
end


local success, tagConfig = fetchJson(JSON_URL, MAX_RETRIES)
if not success then
else
end


local tagOrder = {
  "AK OWNER",
  "AK CO OWNER",
  "AK DADDY",
  "AK STAFF",
  "AK ADVERTISER",
  "AK HELPER",
  "AK LUCKYGOD",
  "AK BOOSTER",
  "AK SUPPORT",
  "AK BADDIE",
  "AK REAPER",
  "AK MONEYMAKER",
  "AK GODMODE",
  "AK FEMBOY",
  "AK ASIAN",
  "AK TERMINATOR",
  "AK CEO",
  "AK E-SEXLOVER",
  "AK MOMMY",
  "AK DEX",
  "AK SNIPERMASK",
  "AK E-KITTEN",
  "AK FREAK",
  "AK AZER",
  "AK HUSTLA",
  "AK HOLLOWFLAME",
  "AK FENNEC",
  "AK DRAGON",
  "AK FEDERAL",
  "AK ARCTURUS",
  "AK GOODBOY",
  "AK WARRIOR",
  "AK KAWAII",
  "AK POTATO",
  "AK TWISTED",
  "AK PHROGSPLOIT",
  "AK DOGGYFUCKER",
  "AK DOGGYFUCKA",
  "AK HORNYBOY",
  "AK PERKZ",
  "AK MOMMY KITTY",
  "AK RYZA",
  "AK CONTENT CREATOR",
  "AK GOONER",
  "AK VORTEX",
  "AK DADDYTWIZZY",
  "AK SHROOMIE",
  "AK DANCER",
  "AK HUNTER",
  "AK VETERAN",
  "AK SEEKER",
  "AK ELITE",
  "AK LEGEND",
  "AK MASTER",
  "AK MYTHIC",
  "AK EXPLORER",
  "AK CHALLENGER",
  "AK ASCENDED",
  "AK ROOKIE",
  "AK ALLMIGHTY",
  "AK GOD",
  "AK FEETLOVER",
  "AK NIGGER",
  "AK LOCKED",
  "AK BIBS",
  "AK YAMAHA_R1",
  "AK SCYTHZ",
  "AK KILLA",
  "AK STAR",
  "AK PWNED",
  "AK IM YOUR DADDY",
  "AK ASTRO 卐",
  "AK GODD",
  "AK MR.RANGER",
  "AK ???",
  "AK F SOCIETY",
  "AK SEX KITTEN",
  "AK ✞ KING",
  "AK SNOWPEEP",
  "PK",
  "AK TICKLENUTS",
  "AK PRINCE",
  "Official NotTutu",
  "AK NOVA",
  "AK SIX",
  "AK JOKER",
  "AK WITCHY",
  "AK SLIME",
  "AK SUZAK卐",
  "AK SCAR",
  "AK SCRIPT-VETERAN-WALUIGI",
  "༺AK SILLY BILLY༻",
  "𝐀𝐊 𝐄𝐗𝐏𝐋𝐎𝐃𝐄",
  "AK PROJECT",
  "AK MOMMY~",
  "AK SHARPENER"
}


local playerToTag = {}
for _, tag in ipairs(tagOrder) do
  local users = tagConfig[tag]
  if users then
    for _, user in ipairs(users) do
      local userLower = user:lower()
      if not playerToTag[userLower] then
        playerToTag[userLower] = tag
      end
    end
  end
end

local function containsIgnoreCase(tbl, name)
  if not name then return false end
  name = name:lower()
  for _, v in ipairs(tbl) do
    if v:lower() == name then
      return true
    end
  end
  return false
end

local CONFIG = {
  TAG_SIZE = UDim2.new(0, 0, 0, 32),
  TAG_OFFSET = Vector3.new(0, 2.0, 0),
  MAX_DISTANCE = 200000,
  DISTANCE_THRESHOLD = 50,
  HYSTERESIS = 5,
  CORNER_RADIUS = UDim.new(0, 10),
  PARTICLE_COUNT = 100,
  PARTICLE_SPEED = 1,
  GLOW_INTENSITY = 0.3,
  TELEPORT_DISTANCE = 5,
  TELEPORT_HEIGHT = 0.5,
}

local RankData = {
  ["AK OWNER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 128, 128)), 
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 255, 230)) 
},
 emoji = "👑",
    image = "http://www.roblox.com/asset/?id=126879270398478"
  },
    ["AK PRINCE"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),       
    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 128))  
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=83391781039426"
  },
    ["AK SCAR"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), 
    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 128))  
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=122877926620695"
  },
    ["AK JOKER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 0)), 
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))    
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=106413040902271"
  },
    ["AK MOMMY~"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 0)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))    
},
    emoji = "😈 ",
    image = "http://www.roblox.com/asset/?id=86039731053035"
  },
    ["AK SUZAK卐"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = true,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))    
},
    emoji = "💣 ",
    image = "http://www.roblox.com/asset/?id=86039731053035"
  },
    ["AK SHARPENER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))    
},
    emoji = "👅 ",
    image = "http://www.roblox.com/asset/?id=86039731053035"
  },
    ["AK PROJECT"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = true,
    GlitchName = false,
    UseImage = false,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 192, 203)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))    
},
    emoji = "🥀 ",
    image = "http://www.roblox.com/asset/?id=86039731053035"
  },
    ["𝐀𝐊 𝐄𝐗𝐏𝐋𝐎𝐃𝐄"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))    
},
    emoji = "💣 ",
    image = "http://www.roblox.com/asset/?id=86039731053035"
  },
    ["༺AK SILLY BILLY༻"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 65, 81)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))    
},
    emoji = "💣 ",
    image = "http://www.roblox.com/asset/?id=89617717885251"
  },
    ["AK SCRIPT-VETERAN-WALUIGI"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))    
},
    emoji = "🩸 ",
    image = "http://www.roblox.com/asset/?id=135169352538575"
  },
    ["AK SLIME"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), 
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 0, 0))    
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=80467495178232"
  },

    ["AK WITCHY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 0, 0)),   
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220)) 
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=87041218001370"
  },
    ["AK BOOSTER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 0, 128)),   
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 182, 193))  
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=110955368200346"
  },
    ["AK SIX"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),       
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 0, 0))      
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=87714816068409"
  },
    ["AK NOVA"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),       
    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 128))  
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=86752549305336"
  },
    ["Official NotTutu"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),       
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))      
  },

    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=101081650805516"
  },
    ["AK TICKLENUTS"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),       
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))  
},
    emoji = "👑",
    image = "http://www.roblox.com/asset/?id=83201140951613"
  },
  ["AK CO OWNER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = true,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(61, 126, 255),
    emoji = "⚡",
    image = "http://www.roblox.com/asset/?id=134980103242776"
  },
  ["AK DADDY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(0, 191, 255),
    emoji = "💎",
    image = ""
  },
  ["AK VORTEX"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(0, 191, 255),
    emoji = "🌪️",
    image = ""
  },
  ["AK NIGGA"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 255, 255),
    emoji = "🤬",
    image = ""
  },
  ["AK STAFF"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(0, 0, 0),
    emoji = "🔰",
    image = "http://www.roblox.com/asset/?id=71948587278990"
  },
  ["AK ADVERTISER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 69, 0),
    emoji = "📢",
    image = ""
  },
  ["AK HELPER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(169, 169, 169),
    emoji = "📢",
    image = ""
  },
  ["AK USER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = true,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = ColorSequence.new{
      ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 216, 230)),   
      ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))     
    },
    emoji = "♦️",
    image = "http://www.roblox.com/asset/?id=112205251766375"
  },
  ["PK"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),       
    ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 128, 128))  
   },
    emoji = "♦️",
    image = "http://www.roblox.com/asset/?id=72686950244762"
  },
  ["OG BUYER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 105, 180),
    emoji = "∞",
    image = ""
  },
  ["AK LUCKYGOD"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(124, 252, 0),
    emoji = "🍀",
    image = ""
  },
  ["AK SUPPORT"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(0, 150, 0),
    emoji = "🔨",
    image = "http://www.roblox.com/asset/?id=78056611932628"
  },
  ["AK BADDIE"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 105, 180),
    emoji = "👅",
    image = ""
  },
  ["AK REAPER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(0, 0, 0),
    emoji = "🧿",
    image = ""
  },
  ["AK MONEYMAKER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(152, 255, 152),
    emoji = "💰",
    image = ""
  },
  ["AK GODMODE"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 215, 0),
    emoji = "🤫",
    image = ""
  },
  ["AK F SOCIETY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = false,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "⛔",
    image = "http://www.roblox.com/asset/?id="
  },
  ["AK FEMBOY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 105, 180),
    emoji = "💖",
    image = ""
  },
  ["AK ASIAN"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(64, 224, 208),
    emoji = "🍜",
    image = ""
  },
  ["AK TERMINATOR"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 102, 102),
    emoji = "👁️",
    image = ""
  },
  ["AK CEO"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(200, 162, 200),
    emoji = "👑",
    image = ""
  },
  ["AK E-SEXLOVER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 105, 180),
    emoji = "💋",
    image = ""
  },
  ["AK MOMMY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(144, 31, 242),
    emoji = "🍄",
    image = ""
  },
  ["AK DEX"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(0, 0, 0),
    emoji = "🐺",
    image = ""
  },
  ["AK SNIPERMASK"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(138, 3, 3),
    emoji = "👁️‍🗨️",
    image = ""
  },
  ["AK E-KITTEN"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 105, 180),
    emoji = "🍑",
    image = ""
  },
  ["AK FREAK"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(255, 255, 255),
    emoji = "🍆",
    image = "http://www.roblox.com/asset/?id=94349052077192"
  },
  ["AK AZER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 255, 255),
    emoji = "🩸",
    image = ""
  },
  ["AK HUSTLA"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(0, 160, 190),
    emoji = "🦈",
    image = ""
  },
  ["AK HOLLOWFLAME"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 85, 0),
    emoji = "🎃",
    image = ""
  },
  ["AK FENNEC"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 140, 0),
    emoji = "🦊",
    image = "http://www.roblox.com/asset/?id=78056611932628"
  },
  ["AK DRAGON"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(139, 0, 0),
    emoji = "🍓",
    image = ""
  },
  ["AK FEDERAL"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "🚨",
    image = ""
  },
  ["AK ARCTURUS"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 165, 0),
    emoji = "♦️",
    image = "http://www.roblox.com/asset/?id=106859219117319"
  },
  ["AK GOODBOY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "🥵",
    image = ""
  },
  ["AK WARRIOR"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(252, 11, 3),
    emoji = "♦️",
    image = "http://www.roblox.com/asset/?id=74203319792453"
  },
  ["AK KAWAII"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 105, 180),
    emoji = "♦️",
    image = "http://www.roblox.com/asset/?id=120305713055340"
  },
  ["AK POTATO"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 165, 0),
    emoji = "♦️",
    image = "http://www.roblox.com/asset/?id=115679774469788"
  },
  ["AK TWISTED"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "🤤",
    image = ""
  },
  ["AK PHROGSPLOIT"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(59, 255, 111),
    emoji = "🐸",
    image = ""
  },
  ["AK DOGGYFUCKER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(255, 102, 102),
    emoji = "🐸",
    image = "http://www.roblox.com/asset/?id=87817403228848"
  },
  ["AK MR.RANGER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(0,0,0),
    emoji = "🕴🏻",
    image = ""
  },
  ["AK DOGGYFUCKA"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(0, 255, 255),
    emoji = "🐸",
    image = "http://www.roblox.com/asset/?id=97511041552708"
  },
  ["AK HORNYBOY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(242, 66, 245),
    emoji = "🦝",
    image = ""
  },
  ["AK PERKZ"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(124, 252, 0),
    emoji = "💰",
    image = ""
  },
  ["AK MOMMY KITTY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = true,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 255, 255),
    emoji = "🐸",
    image = "http://www.roblox.com/asset/?id=110726191381486"
  },
  ["AK RYZA"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(255, 102, 102),
    emoji = "🐸",
    image = "http://www.roblox.com/asset/?id=71284892747793"
  },
  ["AK ROOKIE"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(135, 206, 235),
    emoji = "",
    image = ""
  },
  ["AK EXPLORER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(100, 149, 237),
    emoji = "",
    image = ""
  },
  ["AK CHALLENGER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(60, 179, 113),
    emoji = "",
    image = ""
  },
  ["AK ASTRO 卐"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(128, 176, 255),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=101918643292284"
  },
  ["AK SEEKER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 165, 0),
    emoji = "",
    image = ""
  },
  ["AK VETERAN"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 99, 71),
    emoji = "",
    image = ""
  },
  ["AK ELITE"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(218, 112, 214),
    emoji = "",
    image = ""
  },
  ["AK MASTER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(138, 43, 226),
    emoji = "",
    image = ""
  },
  ["AK MYTHIC"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 20, 147),
    emoji = "",
    image = ""
  },
  ["AK ASCENDED"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(72, 209, 204),
    emoji = "",
    image = ""
  },
  ["AK LEGEND"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 215, 0),
    emoji = "",
    image = ""
  },
  ["AK CONTENT CREATOR"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = true,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=107024412860531"
  },
  ["AK GOONER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(64, 224, 208),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=140562758794416"
  },
  ["AK DADDYTWIZZY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=86892372545965"
  },
  ["AK DANCER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(64, 224, 208),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=98712039214761"
  },
  ["AK SHROOMIE"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = true,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=108669167178355"
  },
  ["AK HUNTER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(0, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=105980186269437"
  },
  ["AK ALLMIGHTY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=91662218502917"
  },
  ["AK GOD"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(75, 0, 130),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=78254662550564"
  },
  ["AK FEETLOVER"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(0, 255, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=112177669514014"
  },
  ["AK LOCKED"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(75, 0, 130),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=129081149538265"
  },
  ["AK BIBS"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = true,
    JumpLetters = false,
    GlitchName = false,
    UseImage = true,
    accent = Color3.fromRGB(0, 0, 0),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=84422083508078"
  },
  ["AK YAMAHA_R1"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(20, 40, 160),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=127219903298526"
  },
  ["AK SCYTHZ"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(173, 66, 245),
    emoji = "😏",
    image = ""
  },
  ["AK KILLA"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "👑",
    image = ""
  },
  ["AK STAR"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(255, 217, 0),
    emoji = "⭐",
    image = ""
  },
  ["AK PWNED"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = false,
    UseImage = false,
    accent = Color3.fromRGB(83, 59, 129),
    emoji = "👾",
    image = ""
  },
  ["AK ✞ KING"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(255, 0, 0),
    emoji = "👾",
    image = "http://www.roblox.com/asset/?id=74132099757103"
  },
  ["AK IM YOUR DADDY"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = false,
    accent = Color3.fromRGB(0, 187, 255),
    emoji = "🍆🍑",
    image = ""
  },
  ["AK GODD"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(0, 191, 255),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=110172191307411"
  },
  ["AK SNOWPEEP"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = Color3.fromRGB(255, 255, 255),
    emoji = "",
    image = "http://www.roblox.com/asset/?id=122740927271713"
  },
  ["AK ???"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
      ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 216, 230)), 
      ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))  
    },
    emoji = "♦️",
    image = "http://www.roblox.com/asset/?id=98665227061937"
  },
  ["AK SEX KITTEN"] = {
    primary = Color3.fromRGB(20, 20, 20),
    AnimateName = false,
    JumpLetters = false,
    GlitchName = true,
    UseImage = true,
    accent = ColorSequence.new{
      ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 182, 193)), 
      ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180))  
    },
    emoji = "♦️",
    image = "http://www.roblox.com/asset/?id=126115432529344"
  }
}


local ChatWhitelist = {}

local function modifyString(randomText)
  local modified = ""
  for char in randomText:gmatch(".") do
    if char ~= " " then
      modified = modified .. char
    end
  end
  return modified
end

local message = "imusing-AKADMIN!"
local modifiedMessage = modifyString(message)

spawn(function()
while true do
  for i = 1, 5 do
    Players:Chat(modifiedMessage)
    wait(8)
  end
end
end)

local function createParticles(tag, parent, accentColor)
  local TweenService = game:GetService("TweenService")

  for i = 1, CONFIG.PARTICLE_COUNT do
    local particle = Instance.new("Frame")
    particle.Name = "Particle_" .. i
    particle.Size = UDim2.new(0, math.random(1, 6), 0, math.random(1, 6))
    particle.Position = UDim2.new(math.random(), math.random(-10, 10), 1 + math.random() * 0.5, 0)
    particle.BackgroundTransparency = math.random(0, 0.4)
    particle.BorderSizePixel = 0
    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(1, 10)
    pCorner.Parent = particle
    
    if typeof(accentColor) == "ColorSequence" then
      local gradient = Instance.new("UIGradient")
      gradient.Color = accentColor
      gradient.Rotation = math.random(0, 360) 
      gradient.Parent = particle
    elseif typeof(accentColor) == "Color3" then
      
      particle.BackgroundColor3 = accentColor
    end

    particle.Parent = parent
    spawn(function()
    while tag and tag.Parent do
      local startX = math.random()
      local startOffsetX = math.random(-10, 10)
      particle.Position = UDim2.new(startX, startOffsetX, 1 + math.random() * 0.5, 0)
      particle.Size = UDim2.new(0, math.random(1, 6), 0, math.random(1, 6))
      particle.BackgroundTransparency = math.random(0, 0.4)
      local duration = math.random(10, 40) / (CONFIG.PARTICLE_SPEED * 10)
      local endX = startX + (math.random() - 0.5) * 0.3
      local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
      local tween = TweenService:Create(particle, tweenInfo, {
        Position = UDim2.new(endX, startOffsetX, -0.5, math.random(-20, 20)),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
      })
      tween:Play()
      task.wait(duration)
    end
    end)
  end
end

local function teleportToPlayer(targetPlayer)
  local localPlayer = Players.LocalPlayer
  local character = localPlayer.Character
  local targetCharacter = targetPlayer.Character
  if not (character and targetCharacter) then return end
  local humanoid = character:FindFirstChild("Humanoid")
  local hrp = character:FindFirstChild("HumanoidRootPart")
  local targetHRP = targetCharacter:FindFirstChild("UpperTorso") or targetCharacter:FindFirstChild("HumanoidRootPart")
  if not (humanoid and hrp and targetHRP) then return end
  local targetCFrame = targetHRP.CFrame
  local teleportPosition = targetCFrame.Position - (targetCFrame.LookVector * CONFIG.TELEPORT_DISTANCE)
  teleportPosition = teleportPosition + Vector3.new(0, CONFIG.TELEPORT_HEIGHT, 0)
  local particlepart = Instance.new("Part", workspace)
  particlepart.Transparency = 1
  particlepart.Anchored = true
  particlepart.CanCollide = false
  particlepart.Position = hrp.Position
  local transmitter1 = Instance.new("ParticleEmitter")
  transmitter1.Texture = "http://www.roblox.com/asset/?id=89296104222585"
  transmitter1.Size = NumberSequence.new(4)
  transmitter1.Lifetime = NumberRange.new(0.15, 0.15)
  transmitter1.Rate = 100
  transmitter1.TimeScale = 0.25
  transmitter1.VelocityInheritance = 1
  transmitter1.Drag = 5
  transmitter1.Parent = particlepart
  local particlepart2 = Instance.new("Part", workspace)
  particlepart2.Transparency = 1
  particlepart2.Anchored = true
  particlepart2.CanCollide = false
  particlepart2.Position = teleportPosition
  local transmitter2 = Instance.new("ParticleEmitter")
  transmitter2.Texture = "http://www.roblox.com/asset/?id=89296104222585"
  transmitter2.Size = NumberSequence.new(4)
  transmitter2.Lifetime = NumberRange.new(0.15, 0.15)
  transmitter2.Rate = 100
  transmitter2.TimeScale = 0.25
  transmitter2.VelocityInheritance = 1
  transmitter2.Drag = 5
  transmitter2.Parent = particlepart2
  local fadeTime = 0.1
  local tweenInfo = TweenInfo.new(fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
  local meshParts = {}
  for _, part in ipairs(character:GetDescendants()) do
    if part:IsA("MeshPart") or part:IsA("Part") then
      table.insert(meshParts, part)
    end
  end
  for _, part in ipairs(meshParts) do
    if part.Name == "HumanoidRootPart" then continue end
    local tween = TweenService:Create(part, tweenInfo, {Transparency = 1})
    tween:Play()
  end
  task.wait(fadeTime)
  hrp.CFrame = CFrame.new(teleportPosition, targetHRP.Position)
  local teleportSound = Instance.new("Sound")
  teleportSound.SoundId = "rbxassetid://5066021887"
  teleportSound.Parent = hrp
  teleportSound.Volume = 0.5
  teleportSound:Play()
  for _, part in ipairs(meshParts) do
    if part.Name == "HumanoidRootPart" then continue end
    local tween = TweenService:Create(part, tweenInfo, {Transparency = 0})
    tween:Play()
  end
  game.Debris:AddItem(teleportSound, 2)
  game.Debris:AddItem(particlepart, 1)
  game.Debris:AddItem(particlepart2, 1)
end

local function getTextWidth(text, font, textSize)
  local size = TextService:GetTextSize(text, textSize, font, Vector2.new(2000, CONFIG.TAG_SIZE.Y.Offset))
  return math.ceil(size.X)
end

local function attachTagToHead(character, player, rankText)
  local head = character:FindFirstChild("Head")
  if not head then return end
  local humanoid = character:FindFirstChildOfClass("Humanoid")
  if humanoid then
    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
  end
  for _, child in ipairs(head:GetChildren()) do
    if child.Name == "RankTag" then
      child:Destroy()
    end
  end
  local rankData = RankData[rankText] or { primary = Color3.fromRGB(20, 20, 20), AnimateName = false, JumpLetters = false, GlitchName = false, accent = Color3.fromRGB(114, 47, 55), emoji = "⭐", image = "" }
  local tag = Instance.new("BillboardGui")
  tag.Name = "RankTag"
  tag.Adornee = head
  tag.Size = CONFIG.TAG_SIZE
  tag.StudsOffset = CONFIG.TAG_OFFSET
  tag.AlwaysOnTop = true
  tag.MaxDistance = CONFIG.MAX_DISTANCE
  tag.LightInfluence = 0
  tag.ResetOnSpawn = false
  tag.Active = true
  
  local function isColorSequence(value)
    return typeof(value) == "ColorSequence"
  end

  
  local BORDER_MARGIN = -3

  
  if isColorSequence(rankData.accent) then
    
    local borderContainer = Instance.new("Frame")
    borderContainer.Name = "TagBorderContainer"
    borderContainer.Size = UDim2.new(1, -BORDER_MARGIN, 1, -BORDER_MARGIN)
    borderContainer.Position = UDim2.new(0, BORDER_MARGIN/2, 0, BORDER_MARGIN/2)
    borderContainer.BackgroundTransparency = 1
    borderContainer.ZIndex = 0
    borderContainer.Parent = tag

    local gradientLayer = Instance.new("Frame")
    gradientLayer.Size = UDim2.new(1, 0, 1, 0)
    gradientLayer.BackgroundColor3 = Color3.new(1, 1, 1)
    gradientLayer.BorderSizePixel = 0
    gradientLayer.ZIndex = 0
    gradientLayer.Parent = borderContainer

    local gradient = Instance.new("UIGradient")
    gradient.Color = rankData.accent
    gradient.Parent = gradientLayer

    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = CONFIG.CORNER_RADIUS
    borderCorner.Parent = gradientLayer
  end

  
  local container = Instance.new("Frame")
  container.Name = "TagContainer"
  container.Size = UDim2.new(1, 0, 1, 0)
  container.BackgroundColor3 = rankData.primary
  container.BackgroundTransparency = 0.15
  container.BorderSizePixel = 0
  container.ClipsDescendants = true
  container.ZIndex = 1
  container.Parent = tag

  local containerCorner = Instance.new("UICorner")
  containerCorner.CornerRadius = CONFIG.CORNER_RADIUS
  containerCorner.Parent = container

  
  if typeof(rankData.accent) == "Color3" then
    local border = Instance.new("UIStroke")
    border.Color = rankData.accent
    border.Thickness = 2
    border.Transparency = 0.2
    border.Parent = container
  end

  local clickButton = Instance.new("TextButton")
  clickButton.Name = "ClickButton"
  clickButton.Size = UDim2.new(1, 0, 1, 0)
  clickButton.BackgroundTransparency = 1
  clickButton.Text = ""
  clickButton.ZIndex = 10
  clickButton.AutoButtonColor = false
  clickButton.Active = true
  clickButton.Parent = container
  if player ~= Players.LocalPlayer then
    clickButton.MouseButton1Click:Connect(function()
    teleportToPlayer(player)
    end)
    clickButton.MouseEnter:Connect(function()
    TweenService:Create(container, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    end)
    clickButton.MouseLeave:Connect(function()
    TweenService:Create(container, TweenInfo.new(0.3), {BackgroundTransparency = 0.15}):Play()
    end)
  end
  local particlesContainer = Instance.new("Frame")
  particlesContainer.Name = "ParticlesContainer"
  particlesContainer.Size = UDim2.new(1, 0, 1, 0)
  particlesContainer.BackgroundTransparency = 1
  particlesContainer.ZIndex = 2
  particlesContainer.ClipsDescendants = true
  particlesContainer.Parent = container
  local pContainerCorner = Instance.new("UICorner")
  pContainerCorner.CornerRadius = UDim.new(1, 0)
  pContainerCorner.Parent = particlesContainer
  createParticles(tag, particlesContainer, rankData.accent)
  local emojiLabel
  if rankData.UseImage and rankData.image ~= "" then
    emojiLabel = Instance.new("ImageLabel")
    emojiLabel.Name = "EmojiLabel"
    emojiLabel.Size = UDim2.new(0, 30, 0, 30)
    emojiLabel.Position = UDim2.new(0, 8, 0.5, -15)
    emojiLabel.BackgroundTransparency = 1
    emojiLabel.Image = rankData.image
    emojiLabel.ScaleType = Enum.ScaleType.Fit
    emojiLabel.ZIndex = 5
    emojiLabel.Parent = container
  else
    emojiLabel = Instance.new("TextLabel")
    emojiLabel.Name = "EmojiLabel"
    emojiLabel.Size = UDim2.new(0, 30, 0, 30)
    emojiLabel.Position = UDim2.new(0, 8, 0.5, -15)
    emojiLabel.BackgroundTransparency = 1
    emojiLabel.Text = rankData.emoji
    emojiLabel.TextSize = 22
    emojiLabel.Font = Enum.Font.GothamBold
    emojiLabel.TextColor3 = Color3.new(1, 1, 1)
    emojiLabel.ZIndex = 5
    emojiLabel.Parent = container
  end
  local displayNameLabel = Instance.new("TextLabel")
  displayNameLabel.Name = "DisplayNameLabel"
  displayNameLabel.BackgroundTransparency = 1
  
  for _, child in ipairs(displayNameLabel:GetChildren()) do
    if child:IsA("UIGradient") then
      child:Destroy()
    end
  end
  local fullDisplayName = player.DisplayName or player.Name
  displayNameLabel.Text = "@" .. fullDisplayName
  displayNameLabel.TextSize = 10
  displayNameLabel.Font = Enum.Font.GothamBold
  displayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
  displayNameLabel.ZIndex = 5

  if typeof(rankData.accent) == "ColorSequence" then
    local gradient = Instance.new("UIGradient")
    gradient.Color = rankData.accent
    gradient.Rotation = 0
    gradient.Parent = displayNameLabel
    displayNameLabel.TextColor3 = Color3.new(1, 1, 1)
    displayNameLabel.RichText = false
  else
    displayNameLabel.TextColor3 = rankData.accent
    displayNameLabel.RichText = false
  end

  local rankLabel = Instance.new("TextLabel")
  rankLabel.Name = "RankLabel"
  rankLabel.BackgroundTransparency = 1
  rankLabel.Text = rankText
  rankLabel.TextSize = 14
  rankLabel.Font = Enum.Font.GothamBold
  rankLabel.TextXAlignment = Enum.TextXAlignment.Left
  rankLabel.ZIndex = 5

  
  for _, child in ipairs(rankLabel:GetChildren()) do
    if child:IsA("UIGradient") then
      child:Destroy()
    end
  end

  if typeof(rankData.accent) == "ColorSequence" then
    local gradient = Instance.new("UIGradient")
    gradient.Color = rankData.accent
    gradient.Rotation = 0
    gradient.Parent = rankLabel
    rankLabel.TextColor3 = Color3.new(1, 1, 1)
  else
    rankLabel.TextColor3 = typeof(rankData.accent) == "Color3" and rankData.accent
  end

  spawn(function()
  while tag and tag.Parent do
    if rankData.AnimateName then
      local name = rankText
      local blinkCount = 5
      local typingDelay = 0.1
      local blinkDelay = 0.5
      for i = 1, #name do
        rankLabel.Text = string.sub(name, 1, i) .. "|"
        wait(typingDelay)
      end
      for i = 1, blinkCount do
        rankLabel.Text = name .. "|"
        wait(blinkDelay)
        rankLabel.Text = name
        wait(blinkDelay)
      end
      for i = #name, 1, -1 do
        rankLabel.Text = string.sub(name, 1, i) .. "|"
        wait(typingDelay)
      end
      for i = 1, blinkCount do
        rankLabel.Text = "|"
        wait(blinkDelay)
        rankLabel.Text = ""
        wait(blinkDelay)
      end
    elseif rankData.JumpLetters then
      local text = rankText
      local jumpDuration = 0.2
      local pauseDuration = 0.5
      local jumpIterations = 3
      for iteration = 1, jumpIterations do
        for i = 1, #text do
          local before = string.sub(text, 1, i-1)
          local current = string.sub(text, i, i)
          local after = string.sub(text, i+1)
          rankLabel.Text = before .. string.lower(current) .. after
          wait(jumpDuration)
          rankLabel.Text = text
          wait(jumpDuration)
        end
        wait(pauseDuration)
      end
    elseif rankData.GlitchName then
      local text = rankText
      local glitchDuration = 0.05
      local normalDuration = 0.3
      local glitchCycles = 5
      local glitchIntensity = 3
      local glitchChars = {"@", "#", "$", "%", "&", "!"}
      for cycle = 1, glitchCycles do
        rankLabel.Text = text
        wait(normalDuration)
        for artifact = 1, glitchIntensity do
          local glitchedText = ""
          for i = 1, #text do
            if math.random() < 0.3 then
              local randomChoice = math.random(1, 10)
              if randomChoice <= 7 then
                glitchedText = glitchedText .. glitchChars[math.random(1, #glitchChars)]
              elseif randomChoice <= 9 then
                local char = string.sub(text, i, i)
                if char == string.upper(char) then
                  glitchedText = glitchedText .. string.lower(char)
                else
                  glitchedText = glitchedText .. string.upper(char)
                end
              else
                glitchedText = glitchedText .. " "
              end
            else
              glitchedText = glitchedText .. string.sub(text, i, i)
            end
          end
          if math.random() < 0.3 then
            local spaces = string.rep(" ", math.random(1, 3))
            glitchedText = spaces .. glitchedText
          end
          if math.random() < 0.3 then
            local extraGlitch = ""
            for i = 1, math.random(1, 3) do
              extraGlitch = extraGlitch .. glitchChars[math.random(1, #glitchChars)]
            end
            glitchedText = glitchedText .. extraGlitch
          end
          rankLabel.Text = glitchedText
          wait(glitchDuration)
        end
        rankLabel.Text = text
        wait(normalDuration * 2)
      end
      rankLabel.Text = text
      wait(normalDuration * 3)
    else
      rankLabel.Text = rankText
      wait(1)
    end
  end
  end)
  local sidePadding = 16
  local emojiWidth = 36
  local emojiLabelWidth = 30
  local emojiLeftPadding = 8
  local rankWidthActual = getTextWidth(rankLabel.Text, rankLabel.Font, rankLabel.TextSize)
  local displayNameWidthActual = getTextWidth("@" .. fullDisplayName, displayNameLabel.Font, displayNameLabel.TextSize)
  local maxTextWidth = math.max(rankWidthActual, displayNameWidthActual)
  local totalWidth = emojiLeftPadding + emojiLabelWidth + sidePadding + maxTextWidth + sidePadding
  tag.Size = UDim2.new(0, totalWidth, 0, CONFIG.TAG_SIZE.Y.Offset)
  container.Size = UDim2.new(1, 0, 1, 0)
  emojiLabel.Position = UDim2.new(0, emojiLeftPadding, 0.5, -15)
  emojiLabel.Size = UDim2.new(0, emojiLabelWidth, 0, 30)
  local textBlockXOffset = emojiLeftPadding + emojiLabelWidth + sidePadding
  rankLabel.Position = UDim2.new(0, textBlockXOffset, 0, 3)
  rankLabel.Size = UDim2.new(0, rankWidthActual, 0, 16)
  rankLabel.Parent = container
  displayNameLabel.Position = UDim2.new(0, textBlockXOffset, 0, 17)
  displayNameLabel.Size = UDim2.new(0, displayNameWidthActual, 0, 16)
  displayNameLabel.Parent = container
  local isMinimized = false
  local FULL_SIZE = UDim2.new(0, totalWidth, 0, CONFIG.TAG_SIZE.Y.Offset)
  local MINI_SIZE = UDim2.new(0, 40, 0, 40)
  local MINI_OFFSET = Vector3.new(0, 1.0, 0)
  local activeTween = true
  spawn(function()
  while activeTween and tag and tag.Parent do
    if character and head and head.Parent and Players.LocalPlayer and Players.LocalPlayer.Character then
      local localHead = Players.LocalPlayer.Character:FindFirstChild("Head")
      if localHead then
        local distance = (head.Position - localHead.Position).Magnitude
        if distance > (CONFIG.DISTANCE_THRESHOLD + CONFIG.HYSTERESIS) and not isMinimized then
          isMinimized = true
          TweenService:Create(tag, TweenInfo.new(0.5), { Size = MINI_SIZE, StudsOffset = MINI_OFFSET }):Play()
          TweenService:Create(rankLabel, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
          TweenService:Create(displayNameLabel, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
          TweenService:Create(emojiLabel, TweenInfo.new(0.5), { Position = UDim2.new(0.5, -15, 0.5, -15), Size = UDim2.new(0, 30, 0, 30)}):Play()
          TweenService:Create(containerCorner, TweenInfo.new(0.5), { CornerRadius = UDim.new(1, 0) }):Play()
        elseif distance < (CONFIG.DISTANCE_THRESHOLD - CONFIG.HYSTERESIS) and isMinimized then
          isMinimized = false
          TweenService:Create(tag, TweenInfo.new(0.5), { Size = FULL_SIZE, StudsOffset = CONFIG.TAG_OFFSET }):Play()
          TweenService:Create(rankLabel, TweenInfo.new(0.5), { TextTransparency = 0 }):Play()
          TweenService:Create(displayNameLabel, TweenInfo.new(0.5), { TextTransparency = 0 }):Play()
          TweenService:Create(emojiLabel, TweenInfo.new(0.5), { Position = UDim2.new(0, 8, 0.5, -15), Size = UDim2.new(0, 30, 0, 30)}):Play()
          TweenService:Create(containerCorner, TweenInfo.new(0.5), { CornerRadius = CONFIG.CORNER_RADIUS }):Play()
        end
      end
    else
      activeTween = false
    end
    task.wait(0.2)
  end
  end)
  tag.AncestryChanged:Connect(function(_, parent)
  if not parent then
    activeTween = false
  end
  end)
  Players.PlayerRemoving:Connect(function(removedPlayer)
  if removedPlayer == player then
    if tag and tag.Parent then
      tag:Destroy()
    end
    activeTween = false
  end
  end)
  tag.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
  return tag
end

local localTagChoice = nil

local notificationCount = 0
local notificationPositions = {} 

local function showAKAdminNotification(player)
    local playerName = player.Name
    local notifMessage = "@" .. playerName .. " has executed AK ADMIN"
    
    
    local success, thumb = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    end)
    if not success then thumb = "" end
    
    
    notificationCount = notificationCount + 1
    local currentNotificationIndex = notificationCount
    
    
    local yOffset = 120
    for i = 1, currentNotificationIndex - 1 do
        if notificationPositions[i] then
            yOffset = math.max(yOffset, notificationPositions[i] + 80) 
        end
    end
    notificationPositions[currentNotificationIndex] = yOffset
    
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AKAdminNotificationGui" .. currentNotificationIndex
    screenGui.ResetOnSpawn = false
    screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    
    local shadowFrame = Instance.new("Frame")
    shadowFrame.Name = "ShadowFrame"
    shadowFrame.Size = UDim2.new(0, 280, 0, 70)
    shadowFrame.Position = UDim2.new(1, -287, 0, yOffset + 3) 
    shadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadowFrame.BackgroundTransparency = 1 
    shadowFrame.BorderSizePixel = 0
    shadowFrame.ZIndex = 1
    shadowFrame.Parent = screenGui
    
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 20)
    shadowCorner.Parent = shadowFrame
    
    
    local frame = Instance.new("Frame")
    frame.Name = "NotificationFrame"
    frame.Size = UDim2.new(0, 280, 0, 70)
    frame.Position = UDim2.new(1, -290, 0, yOffset) 
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 1 
    frame.BorderSizePixel = 0
    frame.ZIndex = 2
    frame.Parent = screenGui
    
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 20)
    uiCorner.Parent = frame
    
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 40, 40)
    stroke.Transparency = 1 
    stroke.Thickness = 1
    stroke.Parent = frame
    
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -16, 1, -16)
    contentFrame.Position = UDim2.new(0, 8, 0, 8)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ZIndex = 3
    contentFrame.Parent = frame
    
    
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "ProfilePic"
    imageLabel.Size = UDim2.new(0, 42, 0, 42)
    imageLabel.Position = UDim2.new(0, 5, 0, 6)
    imageLabel.BackgroundTransparency = 1 
    imageLabel.BorderSizePixel = 0
    imageLabel.Image = thumb
    imageLabel.ImageTransparency = 1 
    imageLabel.ZIndex = 4
    imageLabel.Parent = contentFrame
    
    
    local imageCorner = Instance.new("UICorner")
    imageCorner.CornerRadius = UDim.new(0, 15)
    imageCorner.Parent = imageLabel
    
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "NotificationText"
    textLabel.Size = UDim2.new(1, -115, 0, 25)
    textLabel.Position = UDim2.new(0, 55, 0, 6)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = notifMessage
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 12
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
    textLabel.TextTransparency = 1 
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.TextScaled = true
    textLabel.ZIndex = 4
    textLabel.Parent = contentFrame
    
    
    local teleportButton = Instance.new("TextButton")
    teleportButton.Name = "TeleportButton"
    teleportButton.Size = UDim2.new(0, 60, 0, 22)
    teleportButton.Position = UDim2.new(1, -65, 0, 28)
    teleportButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    teleportButton.BackgroundTransparency = 1 
    teleportButton.BorderSizePixel = 0
    teleportButton.Text = "Teleport"
    teleportButton.Font = Enum.Font.GothamMedium
    teleportButton.TextSize = 11
    teleportButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    teleportButton.TextTransparency = 1 
    teleportButton.ZIndex = 4
    teleportButton.Parent = contentFrame
    
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = teleportButton
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(80, 80, 80)
    buttonStroke.Transparency = 1 
    buttonStroke.Thickness = 1
    buttonStroke.Parent = teleportButton
    
    
    local buttonHoverIn = TweenService:Create(teleportButton, 
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(25, 25, 25), TextColor3 = Color3.fromRGB(255, 255, 255)}
    )
    
    local buttonHoverOut = TweenService:Create(teleportButton, 
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(15, 15, 15), TextColor3 = Color3.fromRGB(220, 220, 220)}
    )
    
    teleportButton.MouseEnter:Connect(function()
        buttonHoverIn:Play()
    end)
    
    teleportButton.MouseLeave:Connect(function()
        buttonHoverOut:Play()
    end)
    
    
    teleportButton.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local localPlayer = Players.LocalPlayer
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end)
    
    
    if not success then thumb = "" end
    
    
    local fadeInShadow = TweenService:Create(shadowFrame, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.8}
    )
    
    local fadeInFrame = TweenService:Create(frame, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.6}
    )
    
    local fadeInStroke = TweenService:Create(stroke, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 0.6}
    )
    
    local fadeInImage = TweenService:Create(imageLabel, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {ImageTransparency = 0}
    )
    
    local fadeInText = TweenService:Create(textLabel, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextTransparency = 0}
    )
    
    local fadeInButton = TweenService:Create(teleportButton, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {TextTransparency = 0, BackgroundTransparency = 0.6}
    )
    
    local fadeInButtonStroke = TweenService:Create(buttonStroke, 
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 0.6}
    )
    
    
    fadeInShadow:Play()
    fadeInFrame:Play()
    fadeInStroke:Play()
    fadeInImage:Play()
    fadeInText:Play()
    fadeInButton:Play()
    fadeInButtonStroke:Play()
    
    fadeInFrame.Completed:Wait()
    task.wait(3.5) 
    
    
    local fadeOutShadow = TweenService:Create(shadowFrame, 
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {BackgroundTransparency = 1}
    )
    
    local fadeOutFrame = TweenService:Create(frame, 
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {BackgroundTransparency = 1}
    )
    
    local fadeOutStroke = TweenService:Create(stroke, 
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Transparency = 1}
    )
    
    local fadeOutImage = TweenService:Create(imageLabel, 
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {ImageTransparency = 1}
    )
    
    local fadeOutText = TweenService:Create(textLabel, 
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {TextTransparency = 1}
    )
    
    local fadeOutButton = TweenService:Create(teleportButton, 
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {TextTransparency = 1, BackgroundTransparency = 1}
    )
    
    local fadeOutButtonStroke = TweenService:Create(buttonStroke, 
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Transparency = 1}
    )
    
    
    fadeOutShadow:Play()
    fadeOutFrame:Play()
    fadeOutStroke:Play()
    fadeOutImage:Play()
    fadeOutText:Play()
    fadeOutButton:Play()
    fadeOutButtonStroke:Play()
    
    fadeOutFrame.Completed:Wait()
    
    
    notificationPositions[currentNotificationIndex] = nil
    notificationCount = notificationCount - 1
    screenGui:Destroy()
end
  
local function createNotificationUI()
  if game:GetService("CoreGui"):FindFirstChild("TagNotification") or localTagChoice ~= nil then
    return nil, nil, nil, nil
  end
  local gui = Instance.new("ScreenGui")
gui.Name = "TagNotification"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local frame = Instance.new("Frame")
frame.Name = "Frame"
frame.Size = UDim2.new(0, 280, 0, 140)
frame.Position = UDim2.new(0.5, -140, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Parent = gui

local notifCorner = Instance.new("UICorner")
notifCorner.CornerRadius = UDim.new(0, 12)
notifCorner.Parent = frame

local blur = Instance.new("BlurEffect")
blur.Size = 24
blur.Parent = Lighting

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(40, 40, 40)
stroke.Transparency = 0.3
stroke.Thickness = 2
stroke.Parent = frame


local innerStroke = Instance.new("UIStroke")
innerStroke.Color = Color3.fromRGB(80, 80, 80)
innerStroke.Transparency = 0.7
innerStroke.Thickness = 1
innerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
innerStroke.Parent = frame


local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 6, 1, 6)
shadow.Position = UDim2.new(0, -3, 0, 3)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.8
shadow.BorderSizePixel = 0
shadow.ZIndex = frame.ZIndex - 1
shadow.Parent = frame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 12)
shadowCorner.Parent = shadow

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.TextSize = 16
title.Text = "Tag Visibility Settings"
title.Parent = frame


local titleShadow = Instance.new("TextLabel")
titleShadow.Size = title.Size
titleShadow.Position = UDim2.new(0, 1, 0, 11)
titleShadow.BackgroundTransparency = 1
titleShadow.Font = title.Font
titleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
titleShadow.TextSize = title.TextSize
titleShadow.Text = title.Text
titleShadow.TextTransparency = 0.8
titleShadow.ZIndex = title.ZIndex - 1
titleShadow.Parent = frame

local messageLabel = Instance.new("TextLabel")
messageLabel.Size = UDim2.new(0.9, 0, 0, 40)
messageLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
messageLabel.BackgroundTransparency = 1
messageLabel.Font = Enum.Font.Gotham
messageLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
messageLabel.TextSize = 14
messageLabel.TextWrapped = true
messageLabel.Text = "Would you like to display your rank tag above your character?"
messageLabel.Parent = frame

local function createButton(text, position, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.35, 0, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.TextSize = 14
    button.Text = text
    button.AutoButtonColor = false
    button.BackgroundTransparency = 0.2
    button.Parent = frame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(60, 60, 60)
    buttonStroke.Transparency = 0.5
    buttonStroke.Thickness = 1
    buttonStroke.Parent = button
    
    
    local buttonShadow = Instance.new("Frame")
    buttonShadow.Size = UDim2.new(1, 2, 1, 2)
    buttonShadow.Position = UDim2.new(0, -1, 0, 1)
    buttonShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    buttonShadow.BackgroundTransparency = 0.9
    buttonShadow.BorderSizePixel = 0
    buttonShadow.ZIndex = button.ZIndex - 1
    buttonShadow.Parent = button
    
    local buttonShadowCorner = Instance.new("UICorner")
    buttonShadowCorner.CornerRadius = UDim.new(0, 8)
    buttonShadowCorner.Parent = buttonShadow
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.05,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.15), {
            Transparency = 0.2
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.2,
            TextColor3 = Color3.fromRGB(200, 200, 200)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.15), {
            Transparency = 0.5
        }):Play()
    end)
    
    return button
end

local yesButton = createButton("Yes", UDim2.new(0.1, 0, 0.7, 0), Color3.fromRGB(46, 204, 113))
local noButton = createButton("No", UDim2.new(0.55, 0, 0.7, 0), Color3.fromRGB(231, 76, 60))

return gui, yesButton, noButton, blur
end

local charAddedConn
local notificationGuiVisible = false

local function attachTagAndConnect(player, rankText)
  if player.Character then
    attachTagToHead(player.Character, player, rankText)
  end
  if charAddedConn then charAddedConn:Disconnect() end
  charAddedConn = player.CharacterAdded:Connect(function(character)
  task.wait()
  attachTagToHead(character, player, rankText)
  end)
  local playerRemovingConn
  playerRemovingConn = Players.PlayerRemoving:Connect(function(leavingPlayer)
  if leavingPlayer == player then
    if charAddedConn then charAddedConn:Disconnect() end
    if playerRemovingConn then playerRemovingConn:Disconnect() end
  end
  end)
end

local function cleanupNotificationUI(gui, blur, yesConn, noConn)
  if yesConn then yesConn:Disconnect() end
  if noConn then noConn:Disconnect() end
  if gui then gui:Destroy() end
  if blur and blur.Parent then
    blur:Destroy()
  end
  notificationGuiVisible = false
end

local function handleUserChoice(player, rankText, choice)
  if choice then
    attachTagAndConnect(player, rankText)
  end
  localTagChoice = choice
end

local function createTag(player, rankText, showPrompt)
  if showPrompt and player == Players.LocalPlayer then
    if localTagChoice ~= nil then
      if localTagChoice then
        attachTagAndConnect(player, rankText)
      end
      return
    end
    if notificationGuiVisible then
      return
    end
    local gui, yesButton, noButton, blur = createNotificationUI()
    if not gui then return end
    local playerGui = player:WaitForChild("PlayerGui", 5)
    if not playerGui then
      if blur then blur:Destroy() end
      if gui then gui:Destroy() end
      return
    end
    gui.Parent = playerGui
    notificationGuiVisible = true
    local yesConn, noConn
    yesConn = yesButton.MouseButton1Click:Connect(function()
    handleUserChoice(player, rankText, true)
    cleanupNotificationUI(gui, blur, yesConn, noConn)
    end)
    noConn = noButton.MouseButton1Click:Connect(function()
    handleUserChoice(player, rankText, false)
    cleanupNotificationUI(gui, blur, yesConn, noConn)
    end)
  else
    attachTagAndConnect(player, rankText)
  end
end

local function applyPlayerTag(player)
  if not player or not player:IsDescendantOf(Players) then
    return
  end
  local showPrompt = (player == Players.LocalPlayer)
  local assignedTag = nil
  local playerNameLower = player.Name:lower()

  
  if playerToTag[playerNameLower] then
    assignedTag = playerToTag[playerNameLower]
  elseif ChatWhitelist[playerNameLower] then
    assignedTag = "AK USER"
  else
  end

  
  local localPlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
  if player.Character and player.Character:FindFirstChild("Head") then
    local head = player.Character.Head
    for _, child in ipairs(head:GetChildren()) do
      if child:IsA("BillboardGui") and child.Name == "RankTag" then
        child:Destroy()
      end
    end
    for _, gui in ipairs(localPlayerGui:GetChildren()) do
      if gui:IsA("BillboardGui") and gui.Name == "RankTag" and gui.Adornee == head then
        gui:Destroy()
      end
    end
  end

  
  if assignedTag then
    createTag(player, assignedTag, showPrompt)
  end
end

local chatConnections = {}

local function setupChatListener(player)
  if chatConnections[player] then
    return
  end

  local conn = game:GetService("TextChatService").TextChannels.RBXGeneral.MessageReceived:Connect(function(textChatMessage)
    if textChatMessage.TextSource.UserId ~= player.UserId then
      return
    end
    
    if not player or not player:IsDescendantOf(Players) then
      if chatConnections[player] then
        chatConnections[player]:Disconnect()
      end
      chatConnections[player] = nil
      return
    end
    
    local msg = textChatMessage.Text
    if modifyString(msg:lower()) == modifiedMessage:lower() then
      local playerNameLower = player.Name:lower()
      
      if not playerToTag[playerNameLower] and not ChatWhitelist[playerNameLower] then
        ChatWhitelist[playerNameLower] = true
        applyPlayerTag(player)
        showAKAdminNotification(player)
      else
      end
    end
  end)
  
  chatConnections[player] = conn
end

local localPlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

spawn(function()
while task.wait(2) do
  local validAdornees = {}
  local currentPlayers = Players:GetPlayers()
  for _, player in ipairs(currentPlayers) do
    if player.Character and player.Character:FindFirstChild("Head") then
      table.insert(validAdornees, player.Character.Head)
      local hasTag = false
      for _, gui in ipairs(localPlayerGui:GetChildren()) do
        if gui:IsA("BillboardGui") and gui.Name == "RankTag" and gui.Adornee == player.Character.Head then
          hasTag = true
          break
        end
      end
      local shouldHaveTag = playerToTag[player.Name:lower()] or ChatWhitelist[player.Name:lower()]
      if shouldHaveTag and not hasTag then
        applyPlayerTag(player)
      end
    end
  end
  for _, gui in ipairs(localPlayerGui:GetChildren()) do
    if gui:IsA("BillboardGui") and gui.Name == "RankTag" then
      local adornee = gui.Adornee
      if not adornee or not adornee:IsDescendantOf(workspace) or not table.find(validAdornees, adornee) then
        gui:Destroy()
      end
    end
  end
end
end)

for _, player in ipairs(Players:GetPlayers()) do
  task.spawn(applyPlayerTag, player)
  task.spawn(setupChatListener, player)
end

Players.PlayerAdded:Connect(function(player)
task.wait(0.5)
task.spawn(setupChatListener, player)
task.spawn(applyPlayerTag, player)
end)

Players.PlayerRemoving:Connect(function(player)
if chatConnections[player] then
  chatConnections[player]:Disconnect()
  chatConnections[player] = nil
end
local playerHead = player.Character and player.Character:FindFirstChild("Head")
if playerHead then
  for _, gui in ipairs(localPlayerGui:GetChildren()) do
    if gui:IsA("BillboardGui") and gui.Name == "RankTag" and gui.Adornee == playerHead then
      gui:Destroy()
    end
  end
end
if player == Players.LocalPlayer then
  local playerGui = player:FindFirstChild("PlayerGui")
  if playerGui then
    local notification = playerGui:FindFirstChild("TagNotification")
    if notification then
      notification:Destroy()
      local blur = Lighting:FindFirstChild("BlurEffect")
      if blur then
        blur:Destroy()
      end
    end
  end
  localTagChoice = nil
end
end)

return {
  refreshTags = function()
  for _, player in ipairs(Players:GetPlayers()) do
    task.spawn(applyPlayerTag, player)
  end
  end,
  forceTag = function(player, rankType)
  if not player or not player:IsDescendantOf(Players) then
    return false
  end
  if RankData[rankType] then
    if player.Character and player.Character:FindFirstChild("Head") then
      local head = player.Character.Head
      for _, child in ipairs(head:GetChildren()) do
        if child.Name == "RankTag" then
          child:Destroy()
        end
      end
    end
    for _, gui in ipairs(localPlayerGui:GetChildren()) do
      if gui:IsA("BillboardGui") and gui.Name == "RankTag" and gui.Adornee and gui.Adornee.Parent == player.Character then
        gui:Destroy()
      end
    end
    createTag(player, rankType, player == Players.LocalPlayer)
    return true
  else
    return false
  end
end
}