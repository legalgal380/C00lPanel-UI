--// C00lPanel UI Fluent Design v2.0
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local C00lUI = {}

-- Temas com cores mais modernas e suaves
local Themes = {
    ["Red"] = Color3.fromRGB(255, 99, 71),
    ["Green"] = Color3.fromRGB(72, 209, 204),
    ["Blue"] = Color3.fromRGB(100, 149, 237),
    ["Purple"] = Color3.fromRGB(147, 112, 219),
    ["Orange"] = Color3.fromRGB(255, 165, 0),
    ["Pink"] = Color3.fromRGB(255, 105, 180),
    ["Cyan"] = Color3.fromRGB(64, 224, 208),
    ["C00lgui"] = Color3.fromRGB(255, 99, 71),
    ["Dark"] = Color3.fromRGB(45, 45, 45),
    ["Light"] = Color3.fromRGB(240, 240, 240)
}

-- Animações suaves
local function CreateTween(object, properties, duration, easingStyle)
    duration = duration or 0.3
    easingStyle = easingStyle or Enum.EasingStyle.Quad
    local tween = TweenService:Create(object, TweenInfo.new(duration, easingStyle), properties)
    tween:Play()
    return tween
end

-- Função para criar efeitos de hover
local function AddHoverEffect(object, hoverColor, originalColor)
    object.MouseEnter:Connect(function()
        CreateTween(object, {BackgroundColor3 = hoverColor}, 0.2)
    end)
    
    object.MouseLeave:Connect(function()
        CreateTween(object, {BackgroundColor3 = originalColor}, 0.2)
    end)
end

-- Função para criar sombras (simuladas)
local function CreateShadow(parent)
    local Shadow = Instance.new("Frame")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 4, 1, 4)
    Shadow.Position = UDim2.new(0, 2, 0, 2)
    Shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    Shadow.BackgroundTransparency = 0.8
    Shadow.BorderSizePixel = 0
    Shadow.ZIndex = parent.ZIndex - 1
    Shadow.Parent = parent.Parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Shadow
    
    return Shadow
end

-- Função para fazer draggable com animação
function MakeDraggable(frame)
    local dragging, offset
    local originalPos = frame.Position
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            offset = input.Position - frame.AbsolutePosition
            CreateTween(frame, {Size = frame.Size + UDim2.new(0, 2, 0, 2)}, 0.1)
        end
    end)
    
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            CreateTween(frame, {Size = frame.Size - UDim2.new(0, 2, 0, 2)}, 0.1)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            frame.Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
        end
    end)
end

function C00lUI:CreateWindow(title, theme)
    theme = theme or "C00lgui"
    local color = Themes[theme] or Themes["C00lgui"]
    local darkColor = Color3.new(color.R * 0.7, color.G * 0.7, color.B * 0.7)
    
    -- ScreenGui principal
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "C00lPanelUI_Fluent"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false
    
    -- Frame principal com design moderno
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 580, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -290, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Cantos arredondados
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame
    
    -- Sombra
    CreateShadow(MainFrame)
    
    -- Stroke moderno
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = color
    Stroke.Transparency = 0.3
    Stroke.Parent = MainFrame
    
    MakeDraggable(MainFrame)
    
    -- Barra de título moderna
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = TitleBar
    
    -- Título
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title or "C00l UI - Fluent Design"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar
    
    -- Botão de fechar
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 95, 95)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextScaled = true
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = TitleBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    AddHoverEffect(CloseButton, Color3.fromRGB(255, 60, 60), Color3.fromRGB(255, 95, 95))
    
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Container para abas
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(0, 150, 1, -60)
    TabContainer.Position = UDim2.new(0, 10, 0, 60)
    TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabContainer
    
    -- Lista de abas
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.Parent = TabContainer
    
    -- Container de conteúdo
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -180, 1, -60)
    ContentFrame.Position = UDim2.new(0, 170, 0, 60)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Parent = ContentFrame
    
    -- Sistema de páginas
    local Pages = {}
    local Tabs = {}
    local CurrentTab = nil
    
    local function ShowPage(tabName)
        for name, page in pairs(Pages) do
            page.Visible = (name == tabName)
        end
        
        for name, tab in pairs(Tabs) do
            if name == tabName then
                CreateTween(tab, {BackgroundColor3 = color}, 0.2)
                tab.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                CreateTween(tab, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
                tab.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        
        CurrentTab = tabName
    end
    
    local function AddTab(tabName)
        -- Botão da aba
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 40)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextScaled = true
        TabButton.BorderSizePixel = 0
        TabButton.Parent = TabContainer
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 6)
        TabButtonCorner.Parent = TabButton
        
        Tabs[tabName] = TabButton
        
        -- Página da aba
        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 6
        Page.ScrollBarImageColor3 = color
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.Visible = false
        Page.Parent = ContentFrame
        
        -- Layout da página
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 10)
        PageLayout.Parent = Page
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.PaddingTop = UDim.new(0, 15)
        PagePadding.PaddingLeft = UDim.new(0, 15)
        PagePadding.PaddingRight = UDim.new(0, 15)
        PagePadding.PaddingBottom = UDim.new(0, 15)
        PagePadding.Parent = Page
        
        -- Atualizar canvas size automaticamente
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 30)
        end)
        
        Pages[tabName] = Page
        
        -- Evento do botão
        TabButton.MouseButton1Click:Connect(function()
            ShowPage(tabName)
        end)
        
        -- Hover effect
        AddHoverEffect(TabButton, Color3.fromRGB(50, 50, 50), Color3.fromRGB(40, 40, 40))
        
        -- Se é a primeira aba, mostrar por padrão
        if CurrentTab == nil then
            ShowPage(tabName)
        end
        
        return {
            AddButton = function(text, callback)
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 0, 45)
                Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Button.Text = text
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Font = Enum.Font.Gotham
                Button.TextSize = 14
                Button.BorderSizePixel = 0
                Button.Parent = Page
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 8)
                ButtonCorner.Parent = Button
                
                local ButtonStroke = Instance.new("UIStroke")
                ButtonStroke.Color = color
                ButtonStroke.Thickness = 1
                ButtonStroke.Transparency = 0.5
                ButtonStroke.Parent = Button
                
                AddHoverEffect(Button, Color3.fromRGB(60, 60, 60), Color3.fromRGB(45, 45, 45))
                
                Button.MouseButton1Click:Connect(function()
                    CreateTween(Button, {Size = Button.Size - UDim2.new(0, 4, 0, 4)}, 0.1)
                    wait(0.1)
                    CreateTween(Button, {Size = Button.Size + UDim2.new(0, 4, 0, 4)}, 0.1)
                    pcall(callback)
                end)
            end,
            
            AddToggle = function(text, default, callback)
                local state = default or false
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Parent = Page
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 8)
                ToggleCorner.Parent = ToggleFrame
                
                local ToggleStroke = Instance.new("UIStroke")
                ToggleStroke.Color = color
                ToggleStroke.Thickness = 1
                ToggleStroke.Transparency = 0.5
                ToggleStroke.Parent = ToggleFrame
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
                ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Text = text
                ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.Parent = ToggleFrame
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
                ToggleButton.BackgroundColor3 = state and color or Color3.fromRGB(80, 80, 80)
                ToggleButton.Text = ""
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Parent = ToggleFrame
                
                local ToggleButtonCorner = Instance.new("UICorner")
                ToggleButtonCorner.CornerRadius = UDim.new(0, 10)
                ToggleButtonCorner.Parent = ToggleButton
                
                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
                ToggleIndicator.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleIndicator.BorderSizePixel = 0
                ToggleIndicator.Parent = ToggleButton
                
                local IndicatorCorner = Instance.new("UICorner")
                IndicatorCorner.CornerRadius = UDim.new(0, 8)
                IndicatorCorner.Parent = ToggleIndicator
                
                ToggleButton.MouseButton1Click:Connect(function()
                    state = not state
                    
                    CreateTween(ToggleButton, {BackgroundColor3 = state and color or Color3.fromRGB(80, 80, 80)}, 0.2)
                    CreateTween(ToggleIndicator, {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}, 0.2)
                    
                    pcall(callback, state)
                end)
            end,
            
            AddTextBox = function(placeholder, callback)
                local TextBoxFrame = Instance.new("Frame")
                TextBoxFrame.Size = UDim2.new(1, 0, 0, 45)
                TextBoxFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                TextBoxFrame.BorderSizePixel = 0
                TextBoxFrame.Parent = Page
                
                local TextBoxCorner = Instance.new("UICorner")
                TextBoxCorner.CornerRadius = UDim.new(0, 8)
                TextBoxCorner.Parent = TextBoxFrame
                
                local TextBoxStroke = Instance.new("UIStroke")
                TextBoxStroke.Color = color
                TextBoxStroke.Thickness = 1
                TextBoxStroke.Transparency = 0.5
                TextBoxStroke.Parent = TextBoxFrame
                
                local TextBox = Instance.new("TextBox")
                TextBox.Size = UDim2.new(1, -20, 1, 0)
                TextBox.Position = UDim2.new(0, 10, 0, 0)
                TextBox.BackgroundTransparency = 1
                TextBox.PlaceholderText = placeholder
                TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.Font = Enum.Font.Gotham
                TextBox.TextSize = 14
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                TextBox.Parent = TextBoxFrame
                
                TextBox.Focused:Connect(function()
                    CreateTween(TextBoxStroke, {Transparency = 0}, 0.2)
                end)
                
                TextBox.FocusLost:Connect(function(enter)
                    CreateTween(TextBoxStroke, {Transparency = 0.5}, 0.2)
                    if enter then
                        pcall(callback, TextBox.Text)
                    end
                end)
            end,
            
            AddLabel = function(text)
                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 0, 35)
                Label.BackgroundTransparency = 1
                Label.Text = text
                Label.TextColor3 = Color3.fromRGB(200, 200, 200)
                Label.Font = Enum.Font.Gotham
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = Page
            end,
            
            AddSlider = function(text, min, max, default, callback)
                local value = default or min
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Size = UDim2.new(1, 0, 0, 60)
                SliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                SliderFrame.BorderSizePixel = 0
                SliderFrame.Parent = Page
                
                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 8)
                SliderCorner.Parent = SliderFrame
                
                local SliderStroke = Instance.new("UIStroke")
                SliderStroke.Color = color
                SliderStroke.Thickness = 1
                SliderStroke.Transparency = 0.5
                SliderStroke.Parent = SliderFrame
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Size = UDim2.new(1, -20, 0, 25)
                SliderLabel.Position = UDim2.new(0, 10, 0, 5)
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Text = text .. ": " .. tostring(value)
                SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.Parent = SliderFrame
                
                local SliderTrack = Instance.new("Frame")
                SliderTrack.Size = UDim2.new(1, -20, 0, 6)
                SliderTrack.Position = UDim2.new(0, 10, 0, 35)
                SliderTrack.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Parent = SliderFrame
                
                local TrackCorner = Instance.new("UICorner")
                TrackCorner.CornerRadius = UDim.new(0, 3)
                TrackCorner.Parent = SliderTrack
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                SliderFill.BackgroundColor3 = color
                SliderFill.BorderSizePixel = 0
                SliderFill.Parent = SliderTrack
                
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(0, 3)
                FillCorner.Parent = SliderFill
                
                local SliderButton = Instance.new("TextButton")
                SliderButton.Size = UDim2.new(0, 16, 0, 16)
                SliderButton.Position = UDim2.new((value - min) / (max - min), -8, 0, -5)
                SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderButton.Text = ""
                SliderButton.BorderSizePixel = 0
                SliderButton.Parent = SliderTrack
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 8)
                ButtonCorner.Parent = SliderButton
                
                local dragging = false
                
                SliderButton.MouseButton1Down:Connect(function()
                    dragging = true
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local percent = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                        value = math.floor(min + (max - min) * percent)
                        
                        CreateTween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
                        CreateTween(SliderButton, {Position = UDim2.new(percent, -8, 0, -5)}, 0.1)
                        
                        SliderLabel.Text = text .. ": " .. tostring(value)
                        pcall(callback, value)
                    end
                end)
            end
        }
    end
    
    return {
        AddTab = AddTab,
        ChangeTheme = function(newTheme)
            if Themes[newTheme] then
                color = Themes[newTheme]
                Stroke.Color = color
                -- Atualizar outras cores conforme necessário
            end
        end,
        Minimize = function()
            local minimized = MainFrame.Size.Y.Offset <= 60
            if minimized then
                CreateTween(MainFrame, {Size = UDim2.new(0, 580, 0, 400)}, 0.3)
            else
                CreateTween(MainFrame, {Size = UDim2.new(0, 580, 0, 50)}, 0.3)
            end
        end,
        Destroy = function()
            CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
            wait(0.3)
            ScreenGui:Destroy()
        end
    }
end

return C00lUI
