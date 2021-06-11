mp_skinWps = {
    {x = 0.2491618, y = 0.5449632},
    {x = 0.2271046, y = 0.5745863},
    {x = 0.2272065, y = 0.5383454},
    {x = 0.2337335, y = 0.5046176},
    {x = 0.2491884, y = 0.4896558},
    {x = 0.2697878, y = 0.4665429},
    {x = 0.2879657, y = 0.4319197},
    {x = 0.2932333, y = 0.4051088},
    {x = 0.3151284, y = 0.3908018},
    {x = 0.3268077, y = 0.4253184},
    {x = 0.3039259, y = 0.4676461},
    {x = 0.2763587, y = 0.4678273},
    {x = 0.2433522, y = 0.5131002}
}
mp_currentSkinWp = 1
function mp_BossModule_SkinFarm_PreOnUpdate()
    if UnitIsDeadOrGhost("focus") then
        mb_IWTClickToMove("focus")
        return true
    end
    if UnitAffectingCombat("player") and not mb_IsValidOffensiveUnit("target", true) then
        ClearTarget()
        return true
    end
    if mb_IsValidOffensiveUnit("target", true) and CheckInteractDistance("target", 2) then
        if UnitName("target") == "Shardhorn Rhino" or UnitName("target") == "Dreadsaber" then
            FocusUnit("target")
        end
        return false
    end

    if mb_IsValidOffensiveUnit("target") and not UnitAffectingCombat("target") then
        mb_IWTClickToMove("target")
        mb_CastSpellOnTarget("Hand of Reckoning")
        return false
    end

    if not UnitExists("target") then
        TargetUnit("Dreadsaber")
        if not UnitExists("target") or not mb_IsSpellInRange("Hand of Reckoning", "target") then
            TargetUnit("Shardhorn Rhino")
            if not UnitExists("target") or not mb_IsSpellInRange("Hand of Reckoning", "target") then
                ClearTarget()
                mb_GoToPosition_SetDestination(mp_skinWps[mp_currentSkinWp].x, mp_skinWps[mp_currentSkinWp].y, 0.002, true)
                if mb_GoToPosition_Update() then
                    mp_print("Waypoint " .. tostring(mp_currentSkinWp) .. " reached.")
                    mp_currentSkinWp = mp_currentSkinWp + 1
                    if mp_currentSkinWp > 13 then
                        mp_currentSkinWp = 1
                    end
                    mp_deleteGreys()
                    return false
                else
                    return false
                end
            end
        end
        mb_IWTClickToMove("target")
        return false
    end
end

function mp_skinFarm()
    mb_BossModule_PreOnUpdate = mp_BossModule_SkinFarm_PreOnUpdate
    mb_isEnabled = true
    mb_commanderUnit = nil
end

function mp_deleteGreys()
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemLink = GetContainerItemLink(bag, slot)
            if itemLink ~= nil then
                local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
                if itemRarity == 0 then
                    mp_print("Deleted " .. itemLink)
                    PickupContainerItem(bag, slot)
                    DeleteCursorItem()
                    return
                end
            end
        end
    end
end