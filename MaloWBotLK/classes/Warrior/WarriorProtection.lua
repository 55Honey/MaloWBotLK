-- talents: https://wotlkdb.com/?talent#LAZhiZVItrx0didczsGo:dTimo

-- to-Do:
-- add Spell Reflection based on a list of non interruptable spells
-- make a use of Mocking blow


function mb_Warrior_Protection_OnLoad()
    mb_EnableIWTDistanceClosing("Sunder Armor")
    mb_CombatLogModule_Enable()
    mb_RegisterExclusiveRequestHandler("taunt", mb_Warrior_Protection_TauntAcceptor, mb_Warrior_Protection_TauntExecutor)
    mb_RegisterInterruptSpell("Shield Bash")
end

function mb_Warrior_Protection_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if GetShapeshiftForm() ~= 2 then
        mb_CastSpellWithoutTarget("Defensive Stance")
        return
    end

    if mb_myClassOrderIndex == 1 and mb_Warrior_CommandingShout() then -- only the first warrior in alphabetical order should cast this
        return
    end

    if not mb_UnitHasMyBuff("Honeyowl", "Vigilance") and mb_CastSpellOnFriendly("Honeyowl", "Vigilance") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if not UnitAffectingCombat("player") then
        return
    end

    if mb_CastSpellOnTarget("Heroic Throw") then
        return
    end

    if mb_GetRemainingSpellCooldown("Shield Block") == 0 and mb_CastSpellWithoutTarget("Shield Block") then
        return
    end

    if UnitAffectingCombat("player") and mb_UnitHealthPercentage("player") < 30 then
        if mb_CastSpellWithoutTarget("Last Stand") then
            return
        end
    end

    if mb_GetDebuffTimeRemaining("target", "Sunder Armor") < 6 and mb_CastSpellOnTarget("Devastate") then
        if UnitPower("player") >= 30 and mb_CastSpellWithoutTarget("Devastate") then
            return
        end
    end

    if mb_IsSpellInRange("Sunder Armor", "target") and mb_myClassOrderIndex == 1 then -- only the first warrior in alphabetical order should cast this
        if not UnitDebuff("target", "Demoralizing Shout") and not UnitDebuff("target", "Demoralizing Roar") then
            if mb_CastSpellWithoutTarget("Demoralizing Shout") then
                return
            end
        end
    end

    if mb_IsSpellInRange("Sunder Armor", "target") then
        if not UnitDebuff("target", "Thunder Clap") and UnitPower("player") >= 31 and mb_CastSpellWithoutTarget("Thunder Clap") then
            return
        end
    end

    if mb_GetRemainingSpellCooldown("Shield Slam") == 0 and UnitPower("player") >= 30 and mb_CastSpellOnTarget("Shield Slam") then
        return
    end

    if mb_GetRemainingSpellCooldown("Revenge") == 0 and UnitPower("player") >= 30 and mb_CastSpellOnTarget("Revenge") then
        return
    end

    if mb_cleaveMode > 0 then
        mb_CastSpellOnTarget("Cleave")
    else
        mb_CastSpellOnTarget("Heroic Strike")
    end

end


function mb_Warrior_Protection_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Commanding Shout") < 60 then
        CancelUnitBuff("player", "Commanding Shout")
        ready = false
    end
    return ready
end

function mb_Warrior_Protection_TauntAcceptor(message, from)
    mb_Print("War_Prot_TauntAcceptor")
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CanCastSpell("Taunt", "target") then
            return true
        end
        return false
    end
end

function mb_Warrior_Protection_TauntExecutor(message, from)
    mb_Print("War_Prot_TauntExecutor")
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CastSpellOnTarget("Taunt") then
            mb_SayRaid("Im Taunting!")
            return true
        end
    end
    return false
end