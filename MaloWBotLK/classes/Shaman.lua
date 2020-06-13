function mb_Shaman_OnLoad()
	mb_classSpecificRunFunction = mb_Shaman_OnUpdate

	mb_registerDesiredBuff(BUFF_KINGS)
	mb_registerDesiredBuff(BUFF_WISDOM)
	mb_registerDesiredBuff(BUFF_MIGHT)
	mb_registerDesiredBuff(BUFF_SANC)
end

function mb_Shaman_OnUpdate()
	if mb_resurrectRaid("Ancestral Spirit") then
		return
	end
	
	if mb_Shaman_ApplyWeaponEnchants("Windfury Weapon", "Flametongue Weapon") then
		return
	end
	
	local _, _, _, maelstromCount = UnitBuff("player", "Maelstrom Weapon")
	if maelstromCount == 5 then
		if mb_Shaman_ChainHealRaid() then
			return
		end
	end
	
	if not UnitBuff("player", "Lightning Shield") then
		CastSpellByName("Lightning Shield")
		return
	end
	
	if UnitAffectingCombat("player") then 
		local haveTotem, totemName, startTime, duration = GetTotemInfo(1) -- Check fire totem
		if startTime == 0 or startTime + duration < mb_time then 
			if mb_castSpellOnSelf("Call of the Elements") then
				return
			end
		end
	end
	
	AssistUnit(mb_commanderUnit)
	if not mb_hasValidOffensiveTarget() then
		return
	end
	
	if not mb_isAutoAttacking then
		InteractUnit("target")
	end
	
	if UnitAffectingCombat("player") and mb_castSpellOnSelf("Shamanistic Rage") then
		return
	end	
	
	if mb_castSpellOnTarget("Stormstrike") then
		return
	end
	
	if not mb_targetHasMyDebuff("Flame Shock") and mb_castSpellOnTarget("Flame Shock") then
		return
	end
	
	if mb_castSpellOnTarget("Lava Lash") then
		return
	end
	
	if mb_castSpellOnSelf("Fire Nova") then
		return
	end
end

function mb_Shaman_ChainHealRaid()
	local healUnit, missingHealth = mb_getMostDamagedFriendly("Chain Heal")
	if missingHealth > 1000 then
		mb_castSpellOnFriendly(healUnit, "Chain Heal")
		return true
	end
	return false
end

function mb_Shaman_ApplyWeaponEnchants(mainHandSpell, offHandSpell)
	local hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
	if not hasMainHandEnchant then
		if mb_castSpellOnSelf(mainHandSpell) then
			return true
		end
	end
	if not hasOffHandEnchant then
		if mb_castSpellOnSelf(offHandSpell) then
			return true
		end
	end
	return false
end



