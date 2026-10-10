AddStep = module.AddStep
AddChoice = module.AddChoice
Call = module.LuaStackCall
Jump = module.LuaStackJump
Return = module.StackReturn
ReturnContinue = module.StackReturnContinue
ReturnTo = module.StackReturnTo

Play_PointAndClick = game.Play_PointAndClick
Play_Posing = game.Play_Posing
Play_FreeMode = game.Play_FreeMode
PoseCam = game.PoseCam
StoryCam = game.StoryCam

-- New-format poses use `camera.PoseCam(...).FOV(n).FocalLength(n).Bloom(n)`.
-- `camera` is registered as a Lua global pointing to the MainCamera instance (see Module.cs / Lua.cs).
-- The chain methods (FOV / FocalLength / Bloom) are C# methods on MainCamera that return `this`.
Human = game.Human
Music = game.Music
StopMusic = game.StopMusic

FSurface = MotionPresets.FSurface
Ankle = MotionPresets.Ankle
HPoint = MotionPresets.HPoint
Wrist = MotionPresets.Wrist
TPos = MotionPresets.TPos
HPos = MotionPresets.HPos
WSurface = MotionPresets.WSurface
BoneMesh = MotionPresets.BoneMesh
FootL = MotionPresets.FootL
FootR = MotionPresets.FootR
HandL = MotionPresets.HandL
HandR = MotionPresets.HandR

ThumbL = MotionPresets.ThumbL
IndexL = MotionPresets.IndexL
MiddleL = MotionPresets.MidL
MidL = MotionPresets.MidL
RingL = MotionPresets.RingL
PinkyL = MotionPresets.PinkyL
ThumbR = MotionPresets.ThumbR
IndexR = MotionPresets.IndexR
MiddleR = MotionPresets.MidR
MidR = MotionPresets.MidR
RingR = MotionPresets.RingR
PinkyR = MotionPresets.PinkyR

EyelidL = MotionPresets.EyelidL
EyelidR = MotionPresets.EyelidR
Mouth = MotionPresets.Mouth
Brows = MotionPresets.Brows
Cheeks = MotionPresets.Cheeks
Nose = MotionPresets.Nose
EyeL = MotionPresets.EyeL
EyeR = MotionPresets.EyeR
ElbowL = MotionPresets.ElbowL
ElbowR = MotionPresets.ElbowR
WristL = MotionPresets.WristL
WristR = MotionPresets.WristR
AnkleL = MotionPresets.AnkleL
AnkleR = MotionPresets.AnkleR
KneeL = MotionPresets.KneeL
KneeR = MotionPresets.KneeR

Head = MotionPresets.Head
HeadRot = MotionPresets.HeadRot
Hips = MotionPresets.Hips
HipsRot = MotionPresets.HipsRot
SpineRot = MotionPresets.SpineRot
Finger = MotionPresets.Finger
Pivot = MotionPresets.Pivot
PivotRot = MotionPresets.PivotRot
WorldPos = MotionPresets.WorldPos
WPos = MotionPresets.WPos
PivotPos = MotionPresets.PivotPos
Penis = MotionPresets.Penis
MapPoint = MotionPresets.MapPoint
Pos = MotionPresets.Pos
Rot = MotionPresets.Rot
FPos = MotionPresets.FPos

EyeContact = MotionPresets.EyeContact
CameraPos = MotionPresets.CameraPos
HeadLookAt = MotionPresets.HeadLookAt
NewClip = MotionClip.NewClip

PlaySound = game.PlaySound
PlaySoundAt = game.PlaySoundAt
Skybox = game.Skybox
Sun = game.Sun
Light = game.Light


Preset = MotionPresets.Preset;

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

Timer = game.GetGlobalTimer
ResetTimer = game.ResetGlobalTimer
Delayed = game.AddAnim
Fade = game.Fade

function StandUp() return Preset(
	Hips(0, 1),
	HipsRot(20.3, 0, 3.775),
	Head(-0.001, 0.987, -0.159),
	HeadRot(356.908, 359.26, 3.669),
	FootL(WSurface(TPos(-0.11, -0.006, 0.027), 0, -1, 0)),
	FootR(WSurface(TPos(0.196, -0.006, 0.032), 0, -1, 0)),
	HandL(HPos(-0.186, -1.083, -0.114), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(0.278, -1.039, -0.109), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	WristL(),
	WristR(),
	ElbowL(),
	ElbowR(),
	KneeL(),
	KneeR(),
	SpineRot()
) end

function KneelDown() return Preset(
	Hips(-0.001, 0.416, 0.172),
	HipsRot(22.175, 0, 3.85),
	Head(0.001, 0.969, -0.247),
	HeadRot(352.484, 354.454, 8.304),
	FootL(WSurface(TPos(-0.099, -0.015, -0.069), 0.024, -1, 0.001)),
	FootR(WSurface(TPos(0.124, -0.064, -0.102), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.525, 0.333, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.565, -0.317, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	WristL(),
	WristR(),
	ElbowL(),
	ElbowR(),
	KneeL(0.061),
	KneeR(0.115),
	SpineRot()
) end

function SitDown() return Preset(
	Hips(0.004, 0.2, -0.042),
	HipsRot(18.95, 0, -0.65),
	Head(-0.007, 0.999, 0.037),
	HeadRot(355.852, 359.582, 356.344),
	FootL(WSurface(TPos(-0.104, -0.005, 0.849), 0, -1, 0)),
	FootR(WSurface(TPos(0.256, -0.005, 0.694), 0, -1, 0)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Calf_L", -0.605, 0.321, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Calf_R", -0.339, -0.31, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_R"),
	WristL(),
	WristR(),
	ElbowL(-0.531),
	ElbowR(-1),
	KneeL(0.13),
	KneeR(0.419),
	SpineRot()
) end

function SitDownSpreadLegs() return Preset(
	Hips(WPos(0.005, 0.2, -0.084)),
	HipsRot(12.5, 0, 1.9),
	Head(0.001, 0.756, -0.654),
	HeadRot(343.261, 0.887, 356.367),
	FootL(WSurface(TPos(-0.517, -0.005, 0.506), 0, -1, 0)),
	FootR(WSurface(TPos(0.478, -0.005, 0.505), 0, -1, 0)),
	HandL(WSurface(WPos(-0.246, -0.004, -0.282), 0, -1, 0), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.252, -0.004, -0.314), 0, -1, 0), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	WristL(),
	WristR(),
	ElbowL(-0.531),
	ElbowR(-1),
	KneeL(-0.078),
	KneeR(-0.263),
	SpineRot()
) end

function LayDownBack() return Preset(
	Hips(0.003, 0.117, 0.06),
	HipsRot(12.725, 0, 3.625),
	Head(0.013, -0.178, -0.984),
	HeadRot(278.628, 6.238, 346.747),
	FootL(WPos(-0.033, 0.18, 1.08)),
	FootR(WPos(0.014, 0.14, 1.012)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", 0.337, -0.102, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.683, -0.275, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	WristL(),
	WristR(),
	ElbowL(-0.531),
	ElbowR(-1),
	KneeL(0.413),
	KneeR(0.14),
	SpineRot()
) end

function LayDownSide() return Preset(
	Hips(0.015, 0.12, 0.034),
	HipsRot(-4.45, -85.875, 23.725),
	Head(0.015, 0.078, -0.997),
	HeadRot(351.273, 286.242, 24.5),
	FootL(WPos(-0.142, 0.066, 0.996)),
	FootR(WPos(0.023, 0.048, 0.744)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Head", 1.002, -0.372, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", 0.368, -0.392, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	WristL(),
	WristR(),
	ElbowL(-0.459),
	ElbowR(-1),
	KneeL(0.112),
	KneeR(0.5),
	SpineRot(-90)
) end

function LaydownStomach() return Preset(
	Hips(0, 0.08, 0.102),
	HipsRot(25.35, 0, -5.775),
	Head(0.005, 0.437, 0.899),
	HeadRot(356.044, 8.207, 6.792),
	FootL(WSurface(TPos(-0.108, -0.005, -0.933), 0, -1, 0)),
	FootR(WSurface(TPos(-0.016, -0.005, -0.962), 0, -1, 0)),
	HandL(WSurface(WPos(0.11, -0.004, 0.695), 0, -1, 0), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.011, -0.004, 0.548), 0, -1, 0), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	WristL(),
	WristR(),
	ElbowL(0.45),
	ElbowR(0.127),
	KneeL(),
	KneeR(-0.033),
	SpineRot()
) end

function GetdownAll4() return Preset(
	Hips(WPos(0, 0.41, 0.011)),
	HipsRot(11.775, 0, -4.95),
	Head(0.005, 0.085, 0.996),
	HeadRot(338.391, 358.298, 354.525),
	FootL(WSurface(TPos(-0.135, -0.005, -0.684), 0, -1, 0)),
	FootR(WSurface(TPos(-0.001, -0.005, -0.702), 0, -1, 0)),
	HandL(WSurface(WPos(-0.131, -0.004, 0.431), 0, -1, 0), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.177, -0.004, 0.416), 0, -1, 0), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	WristL(),
	WristR(),
	ElbowL(-0.362),
	ElbowR(-0.928),
	KneeL(),
	KneeR(-0.033),
	SpineRot()
) end

function BendOver() return Preset(
	Hips(0.001, 0.89, -0.053),
	HipsRot(28.325, 0, -1.625),
	Head(-0.018, 0.51, 0.86),
	HeadRot(356.908, 359.26, 3.669),
	FootL(WSurface(TPos(-0.055, -0.005, 0.094), 0, -1, 0)),
	FootR(WSurface(TPos(0.038, -0.005, -0.033), 0, -1, 0)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Calf_L", -0.905, -0.076, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Calf_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", 0.762, 0.024, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	WristL(),
	WristR(),
	ElbowL(),
	ElbowR(),
	KneeL(0.464),
	KneeR(0.298),
	SpineRot()
) end

function CamelPose() return Preset(
	Hips(WPos(0.001, 0.424, -0.043)),
	HipsRot(22.175, 0, 3.85),
	Head(0.003, 0.188, -0.982),
	HeadRot(308.999, 359.656, 358.507),
	FootL(WSurface(TPos(-0.125, -0.005, -0.09), 0.003, -1, 0.004)),
	FootR(WSurface(TPos(0.124, -0.064, -0.102), 0, -1)),
	HandL(WSurface(WPos(-0.231, -0.006, -0.32), 0.003, -1, 0.004), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.229, -0.004, -0.279), 0.003, -1, 0.004), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(),
	ElbowR(),
	WristL(),
	WristR(),
	KneeL(0.061),
	KneeR(0.115),
	SpineRot()
) end

function LayDownBackSpread() return Preset(
	Hips(WPos(0.003, 0.101, 0.073)),
	HipsRot(-13.2, 0, 1.95),
	Head(0.013, 0.014, -1),
	HeadRot(307.158, 2.576, 354.668),
	FootL(WPos(-0.559, 0.748, 0.367)),
	FootR(WPos(0.33, 0.829, 0.46)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Thigh_L", 0.645, 0.764, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", 0.678, -0.502, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	ElbowL(-0.088),
	ElbowR(0.083),
	WristL(),
	WristR(),
	KneeL(0.019),
	KneeR(-0.244),
	SpineRot()
) end

function JackoPose() return Preset(
	Hips(WPos(0.003, 0.363, 0.16)),
	HipsRot(15.6, 0, 1.5),
	Head(-0.002, -0.47, 0.882),
	HeadRot(302.685, 348.162, 5.991),
	FootL(WSurface(TPos(-1.013, -0.021, 0.02), 0, -1)),
	FootR(WSurface(TPos(1.077, 0.002, -0.072), 0, -1)),
	HandL(WSurface(WPos(-0.143, 0.016, 0.543), -0.031, -0.998, 0.051), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(0.012, 0.009, 0.648), 0, -1), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(-0.17),
	ElbowR(0.298),
	WristL(),
	WristR(),
	KneeL(-0.493),
	KneeR(-0.518),
	SpineRot(-2.4)
) end

function SittingFolded() return Preset(
	Hips(WPos(0, 0.246, 0.05)),
	HipsRot(),
	Head(-0.001, 1, 0.005),
	HeadRot(356.908, 359.26, 3.669),
	FootL(WPos(0.234, 0.04, 0.374)),
	FootR(WPos(-0.197, 0.039, 0.299)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Thigh_L", 0.881, -0.346, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", 0.858, 0.273, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	ElbowL(-1),
	ElbowR(-1),
	WristL(),
	WristR(),
	KneeL(-0.408),
	KneeR(-0.312),
	SpineRot()
) end

function TPose() return Preset(
	Hips(WPos(0, 0.918, -0.096)),
	HipsRot(),
	Head(-0.001, 1, -0.018),
	HeadRot(356.908, 359.26, 3.669),
	FootL(WSurface(TPos(-0.795, -0.003, 0.049), 0, -1, 0)),
	FootR(WSurface(TPos(0.776, -0.002, 0.028), 0, -1)),
	HandL(HPos(-1.179, -0.086, 0.096), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(1.235, -0.042, -0.01), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(0.76),
	ElbowR(1),
	WristL(),
	WristR(),
	KneeL(),
	KneeR(),
	SpineRot()
) end

--CLAUDE_CODED: 8 model presets (Pose 1-8) for the "Loaded Pose" menu; body-only, feet grounded via WSurface, hips via PivotPos(MDist.HipsToHeel), ankles freed (0) so IK grounds feet for both bare/heeled (poses that deliberately set an ankle angle keep it).
function Pose1() return Preset(
	Hips(PivotPos(0, 0.98, 0, MDist.HipsToHeel)),
	HipsRot(),
	Head(0, 0.988, -0.154),
	HeadRot(4.734, 353.747, 354.56),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.12, 0, 0.016), 0, -1)),
	FootR(WSurface(TPos(0.196, 0, 0.054), 0, -1)),
	HandL(HPos(-0.107, -1.176, 0.187), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.574, -0.606, 0.247), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(-0.572),
	ElbowR(0.258),
	WristL(2.461, 0, -34.631),
	WristR(22.704, 0, 8.46),
	KneeL(-0.085),
	KneeR(0.369),
	AnkleL(0),
	AnkleR(0),
	SpineRot(),
	Mouth(0, 0, 0, 0.384, 0.384, 0, 0, 0.833, 0.833, 0.438, 0.438)
) end

function Pose2() return Preset(
	Hips(PivotPos(0, 0.98, 0, MDist.HipsToHeel)),
	HipsRot(20.3, 0, 3.775),
	Head(-0.001, 0.987, -0.159),
	HeadRot(354.485, 358.993, 343.719),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.11, -0.006, 0.027), 0, -1)),
	FootR(WSurface(TPos(0.196, -0.006, 0.032), 0, -1)),
	HandL(HPos(-0.167, -1.084, -0.216), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.215, 0.061, 0.384), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(-1),
	ElbowR(-0.143),
	WristL(),
	WristR(-3.722, 26.762, -41),
	MidR(32.163, 3.628, 3.628, 0, 0, TargetActor.Null, "Null"),
	RingR(34.003, 15.754, 15.754, 0, 0, TargetActor.Null, "Null"),
	PinkyR(37.578, 13.203, 13.203, 0, 0, TargetActor.Null, "Null"),
	KneeL(),
	KneeR(),
	AnkleL(0),
	AnkleR(0),
	SpineRot(),
	Mouth(0, 0, 0, 0.384, 0.384, 0, 0, 0.833, 0.833, 0.438, 0.438)
) end

function Pose3() return Preset(
	Hips(PivotPos(0, 0.98, 0, MDist.HipsToHeel)),
	HipsRot(12.35, 0, 2.725),
	Head(-0.001, 0.987, -0.159),
	HeadRot(356.236, 357.056, 11.298),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.172, 0, 0.003), 0, -1)),
	FootR(WSurface(TPos(0.196, -0.006, 0.032), 0, -1)),
	HandL(HPos(0.474, -0.624, 0.186), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.503, -0.439, 0.374), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(0.323),
	ElbowR(0.112),
	WristL(30.295, 0, -9.523),
	WristR(22.798, 0, 25.084),
	KneeL(0.022),
	KneeR(0.068),
	AnkleL(0),
	AnkleR(0),
	SpineRot(),
	Mouth(0, 0, 0, 0.384, 0.384, 0, 0, 0.833, 0.833, 0.438, 0.438)
) end

function Pose4() return Preset(
	Hips(PivotPos(0, 0.98, 0, MDist.HipsToHeel)),
	HipsRot(20.3, 0, 3.775),
	Head(-0.001, 0.987, -0.159),
	HeadRot(359.833, 351.809, 356.705),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.039, 0, -0.001), 0, -1)),
	FootR(WSurface(TPos(0.104, 0, 0.016), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.552, 0.842, 0.03), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.083, 0.425, 0.527), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ElbowL(),
	ElbowR(0.054),
	WristL(),
	WristR(),
	ThumbR(31.684, 0, 0, -20, 0, TargetActor.Null, "Null"),
	IndexR(22.081, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(19.224, 0, 0, 0, 0, TargetActor.Null, "Null"),
	RingR(15.184, 0, 0, 0, 0, TargetActor.Null, "Null"),
	PinkyR(12.803, 0, 0, 0, 0, TargetActor.Null, "Null"),
	KneeL(),
	KneeR(),
	AnkleL(0),
	AnkleR(0),
	SpineRot(),
	Mouth(0, 0, 0, 0.384, 0.384, 0, 0, 0.833, 0.833, 0.438, 0.438)
) end

function Pose5() return Preset(
	Hips(PivotPos(0, 0.98, 0, MDist.HipsToHeel)),
	HipsRot(20.3, 0, 3.775),
	Head(-0.001, 0.987, -0.159),
	HeadRot(358.216, 354.51, 350.495),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.102, 0, 0.078), 0, -1)),
	FootR(WSurface(TPos(0.024, 0, 0.02), 0, -1)),
	HandL(HPos(0.177, -0.957, 0.317), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.152, -0.922, 0.249), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(-0.039),
	ElbowR(-0.205),
	WristL(),
	WristR(),
	KneeL(0.09),
	KneeR(0.138),
	AnkleL(0.476),
	AnkleR(0),
	SpineRot(),
	Mouth(),
	Brows(),
	EyelidL(),
	EyelidR(),
	Cheeks()
) end

function Pose6() return Preset(
	Hips(PivotPos(0, 0.98, 0, MDist.HipsToHeel)),
	HipsRot(20.3, 0, 3.775),
	Head(-0.001, 0.987, -0.159),
	HeadRot(11.756, 336.913, 10.218),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.033, 0, 0.106), 0, -1)),
	FootR(WSurface(TPos(0.101, 0, -0.109), 0, -1)),
	HandL(HPos(-0.186, -1.083, -0.114), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.137, -0.776, -0.286), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(-0.994),
	ElbowR(0.145),
	WristL(-2.47, 0, -25.655),
	WristR(),
	KneeL(),
	KneeR(),
	AnkleL(0),
	AnkleR(0),
	SpineRot(),
	Mouth(0, 0, 0, 0, 0, 0, 0, 0.617, 0.617, 0.559, 0.559),
	Brows(),
	EyelidL(),
	EyelidR(),
	Cheeks()
) end

function Pose7() return Preset(
	Hips(PivotPos(0, 0.98, 0, MDist.HipsToHeel)),
	HipsRot(20.3, 0, 3.775),
	Head(-0.001, 0.987, -0.159),
	HeadRot(359.344, 357.528, 1.684),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.204, 0, 0), 0, -1)),
	FootR(WSurface(TPos(0.257, 0, 0.019), 0, -1)),
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.249, 0.597), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.302, -0.542), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	ElbowL(),
	ElbowR(),
	WristL(-27.347, 0, -48.627),
	WristR(38.577, 0, 47.793),
	KneeL(),
	KneeR(),
	AnkleL(0),
	AnkleR(0),
	SpineRot(),
	Mouth(0, 0, 0, 0, 0, 0, 0, 0.617, 0.617, 0.559, 0.559),
	Brows(),
	EyelidL(),
	EyelidR(),
	Cheeks()
) end

function Pose8() return Preset(
	Hips(PivotPos(0, 0.98, 0, MDist.HipsToHeel)),
	HipsRot(20.3, 0, 3.775),
	Head(-0.001, 0.987, -0.159),
	HeadRot(356.908, 359.26, 3.669),
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	FootL(WSurface(TPos(-0.11, -0.006, 0.027), 0, -1)),
	FootR(WSurface(TPos(0.196, -0.006, 0.032), 0, -1)),
	HandL(HPos(-0.191, -1.086, -0.093), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(0.294, -1.07, -0.103), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Null, "Null"),
	ElbowL(-0.491),
	ElbowR(-0.285),
	WristL(1.358, 0, -23.348),
	WristR(0.732, 0, -8.625),
	KneeL(),
	KneeR(),
	AnkleL(0, 0, -0.135),
	AnkleR(0),
	SpineRot(),
	Mouth(0, 0, 0, 0.384, 0.384, 0, 0, 0.833, 0.833, 0.438, 0.438)
) end

--------------------------------

function FaceAhegao() return Preset(
	EyeL(346.076, 28.61, 0),
	EyeR(347.849, 328.86, 0),
	Mouth(-1, 0.196, 0, 0.504, 0.504, 0, 0, 1, 1, 0.451, 0.451, 0, 0, 0.66, 0, 0.44),
	Brows(1, 1, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1)
) end

function FaceSmile() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	Mouth(0, -0.097, 0, 0.602, 0.602, -0.273, -0.273, 1, 1, 0.351, 0.351),
	Brows(0.434, 0.434),
	EyelidL(),
	EyelidR(),
	Cheeks(0.217, 0.217)
) end

function FaceAngry() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	Mouth(0, 0, 0, 0.244, 0.244, 0.293, 0.293, -0.613, -0.613, -0.166, -0.166),
	Brows(-1, -1, 1, 1),
	EyelidL(),
	EyelidR(),
	Cheeks(0.611, 0.611)
) end

function FaceSad() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	Mouth(0, 0, 0, -0.021, -0.021, -0.428, -0.428, -1, -1, -0.272, -0.272),
	Brows(1, 1, -1, -1),
	EyelidL(),
	EyelidR(),
	Cheeks(-0.855, -0.855)
) end

function FaceSurprised() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	Mouth(-0.501, -0.11, 0, 0.384, 0.384, -0.238, -0.238, 0.117, 0.117, -0.813, -0.813),
	Brows(1, 1, 1, 1),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(-0.961, -0.961)
) end

function FaceScared() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	Mouth(-0.215, -0.059, 0, 0.384, 0.384, -0.023, -0.023, -1, -1, 0.273, 0.273),
	Brows(1, 1, -1, -1),
	EyelidL(-0.045),
	EyelidR(-0.045),
	Cheeks(-0.609, -0.609)
) end

function FaceDisgusted() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	Mouth(-0.095, -0.194, 0, 0.627, 0.627, 0.243, 0.243, -1, -1, -0.564, -0.662),
	Brows(0.546, 0.546, -0.735, -0.735),
	EyelidL(-0.219),
	EyelidR(-0.219),
	Cheeks(0.633, 0.633)
) end

function FaceConfused() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	Mouth(-0.103, -0.299, 0, 0.331, 0.331, 0.907, 0.907, -1, -0.77, 0.133, 0.934),
	Brows(-1, 1, 1, -1),
	EyelidL(0.173),
	EyelidR(),
	Cheeks(-0.647, -0.999)
) end

function FaceNeutral() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	Mouth(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
	Brows(0, 0),
	EyelidL(0),
	EyelidR(0),
	Cheeks(0)
) end

function LookCamera() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos()),
	EyelidL(0),
	EyelidR(0)
) end

function EyesClose() return Preset(
	EyelidL(1),
	EyelidR(1)
) end
				