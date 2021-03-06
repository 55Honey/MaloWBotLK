-- TODO:
-- Add a DPS rotation if high mana
-- Lay on Hands, is an external CD due to talent
-- Divine Protection pre-taking damage, probably through a "use personals" macro
-- If low on mana, and if next auto-hit on target is less than like 0.3 seconds away, delay healing until after auto-hit to proc Seal of Wisdom and Judgement of Wisdom

function mb_Paladin_Holy_OnLoad()
    mb_desiredFlaskEffect = 67016 --67016=SP, 67017=AP, 67018=Strength
    mb_preCastFinishCallback = mb_Paladin_Holy_PreCastFinishCallback
    mb_RegisterExclusiveRequestHandler("healcd", mb_Paladin_Holy_HealCdAcceptor, mb_Paladin_Holy_HealCdExecutor)
    mb_CheckReagentAmount("Runic Mana Potion", 20)
    mb_RegisterClassSpecificReadyCheckFunction(mb_Paladin_Holy_ReadyCheck)
end

mb_Paladin_Holy_tempThrottle = 0

mb_Paladin_Holy_beaconUnit = nil
mb_Paladin_Holy_useCooldownsCommandTime = 0
function mb_Paladin_Holy_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Redemption") then
        return
    end

    if mb_Paladin_Holy_beaconUnit ~= nil and not UnitBuff(mb_Paladin_Holy_beaconUnit, "Beacon of Light") then
        mb_Paladin_Holy_beaconUnit = nil
    end

    if UnitAffectingCombat("player") then
        if mb_UnitHealthPercentage("player") < 30 and mb_CastSpellWithoutTarget("Divine Shield") then
            return
        end
        if mb_UnitPowerPercentage("player") < 10 then
            if mb_Paladin_Holy_tempThrottle + 60 < mb_time then
                mb_SayRaid("Used Mana Potion")
                mb_Paladin_Holy_tempThrottle = mb_time
            end
        end
    end

    if mb_Paladin_CastAura() then
        return
    end

    if not UnitBuff("player", "Seal of Wisdom") then
        if mb_CastSpellWithoutTarget("Seal of Wisdom") then
            return
        end
    end

    if mb_UnitPowerPercentage("player") < 70 and mb_Paladin_Holy_useCooldownsCommandTime + 20 < mb_time then
        if mb_CastSpellWithoutTarget("Divine Plea") then
            return
        end
    end

    local tanks = mb_GetTanks("Flash of Light")
    if mb_Paladin_Holy_beaconUnit == nil and tanks[1] ~= nil then
        if mb_CastSpellOnFriendly(tanks[1], "Beacon of Light") then
            mb_Paladin_Holy_beaconUnit = tanks[1]
            return
        end
    end
    for _, tank in pairs(tanks) do
        if mb_GetClass(tank) ~= "PALADIN" then
            if UnitBuff(tank, "Sacred Shield") then
                break
            else
                if mb_CastSpellOnFriendly(tank, "Sacred Shield") then
                    return
                end
            end
        end
    end

    if mb_Paladin_Holy_useCooldownsCommandTime + 20 > mb_time then
        mb_UseItemCooldowns()
        mb_CastSpellWithoutTarget("Avenging Wrath")
        mb_CastSpellWithoutTarget("Divine Illumination")
        mb_CastSpellWithoutTarget("Divine Favor")
    end

    if mb_RaidHeal("Holy Shock", tonumber(mb_config.OverhealModifierPaladin)) then
        return
    end

    if UnitBuff("player", "Infusion of Light") then
        if mb_IsMoving() and mb_RaidHeal("Flash of Light", tonumber(mb_config.OverhealModifierPaladin)) then
            return
        end
    end

    local hasValidEnemyTarget = false
    if mb_AcquireOffensiveTarget() then
        hasValidEnemyTarget = true
        if not mb_isAutoAttacking then
            InteractUnit("target")
        end

        if mb_GetBuffTimeRemaining("player", "Judgements of the Pure") < 5 and mb_CastSpellOnTarget("Judgement of Light") then
            return
        end
    end

    if mb_commanderUnit ~= nil and mb_followMode == "lenient" and UnitAffectingCombat("player") and CheckInteractDistance(mb_commanderUnit, 2) then
        mb_BreakFollow()
    end

    if mb_RaidHeal("Holy Light", tonumber(mb_config.OverhealModifierPaladin)) then
        return
    end

    if mb_RaidHeal("Flash of Light", tonumber(mb_config.OverhealModifierPaladin)) then
        return
    end

    if mb_CleanseRaid("Cleanse", "Magic", "Poison", "Disease") then
        return
    end

    if mb_Paladin_Holy_beaconUnit ~= nil and mb_GetBuffTimeRemaining(mb_Paladin_Holy_beaconUnit, "Beacon of Light") < 10 then
        if tanks[1] ~= nil and mb_CastSpellOnFriendly(tanks[1], "Beacon of Light") then
            mb_Paladin_Holy_beaconUnit = tanks[1]
            return
        end
    end

    if hasValidEnemyTarget and mb_CastSpellOnTarget("Judgement of Light") then
        return
    end

    if UnitAffectingCombat("player") then
        if tanks[2] ~= nil and mb_CastSpellOnFriendly(tanks[2], "Holy Light") then
            return
        elseif mb_CastSpellOnFriendly("player", "Holy Light") then
            return
        end
    end
end

function mb_Paladin_Holy_PreCastFinishCallback(spell, unit)
    if spell ~= "Holy Light" and spell ~= "Flash of Light" then
        return
    end
    if unit == nil then
        return
    end
    local spellTargetUnitMissingHealth = mb_GetMissingHealth(unit)
    local beaconUnitMissingHealth = 0
    if mb_Paladin_Holy_beaconUnit ~= nil then
        beaconUnitMissingHealth = mb_GetMissingHealth(mb_Paladin_Holy_beaconUnit)
    end
    local healAmount = mb_GetSpellEffect(spell)
    local effectiveHealAmount = 0
    if healAmount > spellTargetUnitMissingHealth then
        effectiveHealAmount = effectiveHealAmount + spellTargetUnitMissingHealth
    else
        effectiveHealAmount = effectiveHealAmount + healAmount
    end
    if healAmount > beaconUnitMissingHealth then
        effectiveHealAmount = effectiveHealAmount + beaconUnitMissingHealth
    else
        effectiveHealAmount = effectiveHealAmount + healAmount
    end
    if effectiveHealAmount < healAmount * tonumber(mb_config.OverhealModifierPaladin) then
        mb_StopCast()
    end
end

function mb_Paladin_Holy_HealCdAcceptor(message, from)
    if mb_GetBuffTimeRemaining("player", "Divine Plea") > 1 then
        return false
    end
    if not mb_CanCastSpell("Avenging Wrath") then
        return false
    end
    if mb_UnitPowerPercentage("player") < 20 then
        return false
    end
    return true
end

function mb_Paladin_Holy_HealCdExecutor(message, from)
    mb_SayRaid("I'm popping my cooldowns!")
    mb_Paladin_Holy_useCooldownsCommandTime = mb_time
    return true
end

function mb_Paladin_Holy_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Seal of Wisdom") < 540 then
        CancelUnitBuff("player", "Seal of Wisdom")
        ready = false
    end
    return ready
end