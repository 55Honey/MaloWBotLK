function mb_Shaman_Restoration_OnLoad()
    mb_preCastFinishCallback = mb_Shaman_Restoration_PreCastFinishCallback
    mb_desiredFlaskEffect = 67016 --67016=SP, 67017=AP, 67018=Strength
    mb_Shaman_SetEarthTotem("Tremor Totem")
    mb_Shaman_SetFireTotem("Flametongue Totem")
    mb_Shaman_SetWaterTotem("Healing Stream Totem")
    mb_Shaman_SetAirTotem("Wrath of Air Totem")
    mb_RegisterClassSpecificReadyCheckFunction(mb_Shaman_Restoration_ReadyCheck)
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

    if mb_UnitPowerPercentage("player") < 50 and UnitAffectingCombat("player") then
        CastSpellByName("Mana Tide Totem")
            return
    end
   
    for mb_PartyMember=1,4 do
        if mb_UnitPowerPercentage("party".. mb_PartyMember) < 50 and UnitAffectingCombat("party".. mb_PartyMember) then
            if mb_CanCastSpell("Mana Tide Totem") then
                CastSpellByName("Mana Tide Totem")
                return
            end
        end
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

    if mb_RaidHeal("Chain Heal", tonumber(mb_config.OverhealModifierShaman)) then
        return
    end

    if mb_config.OverhealModifierShaman >= 1 then
        if UnitAffectingCombat("player") then
            if mb_config.tanks[1] ~= nil and mb_CastSpellOnFriendly(mb_config.tanks[1], "Healing Wave") then
                return
            elseif mb_CastSpellOnFriendly("player", "Healing Wave") then
                return
            end
        end
    else
        if mb_UnitPowerPercentage("player") > 80 and mb_AcquireOffensiveTarget() then
            if mb_CastSpellOnTarget("Lightning Bolt") then
                return
            end
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

function mb_Shaman_Restoration_PreCastFinishCallback(spell, unit)
    if spell ~= "Chain Heal" and spell ~= "Lesser Healing Wave" and spell ~= "Healing Wave" then
        return
    end
    if unit == nil then
        return
    end
    local spellTargetUnitMissingHealth = mb_GetMissingHealth(unit)
    local healAmount = mb_GetSpellEffect(spell)

    if healAmount * 1.1 > spellTargetUnitMissingHealth then
        mb_StopCast()
    end
end

function mb_Shaman_Restoration_ReadyCheck()
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
