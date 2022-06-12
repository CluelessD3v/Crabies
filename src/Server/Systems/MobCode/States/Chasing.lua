--== <|=============== SERVICES ===============|>
local PathfindingService = game:GetService("PathfindingService")
local RunService         = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
--== <|=============== DEPENDENCIES ===============|>
local Cracker    = require(ServerScriptService:FindFirstChild("Cracker", true))
local Controller = require(ServerScriptService:FindFirstChild("MobSystem", true))

--== <|=============== CHASING STATE ===============|>
local Chasing = {}


Chasing.OnEnterState = function(entities)
    for _, entity in ipairs(entities) do
        
    end
        
end

Chasing.OnExitState = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Exited Chasing")
    end
    
end

return Chasing