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

-- KHỞI TẠO FOV CIRCLE (FIX CHE PHỦ)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false 
FOVCircle.Color = Color3.fromRGB(0, 255, 255)
FOVCircle.Thickness = 1.5
FOVCircle.Transparency = 1
FOVCircle.Filled = false

local function AddScript(tab, name, note, code_func)
    tab:CreateButton({ Name = name .. " [" .. note .. "]", Callback = code_func })
end

-- ================= TAB SERVER (THAIAN HUB) =================
local ServerTab = Window:CreateTab("Server", 4483362458)

AddScript(ServerTab, "Copy Job ID", "Lấy mã Server hiện tại", function()
    setclipboard(tostring(game.JobId))
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã sao chép Job ID!", Duration = 3})
end)

AddScript(ServerTab, "Copy Place ID", "Lấy mã ID của trò chơi", function()
    setclipboard(tostring(game.PlaceId))
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã sao chép Place ID!", Duration = 3})
end)

AddScript(ServerTab, "Rejoin Server", "Kết nối lại server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end)

AddScript(ServerTab, "Server Hop", "Sang server khác", function()
    local HttpService = game:GetService("HttpService")
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    for _, v in pairs(Servers.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
            break
        end
    end
end)

AddScript(ServerTab, "Small Server Hop", "Tìm server vắng", function()
    local HttpService = game:GetService("HttpService")
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    table.sort(Servers.data, function(a, b) return a.playing < b.playing end)
    for _, v in pairs(Servers.data) do
        if v.id ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
            break
        end
    end
end)

ServerTab:CreateInput({
   Name = "Nhập Job ID Server",
   PlaceholderText = "Dán mã Job ID...",
   Callback = function(Text)
      if Text and #Text > 10 then
         game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Text, LP)
      end
   end,
})

-- ================= TAB ANTI / AUTO =================
local AntiTab = Window:CreateTab("Anti / Auto", 4483362458)

AddScript(AntiTab, "Anti Fling", "Chống bị làm văng", function()
    game:GetService("RunService").Stepped:Connect(function()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= LP and v.Character then
                for _, part in pairs(v.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end)
end)

AddScript(AntiTab, "Auto Rejoin", "Tự vào lại khi mất mạng", function()
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
        if child.Name == "ErrorPrompt" then game:GetService("TeleportService"):Teleport(game.PlaceId) end
    end)
end)

AddScript(AntiTab, "Anti-AFK", "Treo máy", function()
    LP.Idled:Connect(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end)

-- ================= TAB TIỆN ÍCH =================
local UtilsTab = Window:CreateTab("Tiện Ích", 4483362458)
UtilsTab:CreateSection("Di Chuyển")
UtilsTab:CreateToggle({ Name = "Bật Fly", CurrentValue = false, Callback = function(v) getgenv().FlyEnabled = v end })
UtilsTab:CreateSlider({ Name = "Tốc độ Fly", Range = {1, 500}, Increment = 1, CurrentValue = 50, Callback = function(v) getgenv().FlySpeed = v end })
UtilsTab:CreateSlider({ Name = "Tốc độ chạy", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(v) getgenv().WalkSpeed = v end })
UtilsTab:CreateSlider({ Name = "Sức mạnh nhảy", Range = {50, 500}, Increment = 1, CurrentValue = 50, Callback = function(v) getgenv().JumpPower = v end })

UtilsTab:CreateSection("Reset")
UtilsTab:CreateButton({ Name = "Reset WalkSpeed", Callback = function() getgenv().WalkSpeed = 16 end })
UtilsTab:CreateButton({ Name = "Reset JumpPower", Callback = function() getgenv().JumpPower = 50 end })

AddScript(UtilsTab, "CMD - X", "Admin", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))() end)
AddScript(UtilsTab, "Fate's Admin", "Admin", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))() end)
AddScript(UtilsTab, "Nameless Admin", "Admin", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source'))() end)
AddScript(UtilsTab, "Infinite Yeild", "Admin", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
AddScript(UtilsTab, "Remote Spy", "Tool", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))() end)
AddScript(UtilsTab, "Dex Explorer", "Tool", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end)

AddScript(UtilsTab, "Emote Unlocker", "Unlock", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))() end)
AddScript(UtilsTab, "View Player", "See", function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/cattimebhhf/cattimebhhf/main/Seeplayer'),true))() end)
AddScript(UtilsTab, "Gravity UI", "Grav", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/0%20Graviy%20Trip%20Universal"))() end)
AddScript(UtilsTab, "Wallhop", "Jump", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fake-Ladder-Flick-And-Wallhop-Script-37199"))() end)
AddScript(UtilsTab, "Shiftlock", "Mobile", function() loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Mobile-Shiftlock-12348"))() end)
AddScript(UtilsTab, "Godmode", "Immortality", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal"))() end)
AddScript(UtilsTab, "Auto Jump", "Jump", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/nguyenphuc888999666-code/Auto-jump-Ph-c/main/Auto%20jump"))() end)
AddScript(UtilsTab, "Super Fling", "Fling", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/long191910/all-my-roblox-script/refs/heads/main/touchfling.lua"))() end)
AddScript(UtilsTab, "Hitbox Expander", "PVP", function() loadstring(game:HttpGet("https://pastefy.app/ItfO0tdg/raw"))() end)
AddScript(UtilsTab, "Fake Lag", "Lag", function() loadstring(game:HttpGet("https://pastebin.com/raw/w6PfESuz"))() end)
AddScript(UtilsTab, "Fake Dead", "Dead", function() loadstring(game:HttpGet("https://pastefy.app/ssXUg0ng/raw", true))() end)

AddScript(UtilsTab, "FPS Booster", "Boost", function() 
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.Plastic v.Reflectance = 0
        elseif v:IsA("Decal") then v.Transparency = 1 end
    end
end)

AddScript(UtilsTab, "Noclip", "Wall", function() 
    game:GetService("RunService").Stepped:Connect(function()
        if LP.Character then for _, v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    end)
end)

AddScript(UtilsTab, "Click TP", "Tool", function() 
    local tool = Instance.new("Tool", LP.Backpack)
    tool.Name = "ThaiAn TP Tool"
    tool.Activated:Connect(function() LP.Character:MoveTo(LP:GetMouse().Hit.p) end)
end)

-- ================= TAB VISUALS (PHIÊN BẢN MODERN UI) =================
local VisualTab = Window:CreateTab("Visuals", 4483362458)

VisualTab:CreateToggle({
   Name = "Custom Crosshair",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         if not game.CoreGui:FindFirstChild("ThaiAnCrosshair") then
            local CrosshairGui = Instance.new("ScreenGui", game.CoreGui); CrosshairGui.Name = "ThaiAnCrosshair"; CrosshairGui.IgnoreGuiInset = true
            local H = Instance.new("Frame", CrosshairGui); H.BackgroundColor3 = Color3.fromRGB(0, 255, 255); H.Position = UDim2.new(0.5, -10, 0.5, 0); H.Size = UDim2.new(0, 20, 0, 2); H.BorderSizePixel = 0
            local V = Instance.new("Frame", CrosshairGui); V.BackgroundColor3 = Color3.fromRGB(0, 255, 255); V.Position = UDim2.new(0.5, 0, 0.5, -10); V.Size = UDim2.new(0, 2, 0, 20); V.BorderSizePixel = 0
         end
      else
         if game.CoreGui:FindFirstChild("ThaiAnCrosshair") then game.CoreGui.ThaiAnCrosshair:Destroy() end
      end
   end,
})

VisualTab:CreateSlider({
   Name = "Field of View (FOV)",
   Range = {70, 120},
   Increment = 1,
   CurrentValue = 70,
   Callback = function(Value) workspace.CurrentCamera.FieldOfView = Value end,
})

VisualTab:CreateToggle({
   Name = "Show FPS & Ping (Modern UI)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ShowStats = Value
      if Value then
         local S = Instance.new("ScreenGui", game.CoreGui); S.Name = "ThaiAnStats"
         local F = Instance.new("Frame", S)
         F.Size = UDim2.new(0, 160, 0, 45); F.Position = UDim2.new(0, 20, 0, 20)
         F.BackgroundColor3 = Color3.fromRGB(15, 15, 15); F.BackgroundTransparency = 0.3; F.BorderSizePixel = 0
         Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)
         local Stroke = Instance.new("UIStroke", F); Stroke.Color = Color3.fromRGB(255, 255, 255); Stroke.Transparency = 0.8
         local L = Instance.new("TextLabel", F)
         L.Size = UDim2.new(1, 0, 1, 0); L.BackgroundTransparency = 1; L.TextColor3 = Color3.new(1, 1, 1); L.TextSize = 13; L.Font = Enum.Font.GothamBold; L.TextXAlignment = Enum.TextXAlignment.Center
         task.spawn(function()
            while _G.ShowStats do
               local fps = math.floor(1/game:GetService("RunService").RenderStepped:Wait())
               local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")
               L.Text = "⚡ " .. fps .. " FPS  |  🌐 " .. ping .. " MS"
               task.wait(0.5)
            end
            S:Destroy()
         end)
      else
         if game.CoreGui:FindFirstChild("ThaiAnStats") then game.CoreGui.ThaiAnStats:Destroy() end
      end
   end,
})

VisualTab:CreateToggle({
   Name = "Show Active Keybinds (Compact)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ShowKeybinds = Value
      if Value then
         local G = Instance.new("ScreenGui", game.CoreGui); G.Name = "ThaiAnKB"
         local F = Instance.new("Frame", G)
         F.Size = UDim2.new(0, 180, 0, 100); F.Position = UDim2.new(1, -200, 0.4, 0)
         F.BackgroundColor3 = Color3.fromRGB(10, 10, 10); F.BackgroundTransparency = 0.4; F.BorderSizePixel = 0
         Instance.new("UICorner", F).CornerRadius = UDim.new(0, 10)
         local List = Instance.new("UIListLayout", F); List.Padding = UDim.new(0, 5); List.HorizontalAlignment = Enum.HorizontalAlignment.Center; List.VerticalAlignment = Enum.VerticalAlignment.Center
         local function Add(N, V)
            local l = Instance.new("TextLabel", F)
            l.Size = UDim2.new(0.9, 0, 0, 25); l.BackgroundTransparency = 0.8; l.BackgroundColor3 = Color3.fromRGB(255,255,255)
            l.TextColor3 = Color3.new(1,1,1); l.TextSize = 11; l.Font = Enum.Font.GothamMedium
            Instance.new("UICorner", l).CornerRadius = UDim.new(0, 4)
            task.spawn(function()
               while _G.ShowKeybinds do
                  l.Text = N .. " : " .. (_G[V] and "ON" or "OFF")
                  l.TextColor3 = _G[V] and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(200, 200, 200)
                  l.BackgroundTransparency = _G[V] and 0.8 or 0.95
                  task.wait(0.3)
               end
            end)
         end
         Add("BALL MAGNET", "Magnet"); Add("SUPER RING", "SuperRing")
      else
         if game.CoreGui:FindFirstChild("ThaiAnKB") then game.CoreGui.ThaiAnKB:Destroy() end
      end
   end,
})

VisualTab:CreateButton({ Name = "No Fog", Callback = function() game:GetService("Lighting").FogEnd = 9e9 end })
VisualTab:CreateButton({ Name = "Full Bright", Callback = function() game:GetService("Lighting").Brightness = 2; game:GetService("Lighting").ClockTime = 14; game:GetService("Lighting").GlobalShadows = false end })

-- ================= TAB AIMBOT & ESP =================
local AimTab = Window:CreateTab("Aimbot & ESP", 4483362458)
AimTab:CreateToggle({ Name = "Bật Aimbot", CurrentValue = false, Callback = function(v) getgenv().Aimbot = v end })
AimTab:CreateToggle({ Name = "Team Check", CurrentValue = false, Callback = function(v) getgenv().TeamCheck = v end })
AimTab:CreateToggle({ Name = "Hiện FOV", CurrentValue = false, Callback = function(v) getgenv().ShowFOV = v end })
AimTab:CreateSlider({ Name = "FOV Size", Range = {10, 600}, Increment = 1, CurrentValue = 150, Callback = function(v) getgenv().FOVSize = v end })
AimTab:CreateSlider({ Name = "Smoothness", Range = {0.1, 1}, Increment = 0.1, CurrentValue = 0.2, Callback = function(v) getgenv().Smoothness = v end })
AimTab:CreateSection("ESP Settings")
AimTab:CreateToggle({ Name = "Highlight", CurrentValue = false, Callback = function(v) getgenv().ESP_Highlight = v end })
AimTab:CreateToggle({ Name = "Tracer", CurrentValue = false, Callback = function(v) getgenv().ESP_Tracer = v end })
AimTab:CreateToggle({ Name = "Name & Distance", CurrentValue = false, Callback = function(v) getgenv().ESP_Name = v end })

-- ================= TAB BLOX FRUIT =================
local BF_Tab = Window:CreateTab("Blox Fruit", 4483362458)
AddScript(BF_Tab, "Teddy Hub", "Free", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/e86ed284a22672d29e906214e7bbf8b9.lua"))() end)
AddScript(BF_Tab, "Teddy Hop Boss", "Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM"))() end)
AddScript(BF_Tab, "Ziss Hub", "No Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Zis/refs/heads/main/ZisChuoiEng"))() end)
AddScript(BF_Tab, "Trẩu Hub", "No Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/trungdao2k4/trauroblox/refs/heads/main/trauv9lord.lua"))() end)
AddScript(BF_Tab, "Min Gaming Hub", "No Key", function() loadstring(game:HttpGet("https://github.com/LuaCrack/Min/raw/refs/heads/main/MinVnV5"))() end)
AddScript(BF_Tab, "Quantum Hub", "No Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end)
AddScript(BF_Tab, "Redz Hub", "No Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/luraobermeyer-jpg/redzhub/refs/heads/main/redzhub.lua.txt"))() end)
AddScript(BF_Tab, "Dragon Hub", "No Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/dragonhubdev/dragonwitheveryone/refs/heads/main/Main-BF.lua"))() end)
AddScript(BF_Tab, "Apple Hub", "Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/longhihilonghihi-hub/AppleHubPremiumV2/refs/heads/main/AppleHubPremiumv2.txt"))() end)
AddScript(BF_Tab, "AnDepZai Hub", "No Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/refs/heads/main/AnDepZaiHubBeta.lua"))() end)
AddScript(BF_Tab, "Hermanos Hub", "No Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hermanos-dev/hermanos-hub/refs/heads/main/Loader.lua"))() end)
AddScript(BF_Tab, "OMG Hub", "Key", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/20f318386e3fbf069ee3fa797cfc9f34.lua"))() end)

-- ================= TAB THE FORGE =================
local Forge_Tab = Window:CreateTab("The Forge", 4483362458)
AddScript(Forge_Tab, "Catraz Hub", "Free", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/nurvian/Catraz-HUB/refs/heads/main/Catraz/main.lua"))() end)
AddScript(Forge_Tab, "No1 Hub", "Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/SkibidiHub111/Forge/refs/heads/main/No1Dev"))() end)
AddScript(Forge_Tab, "Mirage Hub", "Free", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2075c39b9a5a2e4414c59c93fe8a5f06.lua"))() end)
AddScript(Forge_Tab, "Lazy Hub", "Free", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LioK251/RbScripts/refs/heads/main/lazyuhub_theforge.lua"))() end)
AddScript(Forge_Tab, "Vxeze Hub", "Key", function() loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/702a5c5488082e6f"))() end)
AddScript(Forge_Tab, "Bonk Hub", "Key", function() loadstring(game:HttpGet("https://bonkhub.online/loader.lua",true))() end)

-- ================= TAB MM2 =================
local MM2_Tab = Window:CreateTab("MM2", 4483362458)
AddScript(MM2_Tab, "Capybara Hub", "Key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/zorex321/capybara/refs/heads/main/Capybara-Hub",true))() end)
AddScript(MM2_Tab, "Nexus Hub", "Free", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/NexusScripts212/MurderMystery2/refs/heads/main/Mm2",true))() end)
AddScript(MM2_Tab, "Overdrive Hub", "Key", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Overdrive-Hub-43383"))() end)
AddScript(MM2_Tab, "XHub", "Free", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/bluedeal/Mm2.xhub/refs/heads/main/Mm2-KeylessV2"))() end)
AddScript(MM2_Tab, "Vision Hub", "Free", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/VisionHub/refs/heads/main/main.lua"))() end)

-- ================= TAB BLUE LOCK RIVALS =================
local BlueLockTab = Window:CreateTab("Blue Lock", 4483362458)
AddScript(BlueLockTab, "Ball Magnet", "Hút bóng", function()
    _G.Magnet = true
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Magnet and LP.Character then
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name == "Football" and v:IsA("BasePart") then
                        v.Velocity = (LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3).p - v.Position) * 30
                    end
                end
            end)
        end
    end)
end)

AddScript(BlueLockTab, "Curve Kick", "Sút xoáy", function()
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == "Football" and (v.Position - LP.Character.HumanoidRootPart.Position).Magnitude < 10 then
                    v.Velocity = Camera.CFrame.LookVector * 150
                end
            end
        end)
    end)
end)

AddScript(BlueLockTab, "Infinite Stamina", "Hack thể lực", function()
    pcall(function() local s = LP:FindFirstChild("Stamina", true) if s then s.Value = 100 end end)
end)

AddScript(BlueLockTab, "Power Reach", "Tầm cướp", function()
    task.spawn(function() while task.wait(1) do for _, v in pairs(workspace:GetChildren()) do if v.Name == "Football" then v.Size = Vector3.new(15,15,15) end end end end)
end)

-- ================= LOGIC HỆ THỐNG (FIX FOV) =================
local function GetClosestToMouse()
    local target, closestDist = nil, getgenv().FOVSize
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            if getgenv().TeamCheck and v.Team == LP.Team then continue end
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                if dist < closestDist then closestDist = dist target = v end
            end
        end
    end
    return target
end

game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().ShowFOV then
        FOVCircle.Visible = true
        FOVCircle.Radius = getgenv().FOVSize
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        FOVCircle.Visible = false
    end
    if getgenv().Aimbot then
        local t = GetClosestToMouse()
        if t then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t.Character.HumanoidRootPart.Position), getgenv().Smoothness) end
    end
    if getgenv().FlyEnabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        if not LP.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
            local bv = Instance.new("BodyVelocity", LP.Character.HumanoidRootPart); bv.MaxForce = Vector3.new(9e9,9e9,9e9)
            local bg = Instance.new("BodyGyro", LP.Character.HumanoidRootPart); bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        end
        LP.Character.HumanoidRootPart.BodyGyro.CFrame = Camera.CFrame
        local dir = Vector3.new(0,0,0); local UIS = game:GetService("UserInputService")
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
        LP.Character.HumanoidRootPart.BodyVelocity.Velocity = dir * getgenv().FlySpeed
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    pcall(function() 
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then 
            LP.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed
            LP.Character.Humanoid.JumpPower = getgenv().JumpPower
            LP.Character.Humanoid.UseJumpPower = true
        end 
    end)
end)
