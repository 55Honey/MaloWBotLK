
function mb_Warlock_Affliction_OnUpdate()
    mb_Warlock_HandlePetSummon("Summon Felhunter")

    mb_Warlock_HandleFelhunterAutoCasts("Shadow Bite", "Fel Intelligence")

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

  -- if UnitName("player") == "Maligna" and not UnitBuff("player", "Demon Armor") then
  --      CastSpellByName("Demon Armor")
  --      return
  --  end

    if mb_UnitPowerPercentage("player") < 50  and mb_UnitHealthPercentage("player") > 90 then
        CastSpellByName("Life Tap")
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") then
        PetAttack()
    end

  --  if mb_CastSpellWithoutTarget("Shadow Ward") then

  --  end
    if mb_ShouldUseDpsCooldowns("Corruption") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
    end

    if mb_cleaveMode > 0 and mb_GetMyDebuffTimeRemaining("target", "Seed of Corruption") == 0 and mb_CastSpellOnTarget("Seed of Corruption") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target","Corruption") == 0 and mb_CastSpellOnTarget("Corruption") then
        return
    end

    if UnitBuff("player", "Shadow Trance") and mb_CastSpellOnTarget("Shadow Bolt") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target","Curse of Agony") == 0 and mb_CastSpellOnTarget("Curse of Agony") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target","Unstable Affliction") == 0 and mb_CastSpellOnTarget("Unstable Affliction") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target","Haunt") < 0.75 and mb_CastSpellOnTarget("Haunt") then
        return
    end

    if mb_UnitHealthPercentage("player") < 40 then
        if mb_CastSpellOnTarget("Drain Life") then
            return
        end
    end

    if mb_UnitHealthPercentage("target") < 25 then
        if mb_GetMyDebuffTimeRemaining("target","Drain Soul") == 0 then
            return
        end
        CastSpellByName("Drain Soul")
        return
    end

    CastSpellByName("Shadow Bolt")
end