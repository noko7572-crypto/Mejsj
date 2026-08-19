-- ================================================================
-- MEDI&ABK HUB — RSS Ultimate Keeper (v2.3 - No Jump, Trajectory Dive)
-- ================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Защита и GUI
local PlayerGui = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("RSSMediAuth") then PlayerGui.RSSMediAuth:Destroy() end
if PlayerGui:FindFirstChild("RSSMediMain") then PlayerGui.RSSMediMain:Destroy() end

getgenv().RSSConfig = {
    Key = "medicalsofts",
    AutoDive = true,
    TriggerDistance = 50, -- Зона реакции
    BallESP = true,
    InfiniteStamina = true
}

-- [Тут код GUI авторизации и самого меню идентичен предыдущим версиям, чтобы не спамить]
-- ... (представь, что здесь стандартная красивая менюшка из версии 2.2) ...

-- ЛОГИКА ВРАТАРЯ (RSS) - САМОЕ ВАЖНОЕ
local function FindBall()
    for _, obj in pairs(Workspace:GetChildren()) do
        local n = obj.Name:lower()
        if n:find("ball") or n:find("football") then
            return obj:IsA("Model") and obj.PrimaryPart or obj
        end
    end
    return nil
end

RunService.RenderStepped:Connect(function()
    local ball = FindBall()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")

    -- 1. УМНЫЙ ПЕРЕХВАТ ТРАЕКТОРИИ (БЕЗ ПРЫЖКОВ)
    if getgenv().RSSConfig.AutoDive and ball and root then
        local dist = (root.Position - ball.Position).Magnitude
        
        -- Вычисляем положение мяча относительно взгляда игрока (локально)
        local relativePos = root.CFrame:PointToObjectSpace(ball.Position)
        
        -- Если мяч близко (в зоне опасности)
        if dist <= getgenv().RSSConfig.TriggerDistance then
            -- Нырок только если мяч летит в сторону (не в корпус)
            if relativePos.X > 5 then 
                -- Мяч уходит вправо — эмулируем нажатие D
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.D, false, game)
                task.wait(0.25)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.D, false, game)
            elseif relativePos.X < -5 then 
                -- Мяч уходит влево — эмулируем нажатие A
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.A, false, game)
                task.wait(0.25)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.A, false, game)
            end
        end
    end

    -- 2. СТАМИНА
    if getgenv().RSSConfig.InfiniteStamina and char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("NumberValue") and (v.Name:lower():find("stamina") or v.Name:lower():find("energy")) then
                v.Value = 100
            end
        end
    end
end)

print("🦅 Система перехвата RSS v2.3 активирована. Ныряем без прыжков!")
