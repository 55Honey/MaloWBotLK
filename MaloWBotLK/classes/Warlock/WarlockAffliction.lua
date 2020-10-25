--TODO
-- Snapshotting of Corruption. Calculate current statistics, crit% based on target debuffs and my buffs
-- Store current total crit chance as a variable, and check it each frame, if
-- Drain life may not work on mechanicals
-- Drain Soul interrupt to refresh affliction debuff
-- Check if summoning new pet, if pet already exists
-- Possible mb_isMoving() check for Shadowflaming in cleaveMode

mb_Warlock_executeCorruption = false
mb_Warlock_lastUnstableTime = 0

function mb_Warlock_Affliction_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Warlock_ReadyCheck)
end

function mb_Warlock_Affliction_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    mb_Warlock_HandlePetSummon("Summon Felhunter")

    mb_Warlock_HandleFelhunterAutoCasts("Fel Intelligence", "Shadow Bite")

    if not mb_Warlock_HandleStones("Grand Spellstone") then
        return
    end

    if UnitExists("playerpet") then
        PetPassiveMode()
    end

    mb_Warlock_HandleLifeTap()

    if not UnitBuff("player", "Fel Armor") then
        CastSpellByName("Fel Armor")
        return
    end

   -- if UnitName("player") == "Maligna" and not UnitBuff("player", "Demon Armor") then
   --      CastSpellByName("Demon Armor")
   --      return
   -- end

    if not mb_AcquireOffensiveTarget() then
        return
    end

	mb_HandleAutomaticSalvationRequesting()

    if mb_UnitHealthPercentage("target") > 35 and mb_Warlock_executeCorruption then
        mb_Warlock_executeCorruption = false
    end

    if UnitExists("playerpet") and mb_Warlock_petAttack then
        PetAttack()
    end

    if mb_UnitPowerPercentage("player") < 50 and mb_UnitHealthPercentage("player") > 60 then
        CastSpellByName("Life Tap")
        return
    end

    if mb_ShouldUseDpsCooldowns("Corruption") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
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

    local _, _, text = UnitChannelInfo("player")
    if text == "Channeling" then
        if mb_GetMyDebuffTimeRemaining("target", "Haunt") < 2.5 then
            if mb_CastSpellOnTarget("Haunt") then
                return
            end
        end

        return
    end

    if UnitDebuff("target", "Shadow Mastery") and mb_GetMyDebuffTimeRemaining("target", "Corruption") == 0 and mb_CastSpellOnTarget("Corruption") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Haunt") < 1.2 and mb_CastSpellOnTarget("Haunt") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Unstable Affliction") < 1.2 and mb_Warlock_lastUnstableTime + 2.0 < mb_time and mb_CastSpellOnTarget("Unstable Affliction") then
        mb_Warlock_lastUnstableTime = mb_time
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Curse of Agony") == 0 and mb_CastSpellOnTarget("Curse of Agony") then
        return
    end

    if UnitBuff("player", "Shadow Trance") and mb_CastSpellOnTarget("Shadow Bolt") then
        return
    end

    if mb_UnitHealthPercentage("player") < 30 then
        if mb_CastSpellOnTarget("Drain Life") then
            return
        end
    end

    if mb_UnitHealthPercentage("target") < 35 and UnitHealth("target") > 150000 and not mb_Warlock_executeCorruption then
        if mb_CastSpellOnTarget("Corruption") then
            mb_Warlock_executeCorruption = true
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Drain Soul") == 0 and mb_UnitHealthPercentage("target") < 25 then
        if mb_CastSpellOnTarget("Drain Soul") then
            return
        end
    end

    CastSpellByName("Shadow Bolt")
end