--== <|=============== SERVICES ===============|>
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

--== <|=============== MODULES ===============|>
local MobSystem = require(ServerScriptService.Systems.MobCode.MobSystem)

--== <|=============== VALUES ===============|>
--!= Runtime Values ===============|>
local currentState = nil
local mobsToSpawn = 3

--!= Remotes & bindables ===============|>
--* Remote Events
local Events: Folder = ReplicatedStorage.Events 
local PlayerJoined = Events.PlayerJoined
local ShopClosed: RemoteEvent   = Events.ShopClosed


--* Bindable Events
local GameStateChanged: BindableEvent = script.Parent.GameStateChanged 

--!= Tables ===============|>
local states = {
    Intermission = "Intermission",
    InMatch = "InMatch"
}

--== <|=============== ZOMBIE SYSTEM & MANAGED DATA ===============|>
--!= Zombie/Mob data arquetypes ===============|>
--* Zombie mob data schema
local spawns = CollectionService:GetTagged("MobSpawn")

local zombieData = {
    Properties = {
        Name = "Dummy",
        Parent = workspace.Mobs
    },
    
    Attributes = {
        InitialHealth = 100,
        Damage        = 3,
    },

    Tags = {
        "Zombie",
    },

    ObjectValues = {},
    ExtraData = {
        Instance = workspace.Zombie,
        SpawnsList = spawns,
    }
}

--== <|=============== EVENT CONNECTIONS ===============|>
GameStateChanged.Event:Connect(function(newState)
    print(newState)

    if newState == states.InMatch then
        for _ = 1, mobsToSpawn do
            MobSystem:CreateNewMob(zombieData)
        end
    end
end)

Players.PlayerAdded:Connect(function(player: Player)
    PlayerJoined:FireClient(player)
    currentState = states.Intermission
    GameStateChanged:Fire(currentState)
end)

ShopClosed.OnServerEvent:Connect(function(_)
    print("Shop Closed")

    currentState = states.InMatch
    GameStateChanged:Fire(currentState)

    print(currentState)
end)


MobSystem:Init()




