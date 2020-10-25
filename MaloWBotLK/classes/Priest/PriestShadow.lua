-- Recommended glyphs: Shadow, Mind Flay, Dispersion, Levitate, Fortitude, Shadowfiend

-- recommended talents: https://wotlkdb.com/?talent#bVcbhZZGxfVRfzcfqfzAo:hqIzMV before 4/5 T10
-- recommended talents: https://wotlkdb.com/?talent#bVcbuZZGgf0RfzffqfzAo:hqIzMV (this spec needs Mind Blast removed from rotation)
-- /mb re mb_RemoveMindBlast = 1

-- /mb re mb_ShadowAuxiliaryMode = "MTpom"  -- "MTpom" keeps a Prayer of mending on the MainTank.
-- /mb re mb_ShadowAuxiliaryMode = "OTpom"  -- Same for "OTpom" with Offtank.
-- /mb re mb_ShadowAuxiliaryMode = nil      -- Stops Shadow Aux mode
-- /run mb_Priest_Shadow_lastHealCommand = mb_time   -- All shadow priests cast PoM, try for Divine Hymn and cast Prayer of Healing for 3 seconds. May be spammed


-- mbConfig.shadowAuxHandler must be set to match mb_myClassOrderIndex of a shadow priest. Only that toon will handle and send requests to other shadows.

-- TODO:
-- needs IWT distance closing

mb_Priest_Shadow_lastShadowFiendTime = 0
mb_Priest_lastVampiricTouchTime = 0

function mb_Priest_Shadow_OnLoad()
    mb_RegisterExclusiveRequestHandler("PrayerOfMending", mb_PriestPomAcceptor, mb_PriestPomExecutor)
    mb_Priest_Shadow_lastHealCommand = 0
end

function mb_Priest_Shadow_OnUpdate()

    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Resurrection") then
        return
    end

    local _, _, text = UnitChannelInfo("player")
    if text == "Channeling" then
        return
    end
    if text == "Divine Hymn" then
        return
    end

    if mb_Priest_Shadow_lastHealCommand + 3 > mb_time then
        if mb_CastSpellOnSelf("Prayer of Mending") then
            return
        end
        if mb_CastSpellWithoutTarget("Divine Hymn") and mb_GetRemainingSpellCooldown("Divine Hymn") == 0 then
            return
        end
        if mb_CastSpellOnSelf("Prayer of Healing") then
            return
        end
    end

    if not UnitBuff("player", "Vampiric Embrace") and mb_CastSpellWithoutTarget("Vampiric Embrace") then
        return
    end

    if not UnitBuff("player", "Inner Fire") and mb_CastSpellWithoutTarget("Inner Fire") then
        return
    end

    if GetShapeshiftForm() ~=1 then
        CastShapeshiftForm(1)
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_UnitPowerPercentage("player") < 50 and mb_CastSpellWithoutTarget("Dispersion") then
        return
    end

    if mb_UnitPowerPercentage("player") < 50 then
        mb_UseItemCooldowns()
        if mb_UnitPowerPercentage("player") < 90 and mb_ShouldUseDpsCooldowns("Shadowfiend") then
            if mb_CastSpellOnTarget("Shadowfiend") then
                local _, autostate = GetSpellAutocast("Shadowcrawl", "pet")
                if autostate == nil then
                    TogglePetAutocast(4) -- Toggle Shadowcrawl ON
                end
                mb_Priest_Shadow_lastShadowFiendTime = mb_time
                return
            elseif mb_CastSpellWithoutTarget("Hymn of Hope") and mb_Priest_Shadow_lastShadowFiendTime + 5 > mb_time then
                return
            end
        end
    end

    if mb_ShadowAuxiliaryMode ~= nil and mb_myClassOrderIndex == mbConfig.shadowAuxHandler and mb_HandleShadowAux() then  -- If mb_ShadowAuxiliaryMode is set by a macro and youre Priest#1, handle it
        return
    end

    if mb_UnitPowerPercentage("player") > 10 then
        mb_ShadowUseWand = nil
    end

    if mb_ShadowUseWand == 1 then
        return
    end

    if mb_cleaveMode == 2 and mb_GetDebuffStackCount("target", "Mind Sear") == 0 and mb_CastSpellOnTarget("Mind Sear") then --If Cleave Mode is AoE go Mind Sear with high Prio
        return
    end

    if UnitThreatSituation("player", "target") ~= nil then -- Fade if High Aggro
        if UnitThreatSituation("player", "target") >= 1 and mb_CastSpellWithoutTarget("Fade") then
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Vampiric Touch") < 1.2 and mb_Priest_lastVampiricTouchTime + 1.8 < mb_time and mb_CastSpellOnTarget("Vampiric Touch") then
        mb_Priest_lastVampiricTouchTime = mb_time
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Devouring Plague") == 0 and mb_CastSpellOnTarget("Devouring Plague") then
        return
    end

    if mb_RemoveMindBlast == nil and mb_CastSpellOnTarget("Mind Blast") then
        return
    end

    if mb_GetBuffStackCount("player", "Shadow Weaving") == 5 and mb_GetMyDebuffTimeRemaining("target", "Shadow Word: Pain") == 0 and mb_CastSpellOnTarget("Shadow Word: Pain") then
        return
    end

    if mb_cleaveMode == 1 and mb_GetDebuffStackCount("target", "Mind Sear") == 0 and mb_CastSpellOnTarget("Mind Sear") then --If Cleave Mode is AoE go Mind Sear with high Prio
        return
    end

    if mb_UnitHealthPercentage("player") > 90 and mb_CastSpellOnTarget("Shadow Word: Death") then
        return
    end

    if mb_CastSpellOnTarget("Mind Flay") then
        return
    end

    if mb_UnitPowerPercentage("player") < 2 and HasWandEquipped() ~= nil then
        mb_ShadowUseWand = 1
        local autocastable, autostate = GetSpellAutocast("Shoot", "spell")
        if autostate == 1 then
            return
        else
            if mb_CastSpellOnTarget("Shoot") then
                return
            end
        end
    end
end

function mb_HandleShadowAux()
    if mb_ShadowAuxiliaryMode == "MTpom" then
        if mb_GetBuffStackCount(mb_config.mainTank, "Prayer of Mending") == 0 then
            if mb_CastSpellOnFriendly(mb_config.mainTank, "Prayer of Mending") then
                return
            end
            mb_SendExclusiveRequest("PrayerOfMending", "")
        end
    elseif mb_ShadowAuxiliaryMode == "OTpom" then
        if mb_GetBuffStackCount(mb_config.offTank, "Prayer of Mending") == 0 then
            if mb_CastSpellOnFriendly(mb_config.offTank, "Prayer of Mending") then
                return
            end
            mb_SendExclusiveRequest("PrayerOfMending", "")
        end
    end
end

function mb_PriestPomAcceptor(message, from)
    if not mb_CanCastSpell("Prayer of Mending") or mb_GetMySpecName ~= "Shadow" then
        return false
    end
    if mb_UnitPowerPercentage("player") < 15 then
        return false
    end
    return true
end

function mb_PriestPomExecutor(message, from)
    if mb_ShadowAuxiliaryMode == "MTpom" then
        if mb_CastSpellOnFriendly(mb_config.mainTank, "Prayer of Mending") then
            return true
        end
        return false
    end
    if mb_ShadowAuxiliaryMode == "OTpom" then
        if mb_CastSpellOnFriendly(mb_config.offTank, "Prayer of Mending") then
            return true
        end
        return false

    end
end