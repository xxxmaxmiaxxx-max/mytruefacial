--version 0.2
--Body Presets
function DoubleV() return Preset(
	HandL(HPos(-0.3, 0.206, 0.393), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	HandR(HPos(0.309, 0.249, 0.346), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ElbowL(-1),
	ElbowR(-1),
	ThumbL(24.961, 67.355, 67.355, -10.793, 0, TargetActor.Null, "Null"),
	IndexL(8.463, 0, 0, 20, 0, TargetActor.Null, "Null"),
	MidL(2.678, 0, 0, -6.078, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ThumbR(19.829, 51.111, 51.111, -20, 0, TargetActor.Null, "Null"),
	IndexR(7.768, 0, 0, 20, 0, TargetActor.Null, "Null"),
	MidR(3.299, 0, 0, -7.679, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, -20, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 19.571, 0, TargetActor.Null, "Null")
) end

function JackO() return Preset( --Preset by M3RK
	Hips(WPos(0, 0.356, 0.364)),
	HipsRot(15.55, 0, -4.025),
	Head(-0.001, -0.387, 0.922),
	HeadRot(321.733, 356.414, 5.961),
	FootL(WSurface(TPos(-1.031, -0.076, 0.24), 0.012, -1, 0.017)),
	FootR(WSurface(TPos(0.936, -0.072, 0.06), -0.064, -0.998, 0.008)),
	HandL(WSurface(WPos(-0.08, -0.067, 1.002), 0.003, -1, 0.015), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	HandR(WSurface(WPos(-0.038, -0.066, 0.865), 0.023, -1, -0.015), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	IndexR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	MidR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	RingR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.World, "Null"),
	ElbowL(-0.181),
	ElbowR(0.502),
	KneeL(-0.294),
	KneeR(-0.251)
) end

function HandsBehind() return Preset(
	ElbowL(0.247),
	ElbowR(0.247),
	HandL(HPos(0.33, -0.713, -0.321), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	HandR(HPos(-0.279, -0.771, -0.194), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35))
) end
--Face Presets
function OpenWide() return Preset(
	Mouth(-1, 0, 0, 0.504, 0.504, -1, -1, 0.675, 0.675, 0.999, 0.999, 0, 0, 0.8, 0, -0.12),
	--Mouth(-1, 0.196, 0, 0.504, 0.504, 0, 0, 1, 1, 0.451, 0.451, 0, 0, 0.66, 0, 0.44),
	Brows(1, 1, 0.072, 0.072),
	EyelidL(),
	EyelidR(),
	Cheeks(-1, -1),
	EyeL(CameraPos()),
	EyeR(CameraPos())
) end

function LookCam() return Preset(
	EyeL(CameraPos()),
	EyeR(CameraPos())
) end

function FaceCam() return Preset(
	HeadLookAt(CameraPos())
) end

--Animation Loops
-- function Humping1() return Preset(
-- 	HipsRot(-26, 0, 0)
-- ) end
-- function Humping2() return Preset(
-- 	HipsRot(-1.8, 0, 0)
-- ) end
--
-- function HumpingS1() return Preset(
-- 	HipsRot(-10.725, 0, 0)
-- ) end
-- function HumpingS2() return Preset(
-- 	HipsRot(-1.8, 0, 0)
-- ) end

-- function Bounce1() return Preset(
-- 	--Hips(-0.001, 0.480, 0.172)
-- 	Hips(-0.001, 1.0, 0.01)
-- ) end
-- function Bounce2() return Preset(
-- 	--Hips(-0.001, 0.381, 0.172)
-- 	Hips(0, 0.951, 0.01)
-- ) end

-- function HipMov1() return Preset(
-- 	--HipsRot(34, 0, 17)
-- 	HipsRot(20, -15, 15)
-- ) end
-- function HipMov2() return Preset(
-- 	--HipsRot(34, 0, -17)
-- 	HipsRot(20, 15, -15)
-- ) end

-- function Licking1() return Preset(
-- 	Mouth(-0.68, 0.377, 0, 0.504, 0.504, -0.062, -0.062, 0.664, 0.664, 0.57, 0.57, 0, 0, 0.9, 0, 0.45)
-- ) end
-- function Licking2() return Preset(
-- 	Mouth(-0.737, 0.377, 0, 0.504, 0.504, -0.062, -0.062, 0.664, 0.664, 0.57, 0.57, 0, 0, 0.97, 0, -0.10)
-- ) end

function FingeringMRl1() return Preset(
-- 	ThumbL(-5.483, 0, 0, -20, 0, TargetActor.Null, "Null"),
-- 	IndexL(-3.833, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidL(9.834, 36.161, 36.161, -5.928, 0, TargetActor.Null, "Null"),
	RingL(15.206, 27.438, 27.438, -0.33, 0, TargetActor.Null, "Null")
-- 	,PinkyL(5.567, 0, 0, 0, 0, TargetActor.Null, "Null")
) end

function FingeringMRl2() return Preset(
-- 	ThumbL(-5.483, 0, 0, -20, 0, TargetActor.Null, "Null"),
-- 	IndexL(-3.833, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidL(56.145, 24.567, 24.567, -5.928, 0, TargetActor.Null, "Null"),
	RingL(37.106, 40.274, 40.274, -0.33, 0, TargetActor.Null, "Null")
-- 	,PinkyL(5.567, 0, 0, 0, 0, TargetActor.Null, "Null")
) end

function FingeringMRr1() return Preset(
-- 	ThumbR(-5.483, 0, 0, -20, 0, TargetActor.Null, "Null"),
-- 	IndexR(-3.833, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(9.834, 36.161, 36.161, -5.928, 0, TargetActor.Null, "Null"),
	RingR(15.206, 27.438, 27.438, -0.33, 0, TargetActor.Null, "Null")
-- 	,PinkyR(5.567, 0, 0, 0, 0, TargetActor.Null, "Null")
) end

function FingeringMRr2() return Preset(
-- 	ThumbR(-5.483, 0, 0, -20, 0, TargetActor.Null, "Null"),
-- 	IndexR(-3.833, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(56.145, 24.567, 24.567, -5.928, 0, TargetActor.Null, "Null"),
	RingR(37.106, 40.274, 40.274, -0.33, 0, TargetActor.Null, "Null")
-- 	,PinkyR(5.567, 0, 0, 0, 0, TargetActor.Null, "Null")
) end

function FingeringIMl1() return Preset(
-- 	ThumbL(38.629, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexL(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidL(-0.255, 0, 0, 6.945, 0, TargetActor.Null, "Null")
-- 	,RingL(85, 85.415, 85.415, 0, 0, TargetActor.Null, "Null"),
-- 	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

function FingeringIMl2() return Preset(
	--ThumbL(38.629, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexL(-14.203, 46.625, 46.625, 0, 0, TargetActor.Null, "Null"),
	MidL(-13.603, 39.302, 39.302, 6.945, 0, TargetActor.Null, "Null")
	--,RingL(85, 85.415, 85.415, 0, 0, TargetActor.Null, "Null"),
	--PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

function FingeringIMr1() return Preset(
	--ThumbR(38.629, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexR(0, 0, 0, 0, 0, TargetActor.Null, "Null"),
	MidR(-0.255, 0, 0, 6.945, 0, TargetActor.Null, "Null")
	--,RingR(85, 85.415, 85.415, 0, 0, TargetActor.Null, "Null"),
	--PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

function FingeringIMr2() return Preset(
	--ThumbR(38.629, 95, 95, 0, 0, TargetActor.Null, "Null"),
	IndexR(-14.203, 46.625, 46.625, 0, 0, TargetActor.Null, "Null"),
	MidR(-13.603, 39.302, 39.302, 6.945, 0, TargetActor.Null, "Null")
	--,RingR(85, 85.415, 85.415, 0, 0, TargetActor.Null, "Null"),
	--PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null")
) end

-- function Shake1() return Preset(
-- 	SpineRot(15)
-- ) end
--
-- function Shake2() return Preset(
-- 	SpineRot(-15)
-- ) end

-- function ShakeS1() return Preset(
-- 	SpineRot(8)
-- ) end
--
-- function ShakeS2() return Preset(
-- 	SpineRot(-8)
-- ) end
--
-- function Twerk1() return Preset(
-- 	HipsRot(45, 0, 0)
-- ) end
-- function Twerk2() return Preset(
-- 	HipsRot(10, 0, 0)
-- ) end


--Lists
facepresets = {OpenWide, LookCam, FaceCam}
facestr = {"Open Wide", "Look at Camera", "Face the Camera"}
bodypresets = {DoubleV, JackO, HandsBehind}
bodystr = {"Double Vs", "Jack-O Pose", "Hands behind"}
