PersistentVars = {
    
}

-- Register the mod variable for tracking distributed items 
Ext.Vars.RegisterModVariable(ModuleUUID, "PP_DistributedItems", {})   

local function OnSessionLoaded()    
    local ModVars = {}
    ModVars = Ext.Vars.GetModVariables(ModuleUUID).PP_DistributedItems or {}

    -- Array of items and the respective enemies they are to be assigned to        
    local itemArray = {
        --ACT 1
        {
            ItemName = "Blood Pact Blade",
            ItemUUID = "96d85702-801d-4b98-bfa1-0befd32b65f4",
            EnemyName = "Abandon Camp in Swamp - Wizards Backpack",
            EnemyMapKey = "de45b362-eba0-4004-97c8-c45f8e98626f",
            Equip = false
        },
        {
            ItemName = "Shortbow of the Binding Vow",
            ItemUUID = "8a6b0885-d316-4065-bcc9-bf8835282a52",
            EnemyName = "Priestess Gut",
            EnemyMapKey = "b983c336-9a14-4e9b-adb9-4689e7e0afa9",
            Equip = false
        },
        {
            ItemName = "Hood of Subjugation",
            ItemUUID = "362c6f56-ce20-41df-811f-47356ba1bb00",
            EnemyName = "Varsh Kokuu",
            EnemyMapKey = "c61ac08e-addf-4f0e-8a0a-2fc026ec0224",
            Equip = false
        },
        {
            ItemName = "Tunic of Life-Sharing",
            ItemUUID = "a61a9914-7235-4ac5-8063-36473cc1dd9d",
            EnemyName = "Gekh Coal",
            EnemyMapKey = "05c338d9-4590-4c4b-b87e-8c27ea2c2b18",
            Equip = false
        },
        {
            ItemName = "Gauntlets of the Pactkeeper",
            ItemUUID = "2c7764dc-d065-496d-9d22-1884dfae1808",
            EnemyName = "Ardent Jherezath",
            EnemyMapKey = "f51854ec-5dbc-4686-bb4a-b2f8b4c5341b",
            Equip = false
        },
        {
            ItemName = "Boots of the Shadowed Pact",
            ItemUUID = "8bdc441e-db94-40e5-97d0-2e78e678ea42",
            EnemyName = "Heavy Chest near the entrance to druid grove - at the top of cliff.",
            EnemyMapKey = "5b16599a-5115-4f71-8ab9-44f70eefb1df",
            Equip = false
        },
        {
            ItemName = "Mantle of Eldritch Echoes",
            ItemUUID = "3f280a46-457c-4a5e-8e8f-53316bb01112",
            EnemyName = "Chest of the Mundane",
            EnemyMapKey = "fd56efe0-fbd4-471d-9661-856f732a77ef",
            Equip = false
        },
        {
            ItemName = "Bloodstone Ring",
            ItemUUID = "78a48569-fc56-4e33-be6f-8df22303e78a",
            EnemyName = "Buried Chest near Druid Grove - Cross Pillars",
            EnemyMapKey = "903222d8-7232-4f99-a258-db23e26244ca",
            Equip = false
        },
        {
            ItemName = "Grimoire of Whispers",
            ItemUUID = "aa62064c-2100-4e9a-a60b-d51c2b7ab381",
            EnemyName = "Buried Chest, near Summon Quasit scroll location",
            EnemyMapKey = "99dbc510-09f6-42cb-9640-9b220c535567",
            Equip = false
        },
        {
            ItemName = "Stone of Good Luck",
            ItemUUID = "2086f016-812c-4b15-924d-d4de8f9daea5",
            EnemyName = "Warlock Tud",
            EnemyMapKey = "436c4c80-76fe-4396-831d-0d279b394810",
            Equip = false
        },
		--ACT 2
        {
            ItemName = "Shortbow of the Pact Keeper",
            ItemUUID = "95d150ff-f1e4-49cd-8805-539ab91be878",
            EnemyName = "Dead Harper near Shambling Mound",
            EnemyMapKey = "f3caaa60-d094-47f4-9c32-7010910df17c",
            Equip = false
        },
        {
            ItemName = "Whisper of the Fallen Pact",
            ItemUUID = "f6e55640-c199-4247-85e3-ea4bb8eda722",
            EnemyName = "Buried Chest by Graves - Near Mausoleum Entrance",
            EnemyMapKey = "e49fff27-1978-464d-ad23-54cbb40c859a",
            Equip = false
        },
        {
            ItemName = "Hood of the Whispering Mind",
            ItemUUID = "5fa835cf-e638-4268-b9c3-7371ea401cff",
            EnemyName = "Questioner Sumera",
            EnemyMapKey = "480b89b1-ae6c-46e7-ad79-1b3babe3655e",
            Equip = false
        },
        -- CHT: removing item as it doesn't work well with Warlock and Patrons DnD 5R PHB2024 by Chizfreak
        -- {
        --     ItemName = "Tunic of the Ascended Warlock",
        --     ItemUUID = "34d2b229-1051-4f85-982c-229ff3ad66d9",
        --     EnemyName = "Z'rell",
        --     EnemyMapKey = "8e75eb3b-7551-485e-8f98-2bf2e51d3e84",
        --     Equip = false
        -- },
        {
            ItemName = "Gloves of the Pact Weaver",
            ItemUUID = "ebc14f07-bbbb-4b38-88d8-a9645752d10d",
            EnemyName = "Mausoleum Left side - Skeleton on Altar",
            EnemyMapKey = "c58d2def-4d7d-4546-8467-908448b42f61",
            Equip = false
        },
        {
            ItemName = "Boots of the Devouring Void",
            ItemUUID = "313eb834-e4b6-4b06-9237-985037c051cf",
            EnemyName = "Chest behind Cracked Wall in MRT",
            EnemyMapKey = "fcc39731-9c3d-4b7d-bac6-7d634e2ad476",
            Equip = false
        },
        {
            ItemName = "Soulfire Shroud",
            ItemUUID = "7410af35-c5f0-40fe-97cd-3d2cc2dbb687",
            EnemyName = "Gith Warlock - ChraiTskaan",
            EnemyMapKey = "e4141a02-f5e7-4a0c-a7af-d3dda6610c1b",
            Equip = false
        },
        {
            ItemName = "Ring of the Swarm",
            ItemUUID = "b38423f4-7734-401d-afb0-9d9c49fa268a",
            EnemyName = "MF Colony Death Shepherd",
            EnemyMapKey = "1627bff7-5674-45f6-9da5-582521ce9296",
            Equip = false
        },
        {
            ItemName = "Band of the Shifting Sands",
            ItemUUID = "ee7fc437-f7c5-4bb8-89ad-1b6f35fdbdff",
            EnemyName = "Araj Oblodra",
            EnemyMapKey = "511c9413-25fe-449c-a81d-4b09bc20745a",
            Equip = false
        },
        {
            ItemName = "Leechstone Amulet",
            ItemUUID = "993473f7-977b-45d3-8fa0-06dcc94b0b31",
            EnemyName = "Heavy Chest on left side when entering SCL from Grymforge",
            EnemyMapKey = "9b3b8e11-d4ba-4480-a5fa-864879e7a2ad",
            Equip = false
        },
		--ACT 3
        {
            ItemName = "Shortbow of Hellish Flames",
            ItemUUID = "3e79c301-08cb-4fb9-93f1-a0314355cd89",
            EnemyName = "Helsik",
            EnemyMapKey = "299a1c00-ff53-415e-ad8e-9bcbbae55597",
            Equip = false
        },
        -- CHT: removing item as it doesn't work well with Warlock and Patrons DnD 5R PHB2024 by Chizfreak
        -- {
        --     ItemName = "Soulknife of the Everlasting Pact",
        --     ItemUUID = "815f31ec-eea1-4ff5-9557-56d5e63d16f4",
        --     EnemyName = "Vault #5",
        --     EnemyMapKey = "859ec79c-8f81-44e1-b044-bc834cf33acc",
        --     Equip = false
        -- },
        {
            ItemName = "Visage of the Inner Demon",
            ItemUUID = "99fae490-f945-4a10-86c7-b3116536e2e1",
            EnemyName = "Display Case in House of Hope Archive Room",
            EnemyMapKey = "78f571b4-4edf-4691-a94d-b3694cf1e5ca",
            Equip = false
        },
        {
            ItemName = "Tunic of the Ravenous Soul",
            ItemUUID = "a92d216a-4f06-4144-86c8-b5afccf9c676",
            EnemyName = "Lower City - Ancient Lair - Treasure Crates",
            EnemyMapKey = "f3ddfb1f-5ac2-495d-8c46-e6208b3b2f96",
            Equip = false
        },
        {
            ItemName = "Gloves of Eldritch Power",
            ItemUUID = "b0e59203-ed0f-4a0c-b446-2def5cbfc27a",
            EnemyName = "House of Hope Spectator - Same location as Burnished Ring",
            EnemyMapKey = "d92a207c-874a-4409-9cad-4abcec33efa1",
            Equip = false
        },
        {
            ItemName = "Soulrender Boots",
            ItemUUID = "61ce5cf3-369e-4bfa-b958-9fb34640c4f4",
            EnemyName = "Rivington - Buried Chest in Phasm Shack",
            EnemyMapKey = "28ad0189-f57e-42cf-b923-544212e0ba47",
            Equip = false
        },
        {
            ItemName = "Whispersilk Cloak",
            ItemUUID = "233c0706-211d-47fc-8773-b5f839290f95",
            EnemyName = "Gilded Chest in Junk pile - before entering Wyrms Crossing",
            EnemyMapKey = "86251de7-9e5c-4050-8449-ed3021a8e651",
            Equip = false
        },
        {
            ItemName = "Knight's Sigil of Dusk",
            ItemUUID = "5ba21003-7fda-4c9c-998d-c778849660c1",
            EnemyName = "Ringmasters Opulent Chest",
            EnemyMapKey = "a3ac5f78-2e40-494a-a8ec-e028d1ff70fe",
            Equip = false
        },
        {
            ItemName = "Ring of the Soul Siphon",
            ItemUUID = "ff7bb30b-10ce-431f-b5e1-72e63d313221",
            EnemyName = "Garret Dortmell",
            EnemyMapKey = "49cc5f9e-72e3-440f-be8b-2c4ecf5964b5",
            Equip = false
        },
        {
            ItemName = "Amulet of the Eternal Hunger",
            ItemUUID = "902f94ff-cac5-4090-aebb-56ae2256f8f9",
            EnemyName = "Raphael",
            EnemyMapKey = "f65becd6-5cd7-4c88-b85e-6dd06b60f7b8",
            Equip = false
        },
        {
            ItemName = "",
            ItemUUID = "",
            EnemyName = "",
            EnemyMapKey = "",
            Equip = false
        },
        {
            ItemName = "",
            ItemUUID = "",
            EnemyName = "",
            EnemyMapKey = "",
            Equip = false
        }
        --{
        --    ItemName = "xxx",
        --    ItemUUID = "xxx",
        --    EnemyName = "xxx",
        --    EnemyMapKey = "xxx",
        --    Equip = true
        --}
    }
    local json = Ext.Json.Stringify(itemArray)
    _P(json)
    local itemsToAdd = Ext.Json.Parse(json)

    function OnLevelLoaded()
        _P("Beginning adding to inventories")
        for itemCount = 1, #itemsToAdd do
            local item = itemsToAdd[itemCount]
            if ModVars[item.ItemName:gsub('%W','') .. item.EnemyName:gsub('%W','')] ~= true and Osi.TemplateIsInInventory(item.ItemUUID, item.EnemyMapKey) ~= nil and Osi.TemplateIsInInventory(item.ItemUUID, item.EnemyMapKey) < 1 then
                Osi.TemplateAddTo(item.ItemUUID, item.EnemyMapKey, 1)
                _P(item.ItemName, "added to inventory of", item.EnemyName)
                -- Store the assignment in local table ModVars and update the mod variable PP_DistributedItems
                ModVars[item.ItemName:gsub('%W','') .. item.EnemyName:gsub('%W','')] = true
                Ext.Vars.GetModVariables(ModuleUUID).PP_DistributedItems = ModVars
            else
                if ModVars[item.ItemName:gsub('%W','') .. item.EnemyName:gsub('%W','')] == true then
                    _P(item.EnemyName, "has been previously assigned this item via variable")
                end
                if Osi.TemplateIsInInventory(item.ItemUUID, item.EnemyMapKey) == nil then
                    _P(item.EnemyName, "is unavailable to give item to")
                else
                    _P(item.ItemName, "has already been given to", item.EnemyName)
                end
            end
        end
        _P("Items Distributed", "Storing to Variables")   
    end

    function UnequipExistingItems(target, slot)
        local slotString = getSlot(slot)
        local GUID = GetGUID(target)
        if (GetEquippedItem(GUID,slotString) ~= nil) then
            item_to_unequip = GetEquippedItem(GUID, slotString)
            LockUnequip(item_to_unequip, 0)
            Unequip(GUID,item_to_unequip)
        end		
    end

    function GetGUID(str)
        return string.sub(str,-36)
    end

    function getSlot(slot)
        local WW_EquipmentSlots = {
            "Helmet",
            "Breast",
            "Cloak",
            "MeleeMainHand",
            "MeleeOffHand",
            "RangedMainHand",
            "RangedOffHand",
            "Ring",
            "Underwear",
            "Boots",
            "Gloves",
            "Amulet",
            "Ring2",
            "Wings",
            "Horns",
            "Overhead",
            "MusicalInstrument",
            "VanityBody",
            "VanityBoots"
        }
        return WW_EquipmentSlots[slot + 1]
    end

    Ext.Osiris.RegisterListener("TemplateAddedTo", 4, "after", function (wpn_root, wpn_id, character, useless)
        for itemCount = 1, #itemsToAdd do
            local item = itemsToAdd[itemCount]
            if item.ItemUUID == GetGUID(wpn_root) then
                if (item.Equip == true and GetGUID(character) == item.EnemyMapKey and IsPartyMember(character, 1) == 0) then
                    _P(character, "attempting to equip")
                    if (IsEquipable(wpn_id) == 1) then
                        local slot = GetEquipmentSlotForItem(wpn_id)          
                        UnequipExistingItems(character, slot)
                        _P(character, "equipped", wpn_root)
                        Equip(character, wpn_id)
                    end 
                end
            end
        end
    end)
    Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", OnLevelLoaded)
end

Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)