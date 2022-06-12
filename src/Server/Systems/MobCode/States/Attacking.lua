local Attacking = {}

Attacking.Name = "Happy"

Attacking.OnEnterState = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Entered Attacking")
    end
        
end

Attacking.OnExitState = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Exited Attacking")
    end
    
end

return Attacking