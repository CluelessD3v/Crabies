--== <|=============== SERVICES ===============|>
local PathfindingService = game:GetService("PathfindingService")
local RunService         = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
--== <|=============== DEPENDENCIES ===============|>
local Cracker = require(ServerScriptService:FindFirstChild("Cracker", true))

--== <|=============== CHASING STATE ===============|>
local Chasing = {}

Chasing.Name = "Happy"

Chasing.OnEnterState = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Entered Chasing")

    end
        
end

Chasing.OnExitState = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Exited Chasing")
    end
    
end

return Chasing