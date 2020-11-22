function mb_Priest_Holy_OnLoad()
    mb_preCastFinishCallback = mb_Priest_Holy_PreCastFinishCallback
    mb_RegisterClassSpecificReadyCheckFunction(mb_Priest_ReadyCheck)
    mb_RegisterExclusiveRequestHandler("external", mb_Priest_Holy_ExternalRequestAcceptor, mb_Priest_Holy_ExternalRequestExecutor)
end

function mb_Priest_Holy_OnUpdate()
    --mb_HandleRoleplay()

    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Resurrection") then
        return
    end

    local _, _, text = UnitChannelInfo("player")
    if text == "Divine Hymn" or text == "Hymn of Hope" then
        return
    end

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

    if not UnitAffectingCombat("player") then
        mb_AcquireOffensiveTarget()
        return false
    end

    if mb_UnitPowerPercentage("player") < 50 and UnitAffectingCombat("player") and mb_CanCastSpell("Shadowfiend") then
        AssistUnit(mb_commanderUnit)
        if mb_CastSpellOnTarget("Shadowfiend") then
            return
        elseif mb_CastSpellWithoutTarget("Hymn of Hope") then
            return
        end
    end

    if mb_Priest_useCooldownsCommandTime + 20 > mb_time then
        mb_UseItemCooldowns()
    end

    local tanks = mb_GetTanks("Flash Heal")
    if tanks[1] ~= nil and UnitAffectingCombat(tanks[1]) and mb_UnitHealthPercentage(tanks[1]) <= 30 then
        if mb_CastSpellOnFriendly(tanks[1], "Guardian Spirit") then
            return
        end
    end

    if tanks[1] ~= nil and not mb_UnitHasMyBuff(tanks[1], "Prayer of Mending") and UnitAffectingCombat(tanks[1]) then
        if mb_CastSpellOnFriendly(tanks[1], "Prayer of Mending") then
            return
        end
    end

    if tanks[1] ~= nil and not mb_UnitHasMyBuff(tanks[1], "Renew") and UnitAffectingCombat(tanks[1]) then
        if mb_CastSpellOnFriendly(tanks[1], "Renew") then
            return
        end
    end

    if tanks[2] ~= nil and not mb_UnitHasMyBuff(tanks[2], "Renew") and UnitAffectingCombat(tanks[2]) then
        if mb_CastSpellOnFriendly(tanks[2], "Renew") then
            return
        end
    end

    if tanks[1] ~= nil and mb_UnitHealthPercentage(tanks[1]) < 65 and UnitAffectingCombat(tanks[1]) then
        if mb_CastSpellOnFriendly(tanks[1], "Flash Heal") then
            return
        end
    end

    if UnitBuff("player", "Surge of Light") then
        if mb_RaidHeal("Flash Heal", tonumber(mb_config.OverhealModifierHolyPriest)) then
            return
        end
    end

    if mb_RaidHeal("Circle of Healing", tonumber(mb_config.OverhealModifierHolyPriest)) then
        return
    end

    if mb_RaidHeal("Flash Heal", tonumber(mb_config.OverhealModifierHolyPriest)) then
        return
    end

    if UnitAffectingCombat("player") then
        if mb_config.tanks[1] ~= nil and mb_CastSpellOnFriendly(mb_config.tanks[1], "Greater Heal") then
            return
        elseif mb_CastSpellOnFriendly("player", "Greater Heal") then
            return
        end
    end
end

function mb_Priest_Holy_ExternalRequestAcceptor(message, from)
    if mb_IsUsableSpell("Guardian Spirit") and mb_GetRemainingSpellCooldown("Guardian Spirit") < 1.5 then
        if mb_IsUnitValidFriendlyTarget(from, "Guardian Spirit") then
            return true
        end
    end

    return false
end

function mb_Priest_Holy_ExternalRequestExecutor(message, from)
    if not mb_IsReadyForNewCast() then
        return false
    end

    local targetUnit = mb_GetUnitForPlayerName(from)
    if mb_CastSpellOnFriendly(targetUnit, "Guardian Spirit") then
        mb_SayRaid("Casting Guardian Spirit")
        return true
    end

    return false
end

function mb_Priest_Holy_PreCastFinishCallback(spell, unit)
    if spell ~= "Circle of Healing" and spell ~= "Flash Heal" then
        return
    end
    if unit == nil then
        return
    end
    local spellTargetUnitMissingHealth = mb_GetMissingHealth(unit)
    local healAmount = mb_GetSpellEffect(spell)

    if healAmount > spellTargetUnitMissingHealth * tonumber(mb_config.OverhealModifierHolyPriest) then
        mb_StopCast()
    end
end

-- Experimental handling of Roleplay stuff
function mb_HandleRoleplay()
    if mb_isRoleplaying == false then
        return
    end

    if mb_commanderUnit ~= nil then
        if not UnitAffectingCombat(mb_commanderUnit) then
            mb_AcquireOffensiveTarget()
            return false
        end
    else
        if not UnitAffectingCombat("player") then
            mb_AcquireOffensiveTarget()
            return false
        end
    end

    if mb_roleplayThrottle + math.random(60, 120) > mb_time then
        return
    end

    if mb_GetNumAlivePartyOrRaidMembers() < 13 then
        mb_Say(mb_roleplay.fearfulGossip[math.random(#mb_roleplay.fearfulGossip)])
        mb_roleplayThrottle = mb_time
    elseif mb_GetNumAlivePartyOrRaidMembers() > 13 and mb_GetNumPartyOrRaidMembers() <= 24 then
        mb_Say(mb_roleplay.waveringGossip[math.random(#mb_roleplay.waveringGossip)])
        mb_roleplayThrottle = mb_time
    else
        mb_Say(mb_roleplay.courageousGossip[math.random(#mb_roleplay.courageousGossip)])
        mb_roleplayThrottle = mb_time
    end
end