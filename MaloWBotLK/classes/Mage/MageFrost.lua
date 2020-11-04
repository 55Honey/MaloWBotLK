function mb_Mage_Frost_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Mage_Frost_ReadyCheck)
end

function mb_Mage_Frost_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_mage_Frost_CastArmor() then
        return
    end

    if mb_Mage_HandleManaGem("Mana Sapphire") then
        return
    end

    if mb_CleanseRaid("Remove Curse", "Curse") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    mb_HandleAutomaticSalvationRequesting()

    if mb_UnitPowerPercentage("player") < 35 and mb_CanCastSpell("Evocation") then
        CastSpellByName("Evocation")
        return
    end

    if mb_UnitPowerPercentage("player") < 65 and UnitAffectingCombat("player") then
        mb_UseItem("Mana Sapphire")
    end

    if mb_cleaveMode > 1 then
        local range = CheckInteractDistance("target", 2)
        if range then
            if mb_CastSpellWithoutTarget("Arcane Explosion") then
                return
            end
        end
    end

    if UnitBuff("player", "Fingers of Frost") and mb_CanCastSpell("Deep Freeze", player) then
        mb_CastSpellOnTarget("Deep Freeze")
        return
    end

    if UnitBuff("player", "Fireball!") then
        mb_CastSpellOnTarget("Frostfire Bolt")
        mb_CastSpellOnTarget("Fireball")
        return
    end

    if mb_IsMoving() and mb_CastSpellOnTarget("Fire Blast") then
        return
    end

    if mb_IsMoving() and mb_CastSpellOnTarget("Ice Lance") then
        return
    end

    if mb_CastSpellOnTarget("Frostbolt") then
        return
    end
end

function mb_mage_Frost_CastArmor()
    local spell = "Molten Armor"
    if not UnitBuff("player", spell) then
        return mb_CastSpellWithoutTarget(spell)
    end
    return false
end

function mb_Mage_Frost_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Molten Armor") < 540 then
        CancelUnitBuff("player", "Molten Armor")
        ready = false
    end

    return ready
end