--== <|=============== SERVICES ===============|>
local PathfindingService  = game:GetService("PathfindingService")
local RunService          = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService   = game:GetService("CollectionService")

--== <|=============== DEPENDENCIES ===============|>
local Cracker    = require(ServerScriptService:FindFirstChild("Cracker", true))

--== <|=============== CHASING STATE ===============|>
local Chasing = {}
local connections = {}

Chasing.OnEnterState = function(entities)
    local radius = 25

    for _, entity:Model in ipairs(entities) do
        print(entity, "Entered Chasing")
        local chasingTargetConn = nil
        task.wait(3)        
        Cracker.EnterBuffer("Attacking", {entity})
        warn(Cracker.DebugText())

        chasingTargetConn = RunService.Heartbeat:Connect(function()

            task.wait(3)

            if #CollectionService:GetTagged("ValidTarget") >= 1 then
                local target:Model = CollectionService:GetTagged("ValidTarget")[1]

                if (entity:GetPivot().Position - target:GetPivot().Position).Magnitude <= radius then
                    print("inside")
                    Cracker.PassBuffer("Attacking", {entity})
                end 
            end    
        end)

        table.insert(connections, chasingTargetConn)
    end
end

Chasing.OnExitState = function(entities)
    for _, connection:RBXScriptConnection in ipairs(connections) do
        connection:Disconnect()
    end

    for _, entity in ipairs(entities) do
        print(entity, "Exited Chasing")
    end
    
end

return Chasing