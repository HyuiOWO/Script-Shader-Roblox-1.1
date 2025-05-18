-- By HyuiOWO
local ultraBtn = makeButton("Ultra Quality", 240)

-- Thêm hiệu ứng nâng cao
local function setShader(level)
	-- Dọn dẹp các hiệu ứng cũ
	for _, effect in pairs(Lighting:GetChildren()) do
		if effect:IsA("PostEffect") or effect:IsA("Atmosphere") then
			effect:Destroy()
		end
	end

	if level == "Low" then
		Lighting.Brightness = 1
		Lighting.ColorShift_Top = Color3.new(0, 0, 0)
		Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

	elseif level == "Medium" then
		Lighting.Brightness = 2
		Lighting.ColorShift_Top = Color3.fromRGB(50, 50, 50)
		Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)

	elseif level == "High" then
		Lighting.Brightness = 3
		Lighting.ColorShift_Top = Color3.fromRGB(80, 80, 80)
		Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)

	elseif level == "Ultra" then
		Lighting.Brightness = 3.5
		Lighting.ColorShift_Top = Color3.fromRGB(100, 80, 100)
		Lighting.OutdoorAmbient = Color3.fromRGB(220, 200, 220)
		Lighting.FogColor = Color3.fromRGB(255, 230, 240)
		Lighting.FogEnd = 800
		Lighting.ShadowSoftness = 0.1
		Lighting.ClockTime = 17
		Lighting.GlobalShadows = true
		Lighting.EnvironmentDiffuseScale = 0.6
		Lighting.EnvironmentSpecularScale = 0.7
		Lighting.Technology = Enum.Technology.ShadowMap

		-- Bloom
		local bloom = Instance.new("BloomEffect", Lighting)
		bloom.Intensity = 1.5
		bloom.Size = 56
		bloom.Threshold = 0.7

		-- ColorCorrection
		local cc = Instance.new("ColorCorrectionEffect", Lighting)
		cc.TintColor = Color3.fromRGB(255, 240, 240)
		cc.Contrast = 0.4
		cc.Brightness = 0.2
		cc.Saturation = 0.6

		-- SunRays
		local rays = Instance.new("SunRaysEffect", Lighting)
		rays.Intensity = 0.15
		rays.Spread = 0.8

		-- Depth of Field
		local dof = Instance.new("DepthOfFieldEffect", Lighting)
		dof.Enabled = true
		dof.FocusDistance = 30
		dof.InFocusRadius = 12
		dof.FarIntensity = 0.5
		dof.NearIntensity = 0.3

		-- Atmosphere
		local atm = Instance.new("Atmosphere", Lighting)
		atm.Density = 0.35
		atm.Haze = 0.5
		atm.Glare = 0.3
		atm.Color = Color3.fromRGB(255, 240, 240)
		atm.Decay = Color3.fromRGB(180, 160, 160)
	end
end

-- Gán chức năng cho nút Ultra
lowBtn.MouseButton1Click:Connect(function() setShader("Low") end)
medBtn.MouseButton1Click:Connect(function() setShader("Medium") end)
highBtn.MouseButton1Click:Connect(function() setShader("High") end)
ultraBtn.MouseButton1Click:Connect(function() setShader("Ultra") end)