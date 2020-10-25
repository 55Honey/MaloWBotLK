mb_Warlock_lastImmolateTime = 0
mb_Warlock_shadowMastery = false
mb_Warlock_shadowMasteryTimer = 0

function mb_Warlock_Demonology_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Warlock_ReadyCheck)
end

function mb_Warlock_Demonology_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end
    mb_Warlock_HandlePetSummon("Summon Felguard")

    mb_Warlock_HandleFelguardAutoCasts("Intercept", "Cleave", "Anguish")

    if not mb_Warlock_HandleStones("Grand Spellstone") then
        return
    end

    -- local crit = mb_GetRealSpellCrit(6, "target")

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

    if not UnitBuff("player", "Soul Link") then
        CastSpellByName("Soul Link")
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_GetDebuffTimeRemaining("target", "Shadow Mastery") == 0 and mb_Warlock_shadowMasteryTimer < mb_time then
        mb_Warlock_shadowMastery = false
    end

    if UnitExists("playerpet") and mb_Warlock_petAttack then
        PetAttack()
    end

    if mb_UnitPowerPercentage("player") < 50 and mb_UnitHealthPercentage("player") > 60 then
        CastSpellByName("Life Tap")
        return
    end

    if mb_ShouldUseDpsCooldowns("Shadow Bolt") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
        CastSpellByName("Demonic Empowerment")
        if mb_CastSpellWithoutTarget("Metamorphosis") then
            CastSpellByName("Immolation Aura")
            return
        end
    end

    if mb_CastSpellWithoutTarget("Demonic Empowerment") then
        return
    end

    if mb_cleaveMode > 0 then
        local range = CheckInteractDistance("target", 2)
        if range then
            if mb_CastSpellWithoutTarget("Shadowflame") then
                return
            end
        end

        if mb_GetMyDebuffTimeRemaining("target", "Seed of Corruption") == 0 and mb_CastSpellOnTarget("Seed of Corruption") then
            return
        end
    end

    -- First spell cast is Shadow Bolt to apply 5% crit debuff to target, then the affliction locks get better Corruptions.
    if not mb_Warlock_shadowMastery and mb_CastSpellOnTarget("Shadow Bolt") and mb_Warlock_shadowMasteryTimer < mb_time then
        mb_Warlock_shadowMastery = true
        mb_Warlock_shadowMasteryTimer = mb_time + 2.5
        return
    end

    if UnitBuff("player", "Decimation") then
        if mb_CastSpellOnTarget("Soul Fire") then
            return
        end
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

    if mb_GetMyDebuffTimeRemaining("target", "Curse of Agony") == 0 and mb_CastSpellOnTarget("Curse of Agony") then
        return
    end

    if UnitBuff("player", "Molten Core") then
        if mb_CastSpellOnTarget("Incinerate") then
            return
        end
    end

    CastSpellByName("Shadow Bolt")
end