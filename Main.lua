--// C00lPanel UI Base v1.1 (com UIStroke vermelho, botões, toggle, textbox)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local C00lUI = {}

local Themes = {
    ["Red"] = Color3.fromRGB(255, 65, 65),
    ["Green"] = Color3.fromRGB(65, 255, 144),
    ["Blue"] = Color3.fromRGB(65, 165, 255),
    ["Purple"] = Color3.fromRGB(160, 65, 255),
    ["C00lgui"] = Color3.fromRGB(255, 65, 65), -- COR VERMELHA ORIGINAL
}

function MakeDraggable(frame)
    local dragging, offset
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            offset = input.Position - frame.AbsolutePosition
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
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

    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "C00lPanelUI"

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    MainFrame.BorderSizePixel = 0
    MakeDraggable(MainFrame)

    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Thickness = 2
    Stroke.Color = color

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = title or "C00l UI"
    Title.TextColor3 = color
    Title.TextScaled = true
    Title.Font = Enum.Font.Code

    local TabFrame = Instance.new("Frame", MainFrame)
    TabFrame.Size = UDim2.new(1, 0, 0, 30)
    TabFrame.Position = UDim2.new(0, 0, 0, 30)
    TabFrame.BackgroundTransparency = 1

    local Pages = {}
    local CurrentPage = 1

    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.Size = UDim2.new(1, -10, 1, -80)
    ContentFrame.Position = UDim2.new(0, 5, 0, 70)
    ContentFrame.BackgroundTransparency = 1

    local function ShowPage(index)
        for i, page in ipairs(Pages) do
            page.Visible = (i == index)
        end
        CurrentPage = index
    end

    local Left = Instance.new("TextButton", MainFrame)
    Left.Text = "<"
    Left.Size = UDim2.new(0, 30, 0, 30)
    Left.Position = UDim2.new(0, 10, 1, -40)
    Left.BackgroundColor3 = Color3.new(0, 0, 0)
    Left.TextColor3 = color
    Left.Font = Enum.Font.Code
    Left.TextScaled = true

    local Right = Instance.new("TextButton", MainFrame)
    Right.Text = ">"
    Right.Size = UDim2.new(0, 30, 0, 30)
    Right.Position = UDim2.new(1, -40, 1, -40)
    Right.BackgroundColor3 = Color3.new(0, 0, 0)
    Right.TextColor3 = color
    Right.Font = Enum.Font.Code
    Right.TextScaled = true

    Left.MouseButton1Click:Connect(function()
        if CurrentPage > 1 then
            ShowPage(CurrentPage - 1)
        end
    end)

    Right.MouseButton1Click:Connect(function()
        if CurrentPage < #Pages then
            ShowPage(CurrentPage + 1)
        end
    end)

    local function AddTab(tabName)
        local Button = Instance.new("TextButton", TabFrame)
        Button.Size = UDim2.new(0, 100, 1, 0)
        Button.Position = UDim2.new(0, #TabFrame:GetChildren() * 105, 0, 0)
        Button.BackgroundColor3 = Color3.new(0, 0, 0)
        Button.Text = tabName
        Button.TextColor3 = color
        Button.Font = Enum.Font.Code
        Button.TextScaled = true

        local TabPages = {}

        local function AddPage()
            local Page = Instance.new("Frame", ContentFrame)
            Page.Size = UDim2.new(1, 0, 1, 0)
            Page.Visible = false
            Page.BackgroundTransparency = 1
            table.insert(Pages, Page)
            table.insert(TabPages, Page)

            return {
                AddButton = function(text, callback)
                    local Button = Instance.new("TextButton", Page)
                    Button.Size = UDim2.new(0, 200, 0, 40)
                    Button.Position = UDim2.new(0, 10, 0, 10 + (#Page:GetChildren() * 45))
                    Button.BackgroundColor3 = Color3.new(0, 0, 0)
                    Button.Text = text
                    Button.TextColor3 = Color3.new(1, 1, 1)
                    Button.Font = Enum.Font.Code
                    Button.TextScaled = true

                    local Stroke = Instance.new("UIStroke", Button)
                    Stroke.Color = color

                    Button.MouseButton1Click:Connect(function()
                        pcall(callback)
                    end)
                end,

                AddToggle = function(text, default, callback)
                    local state = default
                    local Toggle = Instance.new("TextButton", Page)
                    Toggle.Size = UDim2.new(0, 200, 0, 40)
                    Toggle.Position = UDim2.new(0, 10, 0, 10 + (#Page:GetChildren() * 45))
                    Toggle.BackgroundColor3 = Color3.new(0, 0, 0)
                    Toggle.TextColor3 = Color3.new(1, 1, 1)
                    Toggle.Font = Enum.Font.Code
                    Toggle.TextScaled = true
                    Toggle.Text = text .. ": " .. tostring(state)

                    local Stroke = Instance.new("UIStroke", Toggle)
                    Stroke.Color = color

                    Toggle.MouseButton1Click:Connect(function()
                        state = not state
                        Toggle.Text = text .. ": " .. tostring(state)
                        pcall(callback, state)
                    end)
                end,

                AddTextBox = function(placeholder, callback)
                    local Box = Instance.new("TextBox", Page)
                    Box.Size = UDim2.new(0, 200, 0, 40)
                    Box.Position = UDim2.new(0, 10, 0, 10 + (#Page:GetChildren() * 45))
                    Box.PlaceholderText = placeholder
                    Box.BackgroundColor3 = Color3.new(0, 0, 0)
                    Box.TextColor3 = Color3.new(1, 1, 1)
                    Box.Font = Enum.Font.Code
                    Box.TextScaled = true

                    local Stroke = Instance.new("UIStroke", Box)
                    Stroke.Color = color

                    Box.FocusLost:Connect(function(enter)
                        if enter then
                            pcall(callback, Box.Text)
                        end
                    end)
                end
            }
        end

        Button.MouseButton1Click:Connect(function()
            ShowPage(#Pages - #TabPages + 1)
        end)

        return {
            AddPage = AddPage
        }
    end

    return {
        AddTab = AddTab
    }
end

return C00lUI
