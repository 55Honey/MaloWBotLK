function mb_Deathknight_Blood_OnLoad()
    mb_RegisterExclusiveRequestHandler("taunt", mb_Deathknight_Blood_TauntAcceptor, mb_Deathknight_Blood_TauntExecutor)
    local nStance = GetShapeshiftForm()
    if nStance ~= 2 then
        mb_SayRaid("Blood Tank Rotation requires Frost Presence to be effective.")
    end
    mb_LastPestilenceTime = 0
end

function mb_Deathknight_Blood_OnUpdate()

    local nStance = GetShapeshiftForm()

    if not mb_IsReadyForNewCast() then
        return
    end

    if not IsMounted() and not UnitAffectingCombat("player") and mb_CastSpellWithoutTarget("Horn of Winter") then	 -- keep buff up, use on CD. High Prio out of combat. Low prio out of combat at the end of the rotation.
        --mb_Print("HoW")
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") and mb_Warlock_petAttack then
        PetAttack()
    end

    if mb_GetMyDebuffTimeRemaining("target", "Frost Fever") == 0 and mb_IsSpellInRange("Icy Touch") then -- Icy touch if frost fever not on target. Any Rune.
        if mb_FrostRuneCD() >= 1 or mb_DeathRuneCD() >= 1 then
            if mb_CastSpellOnTarget("Icy Touch") then
                --mb_Print("IT")
                return
            end
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Blood Plague") == 0 then -- Apply Blood plague. Any Rune.
        if mb_UnholyRuneCD() >= 1 or mb_DeathRuneCD() >= 1 then
            if mb_CastSpellOnTarget("Plague Strike") then
                --mb_Print("PS")
                return
            end
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Frost Fever") > 0 and mb_GetMyDebuffTimeRemaining("target", "Blood Plague") > 0 then
        --mb_Print("mb_ LastPestilenceTime= ".. mb_LastPestilenceTime)
        --mb_Print("mb_Time= ".. mb_time)
        if mb_LastPestilenceTime + 20 < mb_time and mb_cleaveMode > 0 and mb_CastSpellOnTarget("Pestilence") then
            --mb_Print("Pestilence1")
            mb_LastPestilenceTime = mb_time
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Frost Fever") < 3 or mb_GetMyDebuffTimeRemaining("target", "Blood Plague") < 3 then
        if mb_GetMyDebuffTimeRemaining("target", "Frost Fever") > 0 and mb_GetMyDebuffTimeRemaining("target", "Blood Plague") > 0 then
            if mb_CastSpellOnTarget("Pestilence") then
                --mb_Print("Pestilence2")
                mb_LastPestilenceTime = mb_time
                return
            end
        end
    end

    if mb_ShouldUseDpsCooldowns("Raise Dead") then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Raise Dead") then
            return
        end
        if mb_CastSpellWithoutTarget("Dancing Rune Weapon") then
            return
        end
        if mb_CastSpellOnFriendly("Ravemail", "Hysteria") then
            return
        end
    end

    if mb_cleaveMode > 0 then -- Use Blood runes for Cleave and AoE mode
        if mb_BloodRuneCD() >= 1 and mb_CastSpellOnTarget("Blood Boil") and mb_IsSpellInRange("Plague Strike") then
            --mb_Print("Blood Boil")
            return
        end
    end

    if mb_cleaveMode > 1 then -- Use Death runes for AoE mode only
        if mb_DeathRuneCD() >= 1 and mb_CastSpellOnTarget("Blood Boil") and mb_IsSpellInRange("Plague Strike") then
            --mb_Print("Blood Boil")
            return
        end
    end

    if mb_UnitHealthPercentage("player") < 95 and  mb_CastSpellOnTarget("Death Strike") then
        --mb_Print("Death Strike")
        return
    end

    if mb_FrostRuneCD() >= 1 and mb_Deathknight_NextFrostRune() <= mb_GetMyDebuffTimeRemaining("target", "Frost Fever") then
        if mb_CastSpellOnTarget("Icy Touch") then
            --mb_Print("IT2")
            return
        end
    end

    if mb_FrostRuneCD() == 2 and mb_CastSpellOnTarget("Icy Touch") then
        --mb_Print("IT3")
        return
    end

    if mb_BloodRuneCD() >= 1 and mb_Deathknight_NextBloodRune() <= mb_GetMyDebuffTimeRemaining("target", "Frost Fever") then
        if mb_Deathknight_NextBloodRune() <= mb_GetMyDebuffTimeRemaining("target", "Blood Plague") and mb_CastSpellOnTarget("Heart Strike") then
            --mb_Print("Heart Strike1")
            return
        end
    end

    if mb_BloodRuneCD() == 2 and mb_CastSpellOnTarget("Heart Strike") then
        --mb_Print("Heart Strike2")
        return
    end

    if mb_UnitPowerPercentage("player") < 80 and mb_CastSpellWithoutTarget("Horn of Winter") then	 -- keep buff up, use on CD
        --mb_Print("HoW")
        return
    end

    if mb_CastSpellOnTarget("Rune Strike") then
        --mb_Print("Rune Strike")
        return
    end

end

function mb_Deathknight_Blood_TauntAcceptor(message, from)
    mb_Print("War_Prot_TauntAcceptor")
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CanCastSpell("Dark Command", "target") then
            return true
        end
        return false
    end
end

function mb_Deathknight_Blood_TauntExecutor(message, from)
    mb_Print("War_Prot_TauntExecutor")
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CastSpellOnTarget("Dark Command") then
            mb_SayRaid("Im Taunting!")
            return true
        end
    end
    return false
end