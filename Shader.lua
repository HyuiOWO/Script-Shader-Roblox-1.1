local ui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ui.Name = "ShaderMenu"

local frame = Instance.new("Frame", ui)
frame.Size = UDim2.new(0, 360, 0, 280)
frame.Position = UDim2.new(0.5, -180, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BackgroundTransparency = 0.1

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 16)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Transparency = 0.7

local title = Instance.new("TextLabel", frame)
title.Text = "✨ Shader Customizable Visual Enhancer"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 10)

local credit = Instance.new("TextLabel", frame)
credit.Text = "Cre: HyuiOWO"
credit.Font = Enum.Font.Gotham
credit.TextSize = 14
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.BackgroundTransparency = 1
credit.Size = UDim2.new(1, -20, 0, 20)
credit.Position = UDim2.new(0, 10, 0, 50)

-- Nút chọn
local function makeButton(text, posY)
	local b = Instance.new("TextButton", frame)
	b.Text = text
	b.Size = UDim2.new(0.85, 0, 0, 40)
	b.Position = UDim2.new(0.075, 0, 0, posY)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.TextColor3 = Color3.new(1, 1, 1)
	b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

	local c = Instance.new("UICorner", b)
	c.CornerRadius = UDim.new(0, 12)

	local g = Instance.new("UIGradient", b)
	g.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 90, 90)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
	}
	return b
end

local lowBtn = makeButton("Low Quality", 90)
local medBtn = makeButton("Medium Quality", 140)
local highBtn = makeButton("High Quality", 190)

-- Code shader gốc
local Lighting = game:GetService("Lighting")

local function setShader(level)
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
	end
end

lowBtn.MouseButton1Click:Connect(function() setShader("Low") end)
medBtn.MouseButton1Click:Connect(function() setShader("Medium") end)
highBtn.MouseButton1Click:Connect(function() setShader("High") end)