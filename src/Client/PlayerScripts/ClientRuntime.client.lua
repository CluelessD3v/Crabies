--== <|=============== SERVICES ===============|>
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--== <|=============== RUNTIME VALUES ===============|>
local LocalPlayer: Player = Players.LocalPlayer
local PlayerGui: Folder   = LocalPlayer.PlayerGui

--* Events
local Events: Folder = ReplicatedStorage.Events 
local PlayerJoined: RemoteEvent = Events.PlayerJoined
local ShopClosed: RemoteEvent   = Events.ShopClosed

--#! Temporal close button asset...
--#! This is just for testing the game loop

local SC: ScreenGui = Instance.new("ScreenGui")
SC.ResetOnSpawn = false
SC.Parent       = PlayerGui

local CB: TextButton = Instance.new("TextButton")
CB.AnchorPoint = Vector2.new(0.5, 0.5)
CB.Position    = UDim2.fromScale(0.5, 0.5)
CB.Size        = UDim2.fromScale(0.35, 0.20)
CB.Parent      = SC

CB.MouseButton1Click:Connect(function()
    SC.Enabled = false
    ShopClosed:FireServer()
end)



PlayerJoined.OnClientEvent:Connect(function(player)
    SC.Enabled = true
end)