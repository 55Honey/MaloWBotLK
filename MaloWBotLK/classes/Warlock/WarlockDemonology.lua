mb_Warlock_lastImmolateTime = 0
function mb_Warlock_Demonology_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end
    mb_Warlock_HandlePetSummon("Summon Felguard")

    mb_Warlock_HandleFelhunterAutoCasts("Anguish", "Cleave")

    if not mb_Warlock_HandleStones("Grand Spellstone") then
        return
    end

    if UnitExists("playerpet") then
        PetPassiveMode()
    end

    local _, _, text = UnitChannelInfo("player")
    if text == "Channeling" then
        return
    end

    mb_Warlock_HandleLifeTap()

    if not UnitBuff("player", "Fel Armor") then
        CastSpellByName("Fel Armor")
        return
    end

    if mb_UnitPowerPercentage("player") < 40  and mb_UnitHealthPercentage("player") > 60 then
        CastSpellByName("Life Tap")
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") then
        PetAttack()
    end

    if mb_ShouldUseDpsCooldowns("Shadow Bolt") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
        CastSpellByName("Demonic Empowerment")
    end

    if mb_cleaveMode > 0 and mb_GetMyDebuffTimeRemaining("target", "Seed of Corruption") == 0 and mb_CastSpellOnTarget("Seed of Corruption") then
        return
    end

    -- First spell cast is Shadow Bolt to apply 5% crit debuff to target, then the affliction locks get better Corruptions.
    if not UnitDebuff("target", "Shadow Mastery") and mb_CastSpellOnTarget("Shadow Bolt") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Corruption") == 0 and mb_CastSpellOnTarget("Corruption") then
        return
    end

    if mb_UnitHealthPercentage("target") < 35 then
        if not UnitBuff("player", "Decimation") then
            if mb_CastSpellOnTarget("Shadow Bolt") then
                return
            end
        else
            if mb_CastSpellOnTarget("Soul Fire") then
                return
            end
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Immolate") < 1.2 and mb_Warlock_lastImmolateTime + 1.5 < mb_time and mb_CastSpellOnTarget("Immolate") then
        mb_Warlock_lastImmolateTime = mb_time
        return
    end

    if UnitBuff("player", "Molten Core") then
        if mb_CastSpellOnTarget("Incinerate") then
            return
        end
    end

    CastSpellByName("Shadow Bolt")
end

