local Light = game:GetService("Lighting")

if Light:FindFirstChild("_ShadersApplied") then return end

local originalLightingSettings = {
    Brightness = Light.Brightness,
    ExposureCompensation = Light.ExposureCompensation,
    ClockTime = Light.ClockTime
}

local function applyShaders()
    local Sky = Instance.new("Sky")
    local Bloom = Instance.new("BloomEffect")
    local ColorC = Instance.new("ColorCorrectionEffect")
    local SunRays = Instance.new("SunRaysEffect")
    
    Light.Brightness = 2.25
    Light.ExposureCompensation = 0.1
    Light.ClockTime = 17.55
    
    Sky.SkyboxBk = "http://www.roblox.com/asset/?id=144933338"
    Sky.SkyboxDn = "http://www.roblox.com/asset/?id=144931530"
    Sky.SkyboxFt = "http://www.roblox.com/asset/?id=144933262"
    Sky.SkyboxLf = "http://www.roblox.com/asset/?id=144933244"
    Sky.SkyboxRt = "http://www.roblox.com/asset/?id=144933299"
    Sky.SkyboxUp = "http://www.roblox.com/asset/?id=144931564"
    Sky.StarCount = 5000
    Sky.SunAngularSize = 5
    Sky.Parent = Light
    
    Bloom.Intensity = 0.3
    Bloom.Size = 10
    Bloom.Threshold = 0.8
    Bloom.Parent = Light
    
    ColorC.Brightness = 0
    ColorC.Contrast = 0.1
    ColorC.Saturation = 0.25
    ColorC.TintColor = Color3.fromRGB(255, 255, 255)
    ColorC.Parent = Light
    
    SunRays.Intensity = 0.1
    SunRays.Spread = 0.8
    SunRays.Parent = Light
    
    local marker = Instance.new("BoolValue")
    marker.Name = "_ShadersApplied"
    marker.Parent = Light
end

applyShaders()
