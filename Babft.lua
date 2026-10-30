-- SADHUB | Modern Launcher Panel (без pcall)
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local old = player.PlayerGui:FindFirstChild("SADHUB_Modern")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "Babft_tp"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player.PlayerGui

-- ===== Экран 1: Предупреждение =====
local warnFrame = Instance.new("Frame")
warnFrame.Size = UDim2.new(0, 380, 0, 220)
warnFrame.Position = UDim2.new(0.5, -190, 0.5, -110)
warnFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
warnFrame.BorderSizePixel = 0
warnFrame.Parent = gui
Instance.new("UICorner", warnFrame).CornerRadius = UDim.new(0, 12)

local warnStroke = Instance.new("UIStroke")
warnStroke.Color = Color3.fromRGB(80, 80, 120)
warnStroke.Thickness = 1
warnStroke.Parent = warnFrame

local warnTitle = Instance.new("TextLabel")
warnTitle.Size = UDim2.new(1, -40, 0, 30)
warnTitle.Position = UDim2.new(0, 20, 0, 18)
warnTitle.BackgroundTransparency = 1
warnTitle.Text = "⚠  ВАЖНО"
warnTitle.TextColor3 = Color3.fromRGB(255, 200, 80)
warnTitle.Font = Enum.Font.GothamBold
warnTitle.TextSize = 18
warnTitle.TextXAlignment = Enum.TextXAlignment.Left
warnTitle.Parent = warnFrame

local warnText = Instance.new("TextLabel")
warnText.Size = UDim2.new(1, -40, 0, 100)
warnText.Position = UDim2.new(0, 20, 0, 55)
warnText.BackgroundTransparency = 1
warnText.Text = "Выключите функцию «Проверять куда я телепортируюсь» в инжекторе и перезапустите игру. Иначе телепорт может не сработать."
warnText.TextColor3 = Color3.fromRGB(200, 200, 210)
warnText.Font = Enum.Font.Gotham
warnText.TextSize = 13
warnText.TextWrapped = true
warnText.TextXAlignment = Enum.TextXAlignment.Left
warnText.TextYAlignment = Enum.TextYAlignment.Top
warnText.Parent = warnFrame

local skipBtn = Instance.new("TextButton")
skipBtn.Size = UDim2.new(1, -40, 0, 40)
skipBtn.Position = UDim2.new(0, 20, 1, -60)
skipBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 220)
skipBtn.BorderSizePixel = 0
skipBtn.Text = "ПРОПУСТИТЬ"
skipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
skipBtn.Font = Enum.Font.GothamBold
skipBtn.TextSize = 14
skipBtn.AutoButtonColor = false
skipBtn.Parent = warnFrame
Instance.new("UICorner", skipBtn).CornerRadius = UDim.new(0, 8)

-- ===== Экран 2: Главное меню =====
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 360)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
mainFrame.Visible = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(80, 80, 120)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, -40, 0, 30)
mainTitle.Position = UDim2.new(0, 20, 0, 16)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "SADHUB  LAUNCHER"
mainTitle.TextColor3 = Color3.fromRGB(240, 240, 250)
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextSize = 18
mainTitle.TextXAlignment = Enum.TextXAlignment.Left
mainTitle.Parent = mainFrame

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, -40, 0, 16)
subTitle.Position = UDim2.new(0, 20, 0, 46)
subTitle.BackgroundTransparency = 1
subTitle.Text = "Выберите действие"
subTitle.TextColor3 = Color3.fromRGB(140, 140, 160)
subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 12
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 20)
statusLabel.Position = UDim2.new(0, 20, 1, -30)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Готов"
statusLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = mainFrame

local function setStatus(text, color)
    statusLabel.Text = text
    statusLabel.TextColor3 = color or Color3.fromRGB(140, 140, 160)
end

-- Ловим ошибку телепорта, чтобы не ронять скрипт
TeleportService.TeleportInitFailed:Connect(function(plr, result, msg)
    if plr == player then
        setStatus("Ошибка телепорта: " .. tostring(msg), Color3.fromRGB(220, 80, 80))
    end
end)

local function createButton(y, text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -40, 0, 52)
    btn.Position = UDim2.new(0, 20, 0, y)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.Parent = mainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -44, 0, 48)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -40, 0, 52)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -40, 0, 52)}):Play()
    end)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Телепорт без pcall
local function teleport(placeId, name, autoScript)
    setStatus("Телепорт в " .. name .. "...", Color3.fromRGB(80, 160, 255))
    if autoScript then
        loadstring(game:HttpGet(autoScript))()
    end
    TeleportService:Teleport(placeId, player)
end

createButton(75, "🐰  Получить пасхальную пушку", Color3.fromRGB(140, 80, 200), function()
    teleport(1930863474, "Inner Cloud", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
end)

createButton(135, "🔒  Бесплатный приватный сервер", Color3.fromRGB(80, 100, 220), function()
    teleport(1930866268, "Winter Place", nil)
end)

createButton(195, "⛵  Build A Boat", Color3.fromRGB(40, 150, 80), function()
    teleport(537413528, "Build A Boat", nil)
end)

createButton(255, "✖  Закрыть панель", Color3.fromRGB(160, 50, 50), function()
    gui:Destroy()
end)

-- Анимации появления/закрытия
skipBtn.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(warnFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    })
    tween:Play()
    tween.Completed:Connect(function()
        warnFrame:Destroy()
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        mainFrame.BackgroundTransparency = 1
        TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 380, 0, 360),
            Position = UDim2.new(0.5, -190, 0.5, -180),
            BackgroundTransparency = 0
        }):Play()
    end)
end)

warnFrame.Size = UDim2.new(0, 0, 0, 0)
warnFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
warnFrame.BackgroundTransparency = 1
TweenService:Create(warnFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 380, 0, 220),
    Position = UDim2.new(0.5, -190, 0.5, -110),
    BackgroundTransparency = 0
}):Play()
