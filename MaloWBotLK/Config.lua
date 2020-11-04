mb_config ={}

mb_config.tanks = {"Fahrif", "Naina", "Honey", "Zakki"}
mb_config.mainTank = "Fahrif"
mb_config.offTank = "Naina"

mb_config.trustedCharacters = {}
table.insert(mb_config.trustedCharacters, "Honey")
table.insert(mb_config.trustedCharacters, "Ravemail")
table.insert(mb_config.trustedCharacters, "Predetar")
table.insert(mb_config.trustedCharacters, "Sanjana")
table.insert(mb_config.trustedCharacters, "Naina")
table.insert(mb_config.trustedCharacters, "Felide")
table.insert(mb_config.trustedCharacters, "Ilnara")
table.insert(mb_config.trustedCharacters, "Irenia")
table.insert(mb_config.trustedCharacters, "Honeyowl")
table.insert(mb_config.trustedCharacters, "Totemtoni")
table.insert(mb_config.trustedCharacters, "Totemtina")
table.insert(mb_config.trustedCharacters, "Totemtuna")
table.insert(mb_config.trustedCharacters, "Totemtone")
table.insert(mb_config.trustedCharacters, "Fahrif")
table.insert(mb_config.trustedCharacters, "Elanya")
table.insert(mb_config.trustedCharacters, "Tristan")
table.insert(mb_config.trustedCharacters, "Mortifer")
table.insert(mb_config.trustedCharacters, "Draegan")
table.insert(mb_config.trustedCharacters, "Khirali")
table.insert(mb_config.trustedCharacters, "Rincewind")
table.insert(mb_config.trustedCharacters, "Philina")
table.insert(mb_config.trustedCharacters, "Abbigail")
table.insert(mb_config.trustedCharacters, "Asteria")
table.insert(mb_config.trustedCharacters, "Fantine")
table.insert(mb_config.trustedCharacters, "Deniece")
table.insert(mb_config.trustedCharacters, "Sothien")
table.insert(mb_config.trustedCharacters, "Zakki")
table.insert(mb_config.trustedCharacters, "Terpentin")

function mb_IsTrustedCharacter(charName)
    for _, name in pairs(mb_config.trustedCharacters) do
        if name == charName then
            return true
        end
    end
    return false
end


-- List of waters that should be drunk
mb_config.waters = {}
table.insert(mb_config.waters, "Conjured Mana Strudel")


-- Class Order is the alphabetical order that the character is within its own class
mb_config.classOrder = {}
mb_config.classOrder.sancBlesser = 1
mb_config.classOrder.kingsBlesser = 2
mb_config.classOrder.wisdomBlesser = 3
mb_config.classOrder.mightBlesser = 4
mb_config.classOrder.retriAura = 1
mb_config.classOrder.concentrationAura = 2
mb_config.classOrder.frostAura = 3
mb_config.classOrder.devoAura = 4
mb_config.classOrder.fireAura = 5
mb_config.classOrder.crusaderAura = 6
mb_config.classOrder.shadowAura = 7


-- Blacklisted interrupt spells, spell that are not interruptible but that shows as interruptible
mb_config.blacklistedInterruptSpells = {}
mb_config.blacklistedInterruptSpells["Malygos"] = { "Arcane Breath" }
mb_config.blacklistedInterruptSpells["Sartharion"] = { "Flame Breath" }


-- -----------------------------------------------
-- Raid Layout for invite macros
-- -----------------------------------------------
mb_config.raidLayout = {}
mb_config.raidLayout["40man"] = {}
mb_config.raidLayout["40man"][1] = {}
table.insert(mb_config.raidLayout["40man"][1], "Fahrif")
table.insert(mb_config.raidLayout["40man"][1], "Irenia")
table.insert(mb_config.raidLayout["40man"][1], "Felide")
table.insert(mb_config.raidLayout["40man"][1], "Predetar")
table.insert(mb_config.raidLayout["40man"][1], "Desire")
mb_config.raidLayout["40man"][2] = {}
table.insert(mb_config.raidLayout["40man"][2], "Philina")
table.insert(mb_config.raidLayout["40man"][2], "Honey")
table.insert(mb_config.raidLayout["40man"][2], "Mortifer")
table.insert(mb_config.raidLayout["40man"][2], "Sanjana")
table.insert(mb_config.raidLayout["40man"][2], "Totemtoni")
mb_config.raidLayout["40man"][3] = {}
table.insert(mb_config.raidLayout["40man"][3], "Abbigail")
table.insert(mb_config.raidLayout["40man"][3], "Rincewind")
table.insert(mb_config.raidLayout["40man"][3], "Khirali")
table.insert(mb_config.raidLayout["40man"][3], "Honeyowl")
table.insert(mb_config.raidLayout["40man"][3], "Totemtina")
mb_config.raidLayout["40man"][4] = {}
table.insert(mb_config.raidLayout["40man"][4], "Ravemail")
table.insert(mb_config.raidLayout["40man"][4], "Naina")
table.insert(mb_config.raidLayout["40man"][4], "Elanya")
table.insert(mb_config.raidLayout["40man"][4], "Draegan")
table.insert(mb_config.raidLayout["40man"][4], "Totemtuna")
mb_config.raidLayout["40man"][5] = {}
table.insert(mb_config.raidLayout["40man"][5], "Zakki")
table.insert(mb_config.raidLayout["40man"][5], "Hnymagethree")
table.insert(mb_config.raidLayout["40man"][5], "Ilnara")
table.insert(mb_config.raidLayout["40man"][5], "Tristan")
table.insert(mb_config.raidLayout["40man"][5], "Totemtone")
mb_config.raidLayout["40man"][6] = {}
table.insert(mb_config.raidLayout["40man"][6], "Hnymagefour")
table.insert(mb_config.raidLayout["40man"][6], "Hnymagefive")
table.insert(mb_config.raidLayout["40man"][6], "Hnylockthree")
table.insert(mb_config.raidLayout["40man"][6], "Hnylockfour")
table.insert(mb_config.raidLayout["40man"][6], "Hnylockfive")
mb_config.raidLayout["40man"][7] = {}
table.insert(mb_config.raidLayout["40man"][7], "Totemtani")
table.insert(mb_config.raidLayout["40man"][7], "Terpentin")
table.insert(mb_config.raidLayout["40man"][7], "Asteria")
table.insert(mb_config.raidLayout["40man"][7], "Fantine")
table.insert(mb_config.raidLayout["40man"][7], "Deniece")
mb_config.raidLayout["40man"][8] = {}
table.insert(mb_config.raidLayout["40man"][8], "Sothien")
table.insert(mb_config.raidLayout["40man"][8], "Yaiel")
table.insert(mb_config.raidLayout["40man"][8], "Dardan")
table.insert(mb_config.raidLayout["40man"][8], "Alon")
table.insert(mb_config.raidLayout["40man"][8], "Kyra")

mb_config.raidLayout["25man"] = {}
mb_config.raidLayout["25man"][1] = {}
table.insert(mb_config.raidLayout["25man"][1], "Fahrif")
table.insert(mb_config.raidLayout["25man"][1], "Irenia")
table.insert(mb_config.raidLayout["25man"][1], "Felide")
table.insert(mb_config.raidLayout["25man"][1], "Predetar")
table.insert(mb_config.raidLayout["25man"][1], "Rincewind")
mb_config.raidLayout["25man"][2] = {}
table.insert(mb_config.raidLayout["25man"][2], "Philina")
table.insert(mb_config.raidLayout["25man"][2], "Honey")
table.insert(mb_config.raidLayout["25man"][2], "Mortifer")
table.insert(mb_config.raidLayout["25man"][2], "Sanjana")
table.insert(mb_config.raidLayout["25man"][2], "Totemtoni")
mb_config.raidLayout["25man"][3] = {}
table.insert(mb_config.raidLayout["25man"][3], "Abbigail")
table.insert(mb_config.raidLayout["25man"][3], "Asteria")
table.insert(mb_config.raidLayout["25man"][3], "Khirali")
table.insert(mb_config.raidLayout["25man"][3], "Honeyowl")
table.insert(mb_config.raidLayout["25man"][3], "Totemtina")
mb_config.raidLayout["25man"][4] = {}
table.insert(mb_config.raidLayout["25man"][4], "Ravemail")
table.insert(mb_config.raidLayout["25man"][4], "Naina")
table.insert(mb_config.raidLayout["25man"][4], "Elanya")
table.insert(mb_config.raidLayout["25man"][4], "Draegan")
table.insert(mb_config.raidLayout["25man"][4], "Totemtuna")
mb_config.raidLayout["25man"][5] = {}
table.insert(mb_config.raidLayout["25man"][5], "Zakki")
table.insert(mb_config.raidLayout["25man"][5], "Terpentin")
table.insert(mb_config.raidLayout["25man"][5], "Ilnara")
table.insert(mb_config.raidLayout["25man"][5], "Tristan")
table.insert(mb_config.raidLayout["25man"][5], "Totemtone")

mb_config.raidLayout["10man"] = {}
mb_config.raidLayout["10man"][1] = {}
table.insert(mb_config.raidLayout["10man"][1], "Terpentin")
table.insert(mb_config.raidLayout["10man"][1], "Draegan")
table.insert(mb_config.raidLayout["10man"][1], "Naina")
table.insert(mb_config.raidLayout["10man"][1], "Totemtoni")
table.insert(mb_config.raidLayout["10man"][1], "Fahrif")
mb_config.raidLayout["10man"][2] = {}
table.insert(mb_config.raidLayout["10man"][2], "Predetar")
table.insert(mb_config.raidLayout["10man"][2], "Sanjana")
table.insert(mb_config.raidLayout["10man"][2], "Tristan")
table.insert(mb_config.raidLayout["10man"][2], "Mortifer")
table.insert(mb_config.raidLayout["10man"][2], "Felide")



-- -----------------------------------------------
-- Stat Weights for lootcouncil with /mb lc
-- -----------------------------------------------
mb_config.statWeights = {}
-- Paladin
mb_config.statWeights["Paladin"] = {}
-- Holy
mb_config.statWeights["Paladin"]["Holy"] = {}
mb_config.statWeights["Paladin"]["Holy"].agility = 0.0
mb_config.statWeights["Paladin"]["Holy"].intellect = 1.0
mb_config.statWeights["Paladin"]["Holy"].spirit = 0.0
mb_config.statWeights["Paladin"]["Holy"].strength = 0.0
mb_config.statWeights["Paladin"]["Holy"].stamina = 0.1
mb_config.statWeights["Paladin"]["Holy"].critRating = 0.46
mb_config.statWeights["Paladin"]["Holy"].resilienceRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].defenseRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].expertiseRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].dodgeRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].parryRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].blockRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].armorPenetrationRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].hitRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].hasteRating = 0.35
mb_config.statWeights["Paladin"]["Holy"].attackPower = 0.0
mb_config.statWeights["Paladin"]["Holy"].armor = 0.0
mb_config.statWeights["Paladin"]["Holy"].blockValue = 0.0
mb_config.statWeights["Paladin"]["Holy"].spellPower = 0.58
mb_config.statWeights["Paladin"]["Holy"].mp5 = 0.88
mb_config.statWeights["Paladin"]["Holy"].dps = 0.0
mb_config.statWeights["Paladin"]["Holy"].socketMeta = 100
mb_config.statWeights["Paladin"]["Holy"].socketColored = 16
-- Protection
mb_config.statWeights["Paladin"]["Protection"] = {}
mb_config.statWeights["Paladin"]["Protection"].agility = 0.6
mb_config.statWeights["Paladin"]["Protection"].intellect = 0.0
mb_config.statWeights["Paladin"]["Protection"].spirit = 0.0
mb_config.statWeights["Paladin"]["Protection"].strength = 0.16
mb_config.statWeights["Paladin"]["Protection"].stamina = 1.0
mb_config.statWeights["Paladin"]["Protection"].critRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].resilienceRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].defenseRating = 0.45
mb_config.statWeights["Paladin"]["Protection"].expertiseRating = 0.59
mb_config.statWeights["Paladin"]["Protection"].dodgeRating = 0.55
mb_config.statWeights["Paladin"]["Protection"].parryRating = 0.30
mb_config.statWeights["Paladin"]["Protection"].blockRating = 0.07
mb_config.statWeights["Paladin"]["Protection"].armorPenetrationRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].hitRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].hasteRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].attackPower = 0.0
mb_config.statWeights["Paladin"]["Protection"].armor = 0.08
mb_config.statWeights["Paladin"]["Protection"].blockValue = 0.06
mb_config.statWeights["Paladin"]["Protection"].spellPower = 0.0
mb_config.statWeights["Paladin"]["Protection"].mp5 = 0.0
mb_config.statWeights["Paladin"]["Protection"].dps = 0.0
mb_config.statWeights["Paladin"]["Protection"].socketMeta = 100
mb_config.statWeights["Paladin"]["Protection"].socketColored = 16
-- Retribution
mb_config.statWeights["Paladin"]["Retribution"] = {}
mb_config.statWeights["Paladin"]["Retribution"].agility = 0.32
mb_config.statWeights["Paladin"]["Retribution"].intellect = 0.0
mb_config.statWeights["Paladin"]["Retribution"].spirit = 0.0
mb_config.statWeights["Paladin"]["Retribution"].strength = 0.8
mb_config.statWeights["Paladin"]["Retribution"].stamina = 0.01
mb_config.statWeights["Paladin"]["Retribution"].critRating = 0.4
mb_config.statWeights["Paladin"]["Retribution"].resilienceRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].defenseRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].expertiseRating = 0.66
mb_config.statWeights["Paladin"]["Retribution"].dodgeRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].parryRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].blockRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].armorPenetrationRating = 0.22
mb_config.statWeights["Paladin"]["Retribution"].hitRating = 1.0
mb_config.statWeights["Paladin"]["Retribution"].hasteRating = 0.3
mb_config.statWeights["Paladin"]["Retribution"].attackPower = 0.34
mb_config.statWeights["Paladin"]["Retribution"].armor = 0.0
mb_config.statWeights["Paladin"]["Retribution"].blockValue = 0.0
mb_config.statWeights["Paladin"]["Retribution"].spellPower = 0.09
mb_config.statWeights["Paladin"]["Retribution"].mp5 = 0.0
mb_config.statWeights["Paladin"]["Retribution"].dps = 0.0
mb_config.statWeights["Paladin"]["Retribution"].socketMeta = 100
mb_config.statWeights["Paladin"]["Retribution"].socketColored = 16

-- Shaman
mb_config.statWeights["Shaman"] = {}
-- Enhancement
mb_config.statWeights["Shaman"]["Enhancement"] = {}
mb_config.statWeights["Shaman"]["Enhancement"].agility = 0.55
mb_config.statWeights["Shaman"]["Enhancement"].intellect = 0.55
mb_config.statWeights["Shaman"]["Enhancement"].spirit = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].strength = 0.35
mb_config.statWeights["Shaman"]["Enhancement"].stamina = 0.01
mb_config.statWeights["Shaman"]["Enhancement"].critRating = 0.55
mb_config.statWeights["Shaman"]["Enhancement"].resilienceRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].defenseRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].expertiseRating = 0.84
mb_config.statWeights["Shaman"]["Enhancement"].dodgeRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].parryRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].blockRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].armorPenetrationRating = 0.26
mb_config.statWeights["Shaman"]["Enhancement"].hitRating = 1.0
mb_config.statWeights["Shaman"]["Enhancement"].hasteRating = 0.42
mb_config.statWeights["Shaman"]["Enhancement"].attackPower = 0.32
mb_config.statWeights["Shaman"]["Enhancement"].armor = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].blockValue = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].spellPower = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].mp5 = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].dps = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].socketMeta = 100
mb_config.statWeights["Shaman"]["Enhancement"].socketColored = 16
-- Elemental
mb_config.statWeights["Shaman"]["Elemental"] = {}
mb_config.statWeights["Shaman"]["Elemental"].agility = 0.0
mb_config.statWeights["Shaman"]["Elemental"].intellect = 0.11
mb_config.statWeights["Shaman"]["Elemental"].spirit = 0.0
mb_config.statWeights["Shaman"]["Elemental"].strength = 0.0
mb_config.statWeights["Shaman"]["Elemental"].stamina = 0.001
mb_config.statWeights["Shaman"]["Elemental"].critRating = 0.4
mb_config.statWeights["Shaman"]["Elemental"].resilienceRating = 0.0
mb_config.statWeights["Shaman"]["Elemental"].defenseRating = 0.0
mb_config.statWeights["Shaman"]["Elemental"].expertiseRating = 0.0
mb_config.statWeights["Shaman"]["Elemental"].dodgeRating = 0.0
mb_config.statWeights["Shaman"]["Elemental"].parryRating = 0.0
mb_config.statWeights["Shaman"]["Elemental"].blockRating = 0.0
mb_config.statWeights["Shaman"]["Elemental"].armorPenetrationRating = 0.0
mb_config.statWeights["Shaman"]["Elemental"].hitRating = 1.0
mb_config.statWeights["Shaman"]["Elemental"].hasteRating = 0.56
mb_config.statWeights["Shaman"]["Elemental"].attackPower = 0.0
mb_config.statWeights["Shaman"]["Elemental"].armor = 0.0
mb_config.statWeights["Shaman"]["Elemental"].blockValue = 0.0
mb_config.statWeights["Shaman"]["Elemental"].spellPower = 0.6
mb_config.statWeights["Shaman"]["Elemental"].mp5 = 0.0
mb_config.statWeights["Shaman"]["Elemental"].dps = 0.0
mb_config.statWeights["Shaman"]["Elemental"].socketMeta = 100
mb_config.statWeights["Shaman"]["Elemental"].socketColored = 16
-- Restoration
mb_config.statWeights["Shaman"]["Restoration"] = {}
mb_config.statWeights["Shaman"]["Restoration"].agility = 0.0
mb_config.statWeights["Shaman"]["Restoration"].intellect = 0.85
mb_config.statWeights["Shaman"]["Restoration"].spirit = 0.0
mb_config.statWeights["Shaman"]["Restoration"].strength = 0.0
mb_config.statWeights["Shaman"]["Restoration"].stamina = 0.01
mb_config.statWeights["Shaman"]["Restoration"].critRating = 0.62
mb_config.statWeights["Shaman"]["Restoration"].resilienceRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].defenseRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].expertiseRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].dodgeRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].parryRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].blockRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].armorPenetrationRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].hitRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].hasteRating = 0.35
mb_config.statWeights["Shaman"]["Restoration"].attackPower = 0.0
mb_config.statWeights["Shaman"]["Restoration"].armor = 0.0
mb_config.statWeights["Shaman"]["Restoration"].blockValue = 0.0
mb_config.statWeights["Shaman"]["Restoration"].spellPower = 0.77
mb_config.statWeights["Shaman"]["Restoration"].mp5 = 1.0
mb_config.statWeights["Shaman"]["Restoration"].dps = 0.0
mb_config.statWeights["Shaman"]["Restoration"].socketMeta = 100
mb_config.statWeights["Shaman"]["Restoration"].socketColored = 16

-- Warrior
mb_config.statWeights["Warrior"] = {}
-- Arms
mb_config.statWeights["Warrior"]["Arms"] = {}
mb_config.statWeights["Warrior"]["Arms"].agility = 0.65
mb_config.statWeights["Warrior"]["Arms"].intellect = 0.0
mb_config.statWeights["Warrior"]["Arms"].spirit = 0.0
mb_config.statWeights["Warrior"]["Arms"].strength = 1.0
mb_config.statWeights["Warrior"]["Arms"].stamina = 0.01
mb_config.statWeights["Warrior"]["Arms"].critRating = 0.8
mb_config.statWeights["Warrior"]["Arms"].resilienceRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].defenseRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].expertiseRating = 0.85
mb_config.statWeights["Warrior"]["Arms"].dodgeRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].parryRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].blockRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].armorPenetrationRating = 0.65
mb_config.statWeights["Warrior"]["Arms"].hitRating = 0.9
mb_config.statWeights["Warrior"]["Arms"].hasteRating = 0.5
mb_config.statWeights["Warrior"]["Arms"].attackPower = 0.45
mb_config.statWeights["Warrior"]["Arms"].armor = 0.0
mb_config.statWeights["Warrior"]["Arms"].blockValue = 0.0
mb_config.statWeights["Warrior"]["Arms"].spellPower = 0.0
mb_config.statWeights["Warrior"]["Arms"].mp5 = 0.0
mb_config.statWeights["Warrior"]["Arms"].dps = 0.0
mb_config.statWeights["Warrior"]["Arms"].socketMeta = 100
mb_config.statWeights["Warrior"]["Arms"].socketColored = 16
-- Prot
mb_config.statWeights["Warrior"]["Prot"] = {}
mb_config.statWeights["Warrior"]["Prot"].agility = 0.67
mb_config.statWeights["Warrior"]["Prot"].intellect = 0.0
mb_config.statWeights["Warrior"]["Prot"].spirit = 0.0
mb_config.statWeights["Warrior"]["Prot"].strength = 0.48
mb_config.statWeights["Warrior"]["Prot"].stamina = 1.0
mb_config.statWeights["Warrior"]["Prot"].critRating = 0.07
mb_config.statWeights["Warrior"]["Prot"].resilienceRating = 0.0
mb_config.statWeights["Warrior"]["Prot"].defenseRating = 0.86
mb_config.statWeights["Warrior"]["Prot"].expertiseRating = 0.19
mb_config.statWeights["Warrior"]["Prot"].dodgeRating = 0.9
mb_config.statWeights["Warrior"]["Prot"].parryRating = 0.67
mb_config.statWeights["Warrior"]["Prot"].blockRating = 0.48
mb_config.statWeights["Warrior"]["Prot"].armorPenetrationRating = 0.1
mb_config.statWeights["Warrior"]["Prot"].hitRating = 0.1
mb_config.statWeights["Warrior"]["Prot"].hasteRating = 0.01
mb_config.statWeights["Warrior"]["Prot"].attackPower = 0.01
mb_config.statWeights["Warrior"]["Prot"].armor = 0.06
mb_config.statWeights["Warrior"]["Prot"].blockValue = 0.81
mb_config.statWeights["Warrior"]["Prot"].spellPower = 0.0
mb_config.statWeights["Warrior"]["Prot"].mp5 = 0.0
mb_config.statWeights["Warrior"]["Prot"].dps = 0.0
mb_config.statWeights["Warrior"]["Prot"].socketMeta = 100
mb_config.statWeights["Warrior"]["Prot"].socketColored = 16


-- Druid
mb_config.statWeights["Druid"] = {}
-- Balance
mb_config.statWeights["Druid"]["Balance"] = {}
mb_config.statWeights["Druid"]["Balance"].agility = 0.0
mb_config.statWeights["Druid"]["Balance"].intellect = 0.22
mb_config.statWeights["Druid"]["Balance"].spirit = 0.22
mb_config.statWeights["Druid"]["Balance"].strength = 0.0
mb_config.statWeights["Druid"]["Balance"].stamina = 0.01
mb_config.statWeights["Druid"]["Balance"].critRating = 0.43
mb_config.statWeights["Druid"]["Balance"].resilienceRating = 0.0
mb_config.statWeights["Druid"]["Balance"].defenseRating = 0.0
mb_config.statWeights["Druid"]["Balance"].expertiseRating = 0.0
mb_config.statWeights["Druid"]["Balance"].dodgeRating = 0.0
mb_config.statWeights["Druid"]["Balance"].parryRating = 0.0
mb_config.statWeights["Druid"]["Balance"].blockRating = 0.0
mb_config.statWeights["Druid"]["Balance"].armorPenetrationRating = 0.0
mb_config.statWeights["Druid"]["Balance"].hitRating = 1.0
mb_config.statWeights["Druid"]["Balance"].hasteRating = 0.54
mb_config.statWeights["Druid"]["Balance"].attackPower = 0.0
mb_config.statWeights["Druid"]["Balance"].armor = 0.0
mb_config.statWeights["Druid"]["Balance"].blockValue = 0.0
mb_config.statWeights["Druid"]["Balance"].spellPower = 0.66
mb_config.statWeights["Druid"]["Balance"].mp5 = 0.0
mb_config.statWeights["Druid"]["Balance"].dps = 0.0
mb_config.statWeights["Druid"]["Balance"].socketMeta = 100
mb_config.statWeights["Druid"]["Balance"].socketColored = 16
-- Feral
mb_config.statWeights["Druid"]["Feral Combat"] = {}
mb_config.statWeights["Druid"]["Feral Combat"].agility = 1.0
mb_config.statWeights["Druid"]["Feral Combat"].intellect = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].spirit = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].strength = 0.1
mb_config.statWeights["Druid"]["Feral Combat"].stamina = 0.75
mb_config.statWeights["Druid"]["Feral Combat"].critRating = 0.03
mb_config.statWeights["Druid"]["Feral Combat"].resilienceRating = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].defenseRating = 0.6
mb_config.statWeights["Druid"]["Feral Combat"].expertiseRating = 0.16
mb_config.statWeights["Druid"]["Feral Combat"].dodgeRating = 0.65
mb_config.statWeights["Druid"]["Feral Combat"].parryRating = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].blockRating = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].armorPenetrationRating = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].hitRating = 0.08
mb_config.statWeights["Druid"]["Feral Combat"].hasteRating = 0.05
mb_config.statWeights["Druid"]["Feral Combat"].attackPower = 0.04
mb_config.statWeights["Druid"]["Feral Combat"].armor = 0.1
mb_config.statWeights["Druid"]["Feral Combat"].blockValue = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].spellPower = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].mp5 = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].dps = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].socketMeta = 100
mb_config.statWeights["Druid"]["Feral Combat"].socketColored = 16
-- Restoration
mb_config.statWeights["Druid"]["Restoration"] = {}
mb_config.statWeights["Druid"]["Restoration"].agility = 0.0
mb_config.statWeights["Druid"]["Restoration"].intellect = 0.51
mb_config.statWeights["Druid"]["Restoration"].spirit = 0.32
mb_config.statWeights["Druid"]["Restoration"].strength = 0.0
mb_config.statWeights["Druid"]["Restoration"].stamina = 0.01
mb_config.statWeights["Druid"]["Restoration"].critRating = 0.11
mb_config.statWeights["Druid"]["Restoration"].resilienceRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].defenseRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].expertiseRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].dodgeRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].parryRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].blockRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].armorPenetrationRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].hitRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].hasteRating = 0.57
mb_config.statWeights["Druid"]["Restoration"].attackPower = 0.0
mb_config.statWeights["Druid"]["Restoration"].armor = 0.0
mb_config.statWeights["Druid"]["Restoration"].blockValue = 0.0
mb_config.statWeights["Druid"]["Restoration"].spellPower = 1.0
mb_config.statWeights["Druid"]["Restoration"].mp5 = 0.73
mb_config.statWeights["Druid"]["Restoration"].dps = 0.0
mb_config.statWeights["Druid"]["Restoration"].socketMeta = 100
mb_config.statWeights["Druid"]["Restoration"].socketColored = 16

-- Mage
mb_config.statWeights["Mage"] = {}
-- Arcane
mb_config.statWeights["Mage"]["Arcane"] = {}
mb_config.statWeights["Mage"]["Arcane"].agility = 0.0
mb_config.statWeights["Mage"]["Arcane"].intellect = 0.34
mb_config.statWeights["Mage"]["Arcane"].spirit = 0.14
mb_config.statWeights["Mage"]["Arcane"].strength = 0.0
mb_config.statWeights["Mage"]["Arcane"].stamina = 0.01
mb_config.statWeights["Mage"]["Arcane"].critRating = 0.37
mb_config.statWeights["Mage"]["Arcane"].resilienceRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].defenseRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].expertiseRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].dodgeRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].parryRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].blockRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].armorPenetrationRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].hitRating = 1.0
mb_config.statWeights["Mage"]["Arcane"].hasteRating = 0.54
mb_config.statWeights["Mage"]["Arcane"].attackPower = 0.0
mb_config.statWeights["Mage"]["Arcane"].armor = 0.0
mb_config.statWeights["Mage"]["Arcane"].blockValue = 0.0
mb_config.statWeights["Mage"]["Arcane"].spellPower = 0.49
mb_config.statWeights["Mage"]["Arcane"].mp5 = 0.0
mb_config.statWeights["Mage"]["Arcane"].dps = 0.0
mb_config.statWeights["Mage"]["Arcane"].socketMeta = 100
mb_config.statWeights["Mage"]["Arcane"].socketColored = 16

-- Priest
mb_config.statWeights["Priest"] = {}
-- Holy
mb_config.statWeights["Priest"]["Holy"] = {}
mb_config.statWeights["Priest"]["Holy"].agility = 0.0
mb_config.statWeights["Priest"]["Holy"].intellect = 0.69
mb_config.statWeights["Priest"]["Holy"].spirit = 0.52
mb_config.statWeights["Priest"]["Holy"].strength = 0.0
mb_config.statWeights["Priest"]["Holy"].stamina = 0.01
mb_config.statWeights["Priest"]["Holy"].critRating = 0.38
mb_config.statWeights["Priest"]["Holy"].resilienceRating = 0.0
mb_config.statWeights["Priest"]["Holy"].defenseRating = 0.0
mb_config.statWeights["Priest"]["Holy"].expertiseRating = 0.0
mb_config.statWeights["Priest"]["Holy"].dodgeRating = 0.0
mb_config.statWeights["Priest"]["Holy"].parryRating = 0.0
mb_config.statWeights["Priest"]["Holy"].blockRating = 0.0
mb_config.statWeights["Priest"]["Holy"].armorPenetrationRating = 0.0
mb_config.statWeights["Priest"]["Holy"].hitRating = 0.0
mb_config.statWeights["Priest"]["Holy"].hasteRating = 0.31
mb_config.statWeights["Priest"]["Holy"].attackPower = 0.0
mb_config.statWeights["Priest"]["Holy"].armor = 0.0
mb_config.statWeights["Priest"]["Holy"].blockValue = 0.0
mb_config.statWeights["Priest"]["Holy"].spellPower = 0.60
mb_config.statWeights["Priest"]["Holy"].mp5 = 1.0
mb_config.statWeights["Priest"]["Holy"].dps = 0.0
mb_config.statWeights["Priest"]["Holy"].socketMeta = 100
mb_config.statWeights["Priest"]["Holy"].socketColored = 16
-- Shadow
mb_config.statWeights["Priest"]["Shadow"] = {}
mb_config.statWeights["Priest"]["Shadow"].agility = 0.0
mb_config.statWeights["Priest"]["Shadow"].intellect = 0.16
mb_config.statWeights["Priest"]["Shadow"].spirit = 0.16
mb_config.statWeights["Priest"]["Shadow"].strength = 0.0
mb_config.statWeights["Priest"]["Shadow"].stamina = 0.01
mb_config.statWeights["Priest"]["Shadow"].critRating = 0.54
mb_config.statWeights["Priest"]["Shadow"].resilienceRating = 0.0
mb_config.statWeights["Priest"]["Shadow"].defenseRating = 0.0
mb_config.statWeights["Priest"]["Shadow"].expertiseRating = 0.0
mb_config.statWeights["Priest"]["Shadow"].dodgeRating = 0.0
mb_config.statWeights["Priest"]["Shadow"].parryRating = 0.0
mb_config.statWeights["Priest"]["Shadow"].blockRating = 0.0
mb_config.statWeights["Priest"]["Shadow"].armorPenetrationRating = 0.0
mb_config.statWeights["Priest"]["Shadow"].hitRating = 1.0
mb_config.statWeights["Priest"]["Shadow"].hasteRating = 0.5
mb_config.statWeights["Priest"]["Shadow"].attackPower = 0.0
mb_config.statWeights["Priest"]["Shadow"].armor = 0.0
mb_config.statWeights["Priest"]["Shadow"].blockValue = 0.0
mb_config.statWeights["Priest"]["Shadow"].spellPower = 0.76
mb_config.statWeights["Priest"]["Shadow"].mp5 = 0.0
mb_config.statWeights["Priest"]["Shadow"].dps = 0.0
mb_config.statWeights["Priest"]["Shadow"].socketMeta = 100
mb_config.statWeights["Priest"]["Shadow"].socketColored = 16

-- Warlock
mb_config.statWeights["Warlock"] = {}
-- Affliction
mb_config.statWeights["Warlock"]["Affliction"] = {}
mb_config.statWeights["Warlock"]["Affliction"].agility = 0.0
mb_config.statWeights["Warlock"]["Affliction"].intellect = 0.15
mb_config.statWeights["Warlock"]["Affliction"].spirit = 0.34
mb_config.statWeights["Warlock"]["Affliction"].strength = 0.0
mb_config.statWeights["Warlock"]["Affliction"].stamina = 0.01
mb_config.statWeights["Warlock"]["Affliction"].critRating = 0.38
mb_config.statWeights["Warlock"]["Affliction"].resilienceRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].defenseRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].expertiseRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].dodgeRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].parryRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].blockRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].armorPenetrationRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].hitRating = 1.0
mb_config.statWeights["Warlock"]["Affliction"].hasteRating = 0.61
mb_config.statWeights["Warlock"]["Affliction"].attackPower = 0.0
mb_config.statWeights["Warlock"]["Affliction"].armor = 0.0
mb_config.statWeights["Warlock"]["Affliction"].blockValue = 0.0
mb_config.statWeights["Warlock"]["Affliction"].spellPower = 0.72
mb_config.statWeights["Warlock"]["Affliction"].mp5 = 0.0
mb_config.statWeights["Warlock"]["Affliction"].dps = 0.0
mb_config.statWeights["Warlock"]["Affliction"].socketMeta = 100
mb_config.statWeights["Warlock"]["Affliction"].socketColored = 16
-- Demonology
mb_config.statWeights["Warlock"]["Demonology"] = {}
mb_config.statWeights["Warlock"]["Demonology"].agility = 0.0
mb_config.statWeights["Warlock"]["Demonology"].intellect = 0.13
mb_config.statWeights["Warlock"]["Demonology"].spirit = 0.29
mb_config.statWeights["Warlock"]["Demonology"].strength = 0.0
mb_config.statWeights["Warlock"]["Demonology"].stamina = 0.01
mb_config.statWeights["Warlock"]["Demonology"].critRating = 0.31
mb_config.statWeights["Warlock"]["Demonology"].resilienceRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].defenseRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].expertiseRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].dodgeRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].parryRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].blockRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].armorPenetrationRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].hitRating = 1.0
mb_config.statWeights["Warlock"]["Demonology"].hasteRating = 0.50
mb_config.statWeights["Warlock"]["Demonology"].attackPower = 0.0
mb_config.statWeights["Warlock"]["Demonology"].armor = 0.0
mb_config.statWeights["Warlock"]["Demonology"].blockValue = 0.0
mb_config.statWeights["Warlock"]["Demonology"].spellPower = 0.8
mb_config.statWeights["Warlock"]["Demonology"].mp5 = 0.0
mb_config.statWeights["Warlock"]["Demonology"].dps = 0.0
mb_config.statWeights["Warlock"]["Demonology"].socketMeta = 100
mb_config.statWeights["Warlock"]["Demonology"].socketColored = 16
-- Destruction
mb_config.statWeights["Warlock"]["Destruction"] = {}
mb_config.statWeights["Warlock"]["Destruction"].agility = 0.0
mb_config.statWeights["Warlock"]["Destruction"].intellect = 0.13
mb_config.statWeights["Warlock"]["Destruction"].spirit = 0.26
mb_config.statWeights["Warlock"]["Destruction"].strength = 0.0
mb_config.statWeights["Warlock"]["Destruction"].stamina = 0.01
mb_config.statWeights["Warlock"]["Destruction"].critRating = 0.16
mb_config.statWeights["Warlock"]["Destruction"].resilienceRating = 0.0
mb_config.statWeights["Warlock"]["Destruction"].defenseRating = 0.0
mb_config.statWeights["Warlock"]["Destruction"].expertiseRating = 0.0
mb_config.statWeights["Warlock"]["Destruction"].dodgeRating = 0.0
mb_config.statWeights["Warlock"]["Destruction"].parryRating = 0.0
mb_config.statWeights["Warlock"]["Destruction"].blockRating = 0.0
mb_config.statWeights["Warlock"]["Destruction"].armorPenetrationRating = 0.0
mb_config.statWeights["Warlock"]["Destruction"].hitRating = 1.0
mb_config.statWeights["Warlock"]["Destruction"].hasteRating = 0.46
mb_config.statWeights["Warlock"]["Destruction"].attackPower = 0.0
mb_config.statWeights["Warlock"]["Destruction"].armor = 0.0
mb_config.statWeights["Warlock"]["Destruction"].blockValue = 0.0
mb_config.statWeights["Warlock"]["Destruction"].spellPower = 0.47
mb_config.statWeights["Warlock"]["Destruction"].mp5 = 0.0
mb_config.statWeights["Warlock"]["Destruction"].dps = 0.0
mb_config.statWeights["Warlock"]["Destruction"].socketMeta = 100
mb_config.statWeights["Warlock"]["Destruction"].socketColored = 16

--Rogue
mb_config.statWeights["Rogue"] = {}
-- Combat
mb_config.statWeights["Rogue"]["Combat"] = {}
mb_config.statWeights["Rogue"]["Combat"].agility = 1.0
mb_config.statWeights["Rogue"]["Combat"].intellect = 0.0
mb_config.statWeights["Rogue"]["Combat"].spirit = 0.0
mb_config.statWeights["Rogue"]["Combat"].strength = 0.55
mb_config.statWeights["Rogue"]["Combat"].stamina = 0.01
mb_config.statWeights["Rogue"]["Combat"].critRating = 0.75
mb_config.statWeights["Rogue"]["Combat"].resilienceRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].defenseRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].expertiseRating = 0.82
mb_config.statWeights["Rogue"]["Combat"].dodgeRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].parryRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].blockRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].armorPenetrationRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].hitRating = 0.8
mb_config.statWeights["Rogue"]["Combat"].hasteRating = 0.73
mb_config.statWeights["Rogue"]["Combat"].attackPower = 0.5
mb_config.statWeights["Rogue"]["Combat"].armor = 0.0
mb_config.statWeights["Rogue"]["Combat"].blockValue = 0.0
mb_config.statWeights["Rogue"]["Combat"].spellPower = 0.0
mb_config.statWeights["Rogue"]["Combat"].mp5 = 0.0
mb_config.statWeights["Rogue"]["Combat"].dps = 0.0
mb_config.statWeights["Rogue"]["Combat"].socketMeta = 100
mb_config.statWeights["Rogue"]["Combat"].socketColored = 16

--Hunter
mb_config.statWeights["Hunter"] = {}
-- Combat
mb_config.statWeights["Hunter"]["Marksmanship"] = {}
mb_config.statWeights["Hunter"]["Marksmanship"].agility = 0.74
mb_config.statWeights["Hunter"]["Marksmanship"].intellect = 0.39
mb_config.statWeights["Hunter"]["Marksmanship"].spirit = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].strength = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].stamina = 0.01
mb_config.statWeights["Hunter"]["Marksmanship"].critRating = 0.57
mb_config.statWeights["Hunter"]["Marksmanship"].resilienceRating = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].defenseRating = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].expertiseRating = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].dodgeRating = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].parryRating = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].blockRating = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].armorPenetrationRating = 0.4
mb_config.statWeights["Hunter"]["Marksmanship"].hitRating = 1.0
mb_config.statWeights["Hunter"]["Marksmanship"].hasteRating = 0.24
mb_config.statWeights["Hunter"]["Marksmanship"].attackPower = 0.32
mb_config.statWeights["Hunter"]["Marksmanship"].armor = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].blockValue = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].spellPower = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].mp5 = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].dps = 0.0
mb_config.statWeights["Hunter"]["Marksmanship"].socketMeta = 100
mb_config.statWeights["Hunter"]["Marksmanship"].socketColored = 16

--Deathknight
mb_config.statWeights["Deathknight"] = {}
-- Blood Tank
mb_config.statWeights["Deathknight"]["Blood"] = {}
mb_config.statWeights["Deathknight"]["Blood"].agility = 0.69
mb_config.statWeights["Deathknight"]["Blood"].intellect = 0.0
mb_config.statWeights["Deathknight"]["Blood"].spirit = 0.0
mb_config.statWeights["Deathknight"]["Blood"].strength = 0.31
mb_config.statWeights["Deathknight"]["Blood"].stamina = 1.0
mb_config.statWeights["Deathknight"]["Blood"].critRating = 0.22
mb_config.statWeights["Deathknight"]["Blood"].resilienceRating = 0.0
mb_config.statWeights["Deathknight"]["Blood"].defenseRating = 0.9
mb_config.statWeights["Deathknight"]["Blood"].expertiseRating = 0.38
mb_config.statWeights["Deathknight"]["Blood"].dodgeRating = 0.5
mb_config.statWeights["Deathknight"]["Blood"].parryRating = 0.43
mb_config.statWeights["Deathknight"]["Blood"].blockRating = 0.0
mb_config.statWeights["Deathknight"]["Blood"].armorPenetrationRating = 0.26
mb_config.statWeights["Deathknight"]["Blood"].hitRating = 0.16
mb_config.statWeights["Deathknight"]["Blood"].hasteRating = 0.16
mb_config.statWeights["Deathknight"]["Blood"].attackPower = 0.08
mb_config.statWeights["Deathknight"]["Blood"].armor = 0.18
mb_config.statWeights["Deathknight"]["Blood"].blockValue = 0.0
mb_config.statWeights["Deathknight"]["Blood"].spellPower = 0.0
mb_config.statWeights["Deathknight"]["Blood"].mp5 = 0.0
mb_config.statWeights["Deathknight"]["Blood"].dps = 0.0
mb_config.statWeights["Deathknight"]["Blood"].socketMeta = 100
mb_config.statWeights["Deathknight"]["Blood"].socketColored = 16
-- Unholy DPS
mb_config.statWeights["Deathknight"]["Unholy"] = {}
mb_config.statWeights["Deathknight"]["Unholy"].agility = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].intellect = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].spirit = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].strength = 1.0
mb_config.statWeights["Deathknight"]["Unholy"].stamina = 0.01
mb_config.statWeights["Deathknight"]["Unholy"].critRating = 0.45
mb_config.statWeights["Deathknight"]["Unholy"].resilienceRating = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].defenseRating = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].expertiseRating = 0.51
mb_config.statWeights["Deathknight"]["Unholy"].dodgeRating = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].parryRating = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].blockRating = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].armorPenetrationRating = 0.32
mb_config.statWeights["Deathknight"]["Unholy"].hitRating = 0.66
mb_config.statWeights["Deathknight"]["Unholy"].hasteRating = 0.48
mb_config.statWeights["Deathknight"]["Unholy"].attackPower = 0.34
mb_config.statWeights["Deathknight"]["Unholy"].armor = 0.01
mb_config.statWeights["Deathknight"]["Unholy"].blockValue = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].spellPower = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].mp5 = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].dps = 0.0
mb_config.statWeights["Deathknight"]["Unholy"].socketMeta = 100
mb_config.statWeights["Deathknight"]["Unholy"].socketColored = 16