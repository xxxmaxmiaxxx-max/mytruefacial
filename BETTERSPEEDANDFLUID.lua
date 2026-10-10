init = false

--BETTER SPEED AND FLUID V3.65B (illafix)

-- Variables
activeAutoBJ = false

if type(TM_AddMenuMod) == "function" then
	TM_AddMenuMod("BETTER SPEED AND FLUID", "BetterSpeedAndFluidTalkMenu")
else
	local funcCode = [[
	function TalkMenu(human, hitTri)
		Jump("BetterSpeedAndFluidTalkMenu", human, hitTri)
	end
	]]
	load(funcCode)()
end

label BetterSpeedAndFluidTalkMenu(human, hitTri)	

-------------------------------------------------------


	+ "set penis hardness"
		+ "set penis hardness 0.001"
			human.Penis.m_ragdollLength = 0.001
			Return()
		+ "set penis hardness 0.01"
			human.Penis.m_ragdollLength = 0.01
			Return()
		+ "set penis hardness 0.1"
			human.Penis.m_ragdollLength = 0.1
			Return()
		+ "set penis hardness 0.2"
			human.Penis.m_ragdollLength = 0.2
			Return()
		+ "set penis hardness 0.3"
			human.Penis.m_ragdollLength = 0.3
			Return()
		+ "set penis hardness 0.4"
			human.Penis.m_ragdollLength = 0.4
			Return()
		+ "set penis hardness 0.5"
			human.Penis.m_ragdollLength = 0.5
			Return()
		+ "set penis hardness 0.6"
			human.Penis.m_ragdollLength = 0.6
			Return()
		+ "set penis hardness 0.7"
			human.Penis.m_ragdollLength = 0.7
			Return()
		+ "set penis hardness 0.8"
			human.Penis.m_ragdollLength = 0.8
			Return()	
		+ "set penis hardness 0.9"
			human.Penis.m_ragdollLength = 0.9
			Return()
		+ "set penis hardness 1"
			human.Penis.m_ragdollLength = 1
			Return()
		+ "Back."
		+ "set penis hardness EXP1"
			human.Penis.m_ragdollWidth = 0
			Return()
		+ "set penis hardness EXP1a"
			human.Penis.m_ragdollWidth = 2
			Return()
		+ "set penis hardness EXP21"
			human.Penis.m_ragdollHeight = 0
			Return()
		+ "set penis hardness EXP21a"
			human.Penis.m_ragdollHeight = 2
			Return()
		+ "set penis hardness EXP3"
			human.Penis.m_ragdollSize = 0
			Return()
		+ "set penis hardness EXP3a"
			human.Penis.m_ragdollSize = 2
			Return()
			Return(2)


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------



	+ "Hide UI" [if HG_UIvis == true]
		HG_UIvis = false
		game.m_controlsUI.Show(false)
		Return()
	+ "Show UI" [if HG_UIvis == false]
		HG_UIvis = true
		game.m_controlsUI.Show()
		Return()



---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	+ "Faces.."
		+ "Neutral face."
			human.Pose(FaceNeutral())
			Return()
		+ "Happy face."
			human.Pose(FaceSmile())
			Return()
		+ "Default.."[gold]
			+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "Neutral face."
				human.Pose(FaceNeutral())
				Return()
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
				human.Pose(FaceAhegao1())
				Return()
			+ "Ahegao! x 2"
				human.Pose(FaceAhegao2())
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
		+ "Custom.."[gold]
			+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "Neutral face."
				human.Pose(FaceNeutral())
				Return()
			+ for i, pres in ipairs (Faun_facestr)
				+ " " .. pres
					human.Pose(Faun_facepresets[i]())
					Return()
			-- + for i, pres in ipairs (facestr)
			-- 	+ " " .. pres
			-- 		human.Pose(facepresets[i]())
			-- 		Return()
			+ "kiss/tongue.."[gold]
				+ for i, pres in ipairs (Faun_kissstr)
					+ " " .. pres
						human.Pose(Faun_kisspresets[i]())
						Return()
				+ "Neutral face."
					human.Pose(FaceNeutral())
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
		+ "Loops.. WIP"[gold]
			+ "Neutral face."
				human.Pose(FaceNeutral())
				Return()
			+ "Smile > Ahegao"
				game.AddRepeatAnim(2, || CustomLoops(human, FaceSmile, FaceAhegao, "Smile > Ahegao"), human)
				Return()
			+ "WIP | Idle Anim Test"
				game.AddRepeatAnim((math.random(5,20)), || CustomLoops3(human, Lipbite, Kiss2, Pursedlips, "Test"), human)
			+ "Neutral > Scared"
				game.AddRepeatAnim(3, || CustomLoops(human, FaceNeutral, FaceScared, "Neutral > Scared"), human)
				Return()
			+ "Angry > Surprised"
				game.AddRepeatAnim(4, || CustomLoops(human, FaceAngry, FaceSurprised, "Angry > Surprised"), human) 
				Return()
			+ "Look Actor > Look Camera"
				game.AddRepeatAnim((math.random(5, 20)), || CustomLoops(human, LookActorA, LookCam, "Look Actor > Look Camera"), human) 
				Return()
			+ "Stop" [if game.HasAnim(human.m_mouth) == true]
				game.RemoveAnim(human.m_mouth)
				Return()
			+ "STOP LOOPING" [if game.HasAnim(human) == true]
				game.RemoveAnim(human)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Look!.."[gold]
			+ "Actor > Camera | Loop"
				game.AddRepeatAnim((math.random(5, 20)), || CustomLoops(human, LookActorA, LookCam, "Look Actor > Camera"), human) 
				Return()
			+ "Face Actor | WIP"
				human.Pose(FaceActorA())
				Return()
			+ "Look Actor"
				human.Pose(LookActorA())
				Return()
			+ "Face Cam"
				human.Pose(FaceCam())
				Return()
			+ "Look Cam"
				human.Pose(LookCam())
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "STOP LOOPING" [if game.HasAnim(human) == true]
			game.RemoveAnim(human)
			Return()
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "<color=#9a646f><i>Done."
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------


	+ "Stop All Animations" [if HasAnyAnimation(human)]
		StopAllAnimations(human)
		Return()

--------------------------------------------------------

	+ "Animations.."
		+ "<color=#9a646f><i>Done."
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "Bouncing.." [if game.HasAnim(human.breastNames) == false][gold]
			+ "Bouncing | 0.97 > 1"
				activeloops[human.breastNames] = 0.3/CL_SMult*1.5
				game.AddRepeatAnim(0.5/CL_SMult, || CustomLoopsV2(human, "Bouncing", activeloops[human.breastNames], 
				Hips(0, 0.97, 0), 
				Hips(0, 1, 0)), human.breastNames)
				Return()
			+ "Bouncing | 0.90 > 0.95"
				activeloops[human.breastNames] = 0.5/CL_SMult*2.5
				game.AddRepeatAnim(0.5/CL_SMult, || CustomLoopsV2(human, "Bouncing", activeloops[human.breastNames], 
				Hips(0, 0.95, 0.0), 
				Hips(0, 0.90, 0.0)), human.breastNames)
				Return()
			+ "Bouncing | 0.92 > 0.95"
				activeloops[human.breastNames] = 0.5/CL_SMult*2.5
				game.AddRepeatAnim(0.5/CL_SMult, || CustomLoopsV2(human, "Bouncing", activeloops[human.breastNames], 
				Hips(0, 0.95, 0.0), 
				Hips(0, 0.92, 0.0)), human.breastNames)
				Return()
			+ "Stop Bouncing" [if game.HasAnim(human.breastNames) == true]
				game.RemoveAnim(human.breastNames)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Feet.."[if game.HasAnim(human.footNames) == false][gold]
			+ "Footjob.Stand.Right"
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, footjob_1R_a, footjob_1R_b, "footjob stand 1"), human.breastNames)
				Return()
			+ "Footjob.Sit.Right"
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoops6(human, footjob_sit_1R_A, footjob_sit_1R_B, footjob_sit_1R_C, footjob_sit_1R_D, footjob_sit_1R_E, footjob_sit_1R_F, "Footjob sit 1"), human.breastNames)
				Return()
			+ "Fj.Sit.Modular.Right"
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoops4(human, footjob_modular_1Ra, footjob_modular_1Rb, footjob_modular_1Rc, footjob_modular_1Rd, "Footjob sit 1"), human.breastNames)
				Return()
			-- + "Footjob.Sit.Right 2" --Quaternion?
			-- 	activeloops[human.footNames] = 0.6/CL_SMult*2.6
			-- 	game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsv6(human, "footjob sit 2", activeloops[human.footNames],
			-- 	FootR(WPos(0.031, 0.118, 0.666)),
			-- 	FootR(WPos(0.011, 0.217, 0.766)),
			-- 	FootR(WPos(0.034, 0.079, 0.673)),
			-- 	FootR(WPos(0.057, 0.136, 0.751)),
			-- 	FootR(WPos(0.025, 0.067, 0.651)),
			-- 	FootR(WPos(0.054, 0.15, 0.76))), human.footNames)
			-- 	Return()
			+ "WIP | Leg Sway L"
				human.Pose(LaydownStomach1())
				activeloops[human.footNames] = 0.6/CL_SMult*2.7
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "legswayL", activeloops[human.footNames], 
				FootL(WPos(-0.15, 0.577, -0.62)), 
				FootL(WPos(-0.15, 0.639, -0.4))), human.footNames)
				Return()
			+ "WIP | Leg Sway R"
				human.Pose(LaydownStomach1())
				activeloops[human.footNames] = 0.6/CL_SMult*2.7		
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "legswayR", activeloops[human.footNames], 
				FootR(WPos(0.007, 0.577, -0.7)), 
				FootR(WPos(0.043, 0.639, -0.4))), human.footNames)
				Return()
			+ "WIP | Leg Sway Both"
				human.Pose(LaydownStomach1())
				activeloops[human.footNames] = 0.6/CL_SMult*3		
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV4(human, "legsway", activeloops[human.footNames], 
				FootR(WPos(0.055, 0.629, -0.32)), 
				FootL(WPos(-0.084, 0.602, -0.537)), 
				FootR(WPos(0.084, 0.624, -0.537)), 
				FootL(WPos(-0.055, 0.605, -0.198))), human.footNames)
				Return()
			-- + "WIP - Leg Sway?" -- no knee lock makes this rough
			-- 	human.Pose(LaydownStomach1())
			-- 	activeloops[human.footNames] = 0.6/CL_SMult*3		
			-- 	game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV6(human, "legsway", activeloops[human.footNames], FootR(WPos(0.05, 0.55, -0.79)), FootL(WPos(-0.055, 0.605, -0.198)), FootR(WPos(0.084, 0.624, -0.537)), FootL(WPos(-0.084, 0.602, -0.537)), FootR(WPos(0.055, 0.629, -0.32)), FootL(WPos(-0.05, 0.463, -0.79))), human.footNames)
			-- 	Return()
			+ "Stand up straight."
				human.Pose(StandUp())
				Return()
			+ "Stop Legs" [if game.HasAnim(human.footNames) == true]
				game.RemoveAnim(human.footNames)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Breasts.."[if game.HasAnim(human.chestNames) == false][gold]
			+ "Shake - 7-25"
				activeloops[human.chestNames] = 0.4/CL_SMult*2
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
				SpineRot((math.random(7, 25))), 
				SpineRot((math.random(-7, -25)))), human.chestNames)
				Return()
			+ "Shake - 15"
				activeloops[human.chestNames] = 0.4/CL_SMult*1.5
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
				SpineRot(15), 
				SpineRot(-15)), human.chestNames)
				Return()
			+ "Shake - 10"
				activeloops[human.chestNames] = 0.5/CL_SMult*1.5
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
				SpineRot(10), 
				SpineRot(-10)), human.chestNames)
				Return()
			+ "Shake - 5-9"
				activeloops[human.chestNames] = 0.4/CL_SMult*2.5
				game.AddRepeatAnim(0.5/CL_SMult, || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
				SpineRot((math.random(9, 5))), 
				SpineRot((math.random(-9, -5)))), human.chestNames)
				Return()
			+ "Shake - 7"
				activeloops[human.chestNames] = 0.5/CL_SMult*2.5
				game.AddRepeatAnim(0.5/CL_SMult, || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
				SpineRot(7), 
				SpineRot(-7)), human.chestNames)
				Return()
			+ "Stop Shaking" [if game.HasAnim(human.chestNames) == true]
				game.RemoveAnim(human.chestNames)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Licking.."[if game.HasAnim(human.m_mouth) == false][gold]
			+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "Dagger"
				activeloops[human.m_mouth] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV2(human, "Default", activeloops[human.m_mouth], 
				Mouth(-1.2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1, 0.3, 0.4), 
				Mouth(-1.2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.8, -0.3, 0.4)), human.m_mouth)--d1
				Return()
			+ "Dagger - 2"
				activeloops[human.m_mouth] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV2(human, "Default", activeloops[human.m_mouth], 
				Mouth(-1.2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1, 0.3, 0.7), 
				Mouth(-1.2, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 2.3, -0.3, 0.7)), human.m_mouth)--d2
				Return()
			+ "Vertical"
				activeloops[human.m_mouth] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV2(human, "vertical", activeloops[human.m_mouth], 
				Mouth(-0.8, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.5, nil, 2.5), 
				Mouth(-1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.5, nil, -1)), human.m_mouth)--v1
				Return()
			+ "Vertical - 2"
				activeloops[human.m_mouth] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV2(human, "vertical", activeloops[human.m_mouth], 
				Mouth(-1.1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 2, nil, 3), 
				Mouth(-1.5, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 2, nil, -1.5)), human.m_mouth)--v2
				Return()
			+ "Horizontal"
				activeloops[human.m_mouth] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV2(human, "horizontal", activeloops[human.m_mouth], 
				Mouth(-1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.4, -1.8, 0.5), 
				Mouth(-1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.4, 1.8, 0.5)), human.m_mouth)--h1
				Return()
			+ "Horizontal - 2"
				activeloops[human.m_mouth] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV2(human, "horizontal", activeloops[human.m_mouth], 
				Mouth(-1.3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.7, -2.1, 0.5), 
				Mouth(-1.3, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.7, 2.1, 0.5)), human.m_mouth)--h2
				Return()
			+ "Rotate"
				activeloops[human.m_mouth] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV4(human, "rotate", activeloops[human.m_mouth], 
				Mouth(-1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.5, 0, 2.5), 
				Mouth(-1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.5, -1.75, 0.2), 
				Mouth(-1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.5, 0, -1), 
				Mouth(-1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, 1.5, 1.75, 0.2)), human.m_mouth)
				Return()
			+ "Rotate - 2"
				activeloops[human.m_mouth] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV4(human, "rotate", activeloops[human.m_mouth], 
				Mouth(-0.8, nil, nil, nil, nil, nil, nil, nil, nil, 0.9, 0.9, nil, nil, 1, 0, 4), 
				Mouth(-1.3, nil, nil, nil, nil, nil, nil, nil, nil, 1, 1, nil, nil, 1.7, 2.5, 0), 
				Mouth(-1.5, nil, nil, nil, nil, nil, nil, nil, nil, 0.8, 0.8, nil, nil, 1.7, 0, -3), 
				Mouth(-1.3, nil, nil, nil, nil, nil, nil, nil, nil, 1, 1, nil, nil, 1.7, -2.5, 0)), human.m_mouth)
				Return()
			+ "Stop Licking" [if game.HasAnim(human.m_mouth) == true]
				game.RemoveAnim(human.m_mouth)
				Return()
		+ "BJ.."[gold]
			+ "forward"
				activeloops[human.Mouth] = 0.6/CL_SMult*3.7
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "BJ 1", activeloops[human.Mouth], 
				HeadRot(340, 355, 320), 
				HeadRot(340, 5, 40)), human.Mouth)
				Return()
			+ "forward - cheek"
				activeloops[human.Mouth] = 0.4/CL_SMult*3.7
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV6(human, "BJ 3", activeloops[human.Mouth], 
				HeadRot(300, 0, nil), 
				HeadRot(300, 340, nil), 
				HeadRot(300, 0, nil), 
				HeadRot(300, 320, nil), 
				HeadRot(300, 0, nil), 
				HeadRot(300, 350, nil)), human.Mouth)
				Return()				
			+ "Forward - Random"
				activeloops[human.Mouth] = 0.6/CL_SMult*3
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.Mouth], 
				HeadRot((math.random(0, -10)), (math.random(30, 20)), -20), 
				HeadRot((math.random(20, 10)), (math.random(330, 340)), 20)), human.Mouth)
				Return()
			+ "Upward"
				activeloops[human.Mouth] = 0.6/CL_SMult*3.7
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "BJ 2", activeloops[human.Mouth], 
				HeadRot(270, 320, 355), 
				HeadRot(270, 405, 5)), human.Mouth)
				Return()
			+ "Downward"
				activeloops[human.Mouth] = 0.6/CL_SMult*3.7 --0.6/CL_SMult*3.7
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "BJ 4", activeloops[human.Mouth], 
				HeadRot(90, (math.random(350, 0)), (math.random(330, 320))), 
				HeadRot(90, (math.random(0, 10)), (math.random(30, 50)))), human.Mouth) --HeadRot(-35, 355, (math.random(310, 330))), HeadRot(-30, 5, (math.random(30, 50)))), human.Mouth)
				Return()
			+ "Stop BJ" [if game.HasAnim(human.Mouth) == true][gold]
				game.RemoveAnim(human.Mouth)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Neck.."[if game.HasAnim(human.headNames) == false][gold]
			+ "<color=#9a646f><i>Done."
			+ "Stop Neck"[if game.HasAnim(human.headNames) == true]
				game.RemoveAnim(human.headNames)
				Return()
			+ "Stop Humping"[if game.HasAnim(human) == true]
				game.RemoveAnim(human)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "Nod - Eye Contact"
				activeloops[human.headNames] = 0.6/CL_SMult*2
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.headNames], 
				HeadRot(320, nil, nil), 
				HeadRot(280, nil, nil)), human.headNames)
				Return()
			+ "Nod - Eye Contact - 2"
				activeloops[human.headNames] = 0.6/CL_SMult*2
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV6(human,"Head", activeloops[human.headNames],
				HeadRot(320, nil, nil),
				HeadRot(280, nil, nil),
				HeadRot(320, nil, nil),
				HeadRot(280, nil, nil),
				HeadRot(280, nil, nil),
				HeadRot(320, nil, 20)), human.headNames)
				Return()
			+ "Nod - Eye Contact - 3"
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops6(human, EC_A , EC_B, EC_A, EC_A, EC_A, EC_B, "Test"), human.headNames)
				Return()
			+ "Nod - Jam - Randomized"
				activeloops[human.headNames] = 0.5/CL_SMult*2
				game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.headNames], 
				HeadRot((math.random(-20, -10)), nil, nil), 
				HeadRot((math.random(20, 10)), nil, nil)), human.headNames)
				Return()
			+ "Shake - No"
				activeloops[human.headNames] = 0.6/CL_SMult*3
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.headNames], 
				HeadRot(nil, 40, nil), 
				HeadRot(nil, 320, nil)), human.headNames)
				Return()
			+ "Shake - No - Quick"
				activeloops[human.headNames] = 0.3/CL_SMult*2.5
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.headNames], 
				HeadRot(320, 30, nil), 
				HeadRot(320, 330, nil)), human.headNames)
				Return()
			+ "Shake - lick"
				activeloops[human.headNames] = 0.6/CL_SMult*3.5
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.headNames], 
				HeadRot(320, 315, nil), 
				HeadRot(320, 45, nil)), human.headNames)
				Return()
			+ "Shake - No - Randomized"
				activeloops[human.headNames] = 0.6/CL_SMult*3
				game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.headNames], 
				HeadRot(nil, (math.random(20, 45)), nil), 
				HeadRot(nil, (math.random(340, 315)), nil)), human.headNames)
				Return()
			+ "Nod - Yes"
				activeloops[human.headNames] = 0.5/CL_SMult*2
				game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.headNames], 
				HeadRot(325, nil, nil), 
				HeadRot(20, nil, nil)), human.headNames)
				Return()
		+ "Hands.."[gold]
			-- + "WIP - Grope Breasts"
			-- 	game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, GropebreastBoth1a, GropebreastBoth1b, "Grope Breasts"), human.forearmNames)
			-- 	Return(2)
			+ "Right hand.."[if game.HasAnim(human.handNames) == false][gold]
				+ "BJ Gesture"
					human.pose(BJGesture())
					human.pose(TongueOut2())
					game.AddRepeatAnim(0.2/CL_SMult*1.4, || CustomLoops(human, Bjgesture_Ra, Bjgesture_Rb, "BJ Gesture"), human.handNames)
					Return()
				+ "WIP | Spank"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, Slap_Ra, Slap_Rb, "Spank"), human.handNames)
					Return()
				+ "Beckon"
					human.Pose(Beckon())
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, Beckon_Ra, Beckon_Rb, "Beckon"), human.handNames)
					Return()
				+ "Touch Herself"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, TouchHerself_Ra, TouchHerself_Rb, "Touch Herself R"), human.handNames)
					Return()
				-- + "Touch Herself 2"
				-- 	activeloops[human.handNames] = 0.6/CL_SMult*2.6
				-- 	game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV6(human, "Touch Herself 2", activeloops[human.handNames],
				-- 	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.747, -0.157, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
				-- 	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.663, -0.204, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
				-- 	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.819, -0.163, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
				-- 	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.718, -0.251, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
				-- 	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.564, -0.188, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
				-- 	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.828, -0.184, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35))), human.handNames)
				-- 	Return()
				+ "WIP | Grope Breast - Topless"
					game.AddRepeatAnim(0.2/CL_SMult*1.5, || CustomLoops6(human, Gropebreast_Ra, Gropebreast_Rb, Gropebreast_Rc, Gropebreast_Rd, Gropebreast_Re, Gropebreast_Rf, "Grope Breast"), human.handNames)
					Return()
				+ "WIP | Grope Breast - 2"
					game.AddRepeatAnim(0.3/CL_SMult*2, || CustomLoops(human, Gropebreast_2Ra, Gropebreast_2Rb, "Grope Breast 2 R"), human.handNames)
					Return()
				+ "Fingering index"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, FingeringIMr1, FingeringIMr2, "Rhand"), human.handNames)
					Return()
				+ "Fingering middle"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, FingeringMRr1, FingeringMRr2, "Rhand"), human.handNames)
					Return()
				+ "Fingering middle - 2"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, FingeringMRr3, FingeringMRr4, "Rhand"), human.handNames)
					Return()
				+ "Stop right hand" [if game.HasAnim(human.handNames) == true]
					game.RemoveAnim(human.handNames)
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Left hand.."[if game.HasAnim(human.forearmNames) == false][gold]
				+ "WIP | Grope Breast Topless"
					game.AddRepeatAnim(0.3/CL_SMult*1.5, || CustomLoops6(human, Gropebreast_La, Gropebreast_Lb, Gropebreast_Lc, Gropebreast_Ld, Gropebreast_Le, Gropebreast_Lf, "Grope Breast"), human.forearmNames)
					Return()
				+ "WIP | Grope Breast - v6"
					game.AddRepeatAnim(0.3/CL_SMult*2, || CustomLoopsV6(human, "WIP - Grope Breast - 2", 0.9,
					HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.882, 0.678, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
					HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.823, 0.423, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
					HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.834, -0.124, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
					HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.797, 0.258, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
					HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.809, 0.081, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
					HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.98, -0.102, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35))), human.forearmNames)
					Return()
				+ "WIP | Grope Breast - v2"
					game.AddRepeatAnim(0.3/CL_SMult*2, || CustomLoopsV2(human, "WIP - Grope Breast - 2", 0.9,
					HandL(BoneMesh(TargetActor.Main, "Bone_Chest", 0.182, -0.312, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
					HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.957, 0.401, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35))), human.forearmNames)
					Return()
				+ "WIP | Touch Herself"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, TouchHerself_La, TouchHerself_Lb, "Touch Herself L"), human.forearmNames)
					Return()
				+ "Fingering index"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, FingeringIMl1, FingeringIMl2, "Lhand"), human.forearmNames)
					Return()
				+ "Fingering middle"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, FingeringMRl1, FingeringMRl2, "Lhand"), human.forearmNames)
					Return()
				+ "Fingering middle - 2"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoops(human, FingeringMRl3, FingeringMRl4, "Rhand"), human.forearmNames)
					Return()
				+ "Stop left hand" [if game.HasAnim(human.forearmNames) == true]
					game.RemoveAnim(human.forearmNames)
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Stop left hand" [if game.HasAnim(human.forearmNames) == true]
				game.RemoveAnim(human.forearmNames)
				Return()
			+ "Stop right hand" [if game.HasAnim(human.handNames) == true]
				game.RemoveAnim(human.handNames)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Hips.."[gold]
			+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "Full Rotation" [if game.HasAnim(human.Anus) == false]
				activeloops[human.Anus] = 0.6/CL_SMult*1.5
				game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV4(human, "Rotate Hips", activeloops[human.Anus], 
				HipsRot(35, nil, -25), 
				HipsRot(35, nil, 25), 
				HipsRot(-35, nil, -25), 
				HipsRot(-35, nil, 25)), human.Anus)
				Return()
			+ "Full Rotation | 2" [if game.HasAnim(human.Anus) == false]
				activeloops[human.Anus] = 0.6/CL_SMult*1.5
				game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV4(human, "Rotate Hips 2", activeloops[human.Anus], 
				HipsRot(35, nil, -25), 
				HipsRot(35, nil, 25), 
				HipsRot(-35, nil, 25), 
				HipsRot(-35, nil, -25)), human.Anus)
				Return()
			+ "Sway.."[gold]
				+ "WIP | Sway Hips | Bent Over"
					activeloops[human] = 0.6/CL_SMult*2.5
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoops(human, HipSway_A, HipSway_B, "Swaying"), human)
					Return()
				+ "Stop Humping"[if game.HasAnim(human) == true]
					game.RemoveAnim(human)
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Twist.."[if game.HasAnim(human.thighNames) == false][gold]
				+ "Twist | 20"
					activeloops[human.thighNames] = 0.6/CL_SMult*1.5
					game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Twisting", activeloops[human.thighNames], 
					HipsRot(nil, -20, nil), 
					HipsRot(nil, 20, nil)), human.thighNames)
					Return()
				+ "Twist | 10"
					activeloops[human.thighNames] = 0.6/CL_SMult*1.5
					game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Twisting", activeloops[human.thighNames], 
					HipsRot(nil, -10, nil), 
					HipsRot(nil, 10, nil)), human.thighNames)
					Return()
				+ "Twist | 5"
					activeloops[human.thighNames] = 0.6/CL_SMult*1.5
					game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Twisting", activeloops[human.thighNames], 
					HipsRot(nil, -5, nil), 
					HipsRot(nil, 5, nil)), human.thighNames)
					Return()
				+ "Stop Twisting" [if game.HasAnim(human.thighNames) == true]
					game.RemoveAnim(human.thighNames)
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Tilt.."[if game.HasAnim(human.Anus) == false][gold]
				+ "Tilt | 35,  -25 > 25"
					activeloops[human.Anus] = 0.6/CL_SMult*2
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "HipMov", activeloops[human.Anus], 
					HipsRot(nil, nil, 25), 
					HipsRot(nil, nil, -25)), human.Anus)
					Return()
				+ "Tilt | 10-24"
					activeloops[human.Anus] = 0.6/CL_SMult*2
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "HipMov", activeloops[human.Anus], 
					HipsRot(nil, nil, (math.random(24, 10))), 
					HipsRot(nil, nil, (math.random(-10, -24)))), human.Anus)
					Return()
				+ "Tilt | 17"
					activeloops[human.Anus] = 0.6/CL_SMult*2
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "HipMov", activeloops[human.Anus], 
					HipsRot(nil, nil, 17), 
					HipsRot(nil, nil, -17)), human.Anus)
					Return()
				+ "Tilt | 13"
					activeloops[human.Anus] = 0.6/CL_SMult*2
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "HipMov", activeloops[human.Anus], 
					HipsRot(nil, nil, 13), 
					HipsRot(nil, nil, -13)), human.Anus)
					Return()
				+ "Tilt | 5-10"
					activeloops[human.Anus] = 0.6/CL_SMult*2
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "HipMov", activeloops[human.Anus], 
					HipsRot(nil, nil, (math.random(5, 10))), 
					HipsRot(nil, nil, (math.random(-5, -10)))), human.Anus)
					Return()
				+ "Stop Hip Moves" [if game.HasAnim(human.Anus) == true]
					game.RemoveAnim(human.Anus)
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Thrust.."[if game.HasAnim(human) == false][gold]
				+ "Humping | . 35"
					activeloops[human] = 0.5/CL_SMult*1.5
					game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot(-35, nil, nil), 
					HipsRot(35, nil, nil)), human)
					Return()
				+ "Humping | . 10 > 35"
					activeloops[human] = 0.6/CL_SMult*2
					game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot(-35, nil, nil), 
					HipsRot(10, nil, nil)), human)
					Return()
				+ "Humping | 0-20 > 30-40"
					activeloops[human] = 0.5/CL_SMult*1.5
					game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot((math.random(-40, -30)), nil, nil), 
					HipsRot((math.random(20, 0)), nil, nil)), human)
					Return()
				+ "Humping | .. 0 > 20-35"
					activeloops[human] = 0.5/CL_SMult*3
					game.AddRepeatAnim(0.7/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot((math.random(-20, -35)), nil, nil), 
					HipsRot(0, nil, nil)), human)
					Return()
				+ "Hard Humping"
					activeloops[human] = 0.3/CL_SMult*3
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot(-55, nil, nil), 
					HipsRot(-10, nil, nil)), human)
					Return()
				+ "Grind Face | -10 > -35-0 "
					activeloops[human] = 0.5/CL_SMult*2
					game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot((math.random(0, -35)), nil, nil), 
					HipsRot(-10, nil, nil)), human)
					Return()
				+ "Grind Face | -20 > -30"
					activeloops[human] = 0.6/CL_SMult*2.5
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot(-30, nil, nil), 
					HipsRot(-20, nil, nil)), human)
					Return()
				+ "Twerk"
					activeloops[human] = 0.3/CL_SMult*1.5
					game.AddRepeatAnim(0.5/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot(45, nil, nil), 
					HipsRot(15, nil, nil)), human)
					Return()
				+ "Twerk 2"
					activeloops[human] = 0.3/CL_SMult*1.5
					game.AddRepeatAnim(0.5/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], 
					HipsRot(50, nil, nil), 
					HipsRot(30, nil, nil)), human)
					Return()


-------------------------------------------------------

	+ "Poses.."
		+ "Original HG Poses.."[gold]
			+ "Stand up straight."
				human.Pose(StandUp())
				Return()
			+ "Kneel down."
				human.Pose(KneelDown())
				Return()
			+ "Sit down."
				human.Pose(SitDown())
				Return()
			+ "Sit down and spread your legs."
				human.Pose(SitDownSpreadLegs())
				Return()
			+ "Lay down on your back."
				human.Pose(LayDownBack())
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
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Sit.."[gold]
			+ "Sit down."
				human.Pose(SitDown1())
				Return()
			+ "Scared."
				human.Pose(SitDown2())
				Return()
			+ "Sit down and spread your legs."
				human.Pose(SitDownSpreadLegs())
				Return()
			+ "Squat"
				human.Pose(Squat())
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Lay Down.."[gold]
			+ "On your back"
				human.Pose(LayDownBack1())
				Return()
			+ "On your side - Right."
				human.Pose(LayDownSideR())
				Return()
			+ "On your side - Left."
				human.Pose(LayDownSideL())
				Return()
			+ "On your stomach."
				human.Pose(LaydownStomach1())
				Return()
			+ "Hanging"
				human.Pose(Hanging_1())
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Stand Up.."[gold]
			+ "Stand up!"
				human.Pose(StandUp1())
				Return()
			+ "Bend Over | Grope"
				human.Pose(BendOver1())
				Return()
			+ "Bend Over | Lean"
				human.Pose(BendOver_Lean())
				Return()
			+ "Bend Over | Spread"
				human.Pose(BendOver_Spread())
				Return()
			+ "Bend Over | Handstand"
				human.Pose(Handstand_1())
				Return()
			+ "Bend Over | Handstand - 2"
				human.Pose(Handstand_2())
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Kneel.."[gold]
			+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back. | vvv Click twice! vvv"
				Return(2)
			+ "Neutral face."
				human.Pose(FaceNeutral())
				Return()
			+ "All Four."
				human.Pose(All41())
				Return()
			+ "All Four - 2."
				human.Pose(All42())
				Return()
			+ "Doggystyle | Exhausted"
				human.Pose(Doggystyle_Exhausted())
				Return()
			+ "Doggystyle | Bound"
				human.Pose(Doggystyle_Bound())
				Return()
			+ "Kneel down."
				human.Pose(KneelDown1())
				Return()
			+ "Kneel down - 2."
				human.Pose(KneelDown2())
				Return()
			+ "Kneel down - 3."
				human.Pose(KneelDown3())
				Return()
			+ "Kneel down - 4."
				human.Pose(KneelDown4())
				Return()
			+ "Kneel down - 5."
				human.Pose(KneelDown5())
				Return()
			+ "Kneel down | Eiffel"
				human.Pose(Eiffel())
				Return()
		+ "Arms.."[gold]
			+ for i, pres in ipairs (Faun_bodystr)
				+ " " .. pres
					human.Pose(Faun_bodypresets[i]())
					Return()
			-- + for i, pres in ipairs (bodystr)
			-- 	+ " " .. pres
			-- 		human.Pose(bodypresets[i]())
			-- 		Return()
			+ "Hands.."[gold]
				+ "Peace L"
					human.Pose(PeaceL())
					Return()
				+ "Peace R"
					human.Pose(PeaceR())
					Return()
				+ "Shush R"
					human.Pose(Shush())
					Return()
				+ "Open."
					human.Pose(HandsOpen())
					Return()
				+ "Rest."
					human.Pose(HandsOpen_2())
					Return()
				+ "Closed."
					human.Pose(HandsClosed())
					Return()
				+ "Half."
					human.Pose(HandsClosed_Half())
					Return()
				+ "Claw"
					human.Pose(HandsOpen_Claw())
					Return()
				+ "Grab Head"
					human.Pose(GrabHead())
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "<color=#9a646f><i>Done."






------------------------------------------------------

------------------------------------------------------------------------

----------------------------------------------------------

	+ "BJ Slower"
		+ "forward S"
			activeloops[human.Mouth] = 1.6/CL_SMult*3.7
			game.AddRepeatAnim(1.6/CL_SMult, || CustomLoopsV2(human, "BJ 1", activeloops[human.Mouth], 
			HeadRot(340, 335, 320), 
			HeadRot(340, 5, 40)), human.Mouth)
			Return()
		+ "forward - cheek S"
			activeloops[human.Mouth] = 1.4/CL_SMult*3.7
			game.AddRepeatAnim(1.6/CL_SMult, || CustomLoopsV6(human, "BJ 3", activeloops[human.Mouth], 
			HeadRot(300, 0, nil), 
			HeadRot(300, 340, nil), 
			HeadRot(300, 0, nil), 
			HeadRot(300, 320, nil), 
			HeadRot(300, 0, nil), 
			HeadRot(300, 330, nil)), human.Mouth)
			Return()				
		+ "Forward - Random2 S"
			activeloops[human.Mouth] = 1.6/CL_SMult*3
			game.AddRepeatAnim(1.6/CL_SMult, || CustomLoopsV2(human, "Head", activeloops[human.Mouth], 
			HeadRot((math.random(0, -10)), (math.random(15, 10)), -10), 
			HeadRot((math.random(15, 10)), (math.random(330, 325)), 10)), human.Mouth)
			Return()


		+ "UPWARD - Random"
			activeloops[human.Mouth] = 1.6/CL_SMult*3.7 
			game.AddRepeatAnim(1.6/CL_SMult, || CustomLoopsV2(human, "BJ 5", activeloops[human.Mouth], 
			HeadRot(270, (math.random(310, 340)), (math.random(320, 340))), 
			HeadRot(270, (math.random(330, 350)), (math.random(0, 5)))), human.Mouth) 
			Return()

		+ "Upward S"
			activeloops[human.Mouth] = 1.6/CL_SMult*3.7
			game.AddRepeatAnim(1.6/CL_SMult, || CustomLoopsV2(human, "BJ 2", activeloops[human.Mouth], 
			HeadRot(270, 320, 330), 
			HeadRot(270, 340, 5)), human.Mouth)
			Return()

		+ "Downward - Random S"
			activeloops[human.Mouth] = 1.6/CL_SMult*3.7 --0.6/CL_SMult*3.7
			game.AddRepeatAnim(1.6/CL_SMult, || CustomLoopsV2(human, "BJ 4", activeloops[human.Mouth], 
			HeadRot(90, (math.random(335, 0)), (math.random(330, 320))), 
			HeadRot(90, (math.random(0, 10)), (math.random(30, 50)))), human.Mouth) --HeadRot(-35, 340, (math.random(310, 330))), HeadRot(-30, 5, (math.random(30, 50)))), human.Mouth)
			Return()
		+ "Stop BJ" [if game.HasAnim(human.Mouth) == true][gold]
			game.RemoveAnim(human.Mouth)
			Return()
		+ "Back"
			Return(2)



--	+ "gag test 1" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 
--		activeloops[human] = 6/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(2, 5)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-45, 20, 5), HipsRot(-50, -20, -5)), human)
--
--		Return(1)


--	+ "gag test 2" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 
--		activeloops[human] = 6/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(2, 5)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-45, 20, 10), HipsRot(-50, -20, -10)), human)
--
--		Return(1)


--	+ "gag test 3" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 
--		activeloops[human] = 6/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(2, 5)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-45, 0, 0), HipsRot(-50, 0, 0)), human)
--
--		Return(1)


--	+ "gag test 4" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 
--		activeloops[human] = 6/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(2, 5)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-45, 0, 20), HipsRot(-50, 0, -20)), human)
--
--		Return(1)
--

----------------------------------------------------------------------------

	+ "FLUID SETTINGS" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 
		+ "MORE DROOL PLEASE, " .. human.Name .. "." [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 
			human.m_mouth.m_wetness = human.m_mouth.m_wetness + 50000
			Return(1)

		+ "STOP DROOLING ALL OVER ME, " .. human.Name .. "." [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 
			human.m_mouth.m_wetness = 0
			human "Sorry, I'll try."
			Return(1)
		+ "Back"
			Return(2)

	+ if game.PovHuman ~= human
		+ "Enter " .. human.Name .. "'s POV."
			game.PovHuman = human
	+ if game.PovHuman ~= nil
		+ "Exit POV."
			game.PovHuman = nil

	+ "LOOK AT ME, " .. human.Name .. "." 
		human.Pose(FaceCam())
		human.Pose(LookCam())
		Return(1)

---------------------------------------------------------------------------------------------------------------------------------------------------------



	+ "Humping"
		+ "Humping"
			activeloops[human] = 0.6/CL_SMult*2
			game.AddRepeatAnim(0.4/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-40, 0, 0), HipsRot(5, 0, 0)), human)
			Return(1)
		+ "Slow Soft humping less deep2"
			activeloops[human] = 1/CL_SMult*3
			game.AddRepeatAnim(1/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-15, 0, 0), HipsRot(10, 0, 0)), human)
			Return(1)
		+ "Slow Soft humping less deep"
			activeloops[human] = 1/CL_SMult*3
			game.AddRepeatAnim(1/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-25, 0, 0), HipsRot(0, 0, 0)), human)
			Return(1)
		+ "Slow Soft humping"
			activeloops[human] = 1/CL_SMult*2
			game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-50, 0, 0), HipsRot(0, 0, 0)), human)
			Return(1)
		+ "Soft humping"
			activeloops[human] = 0.5/CL_SMult*3
			game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-50, 0, 0), HipsRot(0, 0, 0)), human)
			Return(1)
		+ "Hard Humping"
			activeloops[human] = 0.3/CL_SMult*3
			game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-55, 0, 0), HipsRot(-10, 0, 0)), human)
			Return(1)
		+ "Fast Humping"
			activeloops[human] = 0.2/CL_SMult*3
			game.AddRepeatAnim(0.2/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-70, 0, 0), HipsRot(-10, 0, 0)), human)
			Return(1)
		+ "Deep Slow Humping"
			activeloops[human] = 5/CL_SMult*1
			game.AddRepeatAnim(5/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-30, 0, 0), HipsRot(20, 0, 0)), human)
			Return(1)
		+ "Hump front"
			activeloops[human] = 0.6/CL_SMult*2.5
			game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(20, 0, 0), HipsRot(-2, 0, 0)), human)
			Return(1)
		+ "Twerk"
			activeloops[human] = 0.6/CL_SMult*2.5
			game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(45, 0, 0), HipsRot(10, 0, 0)), human)
			Return(1)
		+ "WAIT AND THRUST"
			activeloops[human] = 7/CL_SMult*0.5
			game.AddRepeatAnim(5/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-20, 0, 0), HipsRot(350, 0, 0)), human)
			Return(1)
		+ "Deep Slow Humping2"
			activeloops[human] = 5/CL_SMult*0.7
			game.AddRepeatAnim(5/CL_SMult, || CustomLoopsV2(human, "Humping", activeloops[human], HipsRot(-30, 0, 0), HipsRot(55, 0, -10)), human)
			Return(1)

---------------------------------------------------------------------------------------------------------------------------------------------------------
	+ "PAUSE" [if human.Penis.IsActive][gold] [gold]
		human.Penis.Interaction.m_autoSpeed = 0.0001
		human.m_mouth.m_wetness = 0
		Return(1)
---------------------------------------------------------------------------------------------------------------------------------------------------------

	+ "AUTO THRUST" [if human.Penis.IsActive] [gold]


		+ "Auto Thrust fast not deep" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 20, 0, 0.3, 0.1, 0.1, 0.5, 60)
			Return()

		+ "Auto Thrust MEDIUM deep" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 90, 0, 0.1, 0.005, 0.35, 1, 70)
			Return()
		+ "Auto Thrust slowest deep" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]		
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 100, 0, 0.03, 0.01, 0.2, 1, 10)
			Return()
		+ "Auto Thrust slowestest kinda deep" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 100, 0, 0.02, 0.01, 0.5, 0.7, 10)
			Return()




		+ "Auto Thrust slowish not deep" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 100, 0, 0.02, 0.03, 0.2, 0.4, 10)
			Return()
		+ "Auto Thrust slow not deep" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 100, 0, 0.02, 0.01, 0.001, 0.3, 10)
			Return()


		+ "10Auto Thrust fastest deep RANDOM1" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 30, 0, 0.05, 0.6, 0.05, 1.2, 60)
			human.Penis.Interaction.AutoPenisWeight = 0
			Return()

		+ "9Auto Thrust fastest deep RANDOM1" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 30, 0, 0.05, 0.6, 0.05, 1.5, 60)
			human.Penis.Interaction.AutoPenisWeight = 1
			Return()

		+ "8Auto Thrust fast deep RANDOM" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 30, 0, 0.05, 0.4, 0.3, 1.4, 60)
			human.Penis.Interaction.AutoPenisWeight = 0.9
			Return()

		+ "7Auto Thrust faster RANDOM" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 40, 0, 0.1, 0.5, 0.2, 1.3, 60)
			human.Penis.Interaction.AutoPenisWeight = 0.8
			Return()

		+ "6Auto Thrust fast deep RANDOM 2" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
--			GradualSpeedUpAutoThrusting(human, 10, 0, 0.05, 0.1, 0.2, 1.5, 60)
			GradualSpeedUpAutoThrusting(human, 50, 0, 0.1, 0.4, 0.2, 1.2, 60)
			human.Penis.Interaction.AutoPenisWeight = 0.7
			Return()

		+ "5Auto Thrust slow deep RANDOM" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 60, 0, 0.05, 0.4, 0.1, 1.2, 60)
			human.Penis.Interaction.AutoPenisWeight = 0.6
			Return()

		+ "4Auto Thrust slowestest kinda deep RANDOM" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 50, 0, 0.015, 0.3, 0.05, 0.9, 60)
			human.Penis.Interaction.AutoPenisWeight = 0.5
			Return()

		+ "3Auto Thrust slowestest kinda deep RANDOM 2" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 40, 0, 0.05, 0.3, 0.05, 0.7, 60)
			human.Penis.Interaction.AutoPenisWeight = 0.4
			Return()

--		+ "2Auto Thrust slowestest kinda deep RANDOM 3" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
--			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
--			GradualSpeedUpAutoThrusting(human, 30, 0, 0.01, 0.2, 0.05, 0.55, 60)
--			human.Penis.Interaction.AutoPenisWeight = 0.3
--			Return()

		+ "1Auto Thrust slow NOT deep RANDOM" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
			--function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			GradualSpeedUpAutoThrusting(human, 30, 0, 0.05, 0.3, 0.05, 0.5, 60)
			human.Penis.Interaction.AutoPenisWeight = 0
			Return()



--		+ "autothrust more male"  [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == true] 
--			human.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.2
--			Return()

--		+ "autothrust more female" [if human.Penis.Interaction.AutoActive == true] 
--			human.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.2
--			Return()

		+ "Hold still!" [if human.Penis.Interaction.AutoActive == true] [gold] 
			human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.25
--			human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight * 1.333
			Return()

		+ "Do it yourself" [if human.Penis.Interaction.AutoActive == true] [gold] 
--			human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight - 0.25
			human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight / 1.333
			Return()

		+ "Harder!" [if human.Penis.Interaction.AutoActive == true] [gold] 
--			human.Penis.Interaction.m_autoThrustWeight = human.Penis.Interaction.m_autoThrustWeight * 1.333
			human.Penis.Interaction.m_autoThrustWeight = human.Penis.Interaction.m_autoThrustWeight * 1.4
			Return()

		+ "Softer" [if human.Penis.Interaction.AutoActive == true] [gold] 
--			human.Penis.Interaction.m_autoThrustWeight = human.Penis.Interaction.m_autoThrustWeight / 1.333
			human.Penis.Interaction.m_autoThrustWeight = human.Penis.Interaction.m_autoThrustWeight / 1.4
			Return()

		+ "STOP THRUSTING!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == true] 
			human.Penis.Interaction.AutoActive = false
			human.Penis.Interaction.m_autoThrustWeight = 1
			Return()
		+ "Back."
			Return(2)
------------




--	+ "More male" [if human.Penis.IsActive] [gold] 
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.1
--			Return()

--	+ "More female" [if human.Penis.IsActive] [gold] 
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.1
--			Return()
--	+ "Start thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
------------------------------

	+ "Pause girl!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = 0.01
--		human.m_mouth.m_wetness = human.m_mouth.m_wetness + 10000
--		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = human.Mouth.Fucker.penis.Interaction.m_autoEndDepth * 3

		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = 0.01
		human.m_mouth.m_wetness = human.m_mouth.m_wetness + 10000
--		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = human.Mouth.Fucker.penis.Interaction.m_autoEndDepth * 5
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 3
		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 5
		Return(1)

--------------------------------------------------------------------------------------------------------------------------------------------

	+ "FACEFUCK" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 
		human.m_mouth.m_wetness = human.m_mouth.m_wetness + 50000
		human.Mouth.Fucker.Penis.Interaction.AutoActive = true
		human.Mouth.Fucker.penis.Interaction.m_autoSpeed = human.Mouth.Fucker.penis.Interaction.m_autoSpeed * 1.1
--		human.Mouth.Fucker.penis.Interaction.m_autoSpeed = human.Mouth.Fucker.penis.Interaction.m_autoSpeed * 1.2
--		human.Mouth.Fucker.penis.Interaction.m_autoSpeed = human.Mouth.Fucker.penis.Interaction.m_autoSpeed * 1.05
--		human.Mouth.Fucker.penis.Interaction.m_autoSpeed = human.Mouth.Fucker.penis.Interaction.m_autoSpeed * 1.025

--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.333
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 2.222
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.111
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight + 0.05
		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight + 0.1
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight + 0.2
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight + 0.25
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight + 0.333


		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = human.Mouth.Fucker.penis.Interaction.m_autoEndDepth * 1.3
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth / 1.3
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth / 1.2
		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth / 1.1


--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.3
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.1
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.1

		StopAllAnimations(human)

---		activeloops[human.chestNames] = 4/CL_SMult*1
---		game.AddRepeatAnim(3/CL_SMult, || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
---		SpineRot(15), 
---		SpineRot(-15)), human.chestNames)

		activeloops[human.chestNames] = 4/CL_SMult*1
		game.AddRepeatAnim(2/CL_SMult, || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
		SpineRot(12), 
		SpineRot(-12)), human.chestNames)

		activeloops[human.headNames] = 5/CL_SMult*1
		game.AddRepeatAnim((math.random(2, 12)), || CustomLoops(human, FaceSmile, FaceAhegao1, "Smile > Ahegao"), human)


--		activeloops[human] = 6/CL_SMult*0.5
--		game.AddRepeatAnim(5/CL_SMult, || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-40, 0, 0), HipsRot(-30, 0, 0)), human)

--		activeloops[human] = 6/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(2, 5)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-45, 20, 10), HipsRot(-50, -20, -10)), human)

--		activeloops[human] = 5/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(1, 6)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-40, -5, 5), HipsRot(-30, 5, -5)), human)

--		activeloops[human] = 5/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(1, 6)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-20, 0, 5), HipsRot(-30, -5, 0)), human)

		activeloops[human] = 5/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(0.5, 2)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-20, 0, 5), HipsRot(-30, -5, 0)), human)
--		game.AddRepeatAnim((math.random(3, 8)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-20, 5, 5), HipsRot(-25, -5, -5)), human)
		game.AddRepeatAnim((math.random(1.7, 2.7)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-25, 0, 5), HipsRot(-20, -5, 0)), human)

		Return(1)

--------------------------------------------------------------------------------------------------------------------------------------------
	+ "CHOKE ME" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] 



--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = 0.02
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = 0.03
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = 0.05

		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed / 1.05
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed / 1.1
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed / 1.2
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed / 1.3

		human.m_mouth.m_wetness = human.m_mouth.m_wetness + 50000

--		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = human.Mouth.Fucker.penis.Interaction.m_autoEndDepth * 2
--		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = human.Mouth.Fucker.penis.Interaction.m_autoEndDepth * 1.3
		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = human.Mouth.Fucker.penis.Interaction.m_autoEndDepth * 1.5

--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 2
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.3
		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.4
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.5
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.6
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.7

--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.3
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.1
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight - 0.05
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.1

		StopAllAnimations(human)

		activeloops[human.headNames] = 5/CL_SMult*1
--		game.AddRepeatAnim((math.random(3, 10)), || CustomLoops(human, FaceAngry, FaceScared, "Angry > Scared"), human)
--		game.AddRepeatAnim((math.random(3, 10)), || CustomLoops(human, FaceAhegao1, FaceSurprised , "Ahegao > Surprised"), human)
		game.AddRepeatAnim((math.random(3, 10)), || CustomLoops(human, FaceAhegao1, FaceDisappointed2 , "Ahegao > Disappointed2"), human)




--		activeloops[human.chestNames] = 0.4/CL_SMult*1
--		game.AddRepeatAnim((math.random(1.5, 4)), || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
--		SpineRot((math.random(4, 5))), 
--		SpineRot((math.random(-5, -4)))), human.chestNames)

		activeloops[human.chestNames] = 1/CL_SMult*1
		game.AddRepeatAnim((math.random(1.5, 4)), || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
		SpineRot((math.random(4, 12))), 
		SpineRot((math.random(-4, -12)))), human.chestNames)


--		activeloops[human.chestNames] = 4/CL_SMult*1
--		game.AddRepeatAnim(2/CL_SMult, || CustomLoopsV2(human, "Shaking", activeloops[human.chestNames], 
--		SpineRot(12), 
--		SpineRot(-12)), human.chestNames)


--		activeloops[human] = 6/CL_SMult*0.5
--		game.AddRepeatAnim((math.random(2, 5)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-45, 20, 10), HipsRot(-50, -20, -10)), human)

--		activeloops[human] = 6/CL_SMult*0.6
--		game.AddRepeatAnim((math.random(1, 5)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-45, 5, 5), HipsRot(-35, -5, -5)), human)

--		activeloops[human] = 6/CL_SMult*0.6
--		game.AddRepeatAnim((math.random(1, 5)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-25, 5, 5), HipsRot(-35, -5, -5)), human)

--		activeloops[human] = 6/CL_SMult*0.6
--		game.AddRepeatAnim((math.random(1, 7)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-25, 5, 5), HipsRot(-35, -5, -5)), human)

		activeloops[human] = 4/CL_SMult*0.6
--		game.AddRepeatAnim((math.random(1, 4)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-20, 5, 5), HipsRot(-35, -5, -5)), human)
--		game.AddRepeatAnim((math.random(3, 8)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-20, 5, 5), HipsRot(-35, -5, -5)), human)
		game.AddRepeatAnim((math.random(3, 7)), || CustomLoopsV2(human, "Gag", activeloops[human], HipsRot(-30, 5, 5), HipsRot(-25, -5, -5)), human)

--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.1
		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.2
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.333
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.4
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.5

--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight + 0.2
		Return(1)

------------------------------------------------------


	+ "Start Deeper" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]	
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.333
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.7
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.5
		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth * 1.4

--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed / 1.2
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed * 1.2
		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed / 1.1

		human.m_mouth.m_wetness = human.m_mouth.m_wetness + 50000

		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.1
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.05

		StopAllAnimations(human)
--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceSad, FaceDisgusted, "Sad > Disgusted"), human)
--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceDisappointed, FaceUnimpressed, "Disappointed > Unimpressed"), human)
		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceAhegao1, FaceDisappointed2, "Ahegao1 > Disappointed2"), human)
--		game.AddRepeatAnim((math.random(1, 7)), || CustomLoops(human, FaceNervous, FaceLipbite2, "Nervous > Lipbite2"), human)
		Return()

	+ "Start less deep" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth / 1.333
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth / 1.7
--		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth / 1.5
		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth / 1.4

		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed * 1.1
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed * 1.2

		human.m_mouth.m_wetness = human.m_mouth.m_wetness - 5000

--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.1
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.2

		StopAllAnimations(human)
		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceLipbite2, FaceSmile, "Lipbite2 > Smile"), human)
		Return()



	+ "Suck Deeper!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]
		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = human.Mouth.Fucker.penis.Interaction.m_autoEndDepth * 1.333
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed * 1.1
		human.m_mouth.m_wetness = human.m_mouth.m_wetness + 50000


--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.05
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.1
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.2
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.1

		StopAllAnimations(human)

--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceAngry, FaceScared, "Angry > Scared"), human)
--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceAngry, FaceAhegao, "Angry > Ahegao"), human)
--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceScared, FaceAhegao1, "Scared > Ahegao"), human)

--		game.AddRepeatAnim((math.random(1, 7)), || CustomLoops(human, FaceLipbite, FaceLipbite2, "Lipbite > Lipbite2"), human)
--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceDisappointed2, FaceUnimpressed, "Disappointed2 > Unimpressed"), human)
		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceDisappointed3, FaceAhegao1, "Disappointed3 > Ahegao1"), human)

		Return(1)


	+ "Suck Less Deep" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]
		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = human.Mouth.Fucker.penis.Interaction.m_autoEndDepth / 1.333
--		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed / 1.1
		human.m_mouth.m_wetness = human.m_mouth.m_wetness - 5000

--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.333

--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.2
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.5
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.1
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.05

		StopAllAnimations(human)
		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceNeutral, FaceScared, "Neutral > Scared"), human)
--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceNeutral, FaceSmile, "Neutral > Smile"), human)
		Return(1)



--------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------

------------------------------------------------------



	+ "SUCK FASTER" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]

		human.Mouth.Fucker.Penis.Interaction.AutoActive = true
		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed * 1.333
		human.m_mouth.m_wetness = human.m_mouth.m_wetness + 50000
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.3
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight + 0.2

		StopAllAnimations(human)
--		game.AddRepeatAnim(3, || CustomLoops(human, FaceNeutral, FaceScared, "Neutral > Scared"), human)
--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceNeutral, FaceScared, "Neutral > Scared"), human)
		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceDisappointed2, FaceScared, "Disappointed2 > Scared"), human)


--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.333
		Return(1)

	+ "SUCK SLOWER" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]
		human.Mouth.Fucker.Penis.Interaction.AutoActive = true
		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = human.Mouth.Fucker.Penis.Interaction.m_autoSpeed / 1.333
		human.m_mouth.m_wetness = human.m_mouth.m_wetness - 5000
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 0.3
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight - 1

--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight / 1.333

		StopAllAnimations(human)
		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceNeutral, FaceSmile, "Neutral > Smile"), human)

		Return(1)
	


--------	+ "RESET SPEED" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]
		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = 0.07
		Return(1)



-----------------

	+ "START THRUST DEEPER" [if human.Penis.IsActive] [gold] 
		human.Penis.Interaction.m_autoStartDepth = human.Penis.Interaction.m_autoStartDepth * 1.333
--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.2

--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 1


--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceNeutral, FaceSmile, "Neutral > Smile"), human)

		Return()


	+ "START THRUST LESS DEEP" [if human.Penis.IsActive] [gold] 
		human.Penis.Interaction.m_autoStartDepth = human.Penis.Interaction.m_autoStartDepth / 1.333
--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.2

--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight - 0.05


--		game.AddRepeatAnim((math.random(0.5, 5)), || CustomLoops(human, FaceNeutral, FaceSmile, "Neutral > Smile"), human)

		Return()




----------------------------------------------------------------------------------------------------------------------------------------------------------

	+ "THRUST DEEPER" [if human.Penis.IsActive] [gold] 
--		human.Penis.Interaction.AutoPenisWeight = 1
		human.Penis.Interaction.m_autoEndDepth = human.Penis.Interaction.m_autoEndDepth * 1.333
--		human.Penis.Interaction.m_autoSpeed = human.Penis.Interaction.m_autoSpeed * 1.1
--		human.Penis.Interaction.m_autoSpeed = human.Penis.Interaction.m_autoSpeed*1.3

--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.3
		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.2
--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.1
--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.15


		Return()

	+ "THRUST LESS DEEP" [if human.Penis.IsActive] [gold]
--------		human.Penis.Interaction.AutoPenisWeight = 1
		human.Penis.Interaction.m_autoEndDepth = human.Penis.Interaction.m_autoEndDepth / 1.333
--------		human.Penis.Interaction.m_autoSpeed = human.Penis.Interaction.m_autoSpeed / 1.1
--		human.Penis.Interaction.m_autoSpeed = human.Penis.Interaction.m_autoSpeed/1.3

--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.3
--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.2
--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight - 0.05
		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight - 0.1

		Return()

	+ "THRUST FASTER" [if human.Penis.IsActive] [gold] 
		human.Penis.Interaction.AutoActive = true
		human.Penis.Interaction.m_autoSpeed = human.Penis.Interaction.m_autoSpeed*1.3

		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.2
--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.15
		Return()
	+ "THRUST SLOWER" [if human.Penis.IsActive] [gold]
		human.Penis.Interaction.m_autoSpeed = human.Penis.Interaction.m_autoSpeed/1.3
-------		human.m_mouth.m_wetness = human.m_mouth.m_wetness - 0

--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight + 0.2
--		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight - 0.05
		human.Penis.Interaction.AutoPenisWeight = human.Penis.Interaction.AutoPenisWeight - 0.1


		Return()
							





--------	+ "RESET SPEED" [if human.Penis.IsActive] [gold]
		human.Penis.Interaction.m_autoSpeed = 0.07
		Return(1)




	+ "Start thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
		human.Penis.Interaction.AutoActive = true
--		human.Penis.Interaction.AutoPenisWeight = 0.8
		human.Penis.Interaction.AutoPenisWeight = 0.7
--		human.Penis.Interaction.AutoPenisWeight = 0.5

		human.Penis.Interaction.m_autoSpeed = 0.07
		human.Penis.Interaction.m_autoEndDepth = 0.7
		human.Penis.Interaction.m_autoStartDepth = 0.25

		human.Penis.Interaction.m_autoThrustWeight = 1

--------	human.m_mouth.m_wetness = human.m_mouth.m_wetness + 2000
		Return(1)



	+ "Stop thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == true] [gold]
		human.Penis.Interaction.AutoActive = false
--------	human.m_mouth.m_wetness = human.m_mouth.m_wetness - 2000
		Return(1)



	+ "Start sucking!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == false] [gold]
		StopAllAnimations(human)

		human.Mouth.Fucker.Penis.Interaction.AutoActive = true
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = 0
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = 0.2
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = 0.3
--		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight -0.5

		human.Mouth.Fucker.Penis.Interaction.m_autoSpeed = 0.05
		human.Mouth.Fucker.penis.Interaction.m_autoEndDepth = 0.5


		human.Mouth.Fucker.Penis.Interaction.m_autoStartDepth = 0.15

--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = 1
--		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = 0.7
		human.Mouth.Fucker.Penis.Interaction.m_autoThrustWeight = 1

		human.m_mouth.m_wetness = human.m_mouth.m_wetness + 20000

--		activeloops[human.headNames] = 5/CL_SMult*1
--		game.AddRepeatAnim((math.random(2, 12)), || CustomLoops(human, FaceSmile, FaceAhegao1, "Smile > Ahegao"), human)

		activeloops[human.headNames] = 5/CL_SMult*1
		game.AddRepeatAnim((math.random(2, 7)), || CustomLoops(human, FaceSmile, TongueOut, "Smile > TongueOut"), human)

--		human.Pose(LookCam())
--		human.Pose(FaceSmile())

--		human.Body("Penis size", -1.192093E-07, "Fluid speed", 0.003165427, "Fluid spread", -0.9089578, "Fluid amount", 1.970034, "Fluid force", 0.9845225, "Fluid gravity", 0.9778774)
--		human.Body("Breasts size", 0.9883336, "Neck size", -0.22553, "Fluid speed", 0.9964311, "Fluid spread", 9.960778, "Fluid amount", 1.917425, "Fluid force", -0.9837008, "Fluid gravity", 1.989293)
		human.Body("Fluid speed", 0.9964311, "Fluid spread", 9.960778, "Fluid amount", 1.917425, "Fluid force", -0.9837008, "Fluid gravity", -0.9)

		Return(1)

	+ "Stop sucking!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]
		human.Mouth.Fucker.Penis.Interaction.AutoActive = false
--		human.m_mouth.m_wetness = human.m_mouth.m_wetness - 100000
		human.m_mouth.m_wetness = 0

		game.RemoveAnim(human)
		game.RemoveAnim(human.chestNames)
--		human.Pose(LookCam())
--		human.Pose(FaceSmile())
		Return(1)
	+ "Start handjob" [if human.Penis.m_holdDepth ~= 0 and human.Penis.Interaction.m_autoHandActive == false] [gold]
		human.Penis.Interaction.m_autoHandActive = true
		Return(1)
	+ "Stop handjob" [if human.Penis.m_holdDepth ~= 0 and human.Penis.Interaction.m_autoHandActive == true]
		human.Penis.Interaction.m_autoHandActive = false
		Return(1)
        Return()
	+ "Close"

--	+ "Back to TM" [if TM_ModMenu ~= nil] 
--		TM_ModMenu(human, hitTri)




stop

function HasAnyAnimation(human)
    return game.HasAnim(human.footNames) or
           game.HasAnim(human) or
           game.HasAnim(human.Anus) or
           game.HasAnim(human.chestNames) or
           game.HasAnim(human.breastNames) or
           game.HasAnim(human.m_mouth) or
           game.HasAnim(human.handNames) or
           game.HasAnim(human.forearmNames) or
           game.HasAnim(human.headNames) or
           game.HasAnim(human.thighNames) or
           game.HasAnim(human.spineNames)
end

-----------------------------------------

function FaceAhegao1() return Preset(
	EyeL(330, 15, 0),
	EyeR(330, 0, 0),
	Brows(1.2, 1.2, -1, -1),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(-1, -1)
) end

------------------------------------

--			+ "Neutral face."
--				human.Pose(FaceNeutral())
--				Return()
--			+ "Happy face."
--				human.Pose(FaceSmile())
--				Return()
--			+ "Angry face."
--				human.Pose(FaceAngry())
--				Return()
--			+ "Sad face."
--				human.Pose(FaceSad())
--				Return()
--			+ "Ahegao!"
--				human.Pose(FaceAhegao1())
--				Return()
--			+ "Ahegao! x 2"
--				human.Pose(FaceAhegao2())
--				Return()
--			+ "Surprised face."
--				human.Pose(FaceSurprised())
--				Return()
--			+ "Scared face."
--				human.Pose(FaceScared())
--				Return()
--			+ "Disgusted face."
--				human.Pose(FaceDisgusted())
--				Return()

----------------------------------

function GradualSpeedUpAutoBJ(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
    duration = duration or 30
    step = step or 0
    startSpeed = startSpeed or 0.5
    endSpeed = endSpeed or 0.1
    startDepth = startDepth or 0
    endDepth = endDepth or 1.5
    autoDisableAfter = autoDisableAfter or duration + 1  -- default: disable right after sequence ends

    local fixedEndDepth = 1.0
    local speedStep = (startSpeed - endSpeed) / duration
    local depthStep = (endDepth - startDepth) / duration

    -- Abort if no target
    if human.Mouth == nil or human.Mouth.Fucker == nil or human.Mouth.Fucker.Penis == nil then
        return
    end

    local penis = human.Mouth.Fucker.Penis

    -- On first run, activate and schedule auto-disable
    if step == 0 then
        penis.Interaction.AutoActive = true

        -- Auto disable after X seconds
        Delayed(autoDisableAfter, function()
            if penis.Interaction.AutoActive then
                penis.Interaction.AutoActive = false
            end
        end)
    end

    -- Step progression
    if step <= duration then
        local newSpeed = startSpeed - speedStep * step
        local newStartDepth = startDepth + depthStep * step

        penis.Interaction.m_autoSpeed = newSpeed
        penis.Interaction.m_autoStartDepth = newStartDepth
        penis.Interaction.m_autoEndDepth = fixedEndDepth

		if human.Mouth.Fucker.Penis.Interaction.AutoActive == true then

			Delayed(1, function()
				GradualSpeedUpAutoBJ(human, duration, step + 1, startSpeed, endSpeed, startDepth, endDepth, autoDisableAfter)
			end)
		end
    else
        -- Final clamp
        penis.Interaction.m_autoSpeed = endSpeed
        penis.Interaction.m_autoStartDepth = endDepth
        penis.Interaction.m_autoEndDepth = fixedEndDepth
    end
end

function StopAutoBJ(human)
    if human == nil or human.Mouth == nil or human.Mouth.Fucker == nil then return end

    local penis = human.Mouth.Fucker.Penis
    if penis == nil then return end

    penis.Interaction.AutoActive = false
    penis.Interaction.m_autoSpeed = 0.3
    penis.Interaction.m_autoStartDepth = 0.3
    penis.Interaction.m_autoEndDepth = 0.5
end

function GradualSpeedUpAutoThrusting(human, duration, step, startSpeed, endSpeed, startDepth, endDepth, hasOffsetApplied)
    duration = duration or 30
    step = step or 0
    startSpeed = startSpeed or 0.3
    endSpeed = endSpeed or 1.0
    startDepth = startDepth or 0.3
    endDepth = endDepth or 1.0
    hasOffsetApplied = hasOffsetApplied or false

    if human == nil or human.Penis == nil or human.Penis.Hole == nil then return end
    local penis = human.Penis

    -- Stop if manually deactivated
    if step > 0 and penis.Interaction.AutoActive ~= true then return end

    -- First-time setup
    if step == 0 then
        penis.Interaction.AutoActive = true
        penis.Interaction.AutoPenisWeight = 0.5
    end

    -- Primary offset conditions (once, after half the duration)
    local offsetZoneStart = math.floor(duration * 0.25)
    if not hasOffsetApplied and step >= offsetZoneStart then
        local shouldOffset = math.random() < 0.5 -- 50% chance
        if shouldOffset then
            local offsetPercent = math.random(15, 50) / 100
            local offsetAmount = math.floor(duration * offsetPercent)
            step = math.max(0, step - offsetAmount)
            hasOffsetApplied = true
        end
    end

    -- Increase the pushback chance as progress advances
    local progress = math.min(step / duration, 1)  -- 0 (start) to 1 (end)
    local backStepChance = 0.05 + 0.25 * progress  -- grows from 0.25 to 0.5

    if math.random() < backStepChance then  
        local pushBack = math.random(2, 8)
        step = math.max(0, step - pushBack)
    end

    -- Recalculate progression values after any offset/pushback
    local speedStep = (endSpeed - startSpeed) / duration
    local depthStep = (endDepth - startDepth) / duration

    local currentDepth = startDepth + depthStep * step
    local currentSpeed = startSpeed + speedStep * step

    -- When the depth is nearly closed, decrease the speed gradually.
    local depthThreshold = startDepth + (endDepth - startDepth) * 0.8
    if currentDepth > depthThreshold then
        local ratio = (currentDepth - depthThreshold) / (endDepth - depthThreshold)
        currentSpeed = endSpeed - (endSpeed - startSpeed) * ratio
    end

    local fixedEndDepth = endDepth

    penis.Interaction.m_autoSpeed = currentSpeed
    penis.Interaction.m_autoStartDepth = currentDepth
    penis.Interaction.m_autoEndDepth = fixedEndDepth

    Delayed(1, function()
        GradualSpeedUpAutoThrusting(human, duration, step + 1, startSpeed, endSpeed, startDepth, endDepth, hasOffsetApplied)
    end)
end


------------------------------------------

function FaceAhegao1() return Preset(
	EyeL(330, 15, 0),
	EyeR(330, 0, 0),
	Brows(1.2, 1.2, -1, -1),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(-1, -1)
) end

function FaceAhegao2() return Preset(
	EyeL(346.076, 28.61, 0),
	EyeR(347.849, 328.86, 0),
	Mouth(-0.025, -1, 0, 1, -1, -1, 1, 0.833, 0.833, 0.5, 0.5, 1.2),
	Brows(1.2, 1.2, -0.745, -0.745),
	EyelidL(0.184),
	EyelidR(0.184),
	Cheeks(-1, -1)
) end

function EC_A() return Preset(
	HeadRot(320, nil, nil)
) end

function EC_B() return Preset(
	HeadRot(280, nil, nil)
) end

function StandUp1() return Preset(
	Hips(WPos(0, 1.078, -0.011)),
	HipsRot(),
	Head(-0.001, 0.992, -0.122),
	HeadRot(356.908, 359.26, 3.669),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.295, -0.002, 0.007), 0, -1)),
	FootR(WSurface(TPos(0.314, -0.002, 0.021), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.6, 0.9, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.5, -0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(0.26),
	ElbowR(0.26),
	WristL(-25, 0, -65),
	WristR(-25, 0, -70),
	KneeL(),
	KneeR(),
	SpineRot()
) end

function KneelDown1() return Preset(
	Hips(WPos(-0.001, 0.409, 0.12)),
	HipsRot(1.25, 0, 0.475),
	Head(0.003, 0.99, -0.141),
	HeadRot(345.786, 344.709, 337.23),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.115, -0.005, -0.09), 0, -1)),
	FootR(WSurface(TPos(0.115, -0.005, -0.09), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Thigh_L", 0.191, -0.2, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", 0.178, 0.286, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	ElbowL(),
	ElbowR(0.313),
	WristL(),
	WristR(),
	KneeL(-0.068),
	KneeR(-0.099),
	SpineRot(),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(1, 1, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1)
) end

function KneelDown1b() return Preset(
	Hips(WPos(-0.001, 0.409, 0.12)),
	HipsRot(1.25, 0, 0.475),
	Head(0.003, 0.99, -0.141),
	HeadRot(345.786, 344.709, 337.23),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.115, -0.005, -0.09), 0, -1)),
	FootR(WSurface(TPos(0.115, -0.005, -0.09), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Thigh_L", 0.191, -0.2, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", 0.178, 0.286, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	ElbowL(),
	ElbowR(0.313),
	WristL(),
	WristR(),
	KneeL(-0.068),
	KneeR(-0.099),
	SpineRot()
) end

function KneelDown2() return Preset(
	Hips(WPos(-0.001, 0.357, 0.111)),
	HipsRot(1.25, 0, 0.475),
	Head(0.003, 0.994, -0.107),
	HeadRot(313.516, 355.466, 1.341),
	FootL(WSurface(TPos(-0.115, -0.005, -0.09), 0, -1)),
	FootR(WSurface(TPos(0.115, -0.005, -0.09), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Foot_L", -0.505, 0.952, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Foot_R", -0.41, 0.996, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	ElbowL(-1),
	ElbowR(),
	WristL(),
	WristR(),
	KneeL(-0.362),
	KneeR(-0.405),
	SpineRot(),
	Mouth(-1, 0, 0, 0.504, 0.504, -1, -1, 0.675, 0.675, 0.999, 0.999, 0, 0, 0.8, 0, -0.12),
	Brows(1, 1, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1)
) end

function KneelDown3() return Preset(
	Hips(WPos(-0.001, 0.409, 0.12)),
	HipsRot(1.25, 0, 0.475),
	Head(0.002, 0.995, -0.1),
	HeadRot(337.781, 357.102, 0.584),
	FootL(WSurface(TPos(-0.115, -0.005, -0.09), 0, -1)),
	FootR(WSurface(TPos(0.115, -0.005, -0.09), 0, -1)),
	HandL(HPos(0.202, -0.729, 0.557), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	HandR(HPos(-0.228, -0.716, 0.551), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(),
	ElbowR(),
	WristL(-70, 0, 35),
	WristR(-70, 0, 35),
	KneeL(0.1),
	KneeR(0.1),
	SpineRot()
) end

function KneelDown4() return Preset(
	Hips(WPos(-0.001, 0.357, 0.111)),
	HipsRot(1.25, 0, 0.475),
	Head(0.003, 0.994, -0.107),
	HeadRot(339.189, 351.202, 6.756),
	FootL(WSurface(TPos(-0.115, -0.005, -0.09), 0, -1)),
	FootR(WSurface(TPos(0.115, -0.005, -0.09), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Foot_L", -0.505, 0.952, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Head", 0.127, 0.004, 0.03), Wrist(HPoint(0, 0, 0.3, 0, 0, 0, "Bone_Index3_L"), 70)),
	ThumbR(30, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	RingR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	PinkyR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	ElbowR(-0.193),
	WristR(22.28, 0, 67.466),
	KneeL(-0.4),
	KneeR(-0.4),
	SpineRot(),
	Mouth(-1, 0, 0, 0.504, 0.504, -1, -1, 0.675, 0.675, 0.999, 0.999, 0, 0, 2, 0, -1.5),
	Brows(1, 1, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1)
) end

function KneelDown5() return
	Hips(WPos(-0.001, 0.503, -0.083)),
	HipsRot(1.25, 0, 0.475),
	Head(0.002, 0.926, 0.378),
	HeadRot(333.768, 352.533, 8.489),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.115, -0.005, -0.09), 0, -1)),
	FootR(WSurface(TPos(0.115, -0.005, -0.09), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.3, 0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbL(6.232, 69.101, 69.101, 10.208, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.3, -0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbR(6.232, 69.101, 69.101, 10.208, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ElbowL(0.26),
	ElbowR(0.26),
	WristL(68.619, 0, -76.201),
	WristR(62.219, 0, -52.779),
	KneeL(0.082),
	KneeR(0.312),
	SpineRot(),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(2.5, 2.5, -0.25, -0.25),
	EyelidL(-0.276),
	EyelidR(-0.276),
	Cheeks(2.5, 3)
end

function SitDown1() return Preset(
	Hips(WPos(0.004, 0.137, -0.028)),
	HipsRot(21.05, 0, -3.65),
	Head(-0.006, 0.968, -0.25),
	HeadRot(355.852, 359.582, 356.344),
	FootL(WSurface(TPos(-0.099, 0.002, 1.153), 0.003, -1, 0.004)),
	FootR(WSurface(TPos(0.049, 0.001, 0.863), 0.003, -1, 0.004)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Head", 0.949, -0.862, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Head", 1.009, 0.92, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	ElbowL(0.159),
	ElbowR(0.161),
	WristL(),
	WristR(),
	ThumbL(41.888, 0, 0, -2.933, 0, TargetActor.Null, "Null"),
	ThumbR(23.806, 0, 0, -20, 0, TargetActor.Null, "Null"),
	KneeL(1),
	KneeR(0.663),
	SpineRot()
) end


function SitDown2() return Preset(
	Hips(WPos(0.004, 0.164, -0.033)),
	HipsRot(21.05, 0, -3.65),
	Head(-0.006, 0.981, -0.194),
	HeadRot(359.888, 353.428, 351.967),
	FootL(WSurface(TPos(-0.561, -0.011, 0.733), 0.022, -1, -0.01)),
	FootR(WSurface(TPos(0.153, 0.005, 0.695), 0.022, -1, -0.01)),
	HandL(HPos(-0.163, 0.117, 0.766), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.046, 0.16, 0.7), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(0.159),
	ElbowR(0.161),
	WristL(-29.501, 0, -64.495),
	WristR(-32.087, 0, -35.858),
	KneeL(1),
	KneeR(0.663),
	SpineRot(),
	Mouth(-0.501, -0.11, 0, 0.384, 0.384, -0.238, -0.238, 0.117, 0.117, -0.813, -0.813),
	Brows(1.5, 1.5, 1.5, 1.5),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(-0.98, -0.98)
) end

function LayDownBack1() return Preset(
	Hips(WPos(0, 0.054, 0.002)),
	HipsRot(),
	Head(0, -0.001, -1),
	HeadRot(273.152, 154.97, 200.383),
	FootL(WSurface(TPos(-0.063, -0.002, 1.405), 0, -1, 0)),
	FootR(WSurface(TPos(0.123, -0.002, 1.531), 0, -1, 0)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", 0.439, -0.243, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(13.083, 34.731, 34.731, -20, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", 0.459, 0.242, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 24.329, 24.329, -20, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-0.649),
	ElbowR(-0.604),
	WristL(),
	WristR(14.452, 0, -53.187),
	KneeL(),
	KneeR(),
	SpineRot()
) end

function LayDownSideR() return Preset(
	Hips(WPos(0.016, 0.131, 0.044)),
	HipsRot(-4.45, 85.875, 23.725),
	Head(0.016, 0.1, 0.995),
	HeadRot(348.594, 116.937, 14.724),
	FootL(WPos(0.142, 0.066, -0.996)),
	FootR(WPos(-0.118, 0.089, -0.636)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Head", 1.322, -0.699, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(-2.078, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexL(-35, 55.832, 55.832, 0, 0, TargetActor.Null, "Null"),
	MidL(-14.144, 41.581, 41.581, 0, 0, TargetActor.Null, "Null"),
	RingL(-21.42, 66.818, 66.818, 0, 0, TargetActor.Null, "Null"),
	PinkyL(-35, 76.617, 76.617, 0, 0, TargetActor.Null, "Null"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.912, -0.462, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	ElbowL(0.649),
	ElbowR(-1),
	WristL(71.308, 0, 112.063),
	WristR(),
	KneeL(0.073),
	KneeR(0.582),
	SpineRot(90)
) end

function LayDownSideL() return Preset(
	Hips(WPos(0.017, 0.13, 0.061)),
	HipsRot(-1.45, -85.875, -18.65),
	Head(0.012, 0.064, 0.998),
	HeadRot(6, 270, 343.5),
	FootL(WPos(0.162, 0.1, -0.676)),
	FootR(WPos(-0.109, 0.057, -1.015)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", 0.37, -0.184, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Head", 1.449, 0.293, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(-2.078, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexR(-35, 55.832, 55.832, 0, 0, TargetActor.Null, "Null"),
	MidR(-14.144, 41.581, 41.581, 0, 0, TargetActor.Null, "Null"),
	RingR(-21.42, 66.818, 66.818, 0, 0, TargetActor.Null, "Null"),
	PinkyR(-35, 76.617, 76.617, 0, 0, TargetActor.Null, "Null"),
	ElbowL(-1),
	ElbowR(0.873),
	WristL(),
	WristR(-70, 0, 15.718),
	KneeL(0.876),
	KneeR(0.37),
	SpineRot(-90)
) end

function LaydownStomach1() return Preset(
	Hips(WPos(0, 0.129, 0.107)),
	HipsRot(25.35, 0, -5.775),
	Head(0.004, 0.38, 0.925),
	HeadRot(356.044, 8.207, 6.792),
	FootL(WSurface(TPos(-0.129, 0.091, -1.549), 0.003, -1, -0.003)),
	FootR(WSurface(TPos(-0.062, 0.091, -1.312), 0.003, -1, -0.003)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Head", 0.24, -0.196, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	HandR(WSurface(WPos(0.099, 0.041, 0.633), 0.024, -1, 0.001), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(-0.17),
	ElbowR(0.137),
	WristL(),
	WristR(),
	ThumbL(37.522, 0, 0, -20, 0, TargetActor.Null, "Null"),
	IndexL(19.459, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(31.67, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(37.202, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(35.31, 95, 95, 0, 0, TargetActor.Null, "Null"),
	KneeL(),
	KneeR(),
	SpineRot()
) end

function All41() return Preset(
	Hips(WPos(0.001, 0.436, -0.148)),
	HipsRot(35, 0, -0.65),
	Head(-0.006, 0.199, 0.98),
	HeadRot(15.932, 1, 11.496),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.199, 0.083, -0.702), 0, -1)),
	FootR(WSurface(TPos(0.026, 0.081, -0.718), 0, -1)),
	HandL(WSurface(WPos(-0.103, 0.072, 0.36), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.152, 0.072, 0.336), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(),
	ElbowR(),
	WristL(),
	WristR(),
	KneeL(),
	KneeR(),
	SpineRot()
) end

function All42() return Preset(
	Hips(WPos(0.001, 0.436, -0.148)),
	HipsRot(35, 0, -0.65),
	Head(-0.006, 0.199, 0.98),
	HeadRot(30.923, 331.6, 331.464),
	FootL(WSurface(TPos(-0.623, -0.018, -0.336), 0.024, -1, 0.002)),
	FootR(WSurface(TPos(0.646, 0.013, -0.348), 0.024, -1, 0.002)),
	HandL(WSurface(WPos(-0.103, 0.072, 0.36), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Head", 0.534, -0.009, 0.03), Wrist(HPoint(0, 0, 0.3, 0, 0, 0, "Bone_Index3_L"), 70)),
	ThumbR(30, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	RingR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	PinkyR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	ElbowL(),
	ElbowR(-0.12),
	WristL(),
	WristR(-54.175, 6.846, 22.653),
	KneeL(1),
	KneeR(1),
	SpineRot(),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(-0.187, -0.187, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1)
) end

function BendOver1() return Preset(
	Hips(WPos(0.003, 0.866, -0.137)),
	HipsRot(28.325, 0, -1.625),
	Head(-0.019, 0.323, 0.946),
	HeadRot(356.908, 359.26, 3.669),
	FootL(WSurface(TPos(-0.527, -0.003, -0.127), 0.003, -1, 0.004)),
	FootR(WSurface(TPos(0.558, -0.001, -0.16), 0.003, -1, 0.004)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", 0.433, -0.244, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", 0.443, 0.257, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-0.462),
	ElbowR(-0.488),
	WristL(),
	WristR(),
	KneeL(0.464),
	KneeR(0.298),
	SpineRot()
) end

function BJGesture() return Preset(
	Head(0.003, 0.99, -0.141),
	HeadRot(339.125, 0.561, 358.715),
	HandR(HPos(-0.202, 0.283, 0.53), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(29.379, 25.081, 25.081, 7.61, 0, TargetActor.Null, "Null"),
	IndexR(39.592, 57.582, 57.582, 0, 0, TargetActor.Null, "Null"),
	MidR(26.641, 39.147, 39.147, 0, 0, TargetActor.Null, "Null"),
	RingR(11.97, 37.14, 37.14, 0, 0, TargetActor.Null, "Null"),
	PinkyR(-23.703, 36.128, 36.128, 0, 0, TargetActor.Null, "Null"),
	Mouth(-1, 0.093, 0, 0.504, 0.504, -0.062, -0.062, 0.664, 0.664, 1, 1, 0, 0, 0.9, 0, 0.45),
	ElbowR(-0.149),
	WristR(-49.596, 0, -3.297),
	SpineRot()
	-- Head(0.003, 0.99, -0.141),
	-- HeadRot(339.125, 0.561, 358.715),
	-- HandR(HPos(-0.305, 0.301, 0.415), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	-- ThumbR(29.379, 25.081, 25.081, 7.61, 0, TargetActor.Null, "Null"),
	-- IndexR(39.592, 57.582, 57.582, 0, 0, TargetActor.Null, "Null"),
	-- MidR(26.641, 39.147, 39.147, 0, 0, TargetActor.Null, "Null"),
	-- RingR(11.97, 37.14, 37.14, 0, 0, TargetActor.Null, "Null"),
	-- PinkyR(-23.703, 36.128, 36.128, 0, 0, TargetActor.Null, "Null"),
	-- Mouth(-1, 0.093, 0, 0.504, 0.504, -0.062, -0.062, 0.664, 0.664, 0.999, 0.999, 0, 0, 0.9, 0, 0.45),
	-- ElbowR(-0.149),
	-- WristR(-57.67, 0, -41.878),
	-- SpineRot()
) end

function PeaceR() return Preset(
	HandR(HPos(0.281, 0.127, 0.335), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ElbowR(-0.79),
	WristR(-9.789, 0, -2.241),
	ThumbR(18.468, 58.721, 58.721, 0, 0, TargetActor.Null, "Null"),
	IndexR(9.437, 0, 0, 15.502, 0, TargetActor.Null, "Null"),
	MidR(6.788, 0, 0, -7.787, 0, TargetActor.Null, "Null"),
	RingR(85, 84.597, 84.597, -3.139, 0, TargetActor.Null, "Null"),
	PinkyR(85, 69.908, 69.908, -20, 0, TargetActor.Null, "Null")
) end

function PeaceL() return Preset(
	HandL(HPos(-0.281, 0.127, 0.335), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ElbowL(-0.79),
	WristL(-9.789, 0, -2.241),
	ThumbL(18.468, 58.721, 58.721, 0, 0, TargetActor.Null, "Null"),
	IndexL(9.437, 0, 0, 15.502, 0, TargetActor.Null, "Null"),
	MidL(6.788, 0, 0, -7.787, 0, TargetActor.Null, "Null"),
	RingL(85, 84.597, 84.597, -3.139, 0, TargetActor.Null, "Null"),
	PinkyL(85, 69.908, 69.908, -20, 0, TargetActor.Null, "Null")
) end

function Shush() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Head", 0.534, -0.009, 0.03), Wrist(HPoint(0, 0, 0.3, 0, 0, 0, "Bone_Index3_L"), 70)),
	ThumbR(30, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	RingR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	PinkyR(80, 80, 80, 0, 0, TargetActor.Null, "Null"),
	ElbowR(-0.12),
	WristR(-54.175, 6.846, 22.653)
) end

function HandsClosed() return Preset(
	ThumbL(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	ThumbR(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

function HandsClosed_Half() return Preset(
	ThumbL(-11.683, 76.509, 76.509, 20, 0, TargetActor.Null, "Null"),
	IndexL(25.866, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(23.326, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(18.054, 91.067, 91.067, 0, 0, TargetActor.Null, "Null"),
	PinkyL(9.84, 85.133, 85.133, 0, 0, TargetActor.Null, "Null"),
	ThumbR(-11.683, 76.509, 76.509, 20, 0, TargetActor.Null, "Null"),
	IndexR(25.866, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(23.326, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(18.054, 91.067, 91.067, 0, 0, TargetActor.Null, "Null"),
	PinkyR(9.84, 85.133, 85.133, 0, 0, TargetActor.Null, "Null")
) end

function HandsOpen() return Preset(
	ThumbR(),
	ThumbL(),
	IndexL(),
	MidL(),
	RingL(),
	PinkyL(),
	IndexR(),
	MidR(),
	RingR(),
	PinkyR()
) end

function HandsOpen_2() return
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest")
end

function HandsOpen_Claw() return
	ThumbL(0, 0, 74, 32, 0, TargetActor.Null, "Null"),
	IndexL(28, 28, 24, 36, 0, TargetActor.Null, "Null"),
	MidL(12, 24, 22, 0, 0, TargetActor.Null, "Null"),
	RingL(0, 22, 44, -16, 0, TargetActor.Null, "Null"),
	PinkyL(8, 12, 38, -36, 0, TargetActor.Null, "Null"),
	ThumbR(0, 0, 74, 32, 0, TargetActor.Null, "Null"),
	IndexR(28, 28, 24, 36, 0, TargetActor.Null, "Null"),
	MidR(12, 24, 22, 0, 0, TargetActor.Null, "Null"),
	RingR(0, 22, 44, -16, 0, TargetActor.Null, "Null"),
	PinkyR(8, 12, 38, -36, 0, TargetActor.Null, "Null")
end

function GrabHead() return Preset(
	HandL(BoneMesh(TargetActor.A, "Bone_Head", 1.638, 0.618, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(33.553, 14.859, 14.859, 0, 0, TargetActor.Null, "Null"),
	IndexL(52.444, 19.081, 19.081, 0, 0, TargetActor.Null, "Null"),
	MidL(51.016, 15.795, 15.795, 0, 0, TargetActor.Null, "Null"),
	RingL(53.027, 0, 0, 0, 0, TargetActor.Null, "Null"),
	PinkyL(48.639, 0, 0, 0, 0, TargetActor.Null, "Null"),
	HandR(BoneMesh(TargetActor.A, "Bone_Head", 1.638, -0.618, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(33.553, 14.859, 14.859, 0, 0, TargetActor.Null, "Null"),
	IndexR(52.444, 19.081, 19.081, 0, 0, TargetActor.Null, "Null"),
	MidR(51.016, 15.795, 15.795, 0, 0, TargetActor.Null, "Null"),
	RingR(53.027, 0, 0, 0, 0, TargetActor.Null, "Null"),
	PinkyR(48.639, 0, 0, 0, 0, TargetActor.Null, "Null")
) end

function Beckon() return Preset(
	HandR(HPos(-0.206, 0.194, 0.657), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ElbowR(-0.79),
	WristR(16.705, 6.846, 87.288),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20.668, 41.352, 41.352, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 81.625, 81.625, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

----------------------------------------------------------------


--version 0.2M
--FAUN Body Presets

--[[
function ()

end
--]]

function Doggystyle_Exhausted() return
	Hips(WPos(0, 0.435, 0.532)),
	HipsRot(),
	Head(0, -0.508, 0.861),
	HeadRot(5.104, 287.756, 280.078),
	FootL(WSurface(TPos(-0.441, 0.169, 0.204), 0, -1)),
	FootR(WSurface(TPos(0.353, 0.169, 0.219), 0, -1)),
	HandL(WSurface(WPos(-0.057, 0.142, 0.299), 0, -1), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbL(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	HandR(WSurface(WPos(0.051, 0.142, 0.295), 0, -1), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbR(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ElbowL(),
	ElbowR(),
	WristL(-17.951, 0, 18.077),
	WristR(-23.211, 0, 13.316),
	KneeL(-0.288),
	KneeR(-0.235),
	SpineRot()
end

function Doggystyle_Bound() return
	Hips(WPos(0, 0.435, 0.532)),
	HipsRot(),
	Head(0, -0.508, 0.861),
	HeadRot(5.104, 287.756, 280.078),
	FootL(WSurface(TPos(-0.441, 0.169, 0.204), 0, -1)),
	FootR(WSurface(TPos(0.353, 0.169, 0.219), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.3, 0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbL(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.3, -0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbR(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ElbowL(0.26),
	ElbowR(0.26),
	WristL(68.619, 0, -76.201),
	WristR(62.219, 0, -52.779),
	KneeL(-0.288),
	KneeR(-0.235),
	SpineRot()
end

function Squat() return
	Hips(WPos(0, 0.737, 0.099)),
	HipsRot(),
	Head(0, 0.999, 0.036),
	HeadRot(356.908, 359.26, 3.669),
	FootL(WSurface(TPos(-0.441, 0.169, 0.204), 0, -1)),
	FootR(WSurface(TPos(0.353, 0.169, 0.219), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.6, 0.9, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.5, -0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(0.26),
	ElbowR(0.26),
	WristL(-25, 0, -65),
	WristR(-25, 0, -70),
	KneeL(-0.288),
	KneeR(-0.235),
	SpineRot()
end

function Hanging_1() return
	Hips(WPos(0.003, 0.7, -0.443)),
	HipsRot(34.925, 0, -2.675),
	Head(-0.008, -0.762, -0.647),
	HeadRot(40.176, 191.895, 198.894),
	FootL(WPos(-0.184, 1.433, -0.129)),
	FootR(WPos(0.241, 1.432, -0.139)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.875, 0.018, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	ThumbL(20.986, 17.981, 17.981, -20, 0, TargetActor.Null, "Null"),
	IndexL(52.697, 0, 0, -20, 0, TargetActor.Null, "Null"),
	RingL(51.598, 0, 0, 6.644, 0, TargetActor.Null, "Null"),
	PinkyL(20, 19.583, 19.583, 9.336, 0, TargetActor.Null, "Null"),
	HandR(WSurface(WPos(0.033, -0.061, -0.695), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(0.691),
	ElbowR(),
	WristL(44.826, 0, -67.941),
	WristR(),
	KneeL(-0.475),
	KneeR(-0.415),
	SpineRot()
end

function Handstand_1() return
	Hips(WPos(-0.001, 0.92, -0.694)),
	HipsRot(-15.525, 0, 4.275),
	Head(0.001, -1, -0.028),
	HeadRot(353.29, 185.342, 185.648),
	FootL(WPos(-0.193, 1.539, -0.485)),
	FootR(WPos(0.228, 1.577, -0.488)),
	HandL(WSurface(WPos(-0.17, -0.061, -0.7), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.17, -0.061, -0.7), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(),
	ElbowR(),
	WristL(),
	WristR(),
	KneeL(-0.262),
	KneeR(-0.18)
end

function Handstand_2() return
	Hips(WPos(-0.001, 0.899, -0.696)),
	HipsRot(1.75),
	Head(0.001, -1, -0.025),
	HeadRot(353.29, 185.342, 185.648),
	FootL(WPos(-0.21, 1.9, -0.84)),
	FootR(WPos(0.21, 1.9, -0.84)),
	HandL(WSurface(WPos(-0.17, -0.061, -0.7), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.17, -0.061, -0.7), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(-1),
	ElbowR(-1),
	WristL(),
	WristR(),
	KneeL(0.27),
	KneeR(0.27)
end

function Eiffel() return
	Hips(WPos(0, 0.586, -0.294)),
	HipsRot(1.75),
	Head(0, -0.446, -0.895),
	HeadRot(353.29, 185.342, 185.648),
	FootL(WSurface(TPos(-0.285, -0.091, 0.005), 0, -1)),
	FootR(WSurface(TPos(0.289, -0.067, 0.046), 0, -1)),
	HandL(WSurface(WPos(-0.171, -0.061, -0.699), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.164, -0.061, -0.704), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(-1),
	ElbowR(-1),
	WristL(0.898, 0, 29.104),
	WristR(-10.099, 0, -8.624),
	KneeL(0.272),
	KneeR(0.242),
	SpineRot()
end

function BendOver_Lean() return
	Hips(WPos(0, 0.74, -0.376)),
	HipsRot(1.75),
	Head(-0.001, 0.033, 0.999),
	HeadRot(30.28, 1.281, 10.755),
	FootL(WSurface(TPos(-0.285, -0.091, 0.005), 0, -1)),
	FootR(WSurface(TPos(0.289, -0.067, 0.046), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Thigh_L", 0.844, 0.207, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", 0.871, -0.328, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	KneeL(1),
	KneeR(1),
	SpineRot()
end

function BendOver_Spread() return
	Hips(WPos(0, 0.749, -0.097)),
	HipsRot(1.75),
	Head(-0.001, 0.204, 0.979),
	HeadRot(30.28, 1.281, 10.755),
	FootL(WSurface(TPos(-0.285, -0.091, 0.005), 0, -1)),
	FootR(WSurface(TPos(0.289, -0.067, 0.046), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Thigh_L", -0.5, -0.856, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", -0.42, 0.871, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	KneeL(1),
	KneeR(1),
	SpineRot()
end

function HandsInfront_1() return Preset(
	HandL(HPos(0.2, -0.63, 0.6), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.2, -0.63, 0.6), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ElbowL(),
	ElbowR(),
	WristL(-62.313, 0, 35.937),
	WristR(-49.048, 0, 17.218)
) end

function HandsInfront_2() return Preset(
	HandL(HPos(0.2, -0.63, 0.45), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.2, -0.63, 0.45), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ElbowL(),
	ElbowR(),
	WristL(-62.313, 0, 35.937),
	WristR(-49.048, 0, 17.218)
) end

-- flash
--
-- function HandsInfront_1() return Preset(
-- 	HandL(HPos(-0.1, 0.921, 0.709), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
-- 	ThumbL(14.977, 95, 95, -14.32, 0, TargetActor.Null, "Null"),
-- 	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
-- 	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
-- 	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
-- 	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
-- 	ElbowL(),
-- 	WristL(-49.048, 0, 17.218),
-- 	HandR(HPos(0.1, 0.921, 0.709), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
-- 	ThumbR(14.977, 95, 95, -14.32, 0, TargetActor.Null, "Null"),
-- 	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
-- 	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
-- 	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
-- 	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
-- 	ElbowR(),
-- 	WristR(-49.048, 0, 17.218)
-- ) end

function HandsBehind1() return Preset(
	ElbowL(0.26),
	ElbowR(0.26),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.3, 0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.3, -0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	WristL(68.619, 0, -76.201),
	WristR(62.219, 0, -52.779),
	ThumbL(6.232, 69.101, 69.101, 10.208, 0, TargetActor.Null, "Null"),
	ThumbR(6.232, 69.101, 69.101, 10.208, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

function HandsBehind2() return Preset(
	ElbowL(0.26),
	ElbowR(0.26),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.6, 0.9, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.5, -0.87, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	WristL(-25, 0, -65),
	WristR(-25, 0, -70),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null")
) end

function HandsBehind3() return Preset(
	HandL(HPos(0.349, -0.747, -0.516), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	HandR(HPos(-0.394, -0.808, -0.45), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(6.232, 69.101, 69.101, 10.208, 0, TargetActor.Null, "Null"),
	ThumbR(6.232, 69.101, 69.101, 10.208, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ElbowL(0.2),
	ElbowR(0.26),
	WristL(-20.36, 0, -21.125),
	WristR(10.872, 0, -22.867)
) end

-- function HandsBehind4() return Preset(

-- ) end

function HandsHeels() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Foot_L", -0.43, 0.907, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Foot_R", -0.45, -0.868, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Foot_R")
) end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--FAUN Face Presets

function TongueOut() return Preset(
	Mouth(-1, 0, 0, 0.504, 0.504, -1, -1, 0.675, 0.675, 0.999, 0.999, 0, 0, 1, 0, -1),
	--Mouth(-1, 0.196, 0, 0.504, 0.504, 0, 0, 1, 1, 0.451, 0.451, 0, 0, 0.66, 0, 0.44),
	Brows(1, 1, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1)
) end

function TongueOut2() return Preset(
	Mouth(-1.25, 0, 0, 0, 0, -1, -1, 0.5, 0.5, 1, 1, 0, 0, 1.5, 0.25, -2.5),
	--Mouth(-1, 0.196, 0, 0.504, 0.504, 0, 0, 1, 1, 0.451, 0.451, 0, 0, 0.66, 0, 0.44),
	Brows(1, 1, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1)
) end

function TongueOut3() return Preset(
	Mouth(-1, 0, 0, 0.504, 0.504, -1, -1, 0.675, 0.675, 0.999, 0.999, 0, 0, 2, 0, -1.5),
	--Mouth(-1, 0.196, 0, 0.504, 0.504, 0, 0, 1, 1, 0.451, 0.451, 0, 0, 0.66, 0, 0.44),
	Brows(1, 1, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1)
) end

function GritTeeth() return Preset(
	Mouth(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0)
) end

function GritTeeth2() return Preset(
	Mouth(0, -0.271, 0, 1, 1, -1, -1, 0.328, 0.328, 1, 1, 0, -1),
	Brows(-1, -1, -0.543, -1),
	EyelidL(-0.254),
	EyelidR(0.406),
	Cheeks(1, 1)
) end

function Pog() return Preset(
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, 0, 2, 0, 0, 0)
) end

function Kiss1() return Preset(
	Mouth(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, -1.2, 1.2, 0, 0, 0)
) end

function Kiss2() return Preset(
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1)
) end

function Kiss3() return Preset( --kiss
	Mouth(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, -1.2, 1.2, 0, 0, 0)
) end
function Kiss4() return Preset(
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 2)
) end

function Pursedlips() return Preset(
	Mouth(0, 0, 0, 0, 0, 0.678, 0.678, 0.238, 0.238, 1, 1, 1)
) end

function Pursedsmile() return Preset(
	Mouth(0, 0, 0, 0, 0, -0.35, -0.35, 1, 1, 1, 1, 1.2)
) end

function Lipbite() return Preset(
	Mouth(-0.12, -0.112, 0, 1, 0.314, -0.061, 1, 0.833, 0.833, 0.5, 0.5, 1.2),
	Brows(1.2, 1.2, -0.745, -0.745),
	EyelidL(0.184),
	EyelidR(0.184),
	Cheeks(-1, -1)
) end

function Lipbite2() return Preset(
	Brows(1, 1, -0.745, -0.745),
	EyelidL(-0.5),
	EyelidR(-0.5),
	Cheeks(1, 1)
) end

function FaceNervous() return Preset(
	Mouth(0.25, 0, 0, 0, 0, 0, 0, 0, 0, 1.5, 1, 1),
	Brows(2.75, 2.75),
--	EyelidL(-0.35),
--	EyelidR(-0.35),
	EyelidL(0),
	EyelidR(0),
	Cheeks(1, 1)
) end

function FaceDisappointed() return Preset(
	Mouth(0, 0, 0, 0, 0, 0.223, 0.223, -1, -1, 0.196, 0.196, 1.2),
	Brows(0.28, 0.28, -1, -1),
	EyelidL(0.184),
	EyelidR(0.184),
	Cheeks(-1, -1)
) end

function FaceUnimpressed() return Preset(
	Mouth(0, 0, 0, 0, 0, 0.223, 0.223, -0.169, 0.248, 0.634, 1, 1.2),
	Brows(1.5, 1.5),
--	EyelidL(0.184),
--	EyelidR(0.184),
	EyelidL(1),
	EyelidR(1),
	Cheeks(-1, -1)
) end

function FaceDisappointed2() return Preset(
	Mouth(0, 0, 0, 0, 0, 0.223, 0.223, -1, -1, 0.196, 0.196, 1.2),
	Brows(-1, -1, 1, 1),
	EyelidL(0.3),
	EyelidR(0.3),
	Cheeks(1, 1)
) end

function FaceDisappointed3() return Preset(
	Mouth(0, 0, 0, 0, 0, 0.223, 0.223, -1, -1, 0.196, 0.196, 1.2),
	Brows(0.28, 0.28, -1, -1),
	EyelidL(0.6),
	EyelidR(0.6),
	Cheeks(1, 1)
) end

--function FaceDisappointed2() return Preset(
--	Mouth(0, 0, 0, 0, 0, 0.223, 0.223, -1, -1, 0.196, 0.196, 1.2),
--	Brows(0.28, 0.28, -1, -1),
--	EyelidL(0.8),
--	EyelidR(0.8),
--	Cheeks(-1, -1)
--) end

---------------
----------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------






-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Animation Loops


function LipLick_A() return --left
	Mouth(-0.75, 0, 0, 1.25, 1.25, -0.25, -0.25, 0, 0, 1, 0, 0, 0, 0.5, -1.75, 3)

end

function LipLick_B() return --up
	Mouth(-0.75, 0, 0, 1.25, 1.25, -0.25, -0.25, 0, 0, 1, 0, 0, 0, 0.5, 0, 3)

end

function LipLick_C() return --right
	Mouth(-0.75, 0, 0, 1.25, 1.25, -0.25, -0.25, 0, 0, 1, 0.5, 0, 0, 0.5, 1.5, 3)

end

function footjob_1R_a() return --right
	FootR(WPos(-0.002, 0.297, 0.42))
end

function footjob_1R_b() return --right
	FootR(WPos(-0.006, 0.256, 0.26))
end


function footjob_sit_1R() return
	Hips(WPos(0.005, 0.035, -0.025)),
	HipsRot(-3.7, 0, -8.525),
	Head(-0.006, 0.836, -0.549),
	HeadRot(323.63, 305.38, 35.026),
	FootL(WPos(-0.028, 0.184, 0.775)),
	FootR(WPos(0.036, 0.413, 0.825)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Spine", 0.211, -0.219, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Spine"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Spine"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Spine"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Spine"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Spine"),
	HandR(WSurface(WPos(0.327, 0.168, -0.021), 0.382, -0.919, -0.094), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(-0.054),
	ElbowR(0.678),
	WristL(-36.295, 0, 24.165),
	WristR(),
	KneeL(-0.155),
	KneeR(0.057),
	SpineRot(),
	Mouth(0, 0, 0, 0, 0, 0, 0, 0.812, 0.985, 0.596, 1),
	Brows(),
	EyelidL(),
	EyelidR(),
	Cheeks()
end

function footjob_sit_1R_A() return
	FootR(WPos(0.031, 0.118, 0.666))
end

function footjob_sit_1R_B() return
	FootR(WPos(0.011, 0.217, 0.766))
end

function footjob_sit_1R_C() return
	FootR(WPos(0.034, 0.079, 0.673))
end

function footjob_sit_1R_D() return
	FootR(WPos(0.057, 0.136, 0.751))
end

function footjob_sit_1R_E() return
	FootR(WPos(0.025, 0.067, 0.651))
end

function footjob_sit_1R_F() return
	FootR(WPos(0.054, 0.15, 0.76))
end

function footjob_modular_1Ra() return
	FootR(TPos(AnimInc_Feet1_Pose1, AnimInc_Feet2_Pose1, AnimInc_Feet3_Pose1))
end

function footjob_modular_1Rb() return
	FootR(TPos(AnimInc_Feet3_Pose2, AnimInc_Feet3_Pose2, AnimInc_Feet3_Pose2))
end

function footjob_modular_1Rc() return
	FootR(TPos(AnimInc_Feet3_Pose3, AnimInc_Feet3_Pose3, AnimInc_Feet3_Pose3))
end

function footjob_modular_1Rd() return
	FootR(TPos(AnimInc_Feet3_Pose4, AnimInc_Feet3_Pose4, AnimInc_Feet3_Pose4))
end

function Gropebreast_La() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.882, 0.678, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	ElbowL(-0.15)
) end

function Gropebreast_Lb() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.823, 0.423, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	ElbowL(-0.15)
) end

function Gropebreast_Lc() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.834, -0.124, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	ElbowL(-0.15)
) end

function Gropebreast_Ld() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.797, 0.258, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	ElbowL(-0.15)
) end

function Gropebreast_Le() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.809, 0.081, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	ElbowL(-0.15)
) end

function Gropebreast_Lf() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Breast_L", 0.98, -0.102, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	ElbowL(-0.15)
) end

function Gropebreast_2La() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", -0.20, -0.265, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-1)
) end

function Gropebreast_2Lb() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", -0.19, -0.186, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-1)
) end

function GropebreastBoth1a() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", -0.19, -0.186, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-1),
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", -0.19, 0.186, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowR(-1)
) end

function GropebreastBoth1b() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", -0.19, -0.186, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-1),
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", -0.20, 0.265, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowR(-1)
) end

function Gropebreast_2Ra() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", -0.19, 0.186, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowR(-1)
) end

function Gropebreast_2Rb() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", -0.20, 0.265, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowR(-1)
) end


function Gropebreast_Ra() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Breast_R", 0.882, 0.678, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	ElbowR(-0.15)
) end

function Gropebreast_Rb() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Breast_R", 0.823, 0.423, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	ElbowR(-0.15)
) end

function Gropebreast_Rc() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Breast_R", 0.834, -0.124, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	ElbowR(-0.15)
) end

function Gropebreast_Rd() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Breast_R", 0.797, 0.258, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	ElbowR(-0.15)
) end

function Gropebreast_Re() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Breast_R", 0.809, 0.081, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	ElbowR(-0.15)
) end

function Gropebreast_Rf() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Breast_R", 0.98, -0.102, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Breast_R"),
	ElbowR(-0.15)
) end

function Bjgesture_Ra() return Preset(
	HandR(HPos(-0.231, 0.23, 0.536), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	WristR(-67.945, 0, 5.025),
	ThumbR(29.379, 25.081, 25.081, 7.61, 0, TargetActor.Null, "Null"),
	IndexR(39.592, 57.582, 57.582, 0, 0, TargetActor.Null, "Null"),
	MidR(26.641, 39.147, 39.147, 0, 0, TargetActor.Null, "Null"),
	RingR(11.97, 37.14, 37.14, 0, 0, TargetActor.Null, "Null"),
	PinkyR(-23.703, 36.128, 36.128, 0, 0, TargetActor.Null, "Null")
) end

function Bjgesture_Rb() return Preset(
	HandR(HPos(-0.228, 0.27, 0.37), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(44.204, 32.505, 32.505, 20, 0, TargetActor.Null, "Null"),
	IndexR(53.587, 44.094, 44.094, -1.607, 0, TargetActor.Null, "Null"),
	MidR(46.074, 58.696, 58.696, 0, 0, TargetActor.Null, "Null"),
	RingR(38.248, 51.718, 51.718, 0, 0, TargetActor.Null, "Null"),
	PinkyR(27.866, 57.938, 57.938, 0, 0, TargetActor.Null, "Null"),
	WristR(-61.945, 0, -31.859)
) end

function FingeringMRl3() return Preset(
	ThumbL(6.43, 95, 95, -20, 0, TargetActor.Null, "Null"),
	IndexL(-35, 0, 0, -8.486, 0, TargetActor.Null, "Null"),
	PinkyL(-34.744, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidL(34.929, 83.764, 83.764, -20, 0, TargetActor.Null, "Null"),
	RingL(32.593, 88.095, 88.095, 6.577, 0, TargetActor.Null, "Null")
) end

function FingeringMRl4() return Preset(
	ThumbL(6.43, 95, 95, -20, 0, TargetActor.Null, "Null"),
	IndexL(-35, 0, 0, -8.486, 0, TargetActor.Null, "Null"),
	PinkyL(-34.744, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidL(61.766, 95, 95, -20, 0, TargetActor.Null, "Null"),
	RingL(60.857, 88.742, 88.742, 6.577, 0, TargetActor.Null, "Null")
) end

function FingeringMRr3() return Preset(
	ThumbR(6.43, 95, 95, -20, 0, TargetActor.Null, "Null"),
	IndexR(-35, 0, 0, -8.486, 0, TargetActor.Null, "Null"),
	PinkyR(-34.744, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(34.929, 83.764, 83.764, -20, 0, TargetActor.Null, "Null"),
	RingR(32.593, 88.095, 88.095, 6.577, 0, TargetActor.Null, "Null")
) end

function FingeringMRr4() return Preset(
	ThumbR(6.43, 95, 95, -20, 0, TargetActor.Null, "Null"),
	IndexR(-35, 0, 0, -8.486, 0, TargetActor.Null, "Null"),
	PinkyR(-34.744, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(61.766, 95, 95, -20, 0, TargetActor.Null, "Null"),
	RingR(60.857, 88.742, 88.742, 6.577, 0, TargetActor.Null, "Null")
) end

function TouchHerself_Ra() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.746, -0.129, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips")
) end

function TouchHerself_Rb() return Preset(
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.899, -0.061, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips")
) end

function TouchHerself_La() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.746, 0.129, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips")
) end

function TouchHerself_Lb() return Preset(
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.899, 0.061, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips")
) end

function Beckon_Ra() return Preset(
	ThumbR(51.491, 52.955, 52.955, 0, 0, TargetActor.Null, "Null"),
	IndexR(20.668, 41.352, 41.352, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 81.625, 81.625, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

function Beckon_Rb() return Preset(
	ThumbR(51.491, 52.955, 52.955, 0, 0, TargetActor.Null, "Null"),
	IndexR(-8.691, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 81.625, 81.625, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

function Slap_Ra() return Preset(
	HandR(HPos(0.804, 0.071, 0.177), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	IndexR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	RingR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	PinkyR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	ElbowR(0.222),
	WristR(-11.997, 0, 18.248)
) end

function Slap_Rb() return Preset(
	HandR(HPos(-0.007, -0.855, 0.746), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(-35, 55.782, 55.782, -20, 0, TargetActor.Null, "Null"),
	IndexR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	RingR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	PinkyR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	ElbowR(0.26),
	WristR(4.315, 0, 53.94)
) end

function HipSway_A() return Preset(
	Hips(WPos(0.078, 0.854, 0.427)),
	Head(-0.199, 0.152, 0.968)
) end

function HipSway_B() return Preset(
	Hips(WPos(-0.021, 0.853, 0.421)),
	Head(0.063, 0.155, 0.986)
) end

function LookAwayR() return Preset(
	EyeL(WorldPos(-5.033, 0.667, -2.39)),
	EyeR(WorldPos(-5.033, 0.667, -2.39))
) end


-------------------------------------------------------------

