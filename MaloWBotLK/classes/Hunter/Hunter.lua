function mb_Hunter_OnLoad()
    local mb_Hunterweapon = false
    if IsEquippedItemType("Bow") then
        mb_Hunterweapon = true
        if mb_CheckAmmoAmount("Terrorshaft Arrow", 2000) == false then
            if mb_CheckAmmoAmount("Saronite Razorheads", 2000) == false then
                if mb_CheckAmmoAmount("Iceblade Arrow", 2000) == false then
                    mb_SayRaid("I'm low on Arrows.")
                end
            end
        end
    end
    if IsEquippedItemType("Gun") then
        mb_Hunterweapon = true
        if mb_CheckAmmoAmount("Frostbite Bullets", 2000) == false then
            if mb_CheckAmmoAmount("Mammoth Cutters", 2000) == false then
                if mb_CheckAmmoAmount("Shatter Rounds", 2000) == false then
                    mb_SayRaid("I'm low on Bullets.")
                end
            end
        end
    end

    if mb_Hunterweapon == false then
        mb_SayRaid("I do not have a ranged weapon equipped.")
    end

    usable, noMana = IsUsableSpell("Auto Shot")
    if usable == nil and mb_Hunterweapon == true then
        mb_SayRaid("I do not have any Ammo equipped.")
    end

    if mb_GetMySpecName() == "Beast Mastery" then
        mb_classSpecificRunFunction = mb_Hunter_BeastMastery_OnUpdate
        mb_SpecNotSupported("Beast Mastery Hunters are not yet supported")
    elseif mb_GetMySpecName() == "Marksmanship" then
        mb_classSpecificRunFunction = mb_Hunter_Marksmanship_OnUpdate
        mb_Hunter_Marksmanship_OnLoad()
    else
        mb_classSpecificRunFunction = mb_Hunter_Survival_OnUpdate
        mb_SpecNotSupported("Survival Hunters are not yet supported")
    end

    mb_RegisterInterruptSpell("Silencing Shot")

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_MIGHT)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)
end

function mb_CheckAmmoAmount(itemName, desiredItemCount)
    local currentItemCount = mb_GetItemCount(itemName)
    if currentItemCount < desiredItemCount then
        return false
    end
    return true
end