-- recommended Spec: https://wotlkdb.com/?talent#cxbZceVsohzGIsxhAox00b:fiAMz0

function mb_Hunter_Marksmanship_OnLoad()
    mb_EnableIWTDistanceClosing("Arcane Shot")
end

function mb_Hunter_Marksmanship_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if not UnitAffectingCombat("player") and not PetHasActionBar() and mb_CastSpellWithoutTarget("Revive Pet") then
        return
    end

    if not UnitAffectingCombat("player") and not PetHasActionBar() and mb_CastSpellWithoutTarget("Call Pet") then
        return
    end

    if not UnitAffectingCombat("player") and PetHasActionBar() and mb_GetBuffTimeRemaining("pet", "Mend Pet") == 0 and mb_UnitPowerPercentage("player") == 100 then
        if mb_CastSpellOnFriendly("pet", "Mend Pet") then
            return
        end
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Hunter's Mark") == 0 and mb_CastSpellOnTarget("Hunter's Mark") then
        return
    end

    if not UnitAffectingCombat("target") then
        return
    end

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if mb_GetMyThreatPercentage("target") > 85 then
        if mb_CastSpellWithoutTarget("Feign Death") then
            return
        end
    end

    if mb_ShouldUseDpsCooldowns("Steady Shot") then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Rapid Fire") then
            return
        end
        if mb_CastSpellWithoutTarget("Kill Command") then
            return
        end
    end

    if mb_cleaveMode > 0 and mb_CastSpellOnTarget("Multi-Shot") then
        return
    end

    if mb_cleaveMode > 1 and mb_CastSpellOnTarget("Volley") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Serpent Sting") == 0 and mb_CastSpellOnTarget("Serpent Sting") then 
        return
    end

    if mb_CastSpellOnTarget("Kill Shot") then
        return
    end

    if mb_CastSpellOnTarget("Chimera Shot") then
        return
    end

    if mb_CastSpellOnTarget("Arcane Shot") then
        return
    end

    if mb_CastSpellOnTarget("Steady Shot") then
        return
    end
end
