PLUGIN.name = "Jobs Configuration File"
PLUGIN.author = "Lord Tyler"
PLUGIN.desc = "Lazier way to make factions, DarkRP Style."

// DO NOT EDIT THE BELOW, SCROLL TO THE BOTTOM TO MAKE JOBS.
// DO NOT EDIT THE BELOW, SCROLL TO THE BOTTOM TO MAKE JOBS.
// DO NOT EDIT THE BELOW, SCROLL TO THE BOTTOM TO MAKE JOBS.
// DO NOT EDIT THE BELOW, SCROLL TO THE BOTTOM TO MAKE JOBS.

function AlfNum(str) // This removes all unsafe characters from strings.
	str = str:gsub('%W','')
	return str
end
function AlfNumLow(str) // same as above, but lower case.
	str = str:gsub('%W','')
	return string.lower(str)
end
function nut.CreateFaction(class)
	FACTION = nut.faction.teams[AlfNumLow(class.name)] or {index = table.Count(nut.faction.teams) + 1, isDefault = true}
	FACTION.name = class.name or "MISSING NAME"
	FACTION.color = class.color or Color(255,255,255)
	FACTION.models = class.models or {"missing_models.mdl"}
	FACTION.weapons = class.weapons or {}
	FACTION.isGloballyRecognized = class.isGloballyRecognized or true
	FACTION.isDefault = class.isDefault or true
	FACTION.salary = class.pay or 0
	FACTION.pay = class.pay or 0
	FACTION.uniqueID = AlfNumLow(FACTION.name)
	FACTION.desc = class.desc or "MISSING DESC"
	RunString("FACTION_GENERATED"..FACTION.index.." = FACTION.index") // FACTION must NOT be local for this to work!
	team.SetUp(FACTION.index, FACTION.name, FACTION.color)
	for _,v in pairs(FACTION.models) do
		if (type(v) == "string") then
			util.PrecacheModel(v)
		elseif (type(v) == "table") then
			util.PrecacheModel(v[1])
		end
	end
	nut.faction.indices[FACTION.index] = FACTION
	nut.faction.teams[AlfNumLow(class.name)] = FACTION
	FACTION = nil
end
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////

// MAKE YOUR FACTIONS HERE.
// MAKE YOUR FACTIONS HERE.
// MAKE YOUR FACTIONS HERE.
// MAKE YOUR FACTIONS HERE.

nut.CreateFaction({
	name = "Real Bobbies",
	desc = "King of the Bobbies",
	color = Color(0,200,200),
	models = {"error.mdl"},
	weapons = {},
	isGloballyRecognized = false,
	isDefault = true,
	pay = 69,
})
