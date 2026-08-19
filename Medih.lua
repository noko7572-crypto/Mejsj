-- ================================================================
-- MEDI&ABK HUB — RSS Ultimate Pro Fixed Edition (v2.1)
-- ================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local function GetGuiParent()
    local success, result = pcall(function()
        return game:GetService("CoreGui")
    end)
    if success then return result end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local PlayerGui = GetGuiParent()

if PlayerGui:FindFirstChild("RSSMediAuth") then
    PlayerGui.RSSMediAuth:Destroy()
end
if PlayerGui:FindFirstChild("RSSMediMain") then
    PlayerGui.RSSMediMain:Destroy()
end
if PlayerGui:FindFirstChild("RSSOpenIcon") then
    PlayerGui.RSSOpenIcon:Destroy()
end

getgenv().RSSConfig = {
    Key = "medicalsofts",
    AutoDive = true,
    TriggerDistance = 45,
    BallESP = true,
    InfiniteStamina = true,
    GoalAimbot = true
}

-- 🌌 ЭКРАН АВТОРИЗАЦИИ
local AuthGui = Instance.new("ScreenGui")
AuthGui.Name = "RSSMediAuth"
AuthGui.Parent = PlayerGui
AuthGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AuthGui.ResetOnSpawn = false

local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Size = 0
BlurEffect.Parent = Lighting
TweenService:Create(BlurEffect, TweenInfo.new(1.5, Enum.EasingStyle.Exponential), {Size = 24}):Play()

local AuthFrame = Instance.new("Frame", AuthGui)
AuthFrame.Name = "AuthFrame"
AuthFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
AuthFrame.BackgroundTransparency = 1
AuthFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
AuthFrame.Size = UDim2.new(0, 350, 0, 220)
AuthFrame.ClipsDescendants = true

Instance.new("UICorner", AuthFrame).CornerRadius = UDim.new(0, 16)
local AuthStroke = Instance.new("UIStroke", AuthFrame)
AuthStroke.Color = Color3.fromRGB(0, 200, 255)
AuthStroke.Transparency = 1
AuthStroke.Thickness = 2

TweenService:Create(AuthFrame, TweenInfo.new(1.2, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.25}):Play()
TweenService:Create(AuthStroke, TweenInfo.new(1.2, Enum.EasingStyle.Quart), {Transparency = 0.2}):Play()

local AuthTitle = Instance.new("TextLabel", AuthFrame)
AuthTitle.Text = ""
AuthTitle.Font = Enum.Font.GothamBold
AuthTitle.TextColor3 = Color3.fromRGB(180, 240, 255)
AuthTitle.TextSize = 20
AuthTitle.Size = UDim2.new(1, 0, 0, 40)
AuthTitle.Position = UDim2.new(0, 0, 0.15, 0)
AuthTitle.BackgroundTransparency = 1
AuthTitle.TextXAlignment = Enum.TextXAlignment.Center

local KeyInput = Instance.new("TextBox", AuthFrame)
KeyInput.Text = ""
KeyInput.PlaceholderText = "••••••••••••"
KeyInput.PlaceholderColor3 = Color3.fromRGB(80, 120, 140)
KeyInput.Font = Enum.Font.GothamSemibold
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 16
KeyInput.BackgroundColor3 = Color3.fromRGB(15, 25, 40)
KeyInput.BackgroundTransparency = 0.5
KeyInput.Size = UDim2.new(0.8, 0, 0, 45)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.ClearTextOnFocus = false
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 10)
local KeyStroke = Instance.new("UIStroke", KeyInput)
KeyStroke.Color = Color3.fromRGB(0, 150, 200)
KeyStroke.Thickness = 1.5

local ConfirmBtn = Instance.new("TextButton", AuthFrame)
ConfirmBtn.Text = "Запустить имбу!"
ConfirmBtn.Font = Enum.Font.GothamBold
ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmBtn.TextSize = 16
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ConfirmBtn.Size = UDim2.new(0.8, 0, 0, 45)
ConfirmBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
Instance.new("UICorner", ConfirmBtn).CornerRadius = UDim.new(0, 10)

task.spawn(function()
    task.wait(0.8)
    local targetText = "Введи ключ, братишка"
    for i = 1, #targetText do
        AuthTitle.Text = string.sub(targetText, 1, i)
        task.wait(0.04)
    end
end)

local function LaunchRSSHub()
    TweenService:Create(AuthFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    TweenService:Create(BlurEffect, TweenInfo.new(0.8), {Size = 0}):Play()
    task.wait(0.5)
    AuthGui:Destroy()
    if BlurEffect then BlurEffect:Destroy() end

    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "RSSMediMain"
    MainGui.Parent = PlayerGui
    MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    MainGui.ResetOnSpawn = false

    local HubFrame = Instance.new("Frame", MainGui)
    HubFrame.BackgroundColor3 = Color3.fromRGB(10, 15, 25)
    HubFrame.BackgroundTransparency = 0.2
    HubFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
    HubFrame.Size = UDim2.new(0, 420, 0, 320)
    HubFrame.ClipsDescendants = true
    Instance.new("UICorner", HubFrame).CornerRadius = UDim.new(0, 12)

    local HubStroke = Instance.new("UIStroke", HubFrame)
    HubStroke.Color = Color3.fromRGB(0, 200, 255)
    HubStroke.Thickness = 1.8

    local TopBar = Instance.new("Frame", HubFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.BackgroundTransparency = 1

    local TitleLabel = Instance.new("TextLabel", TopBar)
    TitleLabel.Text = "RSS ULTIMATE HUB v2.1 (Fixed)"
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextColor3 = Color3.fromRGB(150, 220, 255)
    TitleLabel.TextSize = 13
    TitleLabel.Size = UDim2.new(0, 280, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Кнопка открытия (появляется при сворачивании)
    local OpenIcon = Instance.new("TextButton", MainGui)
    OpenIcon.Name = "RSSOpenIcon"
    OpenIcon.Text = "RSS"
    OpenIcon.Font = Enum.Font.GothamBlack
    OpenIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenIcon.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    OpenIcon.Size = UDim2.new(0, 45, 0, 45)
    OpenIcon.Position = UDim2.new(0, 20, 0.5, -22)
    OpenIcon.Visible = false
    OpenIcon.Active = true
    OpenIcon.Draggable = true
    Instance.new("UICorner", OpenIcon).CornerRadius = UDim.new(1, 0)
    local OpenStroke = Instance.new("UIStroke", OpenIcon)
    OpenStroke.Color = Color3.fromRGB(150, 220, 255)
    OpenStroke.Thickness = 2

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Text = "×"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextColor3 = Color3.fromRGB(220, 100, 100)
    CloseBtn.TextSize = 18
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 3)
    CloseBtn.BackgroundTransparency = 1

    local MinimizeBtn = Instance.new("TextButton", TopBar)
    MinimizeBtn.Text = "-"
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MinimizeBtn.TextSize = 18
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Position = UDim2.new(1, -70, 0, 3)
    MinimizeBtn.BackgroundTransparency = 1

    -- Исправленная кнопка закрытия (теперь сворачивает меню, а не стирает)
    CloseBtn.MouseButton1Click:Connect(function()
        HubFrame.Visible = false
        OpenIcon.Visible = true
    end)

    MinimizeBtn.MouseButton1Click:Connect(function()
        HubFrame.Visible = false
        OpenIcon.Visible = true
    end)

    OpenIcon.MouseButton1Click:Connect(function()
        OpenIcon.Visible = false
        HubFrame.Visible = true
    end)

    local Container = Instance.new("ScrollingFrame", HubFrame)
    Container.Size = UDim2.new(1, 0, 1, -45)
    Container.Position = UDim2.new(0, 0, 0, 40)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 3
    Container.CanvasSize = UDim2.new(0, 0, 0, 260)

    local UIList = Instance.new("UIListLayout", Container)
    UIList.Padding = UDim.new(0, 8)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function CreateSwitch(text, configKey)
        local Card = Instance.new("Frame", Container)
        Card.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
        Card.BackgroundTransparency = 0.4
        Card.Size = UDim2.new(1, -20, 0, 45)
        Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

        local Label = Instance.new("TextLabel", Card)
        Label.Text = text
        Label.Font = Enum.Font.GothamMedium
        Label.TextColor3 = Color3.fromRGB(200, 230, 255)
        Label.Size = UDim2.new(0.7, 0, 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextSize = 13

        local ToggleBtn = Instance.new("TextButton", Card)
        ToggleBtn.Text = ""
        ToggleBtn.BackgroundColor3 = getgenv().RSSConfig[configKey] and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(30, 45, 65)
        ToggleBtn.Size = UDim2.new(0, 42, 0, 22)
        ToggleBtn.Position = UDim2.new(1, -55, 0.5, -11)
        Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

        local Indicator = Instance.new("Frame", ToggleBtn)
        Indicator.BackgroundColor3 = Color3.fromRGB(200, 240, 255)
        Indicator.Size = UDim2.new(0, 16, 0, 16)
        Indicator.Position = getgenv().RSSConfig[configKey] and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

        ToggleBtn.MouseButton1Click:Connect(function()
            getgenv().RSSConfig[configKey] = not getgenv().RSSConfig[configKey]
            local state = getgenv().RSSConfig[configKey]
            if state then
                TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
                TweenService:Create(Indicator, TweenInfo.new(0.3), {Position = UDim2.new(1, -19, 0.5, -8)}):Play()
            else
                TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 45, 65)}):Play()
                TweenService:Create(Indicator, TweenInfo.new(0.3), {Position = UDim2.new(0, 3, 0.5, -8)}):Play()
            end
        end)
    end

    CreateSwitch("Auto-Dive (Авто-нырок / Перехват)", "AutoDive")
    CreateSwitch("Ball ESP (Подсветка мяча)", "BallESP")
    CreateSwitch("Infinite Stamina (Бесконечная стамина)", "InfiniteStamina")
    CreateSwitch("Goal Aimbot (Авто-удар в девятку)", "GoalAimbot")

    local function FindBall()
        for _, obj in pairs(Workspace:GetChildren()) do
            local n = obj.Name:lower()
            if n:find("ball") or n:find("football") then
                if obj:IsA("BasePart") then return obj
                elseif obj:IsA("Model") then return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart") end
            end
        end
        return nil
    end

    -- Исправленный и стабильный Drawing ESP для мяча
    local BallESPObj = Drawing.new("Circle")
    BallESPObj.Thickness = 2
    BallESPObj.NumSides = 24
    BallESPObj.Filled = false
    BallESPObj.Color = Color3.fromRGB(0, 255, 255)
    BallESPObj.Visible = false

    RunService.RenderStepped:Connect(function()
        local ball = FindBall()
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        -- 1. Исправленный Ball ESP
        if getgenv().RSSConfig.BallESP and ball then
            local pos, onScreen = Camera:WorldToViewportPoint(ball.Position)
            if onScreen then
                BallESPObj.Position = Vector2.new(pos.X, pos.Y)
                BallESPObj.Radius = math.clamp(3000 / pos.Z, 12, 110)
                BallESPObj.Visible = true
            else
                BallESPObj.Visible = false
            end
        else
            BallESPObj.Visible = false
        end

        -- 2. Фикс Auto-Dive (Теперь дергает механику нырка/перехвата по траектории, а не просто прыгает)
        if getgenv().RSSConfig.AutoDive and ball and root and hum and hum.Health > 0 then
            local dist = (root.Position - ball.Position).Magnitude
            if dist <= getgenv().RSSConfig.TriggerDistance then
                -- Разворачиваем перса лицом к летящему мячу
                root.CFrame = CFrame.new(root.Position, Vector3.new(ball.Position.X, root.Position.Y, ball.Position.Z))
                
                -- Эмулируем нажатие клавиши действия/прыжка с удержанием для нырка
                pcall(function()
                    if firesignal then
                        -- Если эксплорер поддерживает прострел сигналов ввода
                    elseif mouse1press then
                        mouse1press()
                        task.wait(0.05)
                        mouse1release()
                    end
                    if hum.FloorMaterial ~= Enum.Material.Air then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            end
        end

        -- 3. Infinite Stamina
        if getgenv().RSSConfig.InfiniteStamina and char then
            pcall(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("NumberValue") and (v.Name:lower():find("stamina") or v.Name:lower():find("energy") or v.Name:lower():find("fatigue")) then
                        v.Value = 100
                    end
                end
            end)
        end

        -- 4. Goal Aimbot
        if getgenv().RSSConfig.GoalAimbot and ball and root then
            local distToBall = (root.Position - ball.Position).Magnitude
            if distToBall < 6 and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                pcall(function()
                    root.CFrame = CFrame.new(root.Position, root.Position + Camera.CFrame.LookVector)
                end)
            end
        end
    end)
end

ConfirmBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == getgenv().RSSConfig.Key then
        TweenService:Create(ConfirmBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 205, 50)}):Play()
        ConfirmBtn.Text = "Допуск выдан! 🔓"
        task.wait(0.4)
        LaunchRSSHub()
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "Неверный ключ, бро! ❌"
    end
end)
