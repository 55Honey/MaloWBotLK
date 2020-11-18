-- mb_FindMissingEnchants   Makes all toons check for missing enchants (enchanters also on rings)
-- mb_FindMissingGems()     Makes all toons check for missing gems and missing prismatic sockets (blacksmiths also on gloves and bracers)
-- mb_PrintFailedCaps()     Makes all toons print caps (hit/def) which are TOO LOW or EXCEEDING the cap by 8 or more
-- mb_PrintHitCaps()        Makes all toons print only HIT caps.
-- mb_PrintAllCaps()        makes all toons print ALL caps.

-- Note: 1% Melee Hit = 32.79 hit rating, and 1% Spell Hit = 26.23 hit

function mb_CheckStatCaps()
    local mb_mySpec = mb_GetMySpecName()
    local mb_myClass = mb_GetClass("player")
    local _,mb_myRace,_ = UnitRace("player")

    CR_DEFENSE_SKILL = 2;
    CR_DODGE = 3;
    CR_PARRY = 4;
    CR_BLOCK = 5;
    CR_HIT_MELEE = 6;
    CR_HIT_RANGED = 7;
    CR_HIT_SPELL = 8;
    CR_CRIT_MELEE = 9;
    CR_CRIT_RANGED = 10;
    CR_CRIT_SPELL = 11;
    CR_HIT_TAKEN_MELEE = 12;
    CR_HIT_TAKEN_RANGED = 13;
    CR_HIT_TAKEN_SPELL = 14;
    CR_CRIT_TAKEN_MELEE = 15;
    CR_CRIT_TAKEN_RANGED = 16;
    CR_CRIT_TAKEN_SPELL = 17;
    CR_HASTE_MELEE = 18;
    CR_HASTE_RANGED = 19;
    CR_HASTE_SPELL = 20;
    CR_WEAPON_SKILL_MAINHAND = 21;
    CR_WEAPON_SKILL_OFFHAND = 22;
    CR_WEAPON_SKILL_RANGED = 23;
    CR_EXPERTISE = 24;
    CR_ARMOR_PENETRATION = 25;


    if mb_mySpec == "Blood" then
        myHitCapSoft = 263
        myHitCapHard = 289
        myExpertiseCap = 213
        myArmorPenetrationCapSoft = 1260
        myArmorPenetrationCapHard = 1400
        myDefenseCap = 566
    elseif mb_mySpec == "Frost" and mb_myClass == "DEATHKNIGHT" then
        myHitCapSoft = 289
        myHitCapHard = 886
        myExpertiseCap = 213
        myArmorPenetrationCapSoft = 1260
        myArmorPenetrationCapHard = 1400
        myDefenseCap = 566
    elseif mb_mySpec == "Unholy" then
        myHitCapSoft = 263
        myHitCapHard = 289
        myExpertiseCap = 213
        myArmorPenetrationCapSoft = 1260
        myArmorPenetrationCapHard = 1400
    elseif mb_mySpec == "Balance" then
        myHitCapHard = 263
        mySpellHasteCapHard = 585
    elseif mb_mySpec == "Feral Combat" then
        myHitCapHard = 263
        myExpertiseCap = 213
        myArmorPenetrationCapHard = 1400
    elseif mb_myClass == "ROGUE" then
        myHitCapSoft = 315
        myExpertiseCap = 213
        myArmorPenetrationCapHard = 1400
    elseif mb_mySpec == "Shadow" then
        myHitCapHard = 289
    elseif mb_mySpec == "Elemental" then
        myHitCapHard = 289
    elseif mb_mySpec == "Enhancement" then
        myHitCapSoft = 263
    elseif mb_myClass == "MAGE" and mb_mySpec == "Fire" then
        myHitCapHard = 368
    elseif mb_myClass == "MAGE" and mb_mySpec == "Arcane" then
        myHitCapHard = 289
    elseif mb_mySpec == "Affliction" then
        myHitCapHard = 289
    elseif mb_mySpec == "Demonology" then
        myHitCapHard = 368
    elseif mb_mySpec == "Destruction" then
        myHitCapHard = 368
    elseif mb_mySpec == "Arms" then
        myHitCapHard = 263
        myArmorPenetrationCapHard = 1260
        myExpertiseCap = 213
    elseif mb_mySpec == "Fury" then
        myHitCapSoft = 263
        myArmorPenetrationCapHard = 1400
        myExpertiseCap = 213
    elseif mb_mySpec == "Protection" then
        myDefenseCap = 690
    elseif mb_myClass == "HUNTER" then
        myHitCapHard = 263
        myArmorPenetrationCapHard = 1400
    elseif mb_mySpec == "Retribution" then
        myHitCapHard = 263
        myExpertiseCap = 213
    elseif mb_mySpec == "Restoration" or mb_mySpec == "Discipline" or mb_mySpec == "Holy" then
        myHitCapHard = 0
    else
        mb_SayRaid("No caps for my spec available.")
    end

    if mb_myRace == "Human" or mb_myRace == "Dwarf" or mb_myRace == "Night Elf" or mb_myRace == "Gnome" or mb_myRace == "Draenei" then --Draenei-Aura
        myHitCapHard = myHitCapHard - 26    --Spell Hit (All classes except warriors)
        if mb_myClass == "WARRIOR" then
            myHitCapHard = myHitCapHard - 8
        end
        myHitCapSoft = myHitCapSoft - 26
        if mb_myClass == "WARRIOR" then
            myHitCapSoft = myHitCapSoft - 8
        end
        if mb_commanderUnit == nil then
            mb_SayRaid("Alliance detected. Adding 1% Aura from Draenei to calculations.")
        end
    end
end

function mb_PrintAllCaps()
    mb_CheckStatCaps()
    if mb_commanderUnit == nil then
        mb_SayRaid("Requesting ALL caps:")
        mb_SendMessage("remoteExecute ", "mb_PrintAllCaps()")
    end

    if myDefenseCap then
        mb_SayRaid("My DEFENSE cap is at ".. GetCombatRating(CR_DEFENSE_SKILL).. " / ".. myDefenseCap)
    end

    if myHitCapHard then
        if myClass == "WARRIOR" then
            mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_MELEE).. " / ".. myHitCapHard)
        elseif myClass == "HUNTER" then
            mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_RANGED).. " / ".. myHitCapHard)
        else
            mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_SPELL).. " / ".. myHitCapHard)
        end
    end
    if myHitCapSoft then
        if myClass == "WARRIOR" then
            mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_MELEE).. " / ".. myHitCapSoft)
        elseif myClass == "HUNTER" then
            mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_RANGED).. " / ".. myHitCapSoft)
        else
            mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_SPELL).. " / ".. myHitCapSoft)
        end
    end
    if myExpertiseCap then
        mb_SayRaid("My EXPERTISE cap is at ".. GetCombatRating(CR_EXPERTISE).. " / ".. myExpertiseCap)
    end
    if myArmorPenetrationCapHard then
        mb_SayRaid("My AP HARD cap is at ".. GetCombatRating(CR_ARMOR_PENETRATION).. " / ".. myArmorPenetrationCapHard)
    end
    if myArmorPenetrationCapSoft then
        mb_SayRaid("My AP SOFT cap is at ".. GetCombatRating(CR_ARMOR_PENETRATION).. " / ".. myArmorPenetrationCapSoft)
    end
    if mySpellHasteCapHard then
        mb_SayRaid("My HASTE HARD cap is at ".. GetCombatRating(CR_ARMOR_PENETRATION).. " / ".. mySpellHasteCapHard)
    end
end

function mb_PrintHitCaps()
    mb_CheckStatCaps()
    if mb_commanderUnit == nil then
        mb_SayRaid("Requesting HIT caps:")
        mb_SendMessage("remoteExecute ", "mb_PrintHitCaps()")
    end
    if myHitCapHard then
        if myClass == "WARRIOR" then
            mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_MELEE).. " / ".. myHitCapHard)
        elseif myClass == "HUNTER" then
            mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_RANGED).. " / ".. myHitCapHard)
        else
            mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_SPELL).. " / ".. myHitCapHard)
        end
    end
    if myHitCapSoft then
        if myClass == "WARRIOR" then
            mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_MELEE).. " / ".. myHitCapSoft)
        elseif myClass == "HUNTER" then
            mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_RANGED).. " / ".. myHitCapSoft)
        else
            mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_SPELL).. " / ".. myHitCapSoft)
        end
    end
end

function mb_PrintFailedCaps()
    mb_CheckStatCaps()
    if mb_commanderUnit == nil then
        mb_SayRaid("Requesting FAILED caps:")
        mb_SendMessage("remoteExecute ", "mb_PrintFailedCaps()")
    end

    if myHitCapHard and myHitCapHard ~= 0 then
        if myClass == "WARRIOR" then
            if GetCombatRating(CR_HIT_MELEE) < myHitCapHard or GetCombatRating(CR_HIT_MELEE) >= myHitCapHard - 8 then
                mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_MELEE).. " / ".. myHitCapHard)
                local HardHitCapPosted = 1
            end
        elseif myClass == "HUNTER" then
            if GetCombatRating(CR_HIT_RANGED) < myHitCapHard or GetCombatRating(CR_HIT_RANGED) >= myHitCapHard - 8 then
                mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_RANGED).. " / ".. myHitCapHard)
                local HardHitCapPosted = 1
            end
        else
            if GetCombatRating(CR_HIT_SPELL) < myHitCapHard or GetCombatRating(CR_HIT_SPELL) >= myHitCapHard - 8 then
                mb_SayRaid("My HARD HITcap is at ".. GetCombatRating(CR_HIT_SPELL).. " / ".. myHitCapHard)
                local HardHitCapPosted = 1
            end
        end
    end

    if myHitCapSoft and myHitCapSoft ~= 0 then
        if myClass == "WARRIOR" then
            if GetCombatRating(CR_HIT_MELEE) < myHitCapSoft or GetCombatRating(CR_HIT_MELEE) >= myHitCapSoft - 8 then
                mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_MELEE).. " / ".. myHitCapSoft)
            else
                if HardHitCapPosted == 1 then mb_SayRaid("My Soft Hitcap is fine.") end
            end
        elseif myClass == "HUNTER" then
            if GetCombatRating(CR_HIT_RANGED) < myHitCapSoft or GetCombatRating(CR_HIT_RANGED) >= myHitCapSoft - 8 then
                mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_RANGED).. " / ".. myHitCapSoft)
            else
                if HardHitCapPosted == 1 then mb_SayRaid("My Soft Hitcap is fine.") end
            end
        else
            if GetCombatRating(CR_HIT_SPELL) < myHitCapSoft or GetCombatRating(CR_HIT_SPELL) >= myHitCapSoft - 8 then
                mb_SayRaid("My SOFT HITcap is at ".. GetCombatRating(CR_HIT_SPELL).. " / ".. myHitCapSoft)
            else
                if HardHitCapPosted == 1 then mb_SayRaid("My Soft Hitcap is fine.") end
            end
        end
    end

    if myDefenseCap and myDefenseCap ~= 0 then
        if GetCombatRating(CR_DEFENSE_SKILL) < myDefenseCap or GetCombatRating(CR_DEFENSE_SKILL) > myDefenseCap + 7 then
            mb_SayRaid("My DEFENSE cap is at ".. GetCombatRating(CR_DEFENSE_SKILL).. " / ".. myDefenseCap)
        end
    end
end

function mb_FindMissingGems()
    mb_isBlacksmith = false
    local numSkills = GetNumSkillLines()

    for i = 1, numSkills do
        if GetSkillLineInfo(i) == "Blacksmithing" then
            mb_isBlacksmith = true
        end
    end

    if mb_commanderUnit == nil then
        mb_SayRaid("Requesting missing GEMS:")
        mb_SendMessage("remoteExecute ", "mb_FindMissingGems()")
    end

    mb_PrismaticFoundWaist = 0
    mb_PrismaticFoundWrist = 0
    mb_PrismaticFoundHands = 0
    mb_GemMissing = 0

    local mb_GemInSlot
    for j = 1, 17 do
        SocketInventoryItem(j)
        local SocketCount = GetNumSockets()
        if SocketCount > 0 then
            for i = 1, SocketCount do
                mb_GemInSlot = nil
                mb_GemInSlot,_,_ = GetExistingSocketInfo(i)
                if j == 6 then
                    if GetSocketTypes(i) == "Socket" then mb_PrismaticFoundWaist = 1 end
                end
                if mb_isBlacksmith then
                    if j == 9 then
                        if GetSocketTypes(i) == "Socket" then mb_PrismaticFoundWrist = 1 end
                    end
                    if j == 10 then
                        if GetSocketTypes(i) == "Socket" then mb_PrismaticFoundHands = 1 end
                    end
                end
                if mb_GemInSlot == nil then
                    mb_Print("Gem missing at J: ".. j.. "  i: ".. i)
                    mb_GemMissing = mb_GemMissing + 1
                end
            end
        end
        CloseSocketInfo()
    end
    if mb_PrismaticFoundWaist == 0 then mb_SayRaid("Im missing an Eternal Belt Buckle.") end
    if mb_isBlacksmith then
        if mb_PrismaticFoundWrist == 0 then mb_SayRaid("Im a blacksmith and missing a prismatic socket in my BRACERS.") end
        if mb_PrismaticFoundHands == 0 then mb_SayRaid("Im a blacksmith and missing a prismatic socket in my GLOVES.") end
    end
    if mb_GemMissing > 0 then mb_SayRaid("Im missing ".. mb_GemMissing.. " gems.") end
end

function mb_FindMissingEnchants()

    if mb_commanderUnit == nil then
        mb_SayRaid("Requesting missing ENCHANTS:")
        mb_SendMessage("remoteExecute ", "mb_FindMissingEnchants()")
    end

    mb_isEnchanter = false
    local numSkills = GetNumSkillLines()

    for i = 1, numSkills do
        if GetSkillLineInfo(i) == "Enchanting" then
            mb_isEnchanter = true
        end
    end

    for j = 1, 18 do
        if j ~= 2 and j ~= 4 and j ~= 6 and j ~= 13 and j ~= 14 then
            local itemLink = GetInventoryItemLink("player", j)
            if  itemLink ~= nil then
                local itemString = string.match(itemLink, "item[%-?%d:]+")

                local suffixFactor = 0
                local linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = strsplit(":", itemString)
                suffixId = tonumber(suffixId) or 0
                uniqueId = tonumber(uniqueId) or 0
                if (linkType == 'item') then
                    if (suffixId < 0) then
                        suffixFactor = bit.band(uniqueId, 65535)
                    end
                end

                itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
                itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID,
                isCraftingReagent = GetItemInfo(itemString)
                --print(j)
                --print(enchantId)
                if enchantId == "0" and itemSubType ~= "Librams" and itemSubType ~= "Totems" and itemSubType ~= "Idols"
                        and itemSubType ~= "Miscellaneous" and itemSubType ~= "Wands" and itemSubType ~= "Sigils" then
                    --print(itemSubType)
                    if j ~= 11 and j ~= 12 then
                        --print("debug2")
                        --print(itemType)
                        --print(itemSubType)
                        mb_SayRaid("My ".. itemLink.. " is not enchanted.")
                    end

                    if mb_isEnchanter then
                        if j == 11 or j == 12 then
                            mb_SayRaid("My ".. itemLink.. " is not enchanted.")
                        end
                    end
                end
            end
        end
    end
end

function mb_FindBadGear(minItemLevel)

    if mb_commanderUnit == nil then
        mb_SayRaid("Requesting BAD gear below item level ".. minItemLevel.. ":")
        mb_SendMessage("remoteExecute ", "mb_FindBadGear(".. minItemLevel.. ")")
    end

    for j = 1, 18 do
        if j ~= 4 then
            local itemLink = GetInventoryItemLink("player", j)
            if  itemLink ~= nil then
                itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
                itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID,
                isCraftingReagent = GetItemInfo(itemLink)
                if itemLevel == nil then itemLevel = 0 end

                if itemRarity < 4 or itemLevel < minItemLevel then
                    mb_SayRaid("My ".. itemLink.. "appears to be not decent.")
                end
            end
        end
    end
end