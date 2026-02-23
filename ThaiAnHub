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
   Content = "Discord : https://discord.gg/3D3acCm9k
 Anh em nào muốn thêm script game nào đó thì vào discord bảo mình nhé!",
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

-- ================= TAB 1: SERVER =================
local ServerTab = Window:CreateTab("Server", 4483362458) -- Icon hình máy chủ hoặc mạng lưới

-- 1. Sao chép Job ID
AddScript(ServerTab, "Copy Job ID", "Lấy mã Server hiện tại", function()
    local jobId = game.JobId
    setclipboard(tostring(jobId))
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã sao chép Job ID vào bộ nhớ tạm!", Duration = 3})
end)

-- 2. Sao chép Place ID (ID của game)
AddScript(ServerTab, "Copy Place ID", "Lấy mã ID của trò chơi", function()
    setclipboard(tostring(game.PlaceId))
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã sao chép Place ID!", Duration = 3})
end)

-- 3. Vào lại Server (Rejoin)
AddScript(ServerTab, "Rejoin Server", "Kết nối lại server này ngay lập tức", function()
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang kết nối lại...", Duration = 3})
    local ts = game:GetService("TeleportService")
    local p = game.Players.LocalPlayer
    ts:Teleport(game.PlaceId, p)
end)

-- 4. Chuyển Server (Server Hop)
AddScript(ServerTab, "Server Hop", "Sang server khác ngẫu nhiên", function()
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang tìm kiếm server mới...", Duration = 3})
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local PlaceId = game.PlaceId
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    for _, v in pairs(Servers.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(PlaceId, v.id)
            break
        end
    end
end)

-- 5. Server Hop (Ít người nhất)
AddScript(ServerTab, "Small Server Hop", "Tìm server vắng người để cày", function()
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang tìm server vắng nhất...", Duration = 3})
    -- Code này sẽ ưu tiên tìm server có ít người chơi nhất trong danh sách
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local PlaceId = game.PlaceId
    local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    
    table.sort(Servers.data, function(a, b)
        return a.playing < b.playing
    end)

    for _, v in pairs(Servers.data) do
        if v.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(PlaceId, v.id)
            break
        end
    end
end)
-- 6. Nhập Job ID để tham gia (Join by Job ID)
ServerTab:CreateInput({
   Name = "Nhập Job ID Server",
   PlaceholderText = "Dán mã Job ID vào đây...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      -- Khi ông dán mã vào và nhấn Enter
      if Text and #Text > 10 then -- Kiểm tra xem mã có hợp lệ không
         Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang kết nối tới Job ID: " .. Text, Duration = 3})
         game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, Text, game.Players.LocalPlayer)
      else
         Rayfield:Notify({Title = "ThaiAn Hub", Content = "Mã Job ID không hợp lệ!", Duration = 3})
      end
   end,
})

-- ================= TAB 2: ANTI / AUTO =================
local AntiTab = Window:CreateTab("Anti / Auto", 4483362458)

-- 1. Anti Fling (Chống bị làm văng)
AddScript(AntiTab, "Anti Fling", "Chống bọn dùng Fling làm văng ông", function()
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang kích hoạt bảo vệ chống Fling...", Duration = 3})
    -- Cơ chế: Tắt va chạm với người chơi khác
    local RunService = game:GetService("RunService")
    RunService.Stepped:Connect(function()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character then
                for _, part in pairs(v.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- 2. Auto Rejoin (Tự vào lại nếu bị văng game/mất mạng)
AddScript(AntiTab, "Auto Rejoin", "Tự động kết nối lại khi Disconnect", function()
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Chế độ Auto Rejoin đã sẵn sàng!", Duration = 3})
    -- Kiểm tra bảng thông báo lỗi của Roblox để tự Rejoin
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
        if child.Name == "ErrorPrompt" then
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    end)
end)

-- 3. Anti-AFK (Bản nâng cấp)
AddScript(AntiTab, "Anti-AFK", "Treo máy xuyên màn đêm", function()
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã bật Anti-AFK! Không lo bị kick.", Duration = 3})
    local VirtualUser = game:GetService("VirtualUser")
    game.Players.LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- ================= TAB 3: TIỆN ÍCH =================
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

AddScript(UtilsTab, "CMD - X", "Nextgen Admin", function() Rayfield:Notify({
   Title = "ThaiAn Hub - Hệ Thống",
   Content = "Đang khởi chạy script, vui lòng chờ trong giây lát!",
   Duration = 5,
   Image = 4483362458,
}) loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))() end)
AddScript(UtilsTab, "Fate's Admin", "God Command", function() Rayfield:Notify({
   Title = "ThaiAn Hub - Hệ Thống",
   Content = "Đang khởi chạy script, vui lòng chờ trong giây lát!",
   Duration = 5,
   Image = 4483362458,
}) loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))() end)
AddScript(UtilsTab, "Nameless Admin", "Stealth Admin", function() Rayfield:Notify({
   Title = "ThaiAn Hub - Hệ Thống",
   Content = "Đang khởi chạy script, vui lòng chờ trong giây lát!",
   Duration = 5,
   Image = 4483362458,
}) loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source'))() end)
AddScript(UtilsTab, "Infinite Yeild", "Best Script", function() Rayfield:Notify({
   Title = "ThaiAn Hub - Hệ Thống",
   Content = "Đang khởi chạy script, vui lòng chờ trong giây lát!",
   Duration = 5,
   Image = 4483362458,
}) loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
AddScript(UtilsTab, "Remote Spy", "Event Logger", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang kích hoạt Remote Spy...", Duration = 3})
    loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))() 
end)
AddScript(UtilsTab, "Dex Explorer", "Debug Tool", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang mở Dex Explorer...", Duration = 3})
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() 
end)

-- ================= THAIAN HUB - BẢN CẬP NHẬT TỔNG HỢP =================

-- 1. Nhóm Di Chuyển & Tiện Ích
AddScript(UtilsTab, "Emote Unlocker", "Mở khóa hành động", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang khởi chạy Emote Unlocker...", Duration = 3})
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
end)
AddScript(UtilsTab, "View Player", "Soi người chơi", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang mở bảng View Player...", Duration = 3})
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/cattimebhhf/cattimebhhf/main/Seeplayer'),true))()
end)
AddScript(UtilsTab, "Gravity UI", "Chỉnh trọng lực", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang mở bảng Gravity UI...", Duration = 3})
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/0%20Graviy%20Trip%20Universal"))()
end)
AddScript(UtilsTab, "Wallhop", "Leo tường", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang kích hoạt Wallhop...", Duration = 3})
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fake-Ladder-Flick-And-Wallhop-Script-37199"))()
end)
AddScript(UtilsTab, "Shiftlock", "Khóa góc nhìn", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang tải Mobile Shiftlock...", Duration = 3})
    loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Mobile-Shiftlock-12348"))()
end)
-- 2. Nhóm PVP & Phá Đảo
AddScript(UtilsTab, "Godmode", "Bất tử (Universal)", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang thử kích hoạt Godmode...", Duration = 3})
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal"))()
end)
AddScript(UtilsTab, "Auto Jump", "Tự động nhảy", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang bật Auto Jump...", Duration = 3})
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nguyenphuc888999666-code/Auto-jump-Ph-c/main/Auto%20jump"))()
end)
AddScript(UtilsTab, "Super Fling", "Làm văng cực mạnh", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang kích hoạt Touch Fling...", Duration = 3})
    loadstring(game:HttpGet("https://raw.githubusercontent.com/long191910/all-my-roblox-script/refs/heads/main/touchfling.lua"))()
end)
AddScript(UtilsTab, "Hitbox Expander", "Tăng tầm đánh", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang mở rộng Hitbox...", Duration = 3})
    loadstring(game:HttpGet("https://pastefy.app/ItfO0tdg/raw"))()
end)
AddScript(UtilsTab, "Fake Lag", "Tạo lag giả", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang bật Fake Lag...", Duration = 3})
    loadstring(game:HttpGet("https://pastebin.com/raw/w6PfESuz"))() end)
AddScript(UtilsTab, "Fake Dead", "Giả chết", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Bạn đã chết (giả)!", Duration = 3})
    loadstring(game:HttpGet("https://pastefy.app/ssXUg0ng/raw", true))()
end)
    
    -- ================= NHÓM TÍNH NĂNG HỆ THỐNG (LOCAL) =================
-- 1. FPS Booster
AddScript(UtilsTab, "FPS Booster", "Tối ưu mượt game", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đang tối ưu đồ họa...", Duration = 3})
    local settings = settings()
    settings.Network.IncomingReplicationLag = 0
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
    game:GetService("Lighting").GlobalShadows = false
end)

-- 4. Noclip
AddScript(UtilsTab, "Noclip", "Đi xuyên tường", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Noclip đã được bật!", Duration = 3})
    local Noclipping = nil
    Noclipping = game:GetService("RunService").Stepped:Connect(function()
        if game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- 6. Click TP
AddScript(UtilsTab, "Click TP", "Dùng Tool để dịch chuyển", function() 
    Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã thêm Tool Dịch Chuyển vào túi đồ!", Duration = 3})
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "ThaiAn TP Tool"
    tool.Activated:Connect(function()
        local pos = mouse.Hit.p + Vector3.new(0, 3, 0)
        game.Players.LocalPlayer.Character:MoveTo(pos)
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

-- ================= TAB 4: VISUALS =================


local VisualTab = Window:CreateTab("Visuals", 4483362458)

-- 1. Tâm ngắm tùy chỉnh (Toggle)
VisualTab:CreateToggle({
   Name = "Custom Crosshair",
   CurrentValue = false,
   Flag = "CrosshairToggle", 
   Callback = function(Value)
      if Value then
         if not game.CoreGui:FindFirstChild("ThaiAnCrosshair") then
            local CrosshairGui = Instance.new("ScreenGui", game.CoreGui)
            CrosshairGui.Name = "ThaiAnCrosshair"; CrosshairGui.IgnoreGuiInset = true
            local H = Instance.new("Frame", CrosshairGui); H.BackgroundColor3 = Color3.fromRGB(255, 0, 0); H.BorderSizePixel = 0
            H.Position = UDim2.new(0.5, -10, 0.5, 0); H.Size = UDim2.new(0, 20, 0, 2)
            local V = Instance.new("Frame", CrosshairGui); V.BackgroundColor3 = Color3.fromRGB(255, 0, 0); V.BorderSizePixel = 0
            V.Position = UDim2.new(0.5, 0, 0.5, -10); V.Size = UDim2.new(0, 2, 0, 20)
            Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã bật tâm ngắm!", Duration = 2})
         end
      else
         if game.CoreGui:FindFirstChild("ThaiAnCrosshair") then game.CoreGui:FindFirstChild("ThaiAnCrosshair"):Destroy() end
      end
   end,
})

-- 2. Field of View (Slider)
VisualTab:CreateSlider({
   Name = "Field of View (FOV)",
   Range = {70, 120},
   Increment = 1,
   Suffix = "°",
   CurrentValue = 70,
   Flag = "FOVSlider",
   Callback = function(Value) workspace.CurrentCamera.FieldOfView = Value end,
})

-- 3. No Fog (Button)
VisualTab:CreateButton({
   Name = "No Fog",
   Callback = function()
      game:GetService("Lighting").FogEnd = 9e9
      for _, v in pairs(game:GetService("Lighting"):GetDescendants()) do if v:IsA("Atmosphere") then v:Destroy() end end
      Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã xóa sương mù!", Duration = 2})
   end,
})

-- 4. Infinite Zoom (Button)
VisualTab:CreateButton({
   Name = "Infinite Zoom",
   Callback = function()
      game.Players.LocalPlayer.CameraMaxZoomDistance = 1000000
      Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã mở khóa Zoom!", Duration = 2})
   end,
})

-- 5. Full Bright (Button)
VisualTab:CreateButton({
   Name = "Full Bright",
   Callback = function()
      game:GetService("Lighting").Brightness = 2
      game:GetService("Lighting").ClockTime = 14
      game:GetService("Lighting").GlobalShadows = false
      Rayfield:Notify({Title = "ThaiAn Hub", Content = "Đã làm sáng map!", Duration = 2})
   end,
})

-- Giao diện Stats (FPS & Ping) Chill
VisualTab:CreateToggle({
   Name = "Show FPS & Ping",
   CurrentValue = false,
   Flag = "StatsToggle",
   Callback = function(Value)
      _G.ShowStats = Value
      if Value then
         local S = Instance.new("ScreenGui", game.CoreGui); S.Name = "ThaiAnStats"
         local F = Instance.new("Frame", S)
         F.Size = UDim2.new(0, 140, 0, 40)
         F.Position = UDim2.new(0, 20, 0, 20)
         F.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
         F.BackgroundTransparency = 0.2
         F.BorderSizePixel = 0
         Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8) -- Bo góc
         local Stroke = Instance.new("UIStroke", F); Stroke.Color = Color3.fromRGB(255, 255, 255); Stroke.Transparency = 0.8
         
         local L = Instance.new("TextLabel", F)
         L.Size = UDim2.new(1, 0, 1, 0)
         L.BackgroundTransparency = 1
         L.TextColor3 = Color3.new(1, 1, 1)
         L.Font = Enum.Font.GothamMedium
         L.TextSize = 13
         
         task.spawn(function()
            while _G.ShowStats do
               local fps = math.floor(1/game:GetService("RunService").RenderStepped:Wait())
               local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")
               L.Text = "⚡ FPS: " .. fps .. " | 🌐 PING: " .. ping .. "ms"
               task.wait(0.5)
            end
            S:Destroy()
         end)
      end
   end,
})

-- Stats & Keybinds phong cách Rayfield
local function CreateRayfieldFrame(Name, Size, Pos)
    local G = Instance.new("ScreenGui", game.CoreGui); G.Name = Name
    local F = Instance.new("Frame", G)
    F.Size = Size; F.Position = Pos
    F.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Màu nền Rayfield
    F.BorderSizePixel = 0
    local Corner = Instance.new("UICorner", F); Corner.CornerRadius = UDim.new(0, 6)
    local Stroke = Instance.new("UIStroke", F); Stroke.Color = Color3.fromRGB(60, 60, 60); Stroke.Thickness = 1
    return G, F
end

-- 1. Show Stats (FPS & Ping)
VisualTab:CreateToggle({
   Name = "Show Stats",
   CurrentValue = false,
   Callback = function(Value)
      _G.ShowStats = Value
      if Value then
         local G, F = CreateRayfieldFrame("ThaiAnStats", UDim2.new(0, 160, 0, 35), UDim2.new(0, 50, 0, 50))
         local L = Instance.new("TextLabel", F)
         L.Size = UDim2.new(1, 0, 1, 0); L.BackgroundTransparency = 1; L.Font = Enum.Font.GothamSemibold
         L.TextColor3 = Color3.fromRGB(240, 240, 240); L.TextSize = 12
         task.spawn(function()
            while _G.ShowStats do
               local fps = math.floor(1/game:GetService("RunService").RenderStepped:Wait())
               local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString():match("%d+")
               L.Text = "FPS: " .. fps .. "  |  PING: " .. ping .. "ms"
               task.wait(0.5)
            end
            G:Destroy()
         end)
      end
   end,
})

-- 2. Keybinds Status
VisualTab:CreateToggle({
   Name = "Show Active Keybinds",
   CurrentValue = false,
   Callback = function(Value)
      _G.ShowKeybinds = Value
      if Value then
         local G, F = CreateRayfieldFrame("ThaiAnKB", UDim2.new(0, 180, 0, 130), UDim2.new(1, -230, 0.4, 0))
         local T = Instance.new("TextLabel", F)
         T.Size = UDim2.new(1, 0, 0, 30); T.Text = "STATUS INDICATOR"; T.Font = Enum.Font.GothamBold
         T.TextColor3 = Color3.fromRGB(255, 255, 255); T.TextSize = 11; T.BackgroundTransparency = 1
         
         local C = Instance.new("Frame", F); C.Position = UDim2.new(0, 0, 0, 30); C.Size = UDim2.new(1, 0, 1, -35); C.BackgroundTransparency = 1
         Instance.new("UIListLayout", C).Padding = UDim.new(0, 3)

         local function Add(N, V)
            local l = Instance.new("TextLabel", C)
            l.Size = UDim2.new(1, 0, 0, 20); l.BackgroundTransparency = 1; l.Font = Enum.Font.Gotham; l.TextSize = 12
            task.spawn(function()
               while _G.ShowKeybinds do
                  local on = _G[V]; l.Text = "  " .. N .. (on and " : ENABLED" or " : DISABLED")
                  l.TextColor3 = on and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(150, 150, 150)
                  task.wait(0.5)
               end
            end)
         end
         Add("Ball Magnet", "Magnet"); Add("Super Ring", "SuperRing"); Add("Super Bang", "BangActive"); Add("Sit Head", "SitHead")
      else
         if game.CoreGui:FindFirstChild("ThaiAnKB") then game.CoreGui.ThaiAnKB:Destroy() end
      end
   end,
})


-- 7. Rainbow Character (Toggle)
VisualTab:CreateToggle({
   Name = "Rainbow Character",
   CurrentValue = false,
   Flag = "RainbowToggle",
   Callback = function(Value)
      _G.RainbowBody = Value
      task.spawn(function()
         while _G.RainbowBody do
            local char = game.Players.LocalPlayer.Character
            if char then
               local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
               for _, v in pairs(char:GetChildren()) do if v:IsA("BasePart") then v.Color = color end end
            end
            task.wait(0.1)
         end
      end)
   end,
})

-- 8. Time Changer (Slider)
VisualTab:CreateSlider({
   Name = "Time Changer",
   Range = {0, 24},
   Increment = 1,
   Suffix = "h",
   CurrentValue = 12,
   Flag = "TimeSlider",
   Callback = function(Value) game:GetService("Lighting").ClockTime = Value end,
})

-- Crosshair đồng bộ phong cách Rayfield
VisualTab:CreateToggle({
   Name = "Custom Crosshair",
   CurrentValue = false,
   Flag = "CrosshairToggle", 
   Callback = function(Value)
      if Value then
         local G = Instance.new("ScreenGui", game.CoreGui); G.Name = "ThaiAnCH"
         local H = Instance.new("Frame", G)
         H.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Màu trắng cho sang
         H.BackgroundTransparency = 0.2
         H.Size = UDim2.new(0, 18, 0, 2)
         H.Position = UDim2.new(0.5, 0, 0.5, 0)
         H.AnchorPoint = Vector2.new(0.5, 0.5)
         H.BorderSizePixel = 0
         
         local V = Instance.new("Frame", G)
         V.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         V.BackgroundTransparency = 0.2
         V.Size = UDim2.new(0, 2, 0, 18)
         V.Position = UDim2.new(0.5, 0, 0.5, 0)
         V.AnchorPoint = Vector2.new(0.5, 0.5)
         V.BorderSizePixel = 0
         
         -- Thêm chấm nhỏ ở giữa (Dot) cho pro
         local Dot = Instance.new("Frame", G)
         Dot.Size = UDim2.new(0, 2, 0, 2)
         Dot.Position = UDim2.new(0.5, 0, 0.5, 0)
         Dot.AnchorPoint = Vector2.new(0.5, 0.5)
         Dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
         Dot.BorderSizePixel = 0
      else
         if game.CoreGui:FindFirstChild("ThaiAnCH") then game.CoreGui.ThaiAnCH:Destroy() end
      end
   end,
})

-- ================= TAB 5: Aimbot & ESP =================
local AimTab = Window:CreateTab("Aimbot & ESP", 4483362458)

AimTab:CreateSection("Aimbot Thông Minh")
AimTab:CreateToggle({ Name = "Bật Aimbot", CurrentValue = false, Callback = function(v) getgenv().Aimbot = v end })
AimTab:CreateToggle({ Name = "Wall Check (Chống ngắm xuyên tường)", CurrentValue = false, Callback = function(v) getgenv().WallCheck = v end })
AimTab:CreateDropdown({
   Name = "Bộ phận ngắm",
   Options = {"Head", "HumanoidRootPart"},
   CurrentOption = "Head",
   Callback = function(Option) getgenv().AimPart = Option end,
})
AimTab:CreateSlider({ Name = "Độ mượt (Smoothness)", Range = {0.1, 1}, Increment = 0.1, CurrentValue = 0.2, Callback = function(v) getgenv().Smoothness = v end })
AimTab:CreateToggle({ Name = "Hiện FOV", CurrentValue = false, Callback = function(v) getgenv().ShowFOV = v end })
AimTab:CreateSlider({ Name = "Kích thước FOV", Range = {10, 600}, Increment = 1, CurrentValue = 150, Callback = function(v) getgenv().FOVSize = v end })

AimTab:CreateSection("ESP Nâng Cao")
AimTab:CreateToggle({ Name = "Skeleton ESP (Bộ xương)", CurrentValue = false, Callback = function(v) getgenv().Skeleton_ESP = v end })
AimTab:CreateToggle({ Name = "View Forward (Hướng nhìn)", CurrentValue = false, Callback = function(v) getgenv().ViewForward_ESP = v end })

AimTab:CreateSection("ESP Cơ Bản")
AimTab:CreateToggle({ Name = "Highlight (Khung)", CurrentValue = false, Callback = function(v) getgenv().ESP_Highlight = v end })
AimTab:CreateToggle({ Name = "Tracer (Đường kẻ)", CurrentValue = false, Callback = function(v) getgenv().ESP_Tracer = v end })
AimTab:CreateToggle({ Name = "Name & Distance", CurrentValue = false, Callback = function(v) getgenv().ESP_Name = v end })

-- =========================================================
-- 2. LOGIC XỬ LÝ (DÁN VÀO CUỐI SCRIPT)
-- =========================================================

-- Biến mặc định để tránh lỗi
getgenv().AimPart = "Head"
getgenv().WallCheck = false

-- Hàm kiểm tra vật cản
local function IsVisible(target)
    if not getgenv().WallCheck then return true end
    local char = target.Character
    local part = char and (char:FindFirstChild(getgenv().AimPart) or char:FindFirstChild("HumanoidRootPart"))
    if not part then return false end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LP.Character, char}
    local res = workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, params)
    return res == nil
end

-- Hàm tạo đường kẻ Drawing mượt
local function CreateLine(color)
    local l = Drawing.new("Line")
    l.Visible = false; l.Color = color or Color3.new(1, 1, 1); l.Thickness = 1.5; l.Transparency = 1; l.ZIndex = 999
    return l
end

-- Logic ESP Tổng Hợp
local function ApplyAdvESP(plr)
    local viewLine = CreateLine(Color3.fromRGB(255, 0, 0))
    local skel = {H2T = CreateLine(), UT2LA = CreateLine(), UT2RA = CreateLine(), T2LL = CreateLine(), T2RL = CreateLine()}

    game:GetService("RunService").RenderStepped:Connect(function()
        if plr.Character and plr ~= LP and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.Humanoid.Health > 0 then
            -- Xử lý View Forward
            if getgenv().ViewForward_ESP then
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local s, os = Camera:WorldToViewportPoint(head.Position)
                    local e, os2 = Camera:WorldToViewportPoint(head.Position + (head.CFrame.LookVector * 15))
                    if os and os2 then viewLine.Visible = true; viewLine.From = Vector2.new(s.X, s.Y); viewLine.To = Vector2.new(e.X, e.Y) else viewLine.Visible = false end
                end
            else viewLine.Visible = false end

            -- Xử lý Skeleton
            if getgenv().Skeleton_ESP then
                pcall(function()
                    local char = plr.Character
                    local head = char.Head.Position
                    local torso = (char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")).Position
                    local la = (char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")).Position
                    local ra = (char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")).Position
                    local ll = (char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")).Position
                    local rl = (char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")).Position
                    local function Conn(line, p1, p2)
                        local v1, os1 = Camera:WorldToViewportPoint(p1)
                        local v2, os2 = Camera:WorldToViewportPoint(p2)
                        if os1 and os2 then line.Visible = true; line.From = Vector2.new(v1.X, v1.Y); line.To = Vector2.new(v2.X, v2.Y) else line.Visible = false end
                    end
                    Conn(skel.H2T, head, torso); Conn(skel.UT2LA, torso, la); Conn(skel.UT2RA, torso, ra); Conn(skel.T2LL, torso, ll); Conn(skel.T2RL, torso, rl)
                end)
            else for _, l in pairs(skel) do l.Visible = false end end
        else viewLine.Visible = false; for _, l in pairs(skel) do l.Visible = false end end
    end)
end

-- Chạy ESP
for _, p in pairs(game.Players:GetPlayers()) do ApplyAdvESP(p) end
game.Players.PlayerAdded:Connect(ApplyAdvESP)

-- Logic Aimbot & FOV Loop
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Visible = getgenv().ShowFOV
    FOVCircle.Radius = getgenv().FOVSize
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    if getgenv().Aimbot then
        local target = nil; local closest = getgenv().FOVSize
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= LP and v.Character and v.Character:FindFirstChild(getgenv().AimPart) and v.Character.Humanoid.Health > 0 then
                if getgenv().TeamCheck and v.Team == LP.Team then continue end
                if not IsVisible(v) then continue end
                local pos, onScreen = Camera:WorldToViewportPoint(v.Character[getgenv().AimPart].Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < closest then closest = dist; target = v end
                end
            end
        end
        if target then 
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Character[getgenv().AimPart].Position), getgenv().Smoothness) 
        end
    end
end)

-- ================= TAB 6: BLOX FRUIT =================
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
AddScript(BF_Tab, "Xeter Hub", "Không key", function() getgenv().Version = "V3"
getgenv().Team = "Marines"
loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))() end)
AddScript(BF_Tab, "Auto Cyborg", "Không key", function() getgenv().Team = "Marines"
getgenv().Get_Race = "Cyborg"
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7a6c326e81861b3e1e7207c5d11ed755.lua"))() end)
AddScript(BF_Tab, "Auto Ghoul", "Không key", function() getgenv().Team = "Marines"
getgenv().Get_Race = "Ghoul"
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7a6c326e81861b3e1e7207c5d11ed755.lua"))() end)
AddScript(BF_Tab, "Gravity Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"))() end)
AddScript(BF_Tab, "Ngọc Bổng Hub", "Không key", function() getgenv().Team = "Marines"
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/NgocBong/refs/heads/main/NgocBongVn"))() end)
AddScript(BF_Tab, "Rubu Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/RubuRoblox/refs/heads/main/RubuBF"))() end)
AddScript(BF_Tab, "Đạt Thg Hub", "Không key", function() getgenv().Team = "Marines" loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/DatThg/refs/heads/main/DatThgV3Eng"))() end)
AddScript(BF_Tab, "Banana Hub(Kimpro)", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/kimprobloxdz/Banana-Free/refs/heads/main/Protected_5609200582002947.lua.txt"))() end)
AddScript(BF_Tab, "Trọng Nguyễn Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/trongnguyenhubbloxfruit/Cocaigidaumaphaiskid/refs/heads/main/TrongNguyenSTB.lua"))() end)
AddScript(BF_Tab, "Doraemon Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/KiddoHiru/BloxFruits/main/MasterHub.lua"))() end)
AddScript(BF_Tab, "Hoho Hub", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))() end)
AddScript(BF_Tab, "Kaitun Rip_indra", "Không key", function() getgenv().Config = {
Bosses = {
Farm = "rip_indra" -- "Dough King", "Darkbeard", "Tyrant of the Skies"
}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaAnarchist/3TOC-HUB/refs/heads/main/KaitunBoss.luau"))()
AddScript(BF_Tab, "Kaitun Dough King", "Không key", function() getgenv().Config = {
Bosses = {
Farm = "Dough King" -- "Dough King", "Darkbeard", "Tyrant of the Skies"
}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaAnarchist/3TOC-HUB/refs/heads/main/KaitunBoss.luau"))()
AddScript(BF_Tab, "Kaitun Darkbeard", "Không key", function() getgenv().Config = {
Bosses = {
Farm = "Darkbeard" -- "Dough King", "Darkbeard", "Tyrant of the Skies"
}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaAnarchist/3TOC-HUB/refs/heads/main/KaitunBoss.luau"))()

-- ================= TAB 7: 99 nights in the forest =================
local Night99Tab = Window:CreateTab("99 nights in the forest", 4483362458)
AddScript(Night99Tab, "Foxname", "Không key", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FNDayFarm.lua'))() end)
AddScript(Night99Tab, "Voidware", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))() end)
AddScript(Night99Tab, "H4x", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader2.lua", true))() end)
AddScript(Night99Tab, "Ringta", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/wehibuyfgyuwe/99nights.github.io/refs/heads/main/ringta.lua"))() end)
AddScript(Night99Tab, "Cps Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Rx1m/CpsHub/refs/heads/main/Hub",true))() end)
AddScript(Night99Tab, "Overhub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hellattexyss/autofarmdiamonds/main/overhubaurofarm.lua"))() end)

-- ================= TAB 8: THE FORGE =================
local Forge_Tab = Window:CreateTab("The Forge", 4483362458)
AddScript(Forge_Tab, "Catraz Hub", "Không có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/nurvian/Catraz-HUB/refs/heads/main/Catraz/main.lua"))() end)
AddScript(Forge_Tab, "No1 Hub", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/SkibidiHub111/Forge/refs/heads/main/No1Dev"))() end)
AddScript(Forge_Tab, "Mirage Hub", "Không có key", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/2075c39b9a5a2e4414c59c93fe8a5f06.lua"))() end)
AddScript(Forge_Tab,  "Lazy Hub", "Không có key", function() getgenv().mobileMode = true -- set true if ur on mobile device
repeat wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LioK251/RbScripts/refs/heads/main/lazyuhub_theforge.lua"))() end)
AddScript(Forge_Tab,  "Vxeze Hub", "Có key", function() loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/702a5c5488082e6f"))() end)
AddScript(Forge_Tab,  "Bonk Hub", "Có key", function() loadstring(game:HttpGet("https://bonkhub.online/loader.lua",true))() end)

-- ================= TAB 9: MM2 =================
local MM2_Tab = Window:CreateTab("MM2", 4483362458)
AddScript(MM2_Tab, "Capybara Hub", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/zorex321/capybara/refs/heads/main/Capybara-Hub",true))() end)
AddScript(MM2_Tab, "Nexus Hub", "Không có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/NexusScripts212/MurderMystery2/refs/heads/main/Mm2",true))() end)
AddScript(MM2_Tab, "Overdrive Hub", "Có key",  function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Overdrive-Hub-43383"))() end)
AddScript(MM2_Tab,  "XHub", "Không có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/bluedeal/Mm2.xhub/refs/heads/main/Mm2-KeylessV2"))() end)
AddScript(MM2_Tab,  "Vision Hub", "Không có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/orialdev/VisionHub/refs/heads/main/main.lua"))() end)

-- ================= TAB 10: BLUE LOCK RIVALS =================
local BlueLockTab = Window:CreateTab("Blue Lock", 4483362458)
AddScript(BlueLockTab, "Control Ball", "Không key", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Blue-Lock:-Rivals-Lock-Control-ball-32633"))() end)
AddScript(BlueLockTab, "Arbix Hub", "Không key và dễ bị ban", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Arbix--Hub/refs/heads/main/Blue!ock.lua"))() end)
AddScript(BlueLockTab, "Aztreon Hub", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/aal3-33/Hub/refs/heads/main/Gitscripts/aztreonhub.lua"))() end)
AddScript(BlueLockTab, "Omg Hub", "Có key", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua'))() end)

-- ================= TAB 11: FORSAKEN =================
local fsaken_Tab = Window:CreateTab("Forsaken", 4483362458)
AddScript(fsaken_Tab, "Bobby Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/BobJunior1/ForsakenBoi/refs/heads/main/B0bbyHub"))() end)
AddScript(fsaken_Tab, "Saryn Hub", "Không key", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Forsaken-Saryn-Hub-40752"))() end)
AddScript(fsaken_Tab, "Guesting Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/project/refs/heads/main/AutoBLOCKKKWAHV1"))() end)
AddScript(fsaken_Tab, "Vim Hub", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/zylosboom/ViMHub/refs/heads/main/vimHub.lua"))() end)
AddScript(fsaken_Tab, "Sigmasaken", "Không key", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Forsaken-Stamina-settings-for-forsaken-35367"))() end)

-- ================= TAB 12: FISCH =================
local fisch_Tab = Window:CreateTab("Fisch", 4483362458)
AddScript(fisch_Tab, "Shield Hub", "Không key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/KAN-FISCH/tesss/refs/heads/main/gunung/fish.lua"))() end)
AddScript(fisch_Tab, "Speed X", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))() end)
AddScript(fisch_Tab, "Than Hub", "Có key", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))() end)

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
