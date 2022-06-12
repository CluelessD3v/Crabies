--== <|=============== SERVICES ===============|>
local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

--== <|=============== DEPENDENCIES ===============|>
local Cracker = require(ServerScriptService.Cracker)

--== <|=============== MOB SYSTEM ===============|>
local MobSystem = {}

--!= PUBLIC MEMBERS ===============|>

--* Tables
MobSystem.Mobs        = {}
MobSystem.MobStates   = {}

MobSystem.States      = {
    Attacking = require(script.Parent.States.Attacking),
    Chasing   = require(script.Parent.States.Chasing)
}

MobSystem.Transitions = {   
    Attacking = require(script.Parent.Transitions.AttackingTransition),
    Chasing   = require(script.Parent.Transitions.ChasingTransition)
}


--!= AUX FUNCTIONS ===============|>
local function SpawnMob(fromMobData:table, aMob: Model)
    local spawnsList = fromMobData.ExtraData.SpawnsList
    local SpawnLocation: BasePart = spawnsList[math.random(1, #spawnsList)]

    local spawnCF: CFrame   = SpawnLocation:GetPivot()
    local spawnSize:Vector3 = SpawnLocation.Position
    local mobSize:Vector3   = aMob:GetExtentsSize()

    local finalPos:CFrame = spawnCF + Vector3.new(0, (spawnSize.Y/2 + mobSize.Y/2), 0)  
    aMob:PivotTo(finalPos)
end


--!= PUBLIC FUNCTIONS ===============|>
function MobSystem:Init()
    --## Create States
    for stateName, stateObject in pairs(self.States) do
        Cracker.CreateState(stateName, stateObject)
        print(Cracker.GetState(stateName))
    end

    --## Create Transitions
    for transitionName, transitionObject in pairs(self.Transitions) do
        Cracker.CreateTransition(transitionName, transitionObject)
        print(Cracker.GetTransition(transitionName))
    end
end


function MobSystem:CreateNewMob(fromMobData)

    --## Create a new mob instances
    local newMob: Model = fromMobData.ExtraData.Instance:Clone()

    --* Map data from mobData into the instance
    for property, value in pairs(fromMobData.Properties) do
        newMob[property] = value
    end 

    for _, tagName in ipairs(fromMobData.Tags) do --#! This can be an array!
        CollectionService:AddTag(newMob, tagName)
    end

    for attName, attValue in pairs(fromMobData.Attributes) do
        newMob:SetAttribute(attName, attValue)
    end

    for name, objectValue in pairs(fromMobData.ObjectValues) do
        local newObjectValue: ObjectValue = Instance.new(objectValue.Type) or error("Object value must have a type field!")
        newObjectValue.Name   = name
        newObjectValue.Value  = objectValue.Value or nil
        newObjectValue.Parent = newMob
    end 

    --* Enter initial state
    Cracker.EnterStates({"Chasing"}, {newMob})

    --* Spawn the mob
    SpawnMob(fromMobData, newMob)
    table.insert(self.Mobs, newMob)
end


return MobSystem