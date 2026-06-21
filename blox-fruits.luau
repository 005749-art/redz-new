-- Function to safely load and execute script
local function loadScript()
    local success, result = pcall(function()
        -- Load the script from the URL
        local scriptContent = game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau")
        if scriptContent and scriptContent ~= "" then
            -- Execute the loaded script
            local func = loadstring(scriptContent)
            if func then
                func()
                return true
            end
        end
        return false
    end)
    
    return success and result or false
end

-- Create a loading GUI
local function createLoadingUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LoaderGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
    
    -- Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 300, 0, 150)
    bg.Position = UDim2.new(0.5, -150, 0.5, -75)
    bg.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    bg.BackgroundTransparency = 0.2
    bg.BorderSizePixel = 0
    bg.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = bg
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "⚔️ LOADING AUTO FARM ⚔️"
    title.TextColor3 = Color3.fromRGB(255, 200, 50)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.Parent = bg
    
    -- Loading bar background
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(0.9, 0, 0, 8)
    barBg.Position = UDim2.new(0.05, 0, 0, 60)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    barBg.BorderSizePixel = 0
    barBg.Parent = bg
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = barBg
    
    -- Loading bar fill
    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = barFill
    
    -- Status text
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 0, 80)
    status.BackgroundTransparency = 1
    status.Text = "Connecting to server..."
    status.TextColor3 = Color3.fromRGB(200, 200, 200)
    status.TextSize = 14
    status.Font = Enum.Font.Gotham
    status.Parent = bg
    
    -- Animate loading bar
    local progress = 0
    local loadCoroutine = coroutine.create(function()
        while progress < 100 do
            progress = progress + math.random(2, 5)
            if progress > 100 then progress = 100 end
            barFill.Size = UDim2.new(progress / 100, 0, 1, 0)
            
            if progress < 30 then
                status.Text = "Connecting to server..."
            elseif progress < 60 then
                status.Text = "Downloading script..."
            elseif progress < 80 then
                status.Text = "Processing script..."
            elseif progress < 100 then
                status.Text = "Loading features..."
            else
                status.Text = "✅ Loading complete!"
            end
            
            task.wait(0.05)
        end
    end)
    
    coroutine.resume(loadCoroutine)
    
    return screenGui, barFill, status
end

-- Main execution
local function main()
    -- Create loading UI
    local loadingUI, barFill, status = createLoadingUI()
    
    -- Wait for game to fully load
    task.wait(1)
    
    -- Attempt to load the script
    local loaded = false
    local attempts = 0
    
    while not loaded and attempts < 3 do
        attempts = attempts + 1
        status.Text = "Attempt " .. attempts .. " of 3..."
        
        loaded = loadScript()
        
        if not loaded then
            task.wait(1)
        end
    end
    
    -- Update loading UI
    if loaded then
        barFill.Size = UDim2.new(1, 0, 1, 0)
        status.Text = "✅ Auto Farm Loaded Successfully!"
        status.TextColor3 = Color3.fromRGB(50, 255, 50)
    else
        status.Text = "❌ Failed to load script"
        status.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        -- Try alternative loading method
        status.Text = "Trying alternative method..."
        task.wait(1)
        
        -- Alternative: Try using the script directly
        local success = pcall(function()
            local scriptContent = game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau", true)
            if scriptContent and scriptContent ~= "" then
                local func = loadstring(scriptContent)
                if func then
                    func()
                    loaded = true
                    barFill.Size = UDim2.new(1, 0, 1, 0)
                    status.Text = "✅ Auto Farm Loaded Successfully!"
                    status.TextColor3 = Color3.fromRGB(50, 255, 50)
                end
            end
        end)
        
        if not loaded then
            status.Text = "❌ Failed to load. Check your internet connection."
            status.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    end
    
    -- Remove loading UI after 3 seconds if successful, or keep it to show error
    if loaded then
        task.wait(3)
        loadingUI:Destroy()
    else
        -- Add a retry button
        local retryBtn = Instance.new("TextButton")
        retryBtn.Size = UDim2.new(0.4, 0, 0, 35)
        retryBtn.Position = UDim2.new(0.3, 0, 0, 115)
        retryBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
        retryBtn.Text = "Retry"
        retryBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        retryBtn.TextSize = 14
        retryBtn.Font = Enum.Font.GothamBold
        retryBtn.BorderSizePixel = 0
        retryBtn.Parent = loadingUI:FindFirstChild("LoaderGUI") or loadingUI
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = retryBtn
        
        retryBtn.MouseButton1Click:Connect(function()
            loadingUI:Destroy()
            task.wait(0.5)
            main()
        end)
    end
end

-- Start the loader
pcall(main)

-- Print instructions
print("=== DELTA EXECUTOR LOADER ===")
print("Loading Blox Fruits Auto Farm Script...")
print("Source: https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau")
print("===============================")
Alternative Simple Loader (if the above doesn't work):
lua
-- Simple loader for Delta Executor
local success, err = pcall(function()
    local script = game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau")
    loadstring(script)()
end)

if success then
    print("✅ Script loaded successfully!")
else
    print("❌ Error loading script: " .. tostring(err))
    
    -- Try with different method
    local success2, err2 = pcall(function()
        local script = game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau", true)
        loadstring(script)()
    end)
    
    if success2 then
        print("✅ Script loaded successfully with alternative method!")
    else
        print("❌ Failed to load script: " .. tostring(err2))
        print("Check your internet connection or the script URL.")
    end
end
