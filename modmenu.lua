-- The Bronx 3 Private Mod Menu
-- Made by astro👑

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BronxModMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = gethui and gethui() or game:GetService("CoreGui")

-- Main Frame
local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 400, 0, 500)
main.Position = UDim2.new(0.3, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🔧 The Bronx 3 Mod Menu | Made by ChatGPT"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- Toggle Functionality
local open = true
UIS.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.Z then
		open = not open
		screenGui.Enabled = open
	end
end)

-- Add your feature buttons and functionalities here

-- Player List and Kill Feature
local playerListFrame = Instance.new("Frame", main)
playerListFrame.Size = UDim2.new(0, 180, 0, 250)
playerListFrame.Position = UDim2.new(0, 10, 0, 50)
playerListFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerListFrame.Visible = false -- Initially hidden

-- Title for the Player List
local playerListTitle = Instance.new("TextLabel", playerListFrame)
playerListTitle.Size = UDim2.new(1, 0, 0, 30)
playerListTitle.Text = "👥 Select a Player"
playerListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
playerListTitle.BackgroundTransparency = 1
playerListTitle.Font = Enum.Font.GothamBold
playerListTitle.TextSize = 14

-- Function to update player list
local function updatePlayerList()
	-- Clear previous buttons in the list
	for _, child in ipairs(playerListFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	-- Create a button for each player
	for i, player in ipairs(Players:GetPlayers()) do
		if player ~= LP then
			local playerBtn = Instance.new("TextButton", playerListFrame)
			playerBtn.Size = UDim2.new(1, 0, 0, 40)
			playerBtn.Position = UDim2.new(0, 0, 0, 30 * i)
			playerBtn.Text = player.Name
			playerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			playerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			playerBtn.Font = Enum.Font.Gotham
			playerBtn.TextSize = 14
			playerBtn.MouseButton1Click:Connect(function()
				-- Kill the selected player (set health to 0)
				local target = player
				if target.Character then
					local humanoid = target.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.Health = 0
						print(target.Name .. " has been killed!")
					end
				end
			end)
		end
	end
end

-- Open/Close Player List Button
local openPlayerListBtn = Instance.new("TextButton", main)
openPlayerListBtn.Size = UDim2.new(0, 150, 0, 40)
openPlayerListBtn.Position = UDim2.new(0, 10, 0, 50)
openPlayerListBtn.Text = "👥 Player List"
openPlayerListBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
openPlayerListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openPlayerListBtn.Font = Enum.Font.Gotham
openPlayerListBtn.TextSize = 14
openPlayerListBtn.MouseButton1Click:Connect(function()
	playerListFrame.Visible = not playerListFrame.Visible
	if playerListFrame.Visible then
		updatePlayerList() -- Update the list when it's shown
	end
end)

-- Kill Functionality (Already integrated in Player List button)