-- SkillActions: spell container patch stolenf rom Goon

Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, isEditorMode)
    local squadies = Osi.DB_PartOfTheTeam:Get(nil)
    for _,k in pairs(squadies) do
		AddSpell(k[1], "Nemid_Skill_Actions_Container", 1, 1)
    end
end)
