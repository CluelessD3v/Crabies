local ChasingTransition = {}

--* Transition Data
ChasingTransition.FromAnd = {"Chasing"}
ChasingTransition.To      = {"Attacking"}

--* Transition Functions
ChasingTransition.OnEnterBuffer = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Entered Chasing buffer")
    end
end;

ChasingTransition.OnExitBuffer = function(entities)
    for _, entity in ipairs(entities) do
        print(entity, "Exited Chasing buffer")
    end
end;


return ChasingTransition