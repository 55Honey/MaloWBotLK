-- mb_config.ImpInactive == UnitName("player") prevents the Imp from going out of Phase Shift
mb_Warlock_lastImmolateTime = 0
mb_Warlock_shadowMastery = false

function mb_Warlock_Destruction_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Warlock_ReadyCheck)
end

function mb_Warlock_Destruction_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end
    mb_Warlock_HandlePetSummon("Summon Imp")

    mb_Warlock_HandleImpAutoCasts("Fire Shield","Blood Pact", "Firebolt", "Phase Shift")

    if not mb_Warlock_HandleStones("Grand Firestone") then
        return
    end

    if UnitExists("playerpet") then
        PetPassiveMode()
    end

    local _, _, text = UnitChannelInfo("player")
    if text == "Channeling" then
        return
    end

    -- instead of mb_Warlock_HandleLifeTap()
    if mb_UnitPowerPercentage("player") < 95 and not UnitAffectingCombat("player") and mb_UnitHealthPercentage("player") > 80 then
        CastSpellByName("Life Tap")
        return
    end

    if not UnitBuff("player", "Fel Armor") then
        CastSpellByName("Fel Armor")
        return
    end

    if mb_GetBuffTimeRemaining("player", "Blood Pact") == 0 and mb_CastSpellWithoutTarget("Blood Pact") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        mb_Warlock_shadowMastery = false
        return
    end

    if UnitExists("playerpet") and mb_Warlock_petAttack then
        PetAttack()
    end

    if mb_UnitPowerPercentage("player") < 50  and mb_UnitHealthPercentage("player") > 60 then
        CastSpellByName("Life Tap")
        return
    end

    if mb_UnitPowerPercentage("player") < 50 and mb_UnitHealthPercentage("player") > 60 then
        CastSpellByName("Life Tap")
        return
    end

    if mb_ShouldUseDpsCooldowns("Shadow Bolt") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()

        if mb_CastSpellOnTarget("Curse of Doom") then
            return
        end
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

    if mb_GetMyDebuffTimeRemaining("target", "Corruption") == 0 and mb_CastSpellOnTarget("Corruption") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Immolate") < 1.2 and mb_Warlock_lastImmolateTime + 1.5 < mb_time and mb_CastSpellOnTarget("Immolate") then
        mb_Warlock_lastImmolateTime = mb_time
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Curse of Agony") == 0 and mb_GetMyDebuffTimeRemaining("target", "Curse of Doom") == 0 and mb_CastSpellOnTarget("Curse of Agony") then
        return
    end

    if mb_CastSpellOnTarget("Conflagrate") then
        return
    end

    if mb_CastSpellOnTarget("Chaos Bolt") then

    end

    if mb_CastSpellOnTarget("Incinerate") then
        return
    end

end

function mb_Warlock_HandleImpAutoCasts(spell1, spell2, spell3, spell4)
    local _, autostate = GetSpellAutocast(spell1, "pet")
    local _, autostate2 = GetSpellAutocast(spell2, "pet")
    local _, autostate3 = GetSpellAutocast(spell3, "pet")
    local _, autostate4 = GetSpellAutocast(spell4, "pet")

    if autostate == 1 then
        TogglePetAutocast(4) -- Toggle Fire Shield Pact OFF
    end
    if autostate2 == nil then
        TogglePetAutocast(5) -- Toggle Blood Pact ON
    end
    if autostate3 == nil and mb_config.ImpInactive == nil or mb_config.ImpInactive ~= UnitName("player") and mb_config.ImpInactive ~= nil then
        TogglePetAutocast(6) -- Toggle Firebolt ON
    end
    if autostate4 == nil then
        TogglePetAutocast(7) -- Toggle Phase Shift ON
    end
end
