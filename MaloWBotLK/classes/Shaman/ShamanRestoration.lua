function mb_Shaman_Restoration_OnLoad()
    mb_Shaman_SetEarthTotem("Tremor Totem")
    mb_Shaman_SetFireTotem("Flametongue Totem")
    mb_Shaman_SetWaterTotem("Healing Stream Totem")
    mb_Shaman_SetAirTotem("Wrath of Air Totem")
end

function mb_Shaman_Restoration_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Ancestral Spirit") then
        return
    end

    if mb_Shaman_ApplyWeaponEnchants("Earthliving Weapon") then
        return
    end

    if mb_Shaman_HandleTotems() then
        return
    end

    if not UnitBuff("player", "Water Shield") then
        CastSpellByName("Water Shield")
        return
    end

    if mb_isAlchemist == true then
        local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId
        = UnitAura("player", "Flask of the North")

        if spellId == nil then
            mb_UseItem("Flask of the North")
            return
        end

        local remainingBuffTime = expirationTime - mb_time

        --mb_Print("spellId: ".. spellId)
        --mb_Print("remainingBuffTime: ".. remainingBuffTime)

        if spellId ~= 67016 or remainingBuffTime < 1200 then  --67016=SP, 67017=AP, 67018=Strength
            CancelUnitBuff("player", "Flask of the North")
            mb_UseItem("Flask of the North")
        end

    end

    if mb_isAlchemist == true and mb_UnitPowerPercentage("player") < 80 then
        local StartTime, duration, enable = GetItemCooldown("Endless Mana Potion")
        if duration == 0 then
            mb_UseItem("Endless Mana Potion")
        end
    end

    local tanks = mb_GetTanks("Healing Wave")
    if tanks[1] ~= nil and not mb_UnitHasMyBuff(tanks[1], "Earth Shield") then
        if mb_CastSpellOnFriendly(tanks[1], "Earth Shield") then
            return
        end
    end

    if tanks[1] ~= nil and mb_GetMissingHealth(tanks[1]) > mb_GetSpellEffect("Riptide") and not mb_UnitHasMyBuff(tanks[1], "Riptide") then
        if mb_CastSpellOnFriendly(tanks[1], "Riptide") then
            return
        end
    end

    if tanks[2] ~= nil and mb_GetMissingHealth(tanks[2]) > mb_GetSpellEffect("Riptide") and not mb_UnitHasMyBuff(tanks[2], "Riptide") then
        if mb_CastSpellOnFriendly(tanks[2], "Riptide") then
            return
        end
    end

    if tanks[1] ~= nil and mb_GetMissingHealth(tanks[1]) > mb_GetSpellEffect("Healing Wave") and UnitBuff("player", "Tidal Waves") then
        if mb_CastSpellOnFriendly(tanks[1], "Healing Wave") then
            return
        end
    end

    if tanks[1] ~= nil and mb_GetMissingHealth(tanks[1]) > mb_GetSpellEffect("Lesser Healing Wave") and UnitBuff("player", "Tidal Waves") then
        if mb_CastSpellOnFriendly(tanks[1], "Lesser Healing Wave") then
            return
        end
    end

    if mb_CleanseRaid("Cleanse Spirit", "Curse", "Poison", "Disease") then
        return
    end

    if mb_UnitPowerPercentage("Felide") < 50 and UnitAffectingCombat("Felide") then
        CastSpellByName("Mana Tide Totem")
        return
    end

    if tanks[1] ~= nil and mb_GetMissingHealth(tanks[1]) > mb_GetSpellEffect("Lesser Healing Wave") then
        if mb_CastSpellOnFriendly(tanks[1], "Lesser Healing Wave") then
            return
        end
    end

    if tanks[2] ~= nil and mb_GetMissingHealth(tanks[2]) > mb_GetSpellEffect("Lesser Healing Wave") then
        if mb_CastSpellOnFriendly(tanks[2], "Lesser Healing Wave") then
            return
        end
    end

    if mb_Shaman_ChainHealRaid() then
        return
    end

    if mb_UnitPowerPercentage("player") > 80 and mb_AcquireOffensiveTarget() then
        if mb_CastSpellOnTarget("Lightning Bolt") then
            return
        end
    end
end

function mb_Shaman_HandleFocusHealing()
    local healUnit, missingHealth = mb_GetMostDamagedFriendly("Riptide")
    if missingHealth > mb_GetSpellEffect("Lesser Healing Wave") then
        mb_CastSpellOnFriendly(healUnit, "Lesser Healing Wave")
        return true
    end
    return false
end