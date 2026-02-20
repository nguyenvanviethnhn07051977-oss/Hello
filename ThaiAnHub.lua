local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ThaiAn Hub",
   LoadingTitle = "Loading Script",
   LoadingSubtitle = "by Thái An",
   ConfigurationSaving = { Enabled = false }
})

-- THÔNG BÁO DISCORD
Rayfield:Notify({
   Title = "Hệ Thống Đã Kích Hoạt!",
   Content = "Discord : https://discord.gg/3D3acCm9k",
   Duration = 10,
   Image = 4483362458,
   Actions = { Ignore = { Name = "OK!", Callback = function() end }, },
})

-- BIẾN HỆ THỐNG
getgenv().Aimbot = false
getgenv().TeamCheck = false
getgenv().ShowFOV = false 
getgenv().FOVSize = 150
getgenv().Smoothness = 0.2
getgenv().ESP_Highlight = false
getgenv().ESP_Tracer = false
getgenv().ESP_Name = false
getgenv().WalkSpeed = 16
getgenv().JumpPower = 50
getgenv().FlyEnabled = false
getgenv().FlySpeed = 50

local Camera = workspace.CurrentCamera
local LP = game.Players.LocalPlayer
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false 
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Thickness = 1
FOVCircle.Transparency = 1

local function AddScript(tab, name, note, code_func)
    tab:CreateButton({ Name = name .. " [" .. note .. "]", Callback = code_func })
end

-- ================= TAB 1: AIMBOT & ESP =================
local AimTab = Window:CreateTab("Aimbot & ESP", 4483362458)
AimTab:CreateToggle({ Name = "Bật Aimbot", CurrentValue = false, Callback = function(v) getgenv().Aimbot = v end })
AimTab:CreateToggle({ Name = "Team Check", CurrentValue = false, Callback = function(v) getgenv().TeamCheck = v end })
AimTab:CreateToggle({ Name = "Hiện FOV", CurrentValue = false, Callback = function(v) getgenv().ShowFOV = v end })
AimTab:CreateSlider({ Name = "FOV Size", Range = {10, 600}, Increment = 1, CurrentValue = 150, Callback = function(v) getgenv().FOVSize = v end })
AimTab:CreateSlider({ Name = "Smoothness", Range = {0.1, 1}, Increment = 0.1, CurrentValue = 0.2, Callback = function(v) getgenv().Smoothness = v end })
AimTab:CreateSection("ESP Settings")
AimTab:CreateToggle({ Name = "Highlight (Khung)", CurrentValue = false, Callback = function(v) getgenv().ESP_Highlight = v end })
AimTab:CreateToggle({ Name = "Tracer (Đường kẻ)", CurrentValue = false, Callback = function(v) getgenv().ESP_Tracer = v end })
AimTab:CreateToggle({ Name = "Name & Distance", CurrentValue = false, Callback = function(v) getgenv().ESP_Name = v end })

-- ================= TAB 2: BLOX FRUIT (FULL) =================
local BF_Tab = Window:CreateTab("Blox Fruit", 4483362458)
AddScript(BF_Tab, "Teddy Hub", "Không có key", function() 
    repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/e86ed284a22672d29e906214e7bbf8b9.lua"))() 
end)
AddScript(BF_Tab, "Teddy Hop Boss", "Có key", function() 
    repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM"))() 
end)
AddScript(BF_Tab, "Ziss Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Zis/refs/heads/main/ZisChuoiEng"))() end)
AddScript(BF_Tab, "Trẩu Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/trungdao2k4/trauroblox/refs/heads/main/trauv9lord.lua"))() end)
AddScript(BF_Tab, "Min Gaming Hub", "Không key", function() getgenv().Team = "Marines"; loadstring(game:HttpGet("https://github.com/LuaCrack/Min/raw/refs/heads/main/MinVnV5"))() end)
AddScript(BF_Tab, "Quantum Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end)
AddScript(BF_Tab, "Redz Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/luraobermeyer-jpg/redzhub/refs/heads/main/redzhub.lua.txt"))() end)
AddScript(BF_Tab, "Dragon Hub", "Không key", function() getgenv().team = "Pirates"; loadstring(game:HttpGet("https://raw.githubusercontent.com/dragonhubdev/dragonwitheveryone/refs/heads/main/Main-BF.lua"))() end)
AddScript(BF_Tab, "Apple Hub", "Key: Longdz-1234VietNamese", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt"))() end)
AddScript(BF_Tab, "AnDepZai Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/refs/heads/main/AnDepZaiHubBeta.lua"))() end)
AddScript(BF_Tab, "Hermanos Hub", "Không key", function() getgenv().script_mode = "PVP"; loadstring(game:HttpGet("https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/refs/heads/main/Loader.lua"))() end)
AddScript(BF_Tab, "OMG Hub", "Có key", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/20f318386e3fbf069ee3fa797cfc9f34.lua"))() end)

-- ================= TAB 3: THE FORGE =================
local Forge_Tab = Window:CreateTab("The Forge", 4483362458)
AddScript(Forge_Tab, "Catraz Hub", "Không có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/nurvian/Catraz-HUB/refs/heads/main/Catraz/main.lua"))() end)
AddScript(Forge_Tab, "No1 Hub", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/SkibidiHub111/Forge/refs/heads/main/No1Dev"))() end)
AddScript(Forge_Tab, "Mirage Hub", "Không có key", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2075c39b9a5a2e4414c59c93fe8a5f06.lua"))() end)

-- ================= TAB 4: MM2 =================
local MM2_Tab = Window:CreateTab("MM2", 4483362458)
AddScript(MM2_Tab, "Capybara Hub", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/zorex321/capybara/refs/heads/main/Capybara-Hub",true))() end)
AddScript(MM2_Tab, "Nexus Hub", "Không có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/NexusScripts212/MurderMystery2/refs/heads/main/Mm2",true))() end)

-- ================= TAB 5: TIỆN ÍCH (CẬP NHẬT) =================
local UtilsTab = Window:CreateTab("Tiện Ích", 4483362458)
UtilsTab:CreateSection("Di Chuyển")
UtilsTab:CreateToggle({ Name = "Bật Fly", CurrentValue = false, Callback = function(v) getgenv().FlyEnabled = v end })
UtilsTab:CreateSlider({ Name = "Tốc độ Fly", Range = {1, 500}, Increment = 1, CurrentValue = 50, Callback = function(v) getgenv().FlySpeed = v end })
UtilsTab:CreateSlider({ Name = "Tốc độ chạy", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(v) getgenv().WalkSpeed = v end })
UtilsTab:CreateSlider({ Name = "Sức mạnh nhảy", Range = {50, 500}, Increment = 1, CurrentValue = 50, Callback = function(v) getgenv().JumpPower = v end })

UtilsTab:CreateSection("Reset Nhân Vật")
UtilsTab:CreateButton({
    Name = "Reset WalkSpeed",
    Callback = function() 
        getgenv().WalkSpeed = 16 
        Rayfield:Notify({Title = "Hệ Thống", Content = "Đã reset tốc độ về 16", Duration = 2})
    end 
})
UtilsTab:CreateButton({
    Name = "Reset JumpPower",
    Callback = function() 
        getgenv().JumpPower = 50 
        Rayfield:Notify({Title = "Hệ Thống", Content = "Đã reset sức nhảy về 50", Duration = 2})
    end 
})

-- ================= LOGIC HỆ THỐNG =================
local function GetClosestToMouse()
    local target, closestDist = nil, getgenv().FOVSize
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            if getgenv().TeamCheck and v.Team == LP.Team then continue end
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    target = v
                end
            end
        end
    end
    return target
end

local function ManageESP(plr)
    local tracer = Drawing.new("Line")
    local text = Drawing.new("Text")
    local highlight = Instance.new("Highlight")
    game:GetService("RunService").RenderStepped:Connect(function()
        if plr.Character and plr ~= LP and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.Humanoid.Health > 0 then
            local rootPos = plr.Character.HumanoidRootPart.Position
            local pos, onScreen = Camera:WorldToViewportPoint(rootPos)
            highlight.Parent = getgenv().ESP_Highlight and plr.Character or nil
            if getgenv().ESP_Tracer and onScreen then
                tracer.Visible = true; tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y); tracer.To = Vector2.new(pos.X, pos.Y); tracer.Color = Color3.new(1,1,1)
            else tracer.Visible = false end
            if getgenv().ESP_Name and onScreen then
                text.Visible = true; text.Position = Vector2.new(pos.X, pos.Y - 40); text.Center = true; text.Outline = true; text.Size = 16
                text.Text = plr.Name .. " [" .. math.floor((LP.Character.HumanoidRootPart.Position - rootPos).Magnitude) .. "m]"
            else text.Visible = false end
        else tracer.Visible = false; text.Visible = false; highlight.Parent = nil end
    end)
end
for _, p in pairs(game.Players:GetPlayers()) do ManageESP(p) end
game.Players.PlayerAdded:Connect(ManageESP)

game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Visible = getgenv().ShowFOV
    FOVCircle.Radius = getgenv().FOVSize
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    if getgenv().Aimbot then
        local t = GetClosestToMouse()
        if t then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Character.HumanoidRootPart.Position), getgenv().Smoothness) end
    end
    if getgenv().FlyEnabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        if not LP.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then
            Instance.new("BodyGyro", LP.Character.HumanoidRootPart).maxTorque = Vector3.new(9e9, 9e9, 9e9)
            Instance.new("BodyVelocity", LP.Character.HumanoidRootPart).maxForce = Vector3.new(9e9, 9e9, 9e9)
        end
        LP.Character.HumanoidRootPart.BodyGyro.cframe = Camera.CFrame
        local dir = Vector3.new(0, 0, 0)
        local UIS = game:GetService("UserInputService")
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
        LP.Character.HumanoidRootPart.BodyVelocity.velocity = dir * getgenv().FlySpeed
    else
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            if LP.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then LP.Character.HumanoidRootPart.BodyGyro:Destroy() end
            if LP.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then LP.Character.HumanoidRootPart.BodyVelocity:Destroy() end
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    pcall(function() 
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then 
            LP.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed
            LP.Character.Humanoid.JumpPower = getgenv().JumpPower
            -- Delta fix: Đảm bảo JumpPower luôn được nhận diện
            LP.Character.Humanoid.UseJumpPower = true
        end 
    end)
end)

