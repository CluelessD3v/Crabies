local ChasingTransition = {}

--* Transition Data
ChasingTransition.FromOr = {"Attacking"}
ChasingTransition.To      = {"Chasing"}

--* Transition Functions
ChasingTransition.OnEnterBuffer = function(entities)
    print("EnterBuffer Called")
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