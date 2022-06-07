local States = {}
local Transitions = {}

local Module = {}

Module.CreateTransition = function(TransitionName, Template)
    assert(not Transitions[TransitionName], "Transition " .. TransitionName .. " already exists")

    Transitions[TransitionName] = {
        Buffer        = {};

        FromOr        = Template.FromOr  or Template.fromOr  or Template.from_or  or {};
        FromAnd       = Template.FromAnd or Template.fromAnd or Template.from_and or {};
        To            = Template.To      or Template.to      or                      {};

        OnEnterBuffer = Template.OnEnterBuffer or Template.onEnterBuffer or Template.on_enter_buffer or function(Entity) end;
        OnExitBuffer  = Template.OnExitBuffer  or Template.onExitBuffer  or Template.on_exit_buffer  or function(Buffer) end;
    }
end

Module.DeleteTransition = function(TransitionName)
    local Transition = Transitions[TransitionName]
    assert(Transition, "Transition " .. TransitionName .. " does not exist")

    table.clear(Transition.Buffer)
    Transitions[TransitionName] = nil
end

Module.GetTransition = function(TransitionName)
    local Transition = Transitions[TransitionName]
    assert(Transition, "Transition " .. TransitionName .. " does not exist")

    return Transition
end

Module.CreateState = function(StateName, Entities)
	assert(not States[StateName], "State ".. StateName .. " already exists")

	local State = Entities or {}
	States[StateName] = State

	return State
end

Module.GetState = function(StateName)
    return States[StateName]
end

Module.EnterStates = function(StateNames, Entities)
	for _, StateName in ipairs(StateNames) do
		local State = Module.GetState(StateName)
		if not State then State = Module.CreateState(StateName) end

		for _, Entity in ipairs(Entities) do
			State[Entity] = true
		end
	end
end

Module.ExitStates = function(StateNames, Entities)
	for _, StateName in ipairs(StateNames) do
		local State = Module.GetState(StateName)
		if not State then continue end

		for _, Entity in ipairs(Entities) do
			State[Entity] = nil
		end
	end
end

Module.EnterBuffer = function(TransitionName, Entities)
	local Transition = Module.GetTransition(TransitionName)

	for _, Entity in ipairs(Entities) do
		local ValidOr = #Transition.FromOr == 0
		for _, SourceName in ipairs(Transition.FromOr) do
			local SourceState = Module.GetState(SourceName)
			if not SourceState then SourceState = Module.CreateState(SourceName) end
			if not SourceState[Entity] then continue end

			ValidOr = true
			break
		end

		local ValidAnd = #Transition.FromAnd ~= 0
		for _, SourceName in ipairs(Transition.FromAnd) do
			local SourceState = Module.GetState(SourceName)
			if not SourceState then SourceState = Module.CreateState(SourceName) end
			if SourceState[Entity] then continue end

			ValidAnd = false
			break
		end

		if not ValidOr or not ValidAnd then continue end
		if Transition.OnEnterBuffer(Entity) then continue end

		table.insert(Transition.Buffer, Entity)
	end
end

Module.ExitBuffer = function(TransitionName)
	local Transition = Module.GetTransition(TransitionName)
	if Transition.OnExitBuffer(Transition.Buffer) then return end

	Module.ExitStates(Transition.FromOr, Transition.Buffer)
	Module.ExitStates(Transition.FromAnd, Transition.Buffer)
	Module.EnterStates(Transition.To, Transition.Buffer)

	table.clear(Transition.Buffer)
end

Module.DebugText = function()
	local Text = "FINITE STATE MACHINE DEBUG TEXT:\n\n"

	for StateName, Entities in pairs(States) do
		local DebugEntities = {}
		for Entity in pairs(Entities) do
			table.insert(DebugEntities, Entity)
		end

		Text ..= "State " .. StateName .. ": { " .. table.concat(DebugEntities, ', ') .. " }\n"
	end

	Text ..= "\n"

	for TransitionName, Transition in pairs(Transitions) do
		Text ..= "Transition " .. TransitionName .. ": {\n"
		Text ..= "\tBuffer: { " .. table.concat(Transition.Buffer, ', ') .. " }\n"
		Text ..= "\tFromOr: { " .. table.concat(Transition.OrSourceNames, ', ') .. " }\n"
		Text ..= "\tFromAnd: { " .. table.concat(Transition.AndSourceNames, ', ') .. " }\n"
		Text ..= "\tTo: { " .. table.concat(Transition.TargetNames, ', ') .. " }\n"
		Text ..= "}\n"
	end

	return Text
end

return Module