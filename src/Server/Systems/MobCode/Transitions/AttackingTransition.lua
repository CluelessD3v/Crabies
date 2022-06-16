local AttackingTransition = {}

--* Transition Data
AttackingTransition.FromOr = {"Chasing"}
AttackingTransition.To      = {"Attacking"}

--* Transition Functions
AttackingTransition.OnEnterBuffer = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Entered Attacking buffer")
    end
end;

AttackingTransition.OnExitBuffer = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Exited Attacking buffer")
    end
end;


return AttackingTransition