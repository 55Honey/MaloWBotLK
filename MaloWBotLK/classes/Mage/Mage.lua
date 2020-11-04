function mb_Mage_OnLoad()
    if mb_GetMySpecName() == "Arcane" then
        mb_classSpecificRunFunction = mb_Mage_Arcane_OnUpdate
        mb_Mage_Arcane_OnLoad()
    elseif mb_GetMySpecName() == "Fire" then
        mb_classSpecificRunFunction = mb_Mage_Fire_OnUpdate
        mb_SpecNotSupported("Fire Mages are not yet supported")
    else
        mb_classSpecificRunFunction = mb_Mage_Frost_OnUpdate
    end

    if mb_myClassOrderIndex == 1 then
        mb_RegisterMessageHandler(BUFF_INTELLECT.requestType, mb_Mage_IntellectHandler)
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_MIGHT)    -- Warlock pets count as mages, they need might
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)

    mb_CheckReagentAmount("Arcane Powder", 200)
end

function mb_Mage_HandleIntellect(targetPlayerName, greaterSpell)
    --, singleSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellWithoutTarget(greaterSpell) then
        return
    end
    --mb_CastSpellWithoutTarget(mb_getUnitForPlayerName(targetPlayerName), singleSpell)
end

function mb_Mage_IntellectHandler(msg, from)
    mb_Mage_HandleIntellect(from, "Arcane Brilliance")--, "Arcane Intellect")
end

function mb_Mage_HandleManaGem(itemName)
    if UnitAffectingCombat("player") then
        return false
    end

    if mb_GetItemLocation(itemName) == nil then
        mb_CastSpellWithoutTarget("Conjure Mana Gem")
        return true
    end

    local count = GetItemCount("Mana Sapphire", nil, true)
    if count < 3 then
        mb_CastSpellWithoutTarget("Conjure Mana Gem")
        return true
    end

    return false
end