-- Shader Roblox com GUI Mobile (by Hyui)

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Camera = Workspace.CurrentCamera
local LastVector = Camera.CFrame.LookVector
local MotionBlur = nil

-- Config
local QualitySettings = {
    Low = {
        BlurAmount = 1,
        BlurAmplifier = 1,
        BloomIntensity = 0.3,
        BloomSize = 12,
        SunRaysIntensity = 0.02,
        DepthOfFieldEnabled = false,
        AtmosphereDensity = 0.1,
        ShadowSoftness = 0.6,
        FogEnd = 2500,
        SkyEnabled = false
    },
    Medium = {
        BlurAmount = 2,
        BlurAmplifier = 1.5,
        BloomIntensity = 0.6,
        BloomSize = 20,
        SunRaysIntensity = 0.06,
        DepthOfFieldEnabled = true,
        AtmosphereDensity = 0.25,
        ShadowSoftness = 0.4,
        FogEnd = 1500,
        SkyEnabled = true
    },
    High = {
        BlurAmount = 3,
        BlurAmplifier = 1.5,
        BloomIntensity = 1.2,
        BloomSize = 30,
        SunRaysIntensity = 0.15,
        DepthOfFieldEnabled = true,
        AtmosphereDensity = 0.4,
        ShadowSoftness = 0.1,
        FogEnd = 900,
        SkyEnabled = true
    }
}

local CurrentQuality = "High"

local function SetupEffects(quality)
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("Atmosphere") then
            effect:Destroy()
        end
    end
    if MotionBlur then
        MotionBlur:Destroy()
    end

    local settings = QualitySettings[quality]

    MotionBlur = Instance.new("BlurEffect")
    MotionBlur.Name = "MotionBlur"
    MotionBlur.Size = 0
    MotionBlur.Parent = Camera

    local Bloom = Instance.new("BloomEffect")
    Bloom.Intensity = settings.BloomIntensity
    Bloom.Size = settings.BloomSize
    Bloom.Threshold = 0.8
    Bloom.Parent = Lighting

    local ColorCorrection = Instance.new("ColorCorrectionEffect")
    ColorCorrection.Brightness = 0.1
    ColorCorrection.Contrast = 0.3
    ColorCorrection.Saturation = 0.5
    ColorCorrection.TintColor = Color3.fromRGB(255, 235, 220)
    ColorCorrection.Parent = Lighting

    local SunRays = Instance.new("SunRaysEffect")
    SunRays.Intensity = settings.SunRaysIntensity
    SunRays.Spread = 0.8
    SunRays.Parent = Lighting

    local DoF = Instance.new("DepthOfFieldEffect")
    DoF.Enabled = settings.DepthOfFieldEnabled
    DoF.FarIntensity = 0.6
    DoF.FocusDistance = 40
    DoF.InFocusRadius = 12
    DoF.NearIntensity = 0.3
    DoF.Parent = Lighting

    local Atmosphere = Instance.new("Atmosphere")
    Atmosphere.Density = settings.AtmosphereDensity
    Atmosphere.Offset = 0.3
    Atmosphere.Color = Color3.fromRGB(255, 240, 230)
    Atmosphere.Glare = 0.3
    Atmosphere.Haze = 0.4
    Atmosphere.Parent = Lighting
end

local function SetupLighting(quality)
    local settings = QualitySettings[quality]
    Lighting.Brightness = 2.5
    Lighting.GlobalShadows = true
    Lighting.ShadowSoftness = settings.ShadowSoftness
    Lighting.ClockTime = 16.5
    Lighting.Ambient = Color3.fromRGB(70, 60, 80)
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 90, 110)
    Lighting.FogEnd = settings.FogEnd
    Lighting.FogColor = Color3.fromRGB(255, 220, 200)
    Lighting.EnvironmentDiffuseScale = 0.5
    Lighting.EnvironmentSpecularScale = 0.5
    Lighting.Technology = Enum.Technology.ShadowMap
end

local function UpdateMotionBlur(quality)
    local settings = QualitySettings[quality]
    RunService.RenderStepped:Connect(function(dt)
        local currentVec = Camera.CFrame.LookVector
        local delta = (currentVec - LastVector).Magnitude
        local blurSize = math.clamp(settings.BlurAmount * delta * settings.BlurAmplifier * dt * 60, 0, 10)
        MotionBlur.Size = MotionBlur.Size + (blurSize - MotionBlur.Size) * 0.15
        LastVector = currentVec
    end)
end

local function HandleCameraChange()
    Workspace.Changed:Connect(function(prop)
        if prop == "CurrentCamera" then
            Camera = Workspace.CurrentCamera
            LastVector = Camera.CFrame.LookVector
            if MotionBlur then
                MotionBlur.Parent = Camera
            end
        end
    end)
end

-- GUI MOBILE (v1.2)
local function CreateGui()
    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    gui.Name = "ShaderGui"
    gui.ResetOnSpawn = false

    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(0, 240, 0, 200)
    panel.Position = UDim2.new(0.5, -120, 0.5, -100)
    panel.BackgroundTransparency = 0.2
    panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    panel.BorderSizePixel = 0
    panel.Visible = false
    panel.Parent = gui

    local uiLayout = Instance.new("UIListLayout", panel)
    uiLayout.FillDirection = Enum.FillDirection.Vertical
    uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiLayout.Padding = UDim.new(0, 6)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Text = "Shader Customizable Visual Enhancer"
    title.Parent = panel

    local credit = Instance.new("TextLabel")
    credit.Size = UDim2.new(1, 0, 0, 20)
    credit.BackgroundTransparency = 1
    credit.TextColor3 = Color3.fromRGB(200, 200, 200)
    credit.Font = Enum.Font.Gotham
    credit.TextSize = 14
    credit.Text = "Cre: HyuiOWO"
    credit.Parent = panel

    local function createButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -20, 0, 40)
        btn.Position = UDim2.new(0, 10, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Text = text
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 16
        btn.AutoButtonColor = true
        btn.Parent = panel
        btn.BorderSizePixel = 0
        btn.MouseButton1Click:Connect(callback)
    end

    createButton("Low Quality", function()
        CurrentQuality = "Low"
        SetupLighting(CurrentQuality)
        SetupEffects(CurrentQuality)
    end)

    createButton("Medium Quality", function()
        CurrentQuality = "Medium"
        SetupLighting(CurrentQuality)
        SetupEffects(CurrentQuality)
    end)

    createButton("High Quality", function()
        CurrentQuality = "High"
        SetupLighting(CurrentQuality)
        SetupEffects(CurrentQuality)
    end)

    local openBtn = Instance.new("TextButton")
    openBtn.Size = UDim2.new(0, 40, 0, 40)
    openBtn.Position = UDim2.new(1, -50, 0, 10)
    openBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    openBtn.Text = "☰"
    openBtn.TextColor3 = Color3.new(1, 1, 1)
    openBtn.TextSize = 22
    openBtn.Font = Enum.Font.GothamBold
    openBtn.Parent = gui
    openBtn.BorderSizePixel = 0

    openBtn.MouseButton1Click:Connect(function()
        panel.Visible = not panel.Visible
    end)
end

local function Initialize()
    SetupLighting(CurrentQuality)
    SetupEffects(CurrentQuality)
    UpdateMotionBlur(CurrentQuality)
    HandleCameraChange()
    CreateGui()
end

Initialize()