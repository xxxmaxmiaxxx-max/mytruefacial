init = false

label Start()
	init = true
	ResetTimer("GenericChat", math.random(-10, 0))

	local speaker = game.GetRandomHuman(|h| h.CanSpeak)
	if speaker ~= nil
		speaker.Say("Greeting")

	Jump("FreeMode")
	
stop

UI_Display = true

label TalkMenu(human, hitTri)
	
		-- human "Hi, my name is " .. human.Name .. ". How can I help you?"
	+ "Start thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
		human.Penis.Interaction.AutoActive = true
		human.Penis.Interaction.AutoPenisWeight = 1
		Return()
	+ "Stop thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == true] [gold]
		human.Penis.Interaction.AutoActive = false
		Return()
	+ "Start sucking!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == false] [gold]
		human.Mouth.Fucker.Penis.Interaction.AutoActive = true
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = 0
		Return()
	+ "Stop sucking!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] [gold]
		human.Mouth.Fucker.Penis.Interaction.AutoActive = false
		Return()

	+ "Pose for me, " .. human.Name .. "!"
		--human "Sure! What pose do you have in mind?"
		+ "Stand up straight."
			human.Pose(StandUp())
			Return()
		+ "Sit down."
			human.Pose(SitDown())
			Return()
		+ "Kneel down!"
			human.Pose(KneelDown())
			Return()
		+ "Sit down and cross-legged."
			human.Pose(SittingFolded())
			Return()
		+ "Sit down and spread your legs."
			human.Pose(SitDownSpreadLegs())
			Return()
		+ "Lay down on your back."
			human.Pose(LayDownBack())
			Return()
		+ "Lay down on your back and spread your legs."
			human.Pose(LayDownBackSpread())
			Return()
		+ "Lay down on your side."
			human.Pose(LayDownSide())
			Return()
		+ "Lay down on your stomach."
			human.Pose(LaydownStomach())
			Return()
		+ "Get down on all fours."
			human.Pose(GetdownAll4())
			Return()
		+ "Bend over."
			human.Pose(BendOver())
			Return()
		+ "Do a camel pose."
			human.Pose(CamelPose())
			Return()
		+ "Do a Jack-o-Pose."
			human.Pose(JackoPose())
			Return()
		+ "Do a T-Pose."
			human.Pose(TPose())
			Return()
		+ "Random starting pose."
			local poses = { Pose1, Pose2, Pose3, Pose4, Pose5, Pose6, Pose7, Pose8 }
			human.Pose(poses[math.random(#poses)]())
			Return()
		+ "Back."
			Return(2)

	+ "Loaded Pose" [if isEditor]
		+ "Pose 1."
			human.Pose(Pose1())
			Return()
		+ "Pose 2."
			human.Pose(Pose2())
			Return()
		+ "Pose 3."
			human.Pose(Pose3())
			Return()
		+ "Pose 4."
			human.Pose(Pose4())
			Return()
		+ "Pose 5."
			human.Pose(Pose5())
			Return()
		+ "Pose 6."
			human.Pose(Pose6())
			Return()
		+ "Pose 7."
			human.Pose(Pose7())
			Return()
		+ "Pose 8."
			human.Pose(Pose8())
			Return()
		+ "Random."
			local poses = { Pose1, Pose2, Pose3, Pose4, Pose5, Pose6, Pose7, Pose8 }
			human.Pose(poses[math.random(#poses)]())
			Return()
		+ "Back."
			Return(2)

	+ "Make a face!"
		+ "Happy face."
			human.Pose(FaceSmile())
			Return()
		+ "Angry face."
			human.Pose(FaceAngry())
			Return()
		+ "Sad face."
			human.Pose(FaceSad())
			Return()
		+ "Ahegao!"
			human.Pose(FaceAhegao())
			Return()
		+ "Surprised face."
			human.Pose(FaceSurprised())
			Return()
		+ "Scared face."
			human.Pose(FaceScared())
			Return()
		+ "Disgusted face."
			human.Pose(FaceDisgusted())
			Return()
		+ "Neutral face."
			human.Pose(FaceNeutral())
			Return()
		+ "Close your eyes."
			human.Pose(EyesClose())
			Return()
		+ "Back."
			Return(2)
	
	+ "Let's talk about clothing."
		+ "Take off your clothes, " .. human.Name .. "."
			human.CustomizeAll(99)
			human.Customize("Penis", 0)
			human "Done!"
			Return()
		+ "Dress up!"
			human.CustomizeAll(0)
			human "Alright!"
			Return()
		+ "Take something off."
			human "Just click middle mouse button on the piece of clothing you want me to take off."
			human "To make me put them back on, middle click on the part of my body where they was."
			Return()
		+ "Swap your clothes with someone!"
			local humans = game.GetHumans(|h| h ~= human)

			if tablelength(humans) == 0
				human "I don't have anyone to swap clothes with."
				human "You can use the character menu to select clothing for me, just turn on the clothing toggle!"
				human "Or maybe get someone else to join us?"
			elseif tablelength(humans) == 1
				human "You mean with " .. humans[1].Name .. "?"
				+ "Yes."
					> fade
					game.ReplaceClothing(human, humans[1].ClothingName);
					game.ReplaceClothing(humans[1], human.ClothingName);
					human "Done!"
				+ "Nevermind."
					human "Alright."
					Return(3)
			else 
				human "Sure. who should I swap clothes with?"
				+ for i, targetHuman in ipairs(humans)
					+ "Swap clothes with " .. targetHuman.Name .. "."
						if targetHuman.ClothingName == human.ClothingName
							human "What do you mean? We're already wearing the same clothes!"
						else
							> fade
							game.ReplaceClothing(human, targetHuman.ClothingName);
							game.ReplaceClothing(targetHuman, human.ClothingName);
							human "Done!"
				+ "Nevermind."
					human "Alright."
					Return(3)
		+ "Back."
			Return(2)

	+ if human.Penis.IsActive and game.HasAnim(human.Penis)
		+ "Stop auto cumming."
			human "Alright."
			game.RemoveAnim(human.Penis)
	+ else
		+ "Start auto cumming."
			human "Of course!"
			game.AddRepeatAnim(4, || human.Shoot(), human.Penis)


	+ if game.PovHuman ~= human
		+ "Enter " .. human.Name .. "'s POV."
			game.PovHuman = human
	+ if game.PovHuman ~= nil
		+ "Exit POV."
			game.PovHuman = nil
	
	+ "Hide UI" [if UI_Display == true]
			UI_Display = false
			game.m_controlsUI.Show(false)

	+ "Enable UI" [if UI_Display == false]
			UI_Display = true
			game.m_controlsUI.Show()

	+ "Say something for me."
		+ "Say any Akali's voiceline."
			human.SayCustom("akali")
			Return()
		+ "Say any Akali's pleasure voiceline."
			human.SayCustom("akali_pleasure")
			Return()
		+ "Say any greeting voiceline."
			human.SayCustom("greeting")
			Return()
		+ "Back"
			Return(2)

	+ "I have questions."
		+ "How to turn the lights on and off?"
			human "Click your middle mouse on a light turn it on or off, and click right mouse to change its color!"
			human "You can do the same to the sky to switch between day and night or change the skybox."
			Return()
		+ "How do I toggle seeing characters through walls?"
			human "You can press Q to toggle the visibility of characters through walls, or in Settings/Graphics."
			Return()
		+ "How do I customize clothing?"
			human "Just click middle mouse button on the piece of clothing you want to take off."
			human "To put them back on, middle click on the area of the body where it was."
			Return()
		+ "How do I add or replace characters?"
			human "Open the Characters Menu (Numpad 1) and select anyone you want."
			human "They can be created anew (if the Plus icon is selected) or replace someone (with the Swap icon) in the scene."
			Return()
		+ "How do I save a scene?"
			human "Open the Pose Menu (Numpad 2) and click on Camera icon to save! You can also use F5 as a shortcut."
			human "Your saved scenes are stored on the Captures folder in your game folder."
			Return()
		+ "How to change the location?"
			human "Open the Map Menu (Numpad 4) and select the map you want!"
			Return()
		+ "How to enable POV camera?"
			human "Just talk to anyone and ask to enter or exit their POV!"
			human "Otherwise you can use F1 to switch between each character's POV."
			Return()
		+ "I want to make breasts bigger!"
			human "You can adjust that and more in the Character Settings Menu (Numpad 3)."
			human "Just select any character and adjust their available options. More options are available in the Pro version!"
			Return()
		+ "Can you cosplay someone?"
			human "Of course, we can all share outfits with one another."
			human "In the Characters Menu (Numpad 1), select me and click the Hangar icon to enable Outfit Mode." 
			human "Then just choose anyone's outfit from the list!"
			Return()
		+ "How do I pose?"
			human "You can pose by clicking and dragging your mouse directly on areas of the body."
			human "Please hold Alt to highlight all the controllable areas, and hover over them for more instructions!"
			Return()
		+ "I still have more questions."
			human "Please visit us at patreon.com/henrytaiwan or join our Discord server for more support!"
			Return()
		+ "Back"
			Return(2)
	+ "Never mind." [gold]

stop

label FreeMode()
	Play_FreeMode()
stop

function OnHumanClick(human, hitTri)
	Jump("TalkMenu", human, hitTri)
end

function OnCreateHuman(human, isNewlyAdded)
	game.PlayCharacterMusic(human)

	--CLAUDE_CODED: on a brand-new character (isNewlyAdded from C# CreateHuman path): females get a random standing pose (A-H), males get the "Stand up straight" pose (StandUp). On replace/swap the new human inherits the replaced one's pose via SwapHuman. (Slot-based spawn position + rotation is done in C# CreateHuman and applies to both genders.)
	if isNewlyAdded == true then
		if human.m_isMale then
			human.Pose(StandUp())
		else
			local poses = { Pose1, Pose2, Pose3, Pose4, Pose5, Pose6, Pose7, Pose8 }
			human.Pose(poses[math.random(#poses)]())
		end
	end
	--------------------------------

	if init == true then
		human.Say("Greeting")
	end
end

function OnRemoveHuman(human)
	game.PlayRandomCharacterMusic()
end

function OnGameUpdate()
	if init == false then return end

	local lastChatTime = Timer("GenericChat")
	if lastChatTime > game.ChatIntervals then
		ResetTimer("GenericChat", math.random(-7, 0))

		local speaker = game.GetRandomHuman(|h| h.CanSpeak and ((h.FaceMood >= 0 and h.HasVoice("Like") == true) or (h.FaceMood < 0 and h.HasVoice("Dislike") == true)))
		if speaker ~= nil then
			speaker.Say(speaker.FaceMood >= 0 and "Like" or "Dislike")
			--speaker.Animate("ChatLookAt", MotionLayer.Interactions, 3.8, 1, 1.3, HeadLookAt(CameraPos(), 0.6, 60))
		end
	end
end

function OnFluidHit(hitActor, bodyArea, shootActor)
	if hitActor == shootActor or shootActor == nil then return end

	local timerKey = "FluidHit_" .. hitActor.Name .. bodyArea
	local lastHitTime = Timer(timerKey)

	if bodyArea == "L_Eye" and lastHitTime > 1 then 
		hitActor.AddInvoluntaryAnim("L_Eye_HitClose", 1, 0.7, 0.7, EyelidL(1))
		ResetTimer(timerKey)
	elseif bodyArea == "R_Eye" and lastHitTime > 1 then 
		hitActor.AddInvoluntaryAnim("R_Eye_HitClose", 1, 0.7, 0.7, EyelidR(1))
		ResetTimer(timerKey)
	elseif bodyArea == "Lips" and lastHitTime > 10 then 
		hitActor.AddInvoluntaryAnim("OpenMouth", 5, 0.4, 0.4, Mouth(-0.83, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.73, 0, 0.39))
		Delayed(5, function()
			hitActor.Swallow()
		end)
		ResetTimer(timerKey)
	else
		local genericVoiceKey = "FluidHit_Generic_" .. hitActor.Name
		local lastGenericVoiceTime = Timer(genericVoiceKey)

		if lastGenericVoiceTime > 15 and game.FluidReaction == true then
			hitActor.Say(hitActor.FaceMood >= 0 and "Like" or "Dislike")
			ResetTimer(genericVoiceKey)
		end
	end
end

function OnPenetration(girl, holeName, inVelocity, outVelocity, penetrator)
	local key = "PenetrationMoan_" .. girl.Name .. holeName
	local lastMoanTime = Timer(key)

	if inVelocity > 0.3 and lastMoanTime > 6 then 
		girl.Say(girl.FaceMood >= 0 and "Pleasure" or "Pain")
		ResetTimer(key)
	end
end