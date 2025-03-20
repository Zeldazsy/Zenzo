local Notification = {}
Notification.__index = Notification

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = playerGui:FindFirstChild("NotificationGui") or Instance.new("ScreenGui")
screenGui.Name = "NotificationGui"
screenGui.Parent = playerGui

local Notifications = {}  -- Add this line to define the Notifications table

function Notification.new(text, duration)
    local duration = duration or 3
    local maxNotifications = 10
    local centerY = 0.4

    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 300, 0, 40)
    notificationFrame.Position = UDim2.new(0.5, -150, centerY + 0.1, 0)
    notificationFrame.BackgroundTransparency = 1
    notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 30
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = notificationFrame

    table.insert(Notifications, notificationFrame)

    local appearTween = TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -150, centerY, 0),
    })
    appearTween:Play()

    for i, frame in ipairs(Notifications) do
        local newY = centerY - (i - 1) * 0.05
        TweenService:Create(frame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, newY, 0)}):Play()
    end

    if #Notifications > maxNotifications then
        local oldest = table.remove(Notifications, 1)
        oldest:Destroy()
    end

    task.delay(duration, function()
        local disappearTween = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -150, centerY - 0.1, 0),
            BackgroundTransparency = 1
        })
        disappearTween:Play()

        disappearTween.Completed:Wait()
        for i, frame in ipairs(Notifications) do
            if frame == notificationFrame then
                table.remove(Notifications, i)
                break
            end
        end
        notificationFrame:Destroy()
    end)
end

return Notification
