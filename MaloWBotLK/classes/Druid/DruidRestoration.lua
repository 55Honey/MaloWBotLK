--TODO
-- Implement stop-casting from Paladin

function mb_Druid_Restoration_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Druid_ReadyCheck)
    mb_RegisterExclusiveRequestHandler("cr", mb_Druid_CombatRessRequestAcceptor, mb_Druid_CombatRessRequestExecutor)
end

function mb_Druid_Restoration_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Revive") then
        return
    end

    local nStance = GetShapeshiftForm();
    if nStance ~= 5 then
        CastShapeshiftForm(5)
        return
    end

    if not UnitAffectingCombat("player") then
        return false
    end

    if mb_Druid_Innervate("Khirali") then
        return
    end

    local tanks = mb_GetTanks("Rejuvenation")
    if mb_CanCastSpell("Wild Growth") then
        local healUnit, missingHealth = mb_GetMostDamagedFriendly("Wild Growth")
        if missingHealth > 3000 then
            mb_CastSpellOnFriendly(healUnit, "Wild Growth")
            return
        end
    end

    if tanks[1] ~= nil and mb_UnitHealthPercentage(tanks[1]) <= 25 then
        if mb_CanCastSpell("Nature's Swiftness", tanks[1]) then
            CastSpellByName("Nature's Swiftness")
            if mb_CastSpellOnFriendly(tanks[1], "Healing Touch") then
                return
            end
        end
    end

    if tanks[1] ~= nil and mb_GetMissingHealth(tanks[1]) > mb_GetSpellEffect("Regrowth") and not mb_UnitHasMyBuff(tanks[1], "Regrowth") then
        if mb_CastSpellOnFriendly(tanks[1], "Regrowth") then
            return
        end
    end

    if tanks[2] ~= nil and mb_UnitHealthPercentage(tanks[2]) <= 80 and not mb_UnitHasMyBuff(tanks[1], "Regrowth") then
        if mb_CastSpellOnFriendly(tanks[2], "Regrowth") then
            return
        end
    end

    if tanks[1] ~= nil and not mb_UnitHasMyBuff(tanks[1], "Rejuvenation") then
        if mb_CastSpellOnFriendly(tanks[1], "Rejuvenation") then
            return
        end
    end

    if tanks[2] ~= nil and mb_UnitHasMyBuff(tanks[2], "Rejuvenation") then
        if mb_CastSpellOnFriendly(tanks[2], "Rejuvenation") then
            return
        end
    end

    if tanks[1] ~= nil and mb_GetMissingHealth(tanks[1]) > mb_GetSpellEffect("Swiftmend") and mb_UnitHasMyBuff(tanks[1], "Rejuvenation") then
        if mb_CastSpellOnFriendly(tanks[1], "Swiftmend") then
            return
        end
    end

    if tanks[1] ~= nil and not mb_UnitHasMyBuff(tanks[1], "Lifebloom") then
        if mb_CastSpellOnFriendly(tanks[1], "Lifebloom") then
            return
        end
    end

    if tanks[1] ~= nil and mb_GetMissingHealth(tanks[1]) > mb_GetSpellEffect("Nourish") then
        if mb_CastSpellOnFriendly(tanks[1], "Nourish") then
            return
        end
    end

    if tanks[2] ~= nil and mb_GetMissingHealth(tanks[2]) > mb_GetSpellEffect("Nourish") then
        if mb_CastSpellOnFriendly(tanks[2], "Nourish") then
            return
        end
    end

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if mb_Druid_Restoration_BlanketRaid() then
        return
    end
end

function mb_Druid_Restoration_BlanketRaid()
	if not UnitAffectingCombat("player") then
		return false
	end

    local healUnit, missingHealth = mb_GetMostDamagedFriendly("Rejuvenation")

    if mb_UnitHasMyBuff(healUnit, "Rejuvenation") and missingHealth > mb_GetSpellEffect("Swiftmend") then
        if mb_CastSpellOnFriendly(healUnit, "Swiftmend") then
            return true
        end
    end

    if not mb_UnitHasMyBuff(healUnit, "Rejuvenation") then
        if mb_CastSpellOnFriendly(healUnit, "Rejuvenation") then
            return true
        end
    end

    return false
end