function mb_Warrior_OnLoad()

	mb_desiredFlaskEffect = 67016 --67016=SP, 67017=AP, 67018=Strength

	mb_RegisterDesiredBuff(BUFF_KINGS)
	mb_RegisterDesiredBuff(BUFF_MIGHT)
	mb_RegisterDesiredBuff(BUFF_SANCTUARY)
	mb_RegisterDesiredBuff(BUFF_FORT)
	mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)
	mb_RegisterDesiredBuff(BUFF_MOTW)

	if mb_GetMySpecName() == "Arms" then
		mb_classSpecificRunFunction = mb_Warrior_Arms_OnUpdate
		mb_Warrior_Arms_OnLoad()
	elseif mb_GetMySpecName() == "Fury" then
		mb_classSpecificRunFunction = mb_Warrior_Fury_OnUpdate
		mb_SpecNotSupported("Fury Warriors are not yet supported")
	else
		mb_classSpecificRunFunction = mb_Warrior_Protection_OnUpdate
		mb_Warrior_Protection_OnLoad()
	end
end

mb_Warrior_lastCommandingShoutRaidCheck = 0
function mb_Warrior_CommandingShout()
	local _, _, _, _, improvedShouts = GetTalentInfo(2, 2)
	if improvedShouts > 0 then
		if not UnitBuff("player", "Commanding Shout") then
			if UnitPower("player") < 10 then
				return mb_CastSpellWithoutTarget("Bloodrage")
			end
			mb_CastSpellWithoutTarget("Commanding Shout")
			return true
		end
		if mb_Warrior_lastCommandingShoutRaidCheck + 10 > mb_time then
			return false
		end
		mb_Warrior_lastCommandingShoutRaidCheck = mb_time
		local members = mb_GetNumPartyOrRaidMembers()
		for i = 1, members do
			local unit = mb_GetUnitFromPartyOrRaidIndex(i)
			if not UnitBuff(unit, "Commanding Shout") and CheckInteractDistance(unit, 4) then
				if UnitPower("player") < 10 then
					return mb_CastSpellWithoutTarget("Bloodrage")
				end
				mb_CastSpellWithoutTarget("Commanding Shout")
				return true
			end
		end
	end
	return false
end

