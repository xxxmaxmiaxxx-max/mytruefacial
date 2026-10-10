--faunaLABS v1.05

--==============================================================================================================
-- New config changes will appear here and be used as the defaults/fallback.
-- To avoid your data getting overwritten by my updates, don't change this file.
-- Instead: Copy the template below, create and paste into fauna_LABS_Config_User.lua
--==============================================================================================================

Faunalabs = Faunalabs or {}
Faunalabs.state = Faunalabs.state or {}
Faunalabs.defaultState = {
--================================================================================
-- NEW
--================================================================================
    FL_disableIdle = false, -- true = idle off
	FL_pluginMenuEnabled = false, -- plugin menu for slotting in your other mods
--================================================================================

    FL_customHitbox = 0.9, -- Default is 1

    FL_custom_Overrides_Enabled = false,

    FL_custom_Body_Enabled = true, -- body overrides
    FL_custom_Clothing_Enabled = true, -- clothing overrides
    FL_custom_Characters_Enabled = true, -- per character overrides
}

--[[-- = = = = = = = = = = = = = = Template Below = = = = = = = = = = = = = = = Template Below = = = = = = = = = = = = = = = Template Below = = = = = = = = = = = = = = =

--faunaLABS v1.05

local function random(min, max)
    return min + (max - min) * math.random()
end

Faunalabs = Faunalabs or {}
Faunalabs.state = {
--================================================================================
-- NEW
--================================================================================
    FL_disableIdle = false, -- true = idle off
	FL_pluginMenuEnabled = false, -- plugin menu for slotting in your other mods
--================================================================================

	FL_customHitbox = 0.9, -- Default is 1

	FL_custom_Overrides_Enabled = true,

    FL_custom_Body_Enabled = true, -- body overrides
    FL_custom_Clothing_Enabled = true, -- clothing overrides
    FL_custom_Characters_Enabled = true, -- per character overrides
}

Faunalabs.bodyOverrides = function(human)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Applied to all characters:
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	human.Body(
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- "Body size",    -- Since this function overrides scene data,
	-- "Penis size",   -- these 3 have the potential to break scenes.
	-- "Penis length", -- Use at your discretion.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- "Ass size", 
	-- "Breast size",
	-- "Neck size",
	-- "Forearms size",
	-- "Upper arms size",
	-- "Calf size",
	-- "Thigh size",
	-- "Hips size",
	-- "Waist size",
	"Muscle tone",     0.6,
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--fluid
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- human.vagina.m_wetness = 1000
	-- human.mouth.m_wetness = 1000
	"fluid speed",	     2,
	"Fluid spread",	   0.1,
	"Fluid amount",    0.1,
	"Fluid force", 	  0.25,
	"Fluid gravity",   0.5
	) --                  ^ no "," on the last entry
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Females
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	if human.m_isMale == false then
		human.Body( -- applied to female characters
			--body
			-- "Breasts",
			-- "Ass size",
			"Hips size",   -0.15,
			"Waist size",  -0.15,
			"Thigh size",  -0.17
			)
		-- human.vagina.m_wetness = 1000
		-- human.mouth.m_wetness = 1000
	end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Males
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- if human.m_isMale == true then
	--     human.Body(
	--         --body
	--         "placeholder",	   0,
	--         "placeholder",	   0,
	--         "placeholder",	   0,
	--         "placeholder",	   0,
	--         "placeholder"	   0
	--     )
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Clothing
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Faunalabs.clothingOverrides = function(human)
	human.Customize(
	"Watch", 1, "Vest", 5, "Tie", 1, "Skirt", 1, 
	"Dress", 3
	)
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- per character options
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Faunalabs.characterOverrides["Ahri"] = function(human)
    human.Customize(
        "Tail", 2,
        "Micro", 1
    )
    human.Body(
        "Breast size", random(0.3, 1)
    )
	human.vagina.m_wetness = 1000
end

Faunalabs.characterOverrides["Tifa"] = function(human)
    human.Body(
        "Breast size", random(0.3, 1)
    )
	human.vagina.m_wetness = 1000
end

--]]-- = = = = = = = = = = = = = = = Template Above = = = = = = = = = = = = = = = Template Above = = = = = = = = = = = = = = = Template Above = = = = = = = = = = = = = = =