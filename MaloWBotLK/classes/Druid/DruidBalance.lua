mb_druid_lastEclipseSolar = false
mb_druid_lastEclipseLunar = false

function mb_Druid_Balance_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Druid_ReadyCheck)
    mb_RegisterExclusiveRequestHandler("cr", mb_Druid_CombatRessRequestAcceptor, mb_Druid_CombatRessRequestExecutor)
    mb_desiredFlaskEffect = 67016 --67016=SP, 67017=AP, 67018=Strength
end

function mb_Druid_Balance_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    local nStance = GetShapeshiftForm();

    if nStance ~= 5 then
        CastShapeshiftForm(5)
        return
    end

    if nStance == 5 then
        mb_Druid_Moonkin_OnUpdate()
        return
    end
end

function mb_Druid_Moonkin_OnUpdate()

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    for _, name in pairs(mb_config.innervateTargets) do
        if mb_Druid_Innervate(name) then
            return
        end
    end

	mb_HandleAutomaticSalvationRequesting()

    if mb_ShouldUseDpsCooldowns("Wrath") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Starfall") then
            return
        end
    end

    if mb_cleaveMode > 0 and mb_CastSpellWithoutTarget("Starfall") then
        return
    end

    if UnitHealth("target") > 100000 and mb_CanCastSpell("Moonfire") and mb_GetMyDebuffTimeRemaining("target", "Moonfire") == 0 then
        CastSpellByName("Moonfire")
        return
    end

    if UnitHealth("target") > 100000 and mb_CanCastSpell("Insect Swarm") and mb_GetMyDebuffTimeRemaining("target", "Insect Swarm") == 0 then
        CastSpellByName("Insect Swarm")        return
    end

    if UnitHealth("target") > 100000 and mb_CanCastSpell("Faerie Fire") and mb_GetMyDebuffTimeRemaining("target", "Faerie Fire") == 0 then
        CastSpellByName("Faerie Fire")
        return
    end

    if UnitBuff("player", "Eclipse (Solar)") then
        mb_druid_lastEclipseSolar = true
        mb_druid_lastEclipseLunar = false
    end

    if UnitBuff("player", "Eclipse (Lunar)") then
        mb_druid_lastEclipseLunar = true
        mb_druid_lastEclipseSolar = false
    end

    if mb_Druid_HandleEclipse(mb_druid_lastEclipseSolar, mb_druid_lastEclipseLunar) then
        return
    end

    CastSpellByName("Wrath")
end

function mb_Druid_HandleEclipse(solar, lunar)
    if solar == true and mb_CanCastSpell("Wrath") then
        CastSpellByName("Wrath")
        return true
    end
    if lunar == true and mb_CanCastSpell("Starfire") then
        CastSpellByName("Starfire")
        return true
    end

    return false
end