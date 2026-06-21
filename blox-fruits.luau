--[[
    Auto Farm Loader Completo
    - Carrega em background
    - Inicia automaticamente
    - Mostra progresso
    - Tratamento de erros
]]

local player = game:GetService("Players").LocalPlayer

-- UI de carregamento
local gui = Instance.new("ScreenGui")
gui.Name = "AutoFarmLoader"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 100)
frame.Position = UDim2.new(0.5, -160, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(255, 200, 50)
stroke.Transparency = 0.3
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "⚔️ CARREGANDO AUTO FARM"
title.TextColor3 = Color3.fromRGB(255, 200, 50)
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0, 48)
status.BackgroundTransparency = 1
status.Text = "🔄 Inicializando..."
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.TextSize = 13
status.Font = Enum.Font.Gotham
status.Parent = frame

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.85, 0, 0, 4)
barBg.Position = UDim2.new(0.075, 0, 0.75, 0)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
barBg.BorderSizePixel = 0
barBg.Parent = frame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 2)
barCorner.Parent = barBg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 2)
fillCorner.Parent = barFill

-- Função principal de carregamento
local function loadInBackground()
    -- Atualizar progresso
    local function update(percent, text)
        barFill.Size = UDim2.new(percent / 100, 0, 1, 0)
        status.Text = text
        task.wait()
    end
    
    update(5, "🔄 Conectando...")
    task.wait(0.3)
    
    update(20, "📡 Baixando script...")
    
    -- Baixar script
    local ok, scriptContent = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau")
    end)
    
    if not ok or not scriptContent then
        update(100, "❌ Erro de conexão!")
        status.TextColor3 = Color3.fromRGB(255, 50, 50)
        return false
    end
    
    update(50, "⚙️ Processando...")
    task.wait(0.2)
    
    update(70, "🔧 Compilando...")
    task.wait(0.2)
    
    -- Executar
    local execOk, execErr = pcall(function()
        local func = loadstring(scriptContent)
        if func then
            func()
        else
            error("Falha na compilação")
        end
    end)
    
    if execOk then
        update(100, "✅ Auto Farm Iniciado!")
        status.TextColor3 = Color3.fromRGB(50, 255, 50)
        print("✅ Auto Farm carregado e iniciado com sucesso!")
        return true
    else
        update(100, "❌ Erro: " .. tostring(execErr))
        status.TextColor3 = Color3.fromRGB(255, 50, 50)
        warn("❌ Falha: " .. tostring(execErr))
        return false
    end
end

-- Executar em background
task.spawn(function()
    local loaded = loadInBackground()
    task.wait(2)
    gui:Destroy()
    
    if loaded then
        print("📌 Clique no ícone da espada para abrir a UI")
    else
        print("💡 Tente executar manualmente:")
        print('loadstring(game:HttpGet("https://raw.githubusercontent.com/005749-art/redz-new/main/blox-fruits.luau"))()')
    end
end)
