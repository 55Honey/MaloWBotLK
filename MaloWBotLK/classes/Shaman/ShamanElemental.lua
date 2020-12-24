function mb_Shaman_Elemental_OnLoad()
	mb_desiredFlaskEffect = 67016 --67016=SP, 67017=AP, 67018=Strength
	mb_Shaman_SetEarthTotem("Tremor Totem")
	mb_Shaman_SetFireTotem("Totem of Wrath")
	mb_Shaman_SetWaterTotem("Healing Stream Totem")
	mb_Shaman_SetAirTotem("Wrath of Air Totem")
	mb_RegisterClassSpecificReadyCheckFunction(mb_Shaman_Elemental_ReadyCheck)
end

mb_LastFireElementalTotem = 0

function mb_Shaman_Elemental_OnUpdate()
	if not mb_IsReadyForNewCast() then
		return
	end

	if mb_Drink() then
		return
	end

	if mb_ResurrectRaid("Ancestral Spirit") then
		return
	end

	if mb_Shaman_ApplyWeaponEnchants("Flametongue Weapon") then
		return
	end

	if mb_LastFireElementalTotem + 5 < mb_time then
		local haveTotem, totemName, startTime, duration, icon = GetTotemInfo(1)
		if haveTotem ~= true then
			mb_Shaman_SetFireTotem("Totem of Wrath")
		end
	end

	if mb_Shaman_HandleTotems() then
		return
	end

	if not UnitBuff("player", "Water Shield") then
		CastSpellByName("Water Shield")
		return
	end

	if not mb_AcquireOffensiveTarget() then
		return
	end

	if mb_UnitPowerPercentage("player") < 90 then
		if mb_CastSpellWithoutTarget("Thunderstorm") then
			return
		end
	end

	if mb_cleaveMode > 0 then
		local range = CheckInteractDistance("target", 2)
		if range then
			if mb_CastSpellOnTarget("Fire Nova") then
				return
			end

		end
	end

	if mb_ShouldUseDpsCooldowns("Lightning Bolt") and UnitAffectingCombat("player") then
		mb_UseItemCooldowns()
		mb_CastSpellWithoutTarget("Elemental Mastery")

		local name, realm = UnitName("player")
		if mb_config.IgnoreFireElementalTotem ~= name then
			if mb_GetRemainingSpellCooldown("Fire Elemental Totem") == 0 then
				mb_Shaman_SetFireTotem("Fire Elemental Totem")
				if mb_CastSpellWithoutTarget("Fire Elemental Totem") then
					mb_LastFireElementalTotem = mb_time
					return
				end
			end
		end
	end

	mb_Shaman_Elemental_HandleFlameShock()

	mb_Shaman_Elemental_HandleLightning()
end

function mb_Shaman_Elemental_HandleFlameShock()

	if mb_GetMyDebuffTimeRemaining("target", "Flame Shock") == 0 then
		if mb_CastSpellOnTarget("Flame Shock") then
			return true
		end
	end

	if mb_GetMyDebuffTimeRemaining("target", "Flame Shock") < 1.5 then
		if mb_CastSpellOnTarget("Lightning Bolt") then
			return true
		end
	end

	if mb_CastSpellOnTarget("Lava Burst") then
		return true
	end

	return false
end

function mb_Shaman_Elemental_HandleLightning()

	if mb_CastSpellOnTarget("Chain Lightning") then
		return true
	end

	if mb_CastSpellOnTarget("Lightning Bolt") then
		return true
	end

	return false
end

function mb_Shaman_Elemental_ReadyCheck()
	local ready = true
	if mb_GetBuffTimeRemaining("player", "Water Shield") < 540 then
		CancelUnitBuff("player", "Water Shield")
		ready = false
	end
	local _, mainHandExpiration, _, _, _ = GetWeaponEnchantInfo()
	if mainHandExpiration ~= nil then
		if mainHandExpiration / 1000 < 540 then
			CancelItemTempEnchantment(1)
			ready = false
		end
	end
	return ready
end