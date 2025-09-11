---@diagnostic disable: undefined-field, undefined-global
local function Wait(delayInMs, func)
    local startTime = Ext.Utils.MonotonicTime()
    local handlerId;
    handlerId = Ext.Events.Tick:Subscribe(function()
        local endTime = Ext.Utils.MonotonicTime()
        if (endTime - startTime > delayInMs) then
            Ext.Events.Tick:Unsubscribe(handlerId)
            func()
        end
    end)
end

local function GetPartyMembers()
	local partyMembersDB = Osi.DB_PartyMembers:Get(nil)

	local partyMembersSet = {}
	for _, v in pairs(partyMembersDB) do
		local uuid = v[1]
--		print("DB_PartyMembers: " .. uuid)
		partyMembersSet[uuid] = true
	end
	return partyMembersSet
end

---@diagnostic disable-next-line: redundant-parameter
Ext.Vars.RegisterModVariable("60b7b37b-c006-4775-bda2-6ebb726acc12", "wrath", {Server = true, Client = false, SyncToClient = false})
---@diagnostic disable-next-line: redundant-parameter
Ext.Vars.RegisterModVariable("60b7b37b-c006-4775-bda2-6ebb726acc12", "mercy", {Server = true, Client = false, SyncToClient = false})
---@diagnostic disable-next-line: redundant-parameter
Ext.Vars.RegisterModVariable("60b7b37b-c006-4775-bda2-6ebb726acc12", "protection", {Server = true, Client = false, SyncToClient = false})
---@diagnostic disable-next-line: redundant-parameter
Ext.Vars.RegisterModVariable("60b7b37b-c006-4775-bda2-6ebb726acc12", "resolve", {Server = true, Client = false, SyncToClient = false})
---@diagnostic disable-next-line: redundant-parameter
Ext.Vars.RegisterModVariable("60b7b37b-c006-4775-bda2-6ebb726acc12", "justice", {Server = true, Client = false, SyncToClient = false})
---@diagnostic disable-next-line: redundant-parameter
Ext.Vars.RegisterModVariable("60b7b37b-c006-4775-bda2-6ebb726acc12", "chest", {Server = true, Client = false, SyncToClient = false})

--Ring 1 purification handler
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "SIAEL_POTR_RESTORE_SCRIPT_RING1" then
        if GetEquippedItem(object,"Ring") ~= nil then
            if GetTemplate(GetEquippedItem(object,"Ring")) == "Siael_POTR_Ring1_D_addcb0b3-c828-47d0-a597-196d9f99ee73" then
                ApplyStatus(GetEquippedItem(object,"Ring"),"SIAEL_POTR_RESTORE",6,0,causee)
                ApplyStatus(GetEquippedItem(object,"Ring"),"SIAEL_POTR_RESTORE_SCRIPT",0,0,causee)
            end
        end
        if GetEquippedItem(object,"Ring2") ~= nil then
            if GetTemplate(GetEquippedItem(object,"Ring2")) == "Siael_POTR_Ring1_D_addcb0b3-c828-47d0-a597-196d9f99ee73" then
                ApplyStatus(GetEquippedItem(object,"Ring2"),"SIAEL_POTR_RESTORE",6,0,causee)
                ApplyStatus(GetEquippedItem(object,"Ring2"),"SIAEL_POTR_RESTORE_SCRIPT",0,0,causee)
            end
        end
    end
end)

--Ring 2 purification handler
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "SIAEL_POTR_RESTORE_SCRIPT_RING2" then
        if GetEquippedItem(object,"Ring") ~= nil then
            if GetTemplate(GetEquippedItem(object,"Ring")) == "Siael_POTR_Ring2_D_6e1672b1-daf7-491d-a89b-429bbba087e6" then
                ApplyStatus(GetEquippedItem(object,"Ring"),"SIAEL_POTR_RESTORE",6,0,causee)
                ApplyStatus(GetEquippedItem(object,"Ring"),"SIAEL_POTR_RESTORE_SCRIPT",0,0,causee)
            end
        end
        if GetEquippedItem(object,"Ring2") ~= nil then
            if GetTemplate(GetEquippedItem(object,"Ring2")) == "Siael_POTR_Ring2_D_6e1672b1-daf7-491d-a89b-429bbba087e6" then
                ApplyStatus(GetEquippedItem(object,"Ring2"),"SIAEL_POTR_RESTORE",6,0,causee)
                ApplyStatus(GetEquippedItem(object,"Ring2"),"SIAEL_POTR_RESTORE_SCRIPT",0,0,causee)
            end
        end
    end
end)

local function GetPartyMembers()
	local partyMembersDB = Osi.DB_PartyMembers:Get(nil)

	local partyMembersSet = {}
	for _, v in pairs(partyMembersDB) do
		local uuid = v[1]
        --print("DB_PartyMembers: " .. uuid)
		partyMembersSet[uuid] = true
	end
	return partyMembersSet
end

--Curse reveal handler
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "SIAEL_POTR_RESTORE_SCRIPT" then
        local turns = GetStatusTurns(object,"SIAEL_POTR_RESTORE")
        local baseDC = 20
        local baseDCuuid = "d437a563-add4-4e4d-a280-7b1e2dc710"
        local slot = GetEquipmentSlotForItem(object)
        local slotName
        local DC
        if slot == 0 then slotName = "Helmet"
        elseif slot == 1 then slotName = "Breast"
        elseif slot == 2 then slotName = "Cloak"
        elseif slot == 3 then slotName = "Melee Main Weapon"
        elseif slot == 4 then slotName = "Melee Offhand Weapon"
        elseif slot == 5 then slotName = "Ranged Main Weapon"
        elseif slot == 6 then slotName = "Ranged Offhand Weapon"
        elseif slot == 7 then slotName = "Ring"
        elseif slot == 8 then slotName = "Underwear"
        elseif slot == 9 then slotName = "Boots"
        elseif slot == 10 then slotName = "Gloves"
        elseif slot == 11 then slotName = "Amulet"
        elseif slot == 12 then slotName = "Ring2"
        elseif slot == 13 then slotName = "Wings"
        elseif slot == 14 then slotName = "Horns"
        elseif slot == 15 then slotName = "Overhead"
        elseif slot == 16 then slotName = "MusicalInstrument"
        elseif slot == 17 then slotName = "VanityBody"
        elseif slot == 18 then slotName = "VanityBoots"
        end
        print("")
        print("Path of the Righteous - Purification process...")
        print("    Slot: " .. slotName)
        print("    Item: " .. object)
        print("    Checking on party members...")
        local partyMembersSet = GetPartyMembers()
        for uuid, _ in pairs(partyMembersSet) do
            print("    " .. uuid)
            --if uuid:find("Player",1,true) or uuid:find("S_GOB_DrowCommander",1,true) or uuid:find("S_GLO_Halsin",1,true) or uuid:find("Reborn_") then
                local item
                if GetEquippedItem(uuid,slotName) ~= nil then
                    item = GetEquippedItem(uuid,slotName)
                end
                if item == nil or (not object:find(item,1,true) and slotName == "Ring" and GetEquippedItem(uuid,"Ring2") ~= nil) then
                    item = GetEquippedItem(uuid,"Ring2")
                end
                if item ~= nil and object:find(item,1,true) then
                    DC = baseDC - turns * math.max(1,math.floor((10-Osi.GetAbility(uuid,"Wisdom"))/2))
                    local DCuuid
                    if DC <= 1 then DC = 2 end
                    if DC < 10 then DCuuid = baseDCuuid .. "0" .. DC
                    else DCuuid = baseDCuuid .. DC end
                    print("    Found item, rolling Arcana with DC: " .. DC)
                    print("")
                    Osi.RequestPassiveRoll(uuid,"","SkillCheck","Arcana",DCuuid,0,"Siael_POTR_ArcaneCheck" .. object)
                end
            --end
        end
    elseif status == "SIAEL_POTR_SHIELD_TECHNICAL" then
        ApplyStatus(GetEquippedItem(object,"Melee Offhand Weapon"),"SIAEL_POTR_RESTORE",6,0,object)
        ApplyStatus(GetEquippedItem(object,"Melee Offhand Weapon"),"SIAEL_POTR_RESTORE_SCRIPT",0,0,object)
    end
end)

Ext.Osiris.RegisterListener("RollResult", 6, "after", function(eventName, roller, rollSubject, resultType, isActiveRoll, criticality)
    if string.find(eventName,"Siael_POTR_ArcaneCheck") == 1 then
        if resultType == 1 then
            local object = string.sub(eventName,23)
            print("")
            print("Path of the Righteous - successful Arcana check on item: " .. object)
            print("")
            ApplyStatus(object,"SIAEL_POTR_CURSE",-1)
        end
    elseif string.find(eventName,"Siael_POTR_RevealCheck") == 1 then
        if resultType == 1 then
            local object = string.sub(eventName,23)
            --print(object)
            RemoveStatus(object,"SIAEL_POTR_EVIL_WRATH_TECHNICAL")
            RemoveStatus(object,"SIAEL_POTR_EVIL_PROTECTION_TECHNICAL")
            RemoveStatus(object,"SIAEL_POTR_EVIL_JUSTICE_TECHNICAL")
            RemoveStatus(object,"SIAEL_POTR_EVIL_MERCY_TECHNICAL")
            RemoveStatus(object,"SIAEL_POTR_EVIL_RESOLVE_TECHNICAL")
            RemoveStatus(object,"SIAEL_POTR_EVIL_FULL_TECHNICAL")
            RemoveStatus(object,"SIAEL_POTR_EVIL_FINAL_TECHNICAL")
        end
    end
end)

Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(object, status, causee, applyStoryActionID)
    if status == "SIAEL_POTR_EVIL_WRATH_TECHNICAL" then
        ApplyStatus(object,"SIAEL_POTR_EVIL_WRATH",30)
    elseif status == "SIAEL_POTR_EVIL_PROTECTION_TECHNICAL" then
        ApplyStatus(object,"SIAEL_POTR_EVIL_PROTECTION",30)
    elseif status == "SIAEL_POTR_EVIL_JUSTICE_TECHNICAL" then
        ApplyStatus(object,"SIAEL_POTR_EVIL_JUSTICE",30)
    elseif status == "SIAEL_POTR_EVIL_MERCY_TECHNICAL" then
        ApplyStatus(object,"SIAEL_POTR_EVIL_MERCY",30)
    elseif status == "SIAEL_POTR_EVIL_RESOLVE_TECHNICAL" then
        ApplyStatus(object,"SIAEL_POTR_EVIL_RESOLVE",30)
    elseif status == "SIAEL_POTR_EVIL_FULL_TECHNICAL" then
        ApplyStatus(object,"SIAEL_POTR_EVIL_FULL",30)
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").wrath ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_WRATH",-1) else ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_WRATH",0) end
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").mercy ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_MERCY",-1) else ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_MERCY",0) end
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").protection ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_PROTECTION",-1) else  ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_PROTECTION",0) end
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").resolve ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_RESOLVE",-1) else ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_RESOLVE",0) end
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").justice ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_JUSTICE",-1) else ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_JUSTICE",0) end
        Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12")["chest"] = object
        print(Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").chest)
    elseif status == "SIAEL_POTR_EVIL_FULL" then
        ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_2",-1)
    elseif status == "SIAEL_POTR_EVIL_FINAL_TECHNICAL" then
        ApplyStatus(object,"SIAEL_POTR_EVIL_FINAL",-1)
    elseif status == "SIAEL_POTR_EVIL_FINAL" then
        Osi.ApplyDamage(object, 1, "Radiant")
        Osi.OpenMessageBox(causee, "Siael_POTR_Reward")
        TemplateAddTo("99cda093-86bc-4ef2-9ea3-11781aebdf16",causee,1,1)
        TemplateAddTo("af64b864-26af-41ac-8467-6eddca94ebc5",causee,1,1)
    end
end)

--Converter from Desecrated to Rare
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(object, status, causee, applyStoryActionID)
    if status == "SIAEL_POTR_CURSE" then
        local template = GetTemplate(object)
        local x,y,z = GetPosition(object)
        RequestDelete(object)
        if template == "Siael_POTR_Sword_D_1a1d095f-cc53-4aa7-a65c-06bf08a53e42" then
            --Osi.Transform(object,"8dba5984-6a91-4ddf-8a8d-c2238aad2108","")
            CreateAt("8dba5984-6a91-4ddf-8a8d-c2238aad2108",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Gauntlets_D_b13fb5e5-9d07-4f5e-853b-dbe0567c6ce8" then
            --Osi.Transform(object,"91d768aa-fac7-421a-927d-c6fa28625d73","")
            CreateAt("91d768aa-fac7-421a-927d-c6fa28625d73",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Boots_D_beaf5421-f696-4a9a-bc79-84af1037c978" then
            --Osi.Transform(object,"e0cb79a9-f19a-4416-b7a4-7cf09aa4e1c6","")
            CreateAt("e0cb79a9-f19a-4416-b7a4-7cf09aa4e1c6",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Armor_D_5c5a9832-5ae1-4b00-b9b0-f015e18a449c" then
            --Osi.Transform(object,"2fefb133-39c6-49f3-8cf6-040eae5b43f0","")
            CreateAt("2fefb133-39c6-49f3-8cf6-040eae5b43f0",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Head_D_01c426eb-f692-4832-8e3e-f14f36a39254" then
            --Osi.Transform(object,"40215888-0d3c-4e7c-8092-6014bb1d378b","")
            CreateAt("40215888-0d3c-4e7c-8092-6014bb1d378b",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Cape_D_67bfce50-5f00-4b00-8221-df9537859fe4" then
            --Osi.Transform(object,"69e54126-15cd-4ba0-8f01-4e7cd74972a1","")
            CreateAt("69e54126-15cd-4ba0-8f01-4e7cd74972a1",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Shield_D_f5e73745-56fe-4491-acef-6b04ca4250ee" then
            --Osi.Transform(object,"d9965a8b-a971-4ceb-8469-b4f659908466","")
            CreateAt("d9965a8b-a971-4ceb-8469-b4f659908466",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Ring1_D_addcb0b3-c828-47d0-a597-196d9f99ee73" then
            --Osi.Transform(object,"94ec2c7c-dc62-4a2c-850a-ee2b445dda07","")
            CreateAt("94ec2c7c-dc62-4a2c-850a-ee2b445dda07",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Ring2_D_6e1672b1-daf7-491d-a89b-429bbba087e6" then
            --Osi.Transform(object,"4d4f6335-e543-47af-a354-8b768a3dbd68","")
            CreateAt("4d4f6335-e543-47af-a354-8b768a3dbd68",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Amulet_D_3538aea3-5da0-4ee8-8592-4d58c933f495" then
            --Osi.Transform(object,"7f56f65b-090a-44a4-97db-97506d5d3382","")
            CreateAt("7f56f65b-090a-44a4-97db-97506d5d3382",x,y,z,0,0,"")
        elseif template == "Siael_POTR_Trinket_D_b9df0884-3ce0-4b32-aea8-bc1a1f5ca69d" then
            --Osi.Transform(object,"252e4225-1a83-4c7b-b3da-66dfccb640c7","")
            CreateAt("252e4225-1a83-4c7b-b3da-66dfccb640c7",x,y,z,0,0,"")
        end
    end
end)

--Ping for the boots
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "SIAEL_POTR_AUTOPING" then
        --DC 15
        RequestPassiveRoll(object,"","SkillCheck","Perception","831e1fbe-428d-4f4d-bd17-4206d6efea35",0,"SIAEL_POTR_AUTOPING" .. causee)
    end
end)

Ext.Osiris.RegisterListener("RollResult", 6, "after", function(eventName, roller, rollSubject, resultType, isActiveRoll, criticality)
    if string.find(eventName,"SIAEL_POTR_AUTOPING") == 1 and resultType == 1 then
        local source = string.sub(eventName,20)
        local x
        local y
        local z
        x,y,z = Osi.GetPosition(source)
        ---@diagnostic disable-next-line: param-type-mismatch
        RequestPing(x,y,z,source,roller)
    end
end)

Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(levelName, isEditorMode)
    Osi.ClearOwnership("b9c7e23e-e4f6-468e-bc09-1641f14d3a44")
    Osi.ClearOwnership("8451f82a-460a-4925-bc3d-9de889670738")
    if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").chest ~= nil then
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").wrath ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_WRATH",-1) else ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_WRATH",0) end
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").mercy ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_MERCY",-1) else ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_MERCY",0) end
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").protection ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_PROTECTION",-1) else  ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_PROTECTION",0) end
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").resolve ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_RESOLVE",-1) else ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_RESOLVE",0) end
        if Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").justice ~= 1 then ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_JUSTICE",-1) else ApplyStatus(object,"SIAEL_POTR_EVIL_FULL_JUSTICE",0) end
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Rewards
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Pandirna - Crippled Thanks
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(object, status, causee, applyStoryActionID)
    if status == "DEN_PANDIMA_PARALYZED" and IsPlayer(causee) == 1 then
        print("SIAEL - Pandirna has been cured.")
        TemplateAddTo("3cbe5541-922c-4d7e-9b0e-34e364643e25",causee,1,1)
    end
end)

local stopShroom = 0
local stopGondians = 0
--Objectives detector - Flags
Ext.Osiris.RegisterListener("FlagSet", 3, "after", function(flag, speaker, dialogInstance)
    --Thulla - Ironhand Coin
    if flag == "UND_InjuredGnome_State_Healed_6dd9c64e-a6b0-47d5-87f6-b1a1c49d3ab4" then
        print("SIAEL - Thulla has been cured.")
        TemplateAddTo("87e02694-4a26-412f-b519-2854bd221d8e",GetHostCharacter(),1,1)
    --Minthara - Remembrance of Enmity
    elseif flag == "MOO_MintharaFate_State_Freed_b77a54f6-a1e8-20a7-b932-9a0c10547a39" then
        print("SIAEL - Minthara was freed from the mind torture.")
        TemplateAddTo("2ee08744-61d9-4e3a-9814-88f476ac60d6",GetHostCharacter(),1,1)
    --Yenna - Safe Haven Keepsake
    elseif flag == "CAMP_Yenna_State_InviteYenna_97ef627d-05ca-4218-a7e0-00aafcad939e" and GetFlag("WYR_MeetingYenna_State_KindPath_39ce1c08-e6c3-4d5c-9aca-904d1484895d",GetHostCharacter()) == 1 then
        print("SIAEL - Good to Yenna.")
        TemplateAddTo("87a23db1-ef70-47bd-bd9e-f32a79fdb631",GetHostCharacter(),1,1)
    --Mad Monk - Laughing Abnegation
    elseif flag == "WYR_SentientAmulet_Event_GetMonkReward_93f52b5c-5f1f-4163-b76f-ab6cec9a6767" then
        print("SIAEL - The Mad Monk's Curse has been lifted.")
        TemplateAddTo("54eaf5d7-2616-4ed6-9eb0-420f54e2849b",GetHostCharacter(),1,1)
    --Grymforge Gnomes - Broken Chains
    elseif flag == "UND_DuergarCamp_State_GnomeAtMyconids_f48d9c4e-e6eb-46dc-93a7-89326d11829b" then
        print("SIAEL - Gnomes were saved and returned to myconid circle.")
        TemplateAddTo("54f1f1bf-68c1-4244-9c09-bf65144ecc15",GetHostCharacter(),1,1)
    --Wulbren - Gnomish Support
    elseif flag == "HAV_WrootRequest_Event_GaveGift_7b1df8d9-36e9-2de8-3a77-1f1a8c6ff32e" then
        print("SIAEL - Wulbren was brought back to Barcus.")
        TemplateAddTo("35b9c251-a742-4952-b799-5bc9fd4f9cfe",GetHostCharacter(),1,1)
    --Gondians - Ended Tyranny
    elseif flag == "LOW_SteelWatchFoundry_State_Outcome_AllGondiansSaved_422247be-9c7a-4a0b-bf9e-070e62c72d1f" and stopGondians == 0 then
        stopGondians = 1
        print("SIAEL - The Gondians were saved.")
        TemplateAddTo("1876bcea-98f7-4c20-94af-566736524a41",GetHostCharacter(),1,1)
    --Hope - Threads of Hope
    elseif flag == "LOW_HouseOfHope_Event_HopeRescued_119342c6-2a7b-8c90-e96e-3f3a5930e91a" then
        print("SIAEL - Hope was freed.")
        TemplateAddTo("e6debf9e-672c-478e-aca2-7174b026d620",GetHostCharacter(),1,1)
    --Vanra - Fey Vow Dust
    elseif flag == "LOW_BlushingMermaid_Event_VanraWentToMom_895cda4f-6348-45c0-ba2e-bac1a7a1a0b2" then
        print("SIAEL - Vanra was saved.")
        TemplateAddTo("b982de76-493f-4bef-96d3-afc81a3b9fd5",GetHostCharacter(),1,1)
    --Noblestalk - Noblestalk Gill
    elseif flag == "UND_MushroomHunter_State_MushroomDelivered_323718a9-231f-4787-b4f5-8ce2fa30af52" and GetFlag("UND_MushroomHunter_State_Saved_cd1f8012-322b-4135-bb40-54580bf5cea1",GetHostCharacter()) == 1 and stopShroom == 0 then
        stopShroom = 1
        print("SIAEL - The Noblestalk was given to Deryth and Baelen rescued.")
        TemplateAddTo("31a9fd99-7e23-4d51-8b0d-038de488417f",GetHostCharacter(),1,1)
    --Arabella 2 - Innocence Lost
    elseif flag == "TWN_ArabellasPowers_State_ToldParentsDead_cc1a3765-9334-cb88-602f-49ca052de39c" and GetFlag("TWN_ArabellaPowers_State_MovedToCamp_b5f880bc-272e-e8a3-8ca1-b3dca3bce191",GetHostCharacter()) == 1 then
        print("SIAEL - Araballa was informed of the truth and welcome in camp.")
        TemplateAddTo("ed95e9f4-f263-4f2b-974b-24b9f7cc4618",GetHostCharacter(),1,1)
    --Nere - Firecap of Vengeance
    elseif flag == "UND_MyconidRevenge_Event_GiveNereHead_f360d6ae-23b4-4910-8a52-e230e0219958" then
        print("SIAEL - Nere's head was brought to the Myconids.")
        TemplateAddTo("b8979bc1-b5b7-44fc-ae46-1d2ae2271851",GetHostCharacter(),1,1)
    --Duergars - Bliss Spores
    elseif flag == "UND_MyconidCircle_MyconidSovereignReward_bba639f4-7dde-fccb-2572-f88fdaf67af5" then
        print("SIAEL - The duergar invaders were defeated for the Myconids.")
        TemplateAddTo("e80044cc-dda5-4782-b86d-5086b2f7727b",GetHostCharacter(),1,1)
    --Inquisitor - Inquisitor's Brand
    elseif flag == "CRE_Templar_State_Dead_a9546cba-cbcd-4776-9a5e-09d2f30bb004" then
        print("SIAEL - The Crèche Inquisitor was defeated.")
        TemplateAddTo("a4276fc5-3cf3-4e7b-b590-3cc1cea509de",GetHostCharacter(),1,1)
    --Raphael - Infernal Ambition
    elseif flag == "GLO_Monitor_State_Defeated_a5032bc9-878b-4187-b086-d145bec99441" then
        print("SIAEL - Raphael was killed.")
        TemplateAddTo("c4edd352-fd20-44d1-b148-a749fc350b94",GetHostCharacter(),1,1)
    --Cazador - Noble Infamy
    elseif flag == "ORI_Astarion_State_CazadorPermaDefeated_5258c8d8-09a3-4343-bb6e-13ff5b8e3438" then
        print("SIAEL - Cazador Szarr was killed.")
        TemplateAddTo("8bfa120d-9d79-43d7-9662-c566d625aea9",GetHostCharacter(),1,1)
    --Lorroakan - Deva Feather
    elseif flag == "LOW_Lorroakan_State_IsPermadefeated_2c446081-2f24-49c4-84d9-b8f64a3d3098" then
        print("SIAEL - Lorroakan was killed.")
        TemplateAddTo("87d9db33-ff95-47da-9858-7503c19dd811",GetHostCharacter(),1,1)
    --Mystic Carrion - Mortality Chime
    elseif flag == "LOW_FatherCarrion_State_IsFullyDead_683c08ad-358d-400f-8dc8-c1a93f31dcac" then
        print("SIAEL - Mystic Carrion's immortality was put to an end.")
        TemplateAddTo("e5342865-60aa-4ec6-a660-0d88399ed1ba",GetHostCharacter(),1,1)
    --Ansur - Heart of the Storm
    elseif flag == "WYR_SkeletalDragon_State_Defeated_bafbffed-bb3f-43b0-a006-7bac257a633c" then
        print("SIAEL - Ansur was slain once more.")
        TemplateAddTo("1986078c-7fa9-450e-bdf7-44346717f9ef",GetHostCharacter(),1,1)
    elseif flag == "" then
        print("")
    end
end)

local stopEG = 0
local stopFlorrick = 0
local stopAF = 0
local stopMoonrise = 0
local stopKagha = 0
local stopHalsin = 0
local stopVolo = 0
local stopEthel = 0
local stopIsobel = 0
local stopYurgir = 0
local stopNightsong = 0
local stopKetheric = 0
local stopThaniel = 0
local stopArfur = 0
local stopValeria = 0
local stopNaaber = 0
local stopMurders = 0
local stopDribbles = 0
local stopIronThrone = 0
--Objective detector - Quests
Ext.Osiris.RegisterListener("QuestUpdateUnlocked", 3, "after", function(character, topLevelQuestID, stateID)
    print(topLevelQuestID .. " " .. stateID)
    --Emerald Grove - Horned and Thorned Gratitude
    if topLevelQuestID == "DEN_Conflict" and stateID == "SidedTieflings_Celebrate"  and stopEG == 0 then
        print("SIAEL - Emerald Grove was saved.")
        stopEG = 1
        TemplateAddTo("4cd50383-d02b-4023-b8eb-d70d5a30e96f",GetHostCharacter(),1,1)
    --Florrick - Pendant of Tyr
    elseif topLevelQuestID == "WYR_FreeFlorrick" and (stateID == "Escaped" or stateID == "Escaped_Peaceful") and stopFlorrick == 0  then
        stopFlorrick = 1
        print("SIAEL - Counsellor Florrick escaped.")
        TemplateAddTo("03efce1d-0cc4-493a-99df-ba17d16eee96",GetHostCharacter(),1,1)
    --Adamantine Forge - Mithral Will
    elseif topLevelQuestID == "UND_AdamantineForge" and stateID == "ItemPickedUp" and stopAF == 0  then
        stopAF = 1
        print("SIAEL - Adamantine Forge used.")
        TemplateAddTo("26bb3e6f-efa6-4c8b-9fc2-34d0739e6eff",GetHostCharacter(),1,1)
    --Moonrise Jailbreak - Cheerful Reunion
    elseif topLevelQuestID == "Act2_Criminal_MoonriseJailbreak" and (stateID == "AllEscaped" or stateID == "BoatAllEscaped" or stateID == "AllEscapedHav" or stateID == "BoatAllEscapedHav") and stopMoonrise == 0 then
        stopMoonrise = 1
        print("SIAEL - All Moonrise prisonners were freed.")
        TemplateAddTo("6b91bdb7-3f58-4bb6-ab6b-a8250752c035",GetHostCharacter(),1,1)
    --Kagha - Bramble of Redemption
    elseif topLevelQuestID == "DEN_Conflict" and stateID == "FightGood" and stopKagha == 0 then
        stopKagha = 1
        print("SIAEL - Kagha was turned from the Shadow Druids.")
        TemplateAddTo("28730b0f-f06f-4937-96bc-478dc492867f",GetHostCharacter(),1,1)
    --Halsin - Druidic Gratitude
    elseif topLevelQuestID == "DEN_Conflict" and (stateID == "FoundHalsin_Known_KillLeaders" or stateID == "HalsinLeft_KilledLeaders") and stopHalsin == 0 then
        stopHalsin = 1
        print("SIAEL - Halsin was rescued.")
        TemplateAddTo("4d80a901-54e7-4c9d-81cc-471ecfcc1fcc",GetHostCharacter(),1,1)
    -- --Volo - Thrilled Autograph
    -- elseif topLevelQuestID == "DEN_VoloAdventure" and stateID == "VoloCamp" and stopVolo == 0 then
    --     stopVolo = 1
    --     print("SIAEL - Volo has been rescued and sent to camp.")
    --     TemplateAddTo("ce9f40cf-6b50-4b57-89c5-efefbbb6aba8",GetHostCharacter(),1,1)
    -- --Ethel - Widow's Mourning
    -- elseif topLevelQuestID == "HAG_HagSpawn" and stateID == "SavedMayrina" and stopEthel == 0 then
    --     stopEthel = 1
    --     print("SIAEL - Mayrina has been freed.")
    --     TemplateAddTo("ff2fd759-2d8a-4d0c-801a-6ec39817a55d",GetHostCharacter(),1,1)
    --Marcus - Moonveil Keep
    elseif topLevelQuestID == "GLO_Moonrise" and (stateID == "ProtectedIsobel_Reach" or stateID == "SavedIsobel") and stopIsobel == 0 then
        stopIsobel = 1
        print("SIAEL - Marcus was prevented from taking Isobel.")
        TemplateAddTo("1bfca79f-70e7-40c2-b851-21ac2a67d38f",GetHostCharacter(),1,1)
    --Yurgir - Fiendish Cinders
    elseif topLevelQuestID == "SHA_OldEnemy" and stateID == "DefeatedOrphon" and stopYurgir == 0 then
        stopYurgir = 1
        print("SIAEL - Yurgir was killed in the Gauntlet of Shar.")
        TemplateAddTo("79a5abfe-385b-45be-9d64-5b72ec7ce7b1",GetHostCharacter(),1,1)
    --Nightsong - Selunite Crescent
    elseif (topLevelQuestID == "SHA_Nightsong" and stateID == "NightsongFreed") or (topLevelQuestID == "ORI_Avatar_ShadowHeart" and stateID == "Nightsong_Spared") and stopNightsong == 0 then
        stopNightsong = 1
        print("SIAEL - Nightsong has been freed from the Shadowfell.")
        TemplateAddTo("97eb92bb-9865-4e76-94e9-17ad868d794f",GetHostCharacter(),1,1)
    --Ketheric - Piece of Wavered Faith
    elseif topLevelQuestID == "MOO_EndKetheric" and (stateID == "DefeatedKetheric" or stateID == "DefeatedKetheric_Suicide") and stopKetheric == 0  then
        stopKetheric = 1
        print("SIAEL - Ketheric Thorm was defeated.")
        TemplateAddTo("fd43c7e4-6fcb-4c38-9f95-a7105a938a13",GetHostCharacter(),1,1)
    --Thaniel -- Shadow-Touched Dawnbloom
    elseif topLevelQuestID == "SCL_LiftingTheCurse" and stateID == "TalkToThaniel" and stopThaniel == 0 then
        stopThaniel = 1
        print("SIAEL - The Shadow Curse was lifted.")
        TemplateAddTo("c8104249-bd0a-401d-90ed-482d6c07b635",GetHostCharacter(),1,1)
    --Arfur - Preserved Plush
    elseif topLevelQuestID == "WYR_Donations" and stateID == "LearnedPassword_ArfurConfessed" and stopArfur == 0 then
        stopArfur = 1
        print("SIAEL - Arfur was exposed.")
        TemplateAddTo("d558a5d5-a18b-464f-a091-433cdbccc18c",GetHostCharacter(),1,1)
    --Valeria - Bhaalspawn Helmet
    elseif topLevelQuestID == "GLO_GatherYourAllies" and stateID == "ValeriaPromisesSupport" and stopValeria == 0 then
        stopValeria = 1
        print("SIAEL - Valeria was freed from the Murder Tribunal.")
        TemplateAddTo("ea848cfb-6def-44a5-b4c0-4ead74aaca0d",GetHostCharacter(),1,1)
    --Naaber - Utmost Patience
    elseif topLevelQuestID == "HIDDEN_BGO_Boosters" and stateID == "WYR_FigaroSister_FinishedNaaberDialog" and stopNaaber == 0 then
        stopNaaber = 1
        print("SIAEL - Naaber was listened to patiently.")
        TemplateAddTo("fec8eac5-b97c-419d-a4cd-1b73deb8a5c4",GetHostCharacter(),1,1)
    --Murders - Truthseeker's Grace
    elseif topLevelQuestID == "WYR_OpenHandMurder" and stateID == "WYR_ConvinceAnnoyingElephant_GoToDevella" and stopMurders == 0 then
        stopMurders = 1
        print("SIAEL - The Open Hand Temple murders were solved.")
        TemplateAddTo("d8b65034-bbc1-4e4f-9876-5ea27d4e1607",GetHostCharacter(),1,1)
    --Dribbles - Encore et Encore
    elseif topLevelQuestID == "WYR_Clown" and stateID == "Rewarded" and stopDribbles == 0 then
        stopDribbles = 1
        print("SIEL - Dribbles will perform encore.")
        TemplateAddTo("6e0e6f08-781a-42e3-a7b2-357036564754",GetHostCharacter(),1,1)
    --Iron Throne - Old Faith Memorabilia
    elseif topLevelQuestID == "LOW_SaveGondians" and stateID == "LeftIronThrone_AllSaved" and stopIronThrone == 0 then
        stopIronThrone = 1
        print("SIAEL - All the prisonners from the Iron Throne were saved.")
        TemplateAddTo("884d6e6d-3246-45cc-97b7-6ae5139d009f",GetHostCharacter(),1,1)
    end
end)

--Blood of Lathander - Brilliant Devotion
Ext.Osiris.RegisterListener("AddedTo", 3, "after", function(object, inventoryHolder, addType)
    if object == "S_CRE_BloodOfLathander_e26f0c19-6185-43a7-b7f7-7155b936c59c" and GetFlag("f6ee5634-6b15-40d5-9a12-52d2d689055f",GetHostCharacter()) == 0 and GetFlag("CRE_Lance_State_Disarmed_a17b9bbd-43e1-4ba2-8f88-a33ecdb07a96",GetHostCharacter()) == 1 then
        print("SIAEL - The Blood of Lathander was found without destroying the monastery.")
        TemplateAddTo("70429483-15c6-4a04-9bba-046b086e2a70",GetHostCharacter(),1,1)
        SetFlag("f6ee5634-6b15-40d5-9a12-52d2d689055f")
    end
end)

Ext.Osiris.RegisterListener("DialogEnded", 2, "after", function(dialog, instanceID)
    --Arabella 1 - Diamond of Innocence
    if dialog == "DEN_GuardedEntrance_ParentsWithKid_ff5eb453-222a-74e5-8b96-7a43a3d83238" then
        print("SIAEL - Arabella was reunited with her parents.")
        TemplateAddTo("ba70058a-a3e2-4724-805f-4945c8b943f1",GetHostCharacter(),1,1)
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Upgrades
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local sword1 = "Siael_POTR_Sword_R_8dba5984-6a91-4ddf-8a8d-c2238aad2108"
local sword2 = "Siael_POTR_Sword_V_8e979de0-dd0f-44de-8248-d466945376d4"
local sword3 = "Siael_POTR_Sword_L_341c9819-cdf8-44c0-b5c2-12e7eaa74ed7"
local sword4 = "Siael_POTR_Sword_M_22f23551-cb58-48ea-bf1c-69000890afc2"
local bracers1 = "Siael_POTR_Gauntlets_R_91d768aa-fac7-421a-927d-c6fa28625d73"
local bracers2 = "Siael_POTR_Gauntlets_V_0950cc60-84df-4ae0-8511-4a6e64c0305e"
local bracers3 = "Siael_POTR_Gauntlets_L_54631b69-e8ee-471c-8e77-aeb7fe93f60c"
local boots1 = "Siael_POTR_Boots_R_e0cb79a9-f19a-4416-b7a4-7cf09aa4e1c6"
local boots2 = "Siael_POTR_Boots_V_01ed02fd-eb31-4f30-85c6-f9f23e4d164f"
local boots3 = "Siael_POTR_Boots_L_ae6dc6c0-3eaf-4c8d-afdd-984c0b415757"
local armor1 = "Siael_POTR_Armor_R_2fefb133-39c6-49f3-8cf6-040eae5b43f0"
local armor2 = "Siael_POTR_Armor_V_479dcc04-be02-4b6f-8af4-c00fe3d036aa"
local armor3 = "Siael_POTR_Armor_L_79d96a77-9569-4191-9037-61dec83709f6"
local head1 = "Siael_POTR_Head_R_40215888-0d3c-4e7c-8092-6014bb1d378b"
local head2 = "Siael_POTR_Head_V_f2f43418-6691-417b-9138-d8c6ac61a5b4"
local head3 = "Siael_POTR_Head_L_81e19b97-42ed-43b7-81ad-0deeb96c2e25"
local cape1 = "Siael_POTR_Cape_R_69e54126-15cd-4ba0-8f01-4e7cd74972a1"
local cape2 = "Siael_POTR_Cape_V_872a2406-3efb-4fe4-8757-ef77daf8d149"
local cape3 = "Siael_POTR_Cape_L_769e290b-f492-480d-ad6d-3c857e5bb35a"
local shield1 = "Siael_POTR_Shield_R_d9965a8b-a971-4ceb-8469-b4f659908466"
local shield2 = "Siael_POTR_Shield_V_2a02d378-3134-4196-9b94-355604d3c5da"
local shield3 = "Siael_POTR_Shield_L_2d809d9c-c825-466a-91f0-2da79f4ef963"
local ringa1 = "Siael_POTR_Ring1_R_94ec2c7c-dc62-4a2c-850a-ee2b445dda07"
local ringa2 = "Siael_POTR_Ring1_V_4349f5d5-38f0-436a-85ca-aed98801446e"
local ringa3 = "Siael_POTR_Ring1_L_7e73cbd8-331d-4ef6-a96c-ca5f930cb830"
local ringb1 = "Siael_POTR_Ring2_R_4d4f6335-e543-47af-a354-8b768a3dbd68"
local ringb2 = "Siael_POTR_Ring2_V_be62a0e9-789b-4e89-bf1b-df1be81946bc"
local ringb3 = "Siael_POTR_Ring2_L_fd0f1e10-def5-48af-b24d-e42f73e517ad"
local amulet1 = "Siael_POTR_Amulet_R_7f56f65b-090a-44a4-97db-97506d5d3382"
local amulet2 = "Siael_POTR_Amulet_V_fcd13b9e-960e-4780-a8e7-9095d02591bf"
local amulet3 = "Siael_POTR_Amulet_L_08ab1c02-3798-49f5-a002-930ce661b262"
local trinket1 = "Siael_POTR_Trinket_R_252e4225-1a83-4c7b-b3da-66dfccb640c7"
local trinket2 = "Siael_POTR_Trinket_V_97a8a49a-5592-4792-9487-34bbfbe6693a"
local trinket3 = "Siael_POTR_Trinket_L_b41fb5a7-a965-4dfa-bc48-36a3c49e537a"

local trigger = false

local items = {}
table.insert(items,sword1)
table.insert(items,sword2)
table.insert(items,sword3)
table.insert(items,sword4)
table.insert(items,bracers1)
table.insert(items,bracers2)
table.insert(items,bracers3)
table.insert(items,boots1)
table.insert(items,boots2)
table.insert(items,boots3)
table.insert(items,armor1)
table.insert(items,armor2)
table.insert(items,armor3)
table.insert(items,head1)
table.insert(items,head2)
table.insert(items,head3)
table.insert(items,cape1)
table.insert(items,cape2)
table.insert(items,cape3)
table.insert(items,shield1)
table.insert(items,shield2)
table.insert(items,shield3)
table.insert(items,ringa1)
table.insert(items,ringa2)
table.insert(items,ringa3)
table.insert(items,ringb1)
table.insert(items,ringb2)
table.insert(items,ringb3)
table.insert(items,amulet1)
table.insert(items,amulet2)
table.insert(items,amulet3)
table.insert(items,trinket1)
table.insert(items,trinket2)
table.insert(items,trinket3)

--Upgrade spell handler
Ext.Osiris.RegisterListener("CastedSpell", 5, "after", function(caster, spell, spellType, spellElement, storyActionID)
    trigger = true
    if spell == "Siael_POTR_UpgradeSword_1" and GetTemplate(GetEquippedItem(caster,"Melee Main Weapon")) == sword1 then
        Unequip(caster,GetEquippedItem(caster,"Melee Main Weapon"))
        TemplateRemoveFrom(sword1,caster,1)
        TemplateAddTo(sword2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeSword_2" and GetTemplate(GetEquippedItem(caster,"Melee Main Weapon")) == sword2 then
        Unequip(caster,GetEquippedItem(caster,"Melee Main Weapon"))
        TemplateRemoveFrom(sword2,caster,1)
        TemplateAddTo(sword3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeSword_3" and GetTemplate(GetEquippedItem(caster,"Melee Main Weapon")) == sword3 then
        Unequip(caster,GetEquippedItem(caster,"Melee Main Weapon"))
        TemplateRemoveFrom(sword3,caster,1)
        TemplateAddTo(sword4,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeGauntlets_1" and GetTemplate(GetEquippedItem(caster,"Gloves")) == bracers1 then
        Unequip(caster,GetEquippedItem(caster,"Gloves"))
        TemplateRemoveFrom(bracers1,caster,1)
        TemplateAddTo(bracers2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeGauntlets_2" and GetTemplate(GetEquippedItem(caster,"Gloves")) == bracers2 then
        Unequip(caster,GetEquippedItem(caster,"Gloves"))
        TemplateRemoveFrom(bracers2,caster,1)
        TemplateAddTo(bracers3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeBoots_1" and GetTemplate(GetEquippedItem(caster,"Boots")) == boots1 then
        Unequip(caster,GetEquippedItem(caster,"Boots"))
        TemplateRemoveFrom(boots1,caster,1)
        TemplateAddTo(boots2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeBoots_2" and GetTemplate(GetEquippedItem(caster,"Boots")) == boots2 then
        Unequip(caster,GetEquippedItem(caster,"Boots"))
        TemplateRemoveFrom(boots2,caster,1)
        TemplateAddTo(boots3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeArmor_1" and GetTemplate(GetEquippedItem(caster,"Breast")) == armor1 then
        Unequip(caster,GetEquippedItem(caster,"Breast"))
        TemplateRemoveFrom(armor1,caster,1)
        TemplateAddTo(armor2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeArmor_2" and GetTemplate(GetEquippedItem(caster,"Breast")) == armor2 then
        Unequip(caster,GetEquippedItem(caster,"Breast"))
        TemplateRemoveFrom(armor2,caster,1)
        TemplateAddTo(armor3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeHelmet_1" and GetTemplate(GetEquippedItem(caster,"Helmet")) == head1 then
        Unequip(caster,GetEquippedItem(caster,"Helmet"))
        TemplateRemoveFrom(head1,caster,1)
        TemplateAddTo(head2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeHelmet_2" and GetTemplate(GetEquippedItem(caster,"Helmet")) == head2 then
        Unequip(caster,GetEquippedItem(caster,"Helmet"))
        TemplateRemoveFrom(head2,caster,1)
        TemplateAddTo(head3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeCloak_1" and GetTemplate(GetEquippedItem(caster,"Cloak")) == cape1 then
        Unequip(caster,GetEquippedItem(caster,"Cloak"))
        TemplateRemoveFrom(cape1,caster,1)
        TemplateAddTo(cape2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeCloak_2" and GetTemplate(GetEquippedItem(caster,"Cloak")) == cape2 then
        Unequip(caster,GetEquippedItem(caster,"Cloak"))
        TemplateRemoveFrom(cape2,caster,1)
        TemplateAddTo(cape3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeShield_1" and GetTemplate(GetEquippedItem(caster,"Melee Offhand Weapon")) == shield1 then
        Unequip(caster,GetEquippedItem(caster,"Melee Offhand Weapon"))
        TemplateRemoveFrom(shield1,caster,1)
        TemplateAddTo(shield2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeShield_2" and GetTemplate(GetEquippedItem(caster,"Melee Offhand Weapon")) == shield2 then
        Unequip(caster,GetEquippedItem(caster,"Melee Offhand Weapon"))
        TemplateRemoveFrom(shield2,caster,1)
        TemplateAddTo(shield3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeRing1_1" and GetTemplate(GetEquippedItem(caster,"Ring")) == ringa1 then
        Unequip(caster,GetEquippedItem(caster,"Ring"))
        TemplateRemoveFrom(ringa1,caster,1)
        TemplateAddTo(ringa2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeRing1_2" and GetTemplate(GetEquippedItem(caster,"Ring")) == ringa2 then
        Unequip(caster,GetEquippedItem(caster,"Ring"))
        TemplateRemoveFrom(ringa2,caster,1)
        TemplateAddTo(ringa3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeRing1_1" and GetTemplate(GetEquippedItem(caster,"Ring2")) == ringa1 then
        Unequip(caster,GetEquippedItem(caster,"Ring2"))
        TemplateRemoveFrom(ringa1,caster,1)
        TemplateAddTo(ringa2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeRing1_2" and GetTemplate(GetEquippedItem(caster,"Ring2")) == ringa2 then
        Unequip(caster,GetEquippedItem(caster,"Ring2"))
        TemplateRemoveFrom(ringa2,caster,1)
        TemplateAddTo(ringa3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeRing2_1" and GetTemplate(GetEquippedItem(caster,"Ring")) == ringb1 then
        Unequip(caster,GetEquippedItem(caster,"Ring"))
        TemplateRemoveFrom(ringb1,caster,1)
        TemplateAddTo(ringb2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeRing2_2" and GetTemplate(GetEquippedItem(caster,"Ring")) == ringb2 then
        Unequip(caster,GetEquippedItem(caster,"Ring"))
        TemplateRemoveFrom(ringb2,caster,1)
        TemplateAddTo(ringb3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeRing2_1" and GetTemplate(GetEquippedItem(caster,"Ring2")) == ringb1 then
        Unequip(caster,GetEquippedItem(caster,"Ring2"))
        TemplateRemoveFrom(ringb1,caster,1)
        TemplateAddTo(ringb2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeRing2_2" and GetTemplate(GetEquippedItem(caster,"Ring2")) == ringb2 then
        Unequip(caster,GetEquippedItem(caster,"Ring2"))
        TemplateRemoveFrom(ringb2,caster,1)
        TemplateAddTo(ringb3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeAmulet_1" and GetTemplate(GetEquippedItem(caster,"Amulet")) == amulet1 then
        Unequip(caster,GetEquippedItem(caster,"Amulet"))
        TemplateRemoveFrom(amulet1,caster,1)
        TemplateAddTo(amulet2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeAmulet_2" and GetTemplate(GetEquippedItem(caster,"Amulet")) == amulet2 then
        Unequip(caster,GetEquippedItem(caster,"Amulet"))
        TemplateRemoveFrom(amulet2,caster,1)
        TemplateAddTo(amulet3,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeTrinket_1" and GetTemplate(GetEquippedItem(caster,"MusicalInstrument")) == trinket1 then
        Unequip(caster,GetEquippedItem(caster,"MusicalInstrument"))
        TemplateRemoveFrom(trinket1,caster,1)
        TemplateAddTo(trinket2,caster,1,0)
    elseif spell == "Siael_POTR_UpgradeTrinket_2" and GetTemplate(GetEquippedItem(caster,"MusicalInstrument")) == trinket2 then
        Unequip(caster,GetEquippedItem(caster,"MusicalInstrument"))
        TemplateRemoveFrom(trinket2,caster,1)
        TemplateAddTo(trinket3,caster,1,0)
    else
        trigger = false
    end
end)

--Equips the obtained item
Ext.Osiris.RegisterListener("AddedTo", 3, "after", function(object, inventoryHolder, addType)
    if trigger then
        ---@diagnostic disable-next-line: param-type-mismatch
        local template = GetTemplate(object)
        --string.sub(Osi.GetTemplate(string.sub(object,-36)),-36)
        for _,v in pairs(items) do
            if template == v then
                Osi.Equip(inventoryHolder,object)
                trigger = false
            end
        end
    end
end)

--Helper for armor's globe of invulnerability
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "SIAEL_POTR_ARMOR_CD" then
        UseSpell(object,"Siael_POTR_Armor_Globe",object)
    end
end)

--Helper for Arcana checks to reveal sins on evil items
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "SIAEL_POTR_RIGHTEOUS_REVEAL" then
        Osi.RequestPassiveRoll(causee,"","SkillCheck","Arcana","831e1fbe-428d-4f4d-bd17-4206d6efea35",0,"Siael_POTR_RevealCheck" .. object)
    end
end)

--Helper for the evil chest's seals
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(object, status, causee, applyStoryActionID)
    if status == "SIAEL_POTR_EVIL_WRATH_CHECK" then
        Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12")["wrath"] = 1
        RemoveStatus(Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").chest,"SIAEL_POTR_EVIL_FULL_WRATH")
    elseif status == "SIAEL_POTR_EVIL_MERCY_CHECK" then
        Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12")["mercy"] = 1
        RemoveStatus(Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").chest,"SIAEL_POTR_EVIL_FULL_MERCY")
    elseif status == "SIAEL_POTR_EVIL_PROTECTION_CHECK" then
        Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12")["protection"] = 1
        RemoveStatus(Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").chest,"SIAEL_POTR_EVIL_FULL_PROTECTION")
    elseif status == "SIAEL_POTR_EVIL_RESOLVE_CHECK" then
        Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12")["resolve"] = 1
        RemoveStatus(Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").chest,"SIAEL_POTR_EVIL_FULL_RESOLVE")
    elseif status == "SIAEL_POTR_EVIL_JUSTICE_CHECK" then
        Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12")["justice"] = 1
        RemoveStatus(Ext.Vars.GetModVariables("60b7b37b-c006-4775-bda2-6ebb726acc12").chest,"SIAEL_POTR_EVIL_FULL_JUSTICE")
    end
end)

local function FullSet(character)
    local sword = HasPassive(character,'Siael_POTR_Sword_P1_R') + HasPassive(character,'Siael_POTR_Sword_P1_V') + HasPassive(character,'Siael_POTR_Sword_P1') + HasPassive(character,'Siael_POTR_Sword_P1_M')
    local gauntlets = HasPassive(character,'Siael_POTR_Gauntlets_P1')
    local boots = HasPassive(character,'Siael_POTR_Boots_P1') + HasPassive(character,'Siael_POTR_Boots_P1_V') + HasPassive(character,'Siael_POTR_Boots_P1_L')
    local armor = HasPassive(character,'Siael_POTR_Armor_P1') + HasPassive(character,'Siael_POTR_Armor_P1_V') + HasPassive(character,'Siael_POTR_Armor_P1_L')
    local head = HasPassive(character,'Siael_POTR_Head_P1') + HasPassive(character,'Siael_POTR_Head_P1_V') + HasPassive(character,'Siael_POTR_Head_P1_L')
    local cape = HasPassive(character,'Siael_POTR_Cape_P1')
    local shield = HasPassive(character,'Siael_POTR_Shield_P1') + HasPassive(character,'Siael_POTR_Shield_P1_V')
    local ringA = HasPassive(character,'Siael_POTR_Ring1_P1') + HasPassive(character,'Siael_POTR_Ring1_P1_V') + HasPassive(character,'Siael_POTR_Ring1_P1_L')
    local ringB = HasPassive(character,'Siael_POTR_Ring2_P1')
    local amulet = HasPassive(character,'Siael_POTR_Amulet_P1') + HasPassive(character,'Siael_POTR_Amulet_P1_V')
    local trinket = HasPassive(character,'Siael_POTR_Trinket_P1')

    --print(sword .. gauntlets .. boots .. armor .. head .. cape .. shield .. ringA .. ringB .. amulet .. trinket)
    if sword + gauntlets + boots + armor + head + cape + shield + ringA + ringB + amulet + trinket == 11 then
        ApplyStatus(character,"SIAEL_POTR_RIGHTEOUS_R",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_RIGHTEOUS_R")
    end

    sword = HasPassive(character,'Siael_POTR_Sword_P1_V') + HasPassive(character,'Siael_POTR_Sword_P1') + HasPassive(character,'Siael_POTR_Sword_P1_M')
    gauntlets = HasPassive(character,'Siael_POTR_Gauntlets_P2')
    boots = HasPassive(character,'Siael_POTR_Boots_P1_V') + HasPassive(character,'Siael_POTR_Boots_P1_L')
    armor = HasPassive(character,'Siael_POTR_Armor_P1_V') + HasPassive(character,'Siael_POTR_Armor_P1_L')
    head = HasPassive(character,'Siael_POTR_Head_P1_V') + HasPassive(character,'Siael_POTR_Head_P1_L')
    cape = HasPassive(character,'Siael_POTR_Cape_P2')
    shield = HasPassive(character,'Siael_POTR_Shield_P1_V')
    ringA = HasPassive(character,'Siael_POTR_Ring1_P1_V') + HasPassive(character,'Siael_POTR_Ring1_P1_L')
    ringB = HasPassive(character,'Siael_POTR_Ring2_P2')
    amulet = HasPassive(character,'Siael_POTR_Amulet_P1_V')
    trinket = HasPassive(character,'Siael_POTR_Trinket_P2')

    --print(sword .. gauntlets .. boots .. armor .. head .. cape .. shield .. ringA .. ringB .. amulet .. trinket)
    if sword + gauntlets + boots + armor + head + cape + shield + ringA + ringB + amulet + trinket == 11 then
        ApplyStatus(character,"SIAEL_POTR_RIGHTEOUS",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_RIGHTEOUS")
    end

    sword = HasPassive(character,'Siael_POTR_Sword_P1') + HasPassive(character,'Siael_POTR_Sword_P1_M')
    gauntlets = HasPassive(character,'Siael_POTR_Gauntlets_P3')
    boots = HasPassive(character,'Siael_POTR_Boots_P1_L')
    armor = HasPassive(character,'Siael_POTR_Armor_P1_L')
    head = HasPassive(character,'Siael_POTR_Head_P1_L')
    cape = HasPassive(character,'Siael_POTR_Cape_P3')
    shield = HasPassive(character,'Siael_POTR_Shield_P3')
    ringA = HasPassive(character,'Siael_POTR_Ring1_P1_L')
    ringB = HasPassive(character,'Siael_POTR_Ring2_P3')
    amulet = HasPassive(character,'Siael_POTR_Amulet_P3')
    trinket = HasPassive(character,'Siael_POTR_Trinket_P3')

    local wrath = sword + trinket + ringA == 3
    local protection = armor + shield == 2
    local mercy = gauntlets + amulet == 2
    local justice = ringB + cape == 2
    local resolve = head + boots == 2

    --print(sword .. gauntlets .. boots .. armor .. head .. cape .. shield .. ringA .. ringB .. amulet .. trinket)
    if sword + gauntlets + boots + armor + head + cape + shield + ringA + ringB + amulet + trinket == 11 then
        ApplyStatus(character,"SIAEL_POTR_RIGHTEOUS_L",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_RIGHTEOUS_L")
    end

    if wrath and protection then
        ApplyStatus(character,"SIAEL_POTR_WP",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_WP")
    end

    if wrath and mercy then
        ApplyStatus(character,"SIAEL_POTR_WM",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_WM")
    end

    if wrath and resolve then
        ApplyStatus(character,"SIAEL_POTR_WR",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_WR")
    end

    if wrath and justice then
        ApplyStatus(character,"SIAEL_POTR_WJ",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_WJ")
    end

    if protection and mercy then
        ApplyStatus(character,"SIAEL_POTR_PM",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_PM")
    end

    if protection and resolve then
        ApplyStatus(character,"SIAEL_POTR_PR",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_PR")
    end

    if protection and justice then
        ApplyStatus(character,"SIAEL_POTR_PJ",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_PJ")
    end

    if mercy and resolve then
        ApplyStatus(character,"SIAEL_POTR_MR",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_MR")
    end

    if mercy and justice then
        ApplyStatus(character,"SIAEL_POTR_MJ",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_MJ")
    end

    if resolve and justice then
        ApplyStatus(character,"SIAEL_POTR_RJ",-1)
    else
        RemoveStatus(character,"SIAEL_POTR_RJ")
    end
end

Ext.Osiris.RegisterListener("Equipped", 2, "after", function(item, character)
    Wait(10, function()
        FullSet(character)
    end)
end)

Ext.Osiris.RegisterListener("Unequipped", 2, "after", function(item, character)
    Wait(10, function()
        FullSet(character)
    end)
end)

Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "CONSECRATION_AURA_BONUSES" then
        if HasPassive(causee,"Siael_POTR_Armor_P2") == 1 then
            print("PotR + Inquisitor: Rare armor")
            ApplyStatus(object,"SIAEL_POTR_ARMOR_2_JL",-1,0,causee)
        elseif HasPassive(causee,"Siael_POTR_Armor_P2_V") == 1 then
            print("PotR + Inquisitor: Very Rare armor")
            ApplyStatus(object,"SIAEL_POTR_ARMOR_2_V_JL",-1,0,causee)
        elseif HasPassive(causee,"Siael_POTR_Armor_P2_L") == 1 then
            print("PotR + Inquisitor: Legendary armor")
            ApplyStatus(object,"SIAEL_POTR_ARMOR_2_L_JL",-1,0,causee)
        elseif HasPassive(causee,"Siael_POTR_Resolve") == 1 then
            print("PotR + Inquisitor: Resolve")
            ApplyStatus(object,"SIAEL_POTR_RESOLVE_AURA_JL",-1,0,causee)
        elseif HasPassive(causee,"Siael_POTR_PM") == 1 then
            print("PotR + Inquisitor: Protection + Mercy")
            ApplyStatus(object,"SIAEL_POTR_PM_AURA_JL",-1,0,causee)
        elseif HasPassive(causee,"Siael_POTR_RJ") == 1 then
            print("PotR + Inquisitor: Resolve + Justice")
            ApplyStatus(object,"SIAEL_POTR_RJ_AURA_JL",-1,0,causee)
        elseif HasPassive(causee,"Siael_POTR_Righteous_L") == 1 then
            print("PotR + Inquisitor: Full set")
            ApplyStatus(object,"SIAEL_POTR_FULL_AURA_JL",-1,0,causee)
        end
    end
end)

local function FilterStatuses(status)
    return status == "AURA_OF_COURAGE"
    or status == "AURA_OF_DEVOTION"
    or status == "AURA_OF_HATE"
    or status == "AURA_OF_DEVOTION"
    or status == "AURA_OF_PROTECTION"
    or status == "AURA_OF_WARDING"
    or status == "AURA_OF_COURAGE_2"
    or status == "AURA_OF_HATE_2"
    or status == "AURA_OF_PROTECTION_2"
    or status == "AURA_OF_WARDING_2"
    or status == "CONSECRATION_AURA_BONUSES"
    or status == "AURA_OF_COURAGE_BUFF"
    or status == "AURA_OF_DEVOTION_BUFF"
    or status == "AURA_OF_HATE_BUFF"
    or status == "AURA_OF_PROTECTION_BUFF"
    or status == "AURA_OF_WARDING_BUFF"
    or status == "SIAEL_POTR_ARMOR_R"
    or status == "SIAEL_POTR_ARMOR_V"
    or status == "SIAEL_POTR_ARMOR"
    or status == "SIAEL_POTR_ARMOR_AURA"
    or status == "SIAEL_POTR_ARMOR_AURA_EFFECT"
end

local function HasValidAura(object)
    return HasActiveStatus(object,"AURA_OF_COURAGE") == 1
    or HasActiveStatus(object,"AURA_OF_DEVOTION") == 1
    or HasActiveStatus(object,"AURA_OF_HATE") == 1
    or HasActiveStatus(object,"AURA_OF_PROTECTION") == 1
    or HasActiveStatus(object,"AURA_OF_WARDING") == 1
    or HasActiveStatus(object,"AURA_OF_COURAGE_2") == 1
    or HasActiveStatus(object,"AURA_OF_DEVOTION_2") == 1
    or HasActiveStatus(object,"AURA_OF_HATE_2") == 1
    or HasActiveStatus(object,"AURA_OF_PROTECTION_2") == 1
    or HasActiveStatus(object,"AURA_OF_WARDING_2") == 1
    or HasActiveStatus(object,"CONSECRATION_AURA_BONUSES") == 1
end

local function HasValidAuraEffect(object,causee)
    return (HasActiveStatus(causee,"AURA_OF_COURAGE") == 1 or HasActiveStatus(causee,"AURA_OF_COURAGE_2") == 1 and HasActiveStatus(object,"AURA_OF_COURAGE_BUFF") == 1)
    or (HasActiveStatus(causee,"AURA_OF_DEVOTION") == 1 or HasActiveStatus(causee,"AURA_OF_DEVOTION_2") == 1 and HasActiveStatus(object,"AURA_OF_DEVOTION_BUFF") == 1)
    or (HasActiveStatus(causee,"AURA_OF_HATE") == 1 or HasActiveStatus(causee,"AURA_OF_HATE_2") == 1 and HasActiveStatus(object,"AURA_OF_HATE_BUFF") == 1)
    or (HasActiveStatus(causee,"AURA_OF_PROTECTION") == 1 or HasActiveStatus(causee,"AURA_OF_PROTECTION_2") == 1 and HasActiveStatus(object,"AURA_OF_PROTECTION_BUFF") == 1)
    or (HasActiveStatus(causee,"AURA_OF_WARDING") == 1 or HasActiveStatus(causee,"AURA_OF_WARDING_2") == 1 and HasActiveStatus(object,"AURA_OF_WARDING_BUFF") == 1)
    or HasActiveStatus(object,"CONSECRATION_AURA_BONUSES") == 1
end


local causer
local function StalwartParagon(object,causee)
    if HasPassive(causee,"Siael_POTR_Armor_P2") == 1 then
        print("Rare")
        ApplyStatus(object,"SIAEL_POTR_GUIDANCE",-1,0,causee)
        RemoveStatus(object,"SIAEL_POTR_BLESS")
        RemoveStatus(object,"SIAEL_POTR_HEROISM")
    elseif HasPassive(causee,"Siael_POTR_Armor_P2_V") == 1 then
        print("Very Rare")
        ApplyStatus(object,"SIAEL_POTR_GUIDANCE",-1,0,causee)
        ApplyStatus(object,"SIAEL_POTR_BLESS",-1,0,causee)
        RemoveStatus(object,"SIAEL_POTR_HEROISM")
    elseif HasPassive(causee,"Siael_POTR_Armor_P2_L") == 1 then
        print("Legendary")
        ApplyStatus(object,"SIAEL_POTR_GUIDANCE",-1,0,causee)
        ApplyStatus(object,"SIAEL_POTR_BLESS",-1,0,causee)
        ApplyStatus(object,"SIAEL_POTR_HEROISM",-1,0,causee)
    end
end

--Handles the Stalwart Paragon passive, applying the effects when an ally is within the wearer's aura
Ext.Osiris.RegisterListener("StatusApplied", 4, "after", function(object, status, causee, storyActionID)
    if status == "SIAEL_POTR_ARMOR_AURA_EFFECT" then
        causer = causee
    elseif status == "SIAEL_POTR_GUIDANCE" and HasPassive(causee,"Siael_POTR_Righteous_R") == 1 then
        ApplyStatus(object,"SIAEL_POTR_PFEG",-1,0,causee)
    end
    if FilterStatuses(status) then
        if HasActiveStatus(object,"SIAEL_POTR_ARMOR_AURA_EFFECT") == 1 and HasValidAuraEffect(object,causee) then
            print("Stalwart Paragon - Ally: " .. ResolveTranslatedString(GetDisplayName(object)))
            StalwartParagon(object,causee)
        elseif HasActiveStatus(object,"SIAEL_POTR_ARMOR_AURA") == 1 and HasValidAura(object) then
            print("Stalwart Paragon - Self: " .. ResolveTranslatedString(GetDisplayName(object)))
            StalwartParagon(object,object)
        end
    elseif status == "SIAEL_POTR_RIGHTEOUS_R" then
        ApplyStatus(object,"SIAEL_POTR_PFEG",-1,0,causee)
        local partyMembersSet = GetPartyMembers()
        for uuid, _ in pairs(partyMembersSet) do
            if HasValidAuraEffect(uuid,causer) then
                ApplyStatus(uuid,"SIAEL_POTR_PFEG",-1,0,causee)
            end
        end
    end
end)

--Handles removal of above effects, on the wearer we check they don't have the aura source (or effect for Inquisitor), on others we check they don't have the aura effects
Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", function(object, status, causee, applyStoryActionID)
    if FilterStatuses(status) then
        causer = causee
        print(status .. " removed from " .. ResolveTranslatedString(GetDisplayName(object)))
        if (HasActiveStatus(object,"SIAEL_POTR_ARMOR_AURA") == 0 or not HasValidAura(object)) and (HasActiveStatus(object,"SIAEL_POTR_ARMOR_AURA_EFFECT") == 0 or not HasValidAuraEffect(object,causer)) then
            RemoveStatus(object,"SIAEL_POTR_GUIDANCE")
            RemoveStatus(object,"SIAEL_POTR_BLESS")
            RemoveStatus(object,"SIAEL_POTR_HEROISM")
            RemoveStatus(object,"SIAEL_POTR_PFEG")
        end
        if HasPassive(causee,"Siael_POTR_Righteous_R") == 0 then
            RemoveStatus(object,"SIAEL_POTR_PFEG")
        end
    elseif status == "SIAEL_POTR_RIGHTEOUS_R" then
        RemoveStatus(object,"SIAEL_POTR_PFEG")
        local partyMembersSet = GetPartyMembers()
        for uuid, _ in pairs(partyMembersSet) do
            if HasValidAuraEffect(uuid,causer) then
                RemoveStatus(uuid,"SIAEL_POTR_PFEG")
            end
        end
    end
end)