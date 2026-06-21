local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- Create loading GUI
local function createLoadingUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoaderUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 320, 0, 160)
    mainFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(255, 200, 50)
    stroke.Transparency = 0.3
    stroke.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "⚔️ LOADING AUTO FARM ⚔️"
    title.TextColor3 = Color3.fromRGB(255, 200, 50)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(0.9, 0, 0, 8)
    barBg.Position = UDim2.new(0.05, 0, 0, 60)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    barBg.BorderSizePixel = 0
    barBg.Parent = mainFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = barBg
    
    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = barFill
    
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 0, 80)
    status.BackgroundTransparency = 1
    status.Text = "Initializing..."
    status.TextColor3 = Color3.fromRGB(200, 200, 200)
    status.TextSize = 14
    status.Font = Enum.Font.Gotham
    status.Parent = mainFrame
    
    return screenGui, barFill, status
end

-- Main loader function
local function loadScript()
    local loadingUI, barFill, status = createLoadingUI()
    
    -- Update progress
    local function updateProgress(percentage, text)
        barFill.Size = UDim2.new(percentage / 100, 0, 1, 0)
        if text then
            status.Text = text
        end
        task.wait()
    end
    
    updateProgress(10, "Connecting to server...")
    task.wait(0.5)
    
    updateProgress(30, "Downloading script...")
    
    local success, result = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau")
    end)
    
    if not success or not result then
        updateProgress(100, "❌ Failed to download script")
        status.TextColor3 = Color3.fromRGB(255, 50, 50)
        task.wait(2)
        loadingUI:Destroy()
        return false
    end
    
    updateProgress(70, "Processing script...")
    task.wait(0.3)
    
    updateProgress(90, "Loading features...")
    task.wait(0.3)
    
    local loadSuccess, loadError = pcall(function()
        local func = loadstring(result)
        if func then
            func()
        else
            error("Failed to compile script")
        end
    end)
    
    if loadSuccess then
        updateProgress(100, "✅ Auto Farm Loaded Successfully!")
        status.TextColor3 = Color3.fromRGB(50, 255, 50)
        task.wait(1.5)
        loadingUI:Destroy()
        return true
    else
        updateProgress(100, "❌ Error: " .. tostring(loadError))
        status.TextColor3 = Color3.fromRGB(255, 50, 50)
        task.wait(3)
        loadingUI:Destroy()
        return false
    end
end

-- Execute loader
local loaded = loadScript()

if loaded then
    print("✅ Auto Farm Script Loaded Successfully!")
    print("📌 Click the sword icon to open the UI")
else
    print("❌ Failed to load Auto Farm Script")
    print("🔄 Retrying with alternative method...")
    
    -- Alternative loading method
    task.wait(1)
    local altSuccess = pcall(function()
        local scriptContent = game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau", true)
        local func = loadstring(scriptContent)
        if func then
            func()
            print("✅ Script loaded with alternative method!")
        end
    end)
    
    if not altSuccess then
        print("❌ All loading methods failed. Check your internet connection.")
        print("📝 You can also try loading the script manually:")
        print('   loadstring(game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau"))()')
    end
end
