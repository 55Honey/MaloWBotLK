-- recommended Talents pre ICC: https://wotlkdb.com/?talent#jfVMVZZfM0Ixcdg0zx0uIqo:bspmVc

mb_Deathknight_summonGargoyle = 0

function mb_Deathknight_Unholy_OnLoad()
    mb_EnableIWTDistanceClosing("Plague Strike")
    local nStance = GetShapeshiftForm()
    if nStance ~= 1 then
        mb_SayRaid("Unholy DPS Rotation requires Blood Presence to be effective.")
    end
    mb_LastPestilenceTime = 0
end


function mb_Deathknight_Unholy_OnUpdate()

    local nStance = GetShapeshiftForm()

    if not mb_IsReadyForNewCast() then
        return
    end

    if not IsMounted() and not UnitAffectingCombat("player") and mb_CastSpellWithoutTarget("Horn of Winter") then	 -- keep buff up, use on CD. High Prio out of combat. Low prio out of combat at the end of the rotation.
        --mb_Print("HoW")
        return
    end

    if not IsMounted() and mb_GetBuffTimeRemaining("player", "Bone Shield") <= 60 and mb_CastSpellWithoutTarget("Bone Shield") then	 -- keep buff up, use on CD
        --mb_Print("BS")
        return
    end

    if not IsMounted() and mb_Deathknight_summonGhoul() then
        return
    end

    if UnitExists("playerpet") and not UnitAffectingCombat("player") then
        PetPassiveMode()
        mb_Deathknight_HandleGhoulAutoCasts("Gnaw", "Claw", "Leap")
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") and mb_Warlock_petAttack and IsPetAttackActive() == false then
        PetAttack()
    end

    if mb_Deathknight_summonGargoyle ~= 1 and nStance ~= 1 and mb_CastSpellWithoutTarget("Blood Presence") then --go back to Blood Presence if Gargoyle isnt to be cast
        --mb_Print("Blood Presence")
        return
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

    if mb_ShouldUseDpsCooldowns("Summon Gargoyle") then
        mb_UseItemCooldowns()
        if nStance == 3 and mb_CastSpellWithoutTarget("Summon Gargoyle") then --Summon Gargoyle if in Unholy Stance
            mb_Deathknight_summonGargoyle = 0
            --mb_Print("Gargoyle")
            return
        end
        if mb_DeathRuneCD() >= 1 or mb_UnholyRuneCD() >= 1 then
            if mb_UnitPowerPercentage("player") >= 60 and nstance ~= 3 and mb_GetRemainingSpellCooldown("Summon Gargoyle") == 0 then --Go to Unholy Stance before casting Gargoyle
                mb_Deathknight_summonGargoyle = 1
                mb_CastSpellWithoutTarget("Unholy Presence")
                --mb_Print("Unholy Presence")
            end
        end
    end

    if mb_cleaveMode > 0 then -- Use Blood runes for Cleave and AoE mode
        if mb_BloodRuneCD() >= 1 and mb_CastSpellOnTarget("Blood Boil") then
            --mb_Print("Blood Boil")
            return
        end
    end

    if mb_cleaveMode > 1 then -- Use Death runes for AoE mode only
        if mb_DeathRuneCD() >= 1 and mb_CastSpellOnTarget("Blood Boil") then
            --mb_Print("Blood Boil")
            return
        end
    end

    if mb_CastSpellOnTarget("Scourge Strike") then
            --mb_Print("Scourge Strike")
            return
    end

    if mb_BloodRuneCD() >= 1 and mb_Deathknight_NextBloodRune() <= mb_GetMyDebuffTimeRemaining("target", "Frost Fever") and mb_Deathknight_NextBloodRune() <= mb_GetMyDebuffTimeRemaining("target", "Blood Plague") and mb_CastSpellOnTarget("Blood Strike") then
        --mb_Print("Blood Strike")
        return
    end

    if mb_UnitPowerPercentage("player") < 80 and mb_CastSpellWithoutTarget("Horn of Winter") then	 -- keep buff up, use on CD
        --mb_Print("HoW")
        return
    end

    if not mb_ShouldUseDpsCooldowns("Summon Gargoyle") and mb_CastSpellOnTarget("Death Coil") then --use Death Coil if no Cooldowns will be used
        --mb_Print("Death Coil")
        return
    end

    if mb_GetRemainingSpellCooldown("Summon Gargoyle") > 0 and mb_CastSpellOnTarget("Death Coil") then -- use Death Coil if Gargoyle is on Cooldown
        --mb_Print("Death Coil")
        return
    end

end

