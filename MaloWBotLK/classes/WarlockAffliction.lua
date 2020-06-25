
function mb_Warlock_Affliction_OnUpdate()
    mb_Warlock_HandlePetSummon("Summon Felhunter")

    mb_Warlock_HandleFelhunterAutoCasts("Shadow Bite", "Fel Intelligence")

    --mb_Warlock_handleStones("Demonic Spellstone")

    local _, _, text = UnitCastingInfo("player")
    if text == "Channeling" then
        return
    end

    mb_Warlock_HandleLifeTap()

    if  not UnitBuff("player", "Fel Armor") then
        CastSpellByName("Fel Armor")
        return
    end

  --  if GetUnitName("player") == "Maligna" and not UnitBuff("player", "Demon Armor") then
  --      CastSpellByName("Demon Armor")
  --      return
  --  end

    if mb_UnitPowerPercentage("player") < 15 then
        CastSpellByName("Life Tap")
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

   -- if not mb_TargetHasMyDebuff("Seed of Corruption") and mb_CastSpellOnTarget("Seed of Corruption") then
   --     return
  --  end

    if not mb_TargetHasMyDebuff("Corruption") and mb_CastSpellOnTarget("Corruption") then
        return
    end

    if UnitBuff("player", "Shadow Trance") and mb_CastSpellOnTarget("Shadow Bolt") then
        return
    end

    if not mb_TargetHasMyDebuff("Curse of Agony") and mb_CastSpellOnTarget("Curse of Agony") then
        return
    end

    if not mb_TargetHasMyDebuff("Unstable Affliction") and mb_CastSpellOnTarget("Unstable Affliction") then
        return
    end

    if not mb_TargetHasMyDebuff("Haunt") and mb_CastSpellOnTarget( "Haunt") then
        return
    end

    if mb_UnitHealthPercentage("player") < 50 then
        if mb_CastSpellOnTarget("Drain Life") then
            return
        end
    end

    if mb_UnitHealthPercentage("target") < 25 then
        if mb_TargetHasMyDebuff("Drain Soul") then
            return
        end
        CastSpellByName("Drain Soul")
        return
    end

    CastSpellByName("Shadow Bolt")
end

function mb_Warlock_HandleFelhunterAutoCasts(spell1, spell2)
    local _, autostate = GetSpellAutocast(spell1, "pet")
    local _, autostate2 = GetSpellAutocast(spell2, "pet")
    if autostate == nil then
        TogglePetAutocast(6)
    end
    if autostate2 == nil then
        TogglePetAutocast(4)
    end
end