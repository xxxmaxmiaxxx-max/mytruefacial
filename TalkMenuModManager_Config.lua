if type(TM_TalkMenuMod_Enable) == "function" then

TM_SetDefault_EnableTMMM(true) --Use Talk Menu Mod Manager?
TM_SetDefault_Mod_Sticks(true) --After selecting a mod from the mod menu, should further clicks open that mod directly? (Double click the person to open mod menu)
TM_SetDefault_Stick_Is_Global(true) --Should the mod that directly opens after clicking be applied to everyone? Or every person has their own "stickied" mod.
TM_SetDefault_Do_Not_Change_Stickied_Mod(false) --Do not change what mod is stickied (even after selecting another mod)
TM_SetDefault_Double_Click_Delay(0.5) --How long in seconds between clicks to register as a double click to open mod menu
TM_SetDefault_Stickied_Mod_By_Name("None") --Set this mod (name from the mod menu button), as the stickied mod by default when game launches
TM_SetDefault_Stickied_Mod_By_Label("None") --Set this mod (name from the lua file), as the stickied mod by default when game launches
TM_SetDefault_Debug_Enabled(false) --Show TM Debug in Mod Menu
TM_SetDefault_AutoFreeMode(true) --Double click does not work in non-FreeMode. This toggle tells TalkMenuModManager to automatically switch scene to FreeMode if it detects other modes being used.

end