-- fauna_LABS_v1.05
log("faunaLABS v1.04 fired!")
--game.m_lastHitButton -- mousover targets?
--[[
for plugin add this to your menu:
	+ "faunaLABS"
		fauna_LABS_Menu(human, hitTri)
--]]

if type(TM_AddMenuMod) == "function" then
	TM_AddMenuMod("faunaLABS", "fauna_LABS_Menu")
else
	local funcCode = [[
	function TalkMenu(human, hitTri)
		Jump("fauna_LABS_Menu", human, hitTri)
	end
	]]
	load(funcCode)()
end

Faunalabs = Faunalabs or {}

function FL_gameStart()
    Faunalabs.state =
        FL_ApplyDefaults(
            Faunalabs.defaultState,
            Faunalabs.state
        )
    if Faunalabs.state.FL_disableIdle then
        game.s_characterIdleEnabled = false
    end
end

FL_colorToggle = false
FL_CoreParts = {}
FL_FaceParts = {}
FL_ArmParts  = {}
FL_LegParts  = {}
FL_FingerLParts = {}
FL_FingerRParts = {}
FL_ActiveHumans = FL_ActiveHumans or {}
FL_RandomizerConfig = FL_RandomizerConfig or {}
activeloops = activeloops or {}
CL_SMult = CL_SMult or 1 --Speed multiplier
CLV_A = 2 -- ease in
CLV_B = 2 -- ease out
-- characterAnimParams = {} -- Per-character animation storage
-- customSequences = {} -- Store custom animation sequences per character
FL_Fluidspeed 	 = 1
FL_Fluidspread  = 1
FL_Fluidamount	 = 1
FL_Fluidforce 	 = 1
FL_Fluidgravity = 1
Anim_MenuPose        = 2
Anim_MenuPoseCount   = 2
Anim_Menu1           = 0
Anim_Menu2           = 0
Anim_Menu3           = 0
Anim_Menu4           = 0
Anim_Menu5           = 0
Anim_Menu6           = 0
Anim_Menu7           = 0
Anim_Menu8           = 0
Anim_Menu9           = 0
Anim_Menu10          = 0
Anim_Menu11          = 0
Anim_Menu12          = 0
Anim_Menu13          = 0
Anim_Menu14          = 0
Anim_Menu15          = 0
Anim_Menu16          = 0
Anim_Menu17          = 0
AnimParts           = AnimParts or {}
ActiveAnimPart      = ActiveAnimPart or "HipsRot"
ActiveAnimParts = ActiveAnimParts or {}
ActiveAnimHuman = nil
ActiveAnimHumanObj = nil
FL_DurMult = 2.5
FL_speedInc = 0.1 --The value that animation speed will be changed by
FL_easeInc = 0.2 --The value that animation easement will be changed by
Faun_autoCUM = 10
faunInc = faunInc or 0.1
LAB_Selected = LAB_Selected or {}
FL_HipsMode = {}  -- FL_HipsMode[hid] = 0 (float) or 1 (WPos step)
FL_EyeMode = {}
FL_meshTargets = {
    "Eyes",
    "Eyelashes",
	"EyeShadow",
    "Eyebrows",
    "Brows",
    "Body_",
    "Mouth",
    "Teeth",
    "Tongue",
    "Hair",
}

FL_puppetBones = {
    "UpperArm_L", -- 0
    "Forearm_L",  -- 1
    "Hand_L",     -- 2
    "UpperArm_R", -- 3
    "Forearm_R",  -- 4
    "Hand_R",     -- 5
    "Head",       -- 6
    "Breast_L",   -- 7
    "Breast_R",   -- 8
    "Chest",      -- 9
    "Spine",      -- 10
    "Hips",       -- 11
    "Ass_L",      -- 12
    "Ass_R",      -- 13
    "Thigh_L",    -- 14
    "Calf_L",     -- 15
    "Foot_L",     -- 16
    "Thigh_R",    -- 17
    "Foot_R",     -- 18
    "Calf_R",     -- 19
    -- "SkinBones",  -- 20
    -- "SkinParts",  -- 21
}

FL_puppetBoneIds = {
    ["UpperArm_L"] = 111, ["Forearm_L"] = 113, ["Hand_L"] = 115,
    ["UpperArm_R"] = 127, ["Forearm_R"] = 129, ["Hand_R"] = 131,
    ["Head"] = 97, ["Breast_L"] = 101, ["Breast_R"] = 103,
    ["Chest"] = 94, ["Spine"] = 92, ["Hips"] = 90,
    ["Ass_L"] = 105, ["Ass_R"] = 106,
    ["Thigh_L"] = 117, ["Calf_L"] = 119, ["Foot_L"] = 121,
    ["Thigh_R"] = 133, ["Calf_R"] = 135, ["Foot_R"] = 137,
}

FL_puppetBoneDefaults = {
    ["UpperArm_L"] = 2.025,  ["UpperArm_R"] = 2.025,
    ["Forearm_L"]  = 1.2,    ["Forearm_R"]  = 1.2,
    ["Hand_L"]     = 0.495,  ["Hand_R"]     = 0.495,
    ["Head"]       = 5.49,
    ["Breast_L"]   = 0.75,   ["Breast_R"]   = 0.75,
    ["Chest"]      = 12.7,
    ["Spine"]      = 12.7,
    ["Hips"]       = 12.7,
    ["Ass_L"]      = 1.0,    ["Ass_R"]      = 1.0,
    ["Thigh_L"]    = 7.41,   ["Thigh_R"]    = 7.41,
    ["Calf_L"]     = 3.4875, ["Calf_R"]     = 3.4875,
    ["Foot_L"]     = 1.0875, ["Foot_R"]     = 1.0875,
}

FL_boneMassStep     = 0.1

FL_breastDefaults = FL_breastDefaults or {}
FL_breastMassInc   = 0.2
FL_breastDragInc   = 0.5
FL_breastComInc    = 0.01
FL_breastITInc     = 0.001


FL_assDefaults = FL_assDefaults or {}
FL_assMassStep   = 0.2
FL_assDragStep   = 0.5
FL_assComStep    = 0.01
FL_assITStep     = 0.001

FL_boneMass = {}
FL_menuInc = "+"

ActiveAnimShuffles = ActiveAnimShuffles or {}

FL_POSES = 8

-- Central storage for all body part data
FL_BodyPartDefs = {
    -- Core
    SpineRot   = { category = "Core", axes = 1, defaults = {0},     type = "float", increment = 5 },
    Head       = { category = "Core", axes = 3, defaults = {0,1,0}, type = "float", supportsStep = true, increment = 0.1 },
    HeadRot    = { category = "Core", axes = 3, defaults = {0,0,0}, type = "float", increment = 5 },
    Hips       = { category = "Core", axes = 3, defaults = {0,1,0}, type = "float", supportsStep = true, increment = 0.1 },
    HipsRot    = { category = "Core", axes = 3, defaults = {0,0,0}, type = "float", increment = 5 },

    -- Face
    Mouth      = { category = "Face", axes = 16, defaults = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, type = "float", increment = 0.2 },
    Brows      = { category = "Face", axes = 4,  defaults = {0,0,0,0}, type = "float", increment = 0.2 },
    EyelidL    = { category = "Face", axes = 1,  defaults = {0}, type = "float", increment = 0.2 },
    EyelidR    = { category = "Face", axes = 1,  defaults = {0}, type = "float", increment = 0.2 },
    Cheeks     = { category = "Face", axes = 2,  defaults = {0,0}, type = "float", increment = 0.2 },
    Nose       = { category = "Face", axes = 2,  defaults = {0,0}, type = "float", increment = 0.2 },

    Eyes = {
        category     = "Face",
        axes         = 3,
        defaults     = { 0, 0, 0 },
        type         = "step",
        stepType     = "eye",
        supportsStep = true,
        axisLabels   = { "X", "Y", "Z" },
        increment    = 5,
    },

    -- Legs
    KneeL  = { category = "Legs", axes = 1, defaults = {0},     type = "float", increment = 5 },
    AnkleL = { category = "Legs", axes = 3, defaults = {0,0,0}, type = "float", increment = 5 },
    KneeR  = { category = "Legs", axes = 1, defaults = {0},     type = "float", increment = 5 },
    AnkleR = { category = "Legs", axes = 3, defaults = {0,0,0}, type = "float", increment = 5 },

    FootL = {
        category     = "Legs",
        axes         = 4,
        defaults     = { 0, 0.5, 0.5, 0 },
        type         = "step",
        stepType     = "foot",
        supportsStep = true,
        noRandom     = { 4 },
        axisLabels   = { "X", "Y", "Z", "GroundSnap" },
        increment    = 0.2,
    },

    FootR = {
        category     = "Legs",
        axes         = 4,
        defaults     = { 0, 0.5, 0.5, 0 },
        type         = "step",
        stepType     = "foot",
        supportsStep = true,
        noRandom     = { 4 },
        axisLabels   = { "X", "Y", "Z", "GroundSnap" },
        increment    = 0.2,
    },

    -- Arms
    ElbowL = { category = "Arms", axes = 1, defaults = {0},     type = "float", increment = 5 },
    WristL = { category = "Arms", axes = 3, defaults = {0,0,0}, type = "float", increment = 5 },
    ElbowR = { category = "Arms", axes = 1, defaults = {0},     type = "float", increment = 5 },
    WristR = { category = "Arms", axes = 3, defaults = {0,0,0}, type = "float", increment = 5 },

    HandL = {
        category     = "Arms",
        axes         = 3,
        defaults     = { 0, 0.5, 0.5 },
        type         = "step",
        stepType     = "hand",
        supportsStep = true,
        axisLabels   = { "X", "Y", "Z" },
        increment    = 0.2,
    },

    HandR = {
        category     = "Arms",
        axes         = 3,
        defaults     = { 0, 0.5, 0.5 },
        type         = "step",
        stepType     = "hand",
        supportsStep = true,
        axisLabels   = { "X", "Y", "Z" },
        increment    = 0.2,
    },

    -- Fingers
    ThumbL = { category = "Arms", sub = "Fingers - L", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    IndexL = { category = "Arms", sub = "Fingers - L", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    MidL   = { category = "Arms", sub = "Fingers - L", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    RingL  = { category = "Arms", sub = "Fingers - L", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    PinkyL = { category = "Arms", sub = "Fingers - L", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },

    ThumbR = { category = "Arms", sub = "Fingers - R", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    IndexR = { category = "Arms", sub = "Fingers - R", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    MidR   = { category = "Arms", sub = "Fingers - R", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    RingR  = { category = "Arms", sub = "Fingers - R", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    PinkyR = { category = "Arms", sub = "Fingers - R", axes = 5, defaults = {0,0,0,0,0}, type = "float", increment = 1 },
    -- Special Interactions
    -- Penis      = { axes = 0,  defaults = {},          type = "interaction", optional = {HandActor = nil, TargetActor = nil, AutoSpeed = nil} },
    -- Generic / Utility
    -- GenericKey = { axes = 0,  defaults = {},          type = "generic",     optional = {Ctrl = nil, FuncName = nil, Values = nil} },
}

--------------------------------------------------
-- Part registrations
--------------------------------------------------

AnimParts_DefaultEffects = {
    Hips     = Hips,
    HipsRot  = HipsRot,
    SpineRot = SpineRot,
    Head     = Head,
    HeadRot  = HeadRot,
    Mouth    = Mouth,
    Brows    = Brows,
    EyelidL  = EyelidL,
    EyelidR  = EyelidR,
    Cheeks   = Cheeks,
    Nose     = Nose,
    ElbowL   = ElbowL,
    ElbowR   = ElbowR,
    WristL   = WristL,
    WristR   = WristR,
    ThumbL   = ThumbL,
    IndexL   = IndexL,
    MidL     = MidL,
    RingL    = RingL,
    PinkyL   = PinkyL,
    ThumbR   = ThumbR,
    IndexR   = IndexR,
    MidR     = MidR,
    RingR    = RingR,
    PinkyR   = PinkyR,
    KneeL    = KneeL,
    KneeR    = KneeR,
    AnkleL   = AnkleL,
    AnkleR   = AnkleR,

    -- Step parts
    HandL = nil,
    HandR = nil,
    FootL = nil,
    FootR = nil,
    -- EyeL  = nil,
    -- EyeR  = nil,
	Eyes  = nil,
}

--------------------------------------------------
-- Part → animation ID mapping per human
--------------------------------------------------

function LAB_GetPartIDs(human)
    return {
        -- Spine & Core
        Hips     = { animID = human.hipsNames        },
        HipsRot  = { animID = human.Anus             },
        SpineRot = { animID = human.spineNames       },
        -- Head & Face
        Head     = { animID = human.headNames        },
        HeadRot  = { animID = human.neckNames        },
        Mouth    = { animID = human.m_mouth          },
		Nose     = { animID = human.noseNames        },
        Brows    = { animID = human.browNames        },
        EyelidL  = { animID = human.upperEyelidNames },
        EyelidR  = { animID = human.lowerEyelidNames },	
		-- EyeL     = { animID = human.eyeNames         },
		-- EyeR     = { animID = human.eyeNames         },	
		Eyes     = { animID = human.eyeNames		 },
		Eyes_R   = { animID = human.jawNames		 },
        Cheeks   = { animID = human.cheekNames       },
        -- Arms & Hands (Left)
        ElbowL   = { animID = human.upperarmNames    },
        WristL   = { animID = human.chestNames       },
        HandL    = { animID = human.forearmNames     },
        ThumbL   = { animID = human.upperLipsNames   },
        IndexL   = { animID = human.tongueNames      },
        MidL     = { animID = human.lowerLipsNames   },
        RingL    = { animID = human.lipsCornerNames  },
        PinkyL   = { animID = human.pinkyNames       },
        -- Arms & Hands (Right)
        ElbowR   = { animID = human.shoulderNames    },
        WristR   = { animID = human.breastNames      },
        HandR    = { animID = human.handNames        },
        ThumbR   = { animID = human.thumbNames       },
        IndexR   = { animID = human.indexNames       },
        MidR     = { animID = human.middleNames      },
        RingR    = { animID = human.ringNames        },
        PinkyR   = { animID = human.pinkyNames       },
        -- Lower Body & Legs
        KneeL    = { animID = human.calfNames        },
        KneeR    = { animID = human.thighNames       },
        AnkleL   = { animID = human.footNames        },
        AnkleR   = { animID = human.ignoreNames      },
        FootL    = { animID = human.noseNames        },
        FootR    = { animID = human.toeNames         },
    }
end

-- Hips
AnimParts_DefaultEffects["Hips"] = function(x, y, z)
    if FL_HipsMode_Get() == 1 then
        return Hips(WPos(x, y, z))
    else
        return Hips(x, y, z)
    end
end

-- Eyes
AnimParts_DefaultEffects["Eyes"] = function(x, y, z)
    local m = FL_EyeMode_Get("Eyes")
    if m == 1 then
        return EyeL(CameraPos()), EyeR(CameraPos())
    else
        return EyeL(x + 0.0, y + 0.0, z + 0.0), EyeR(x + 0.0, y + 0.0, z + 0.0)
    end
end

-- Hands
AnimParts_DefaultEffects["HandL"] = function(x, y, z)
    return HandL(HPos(x, y, z, true), FL_DefaultWrist())
end
AnimParts_DefaultEffects["HandR"] = function(x, y, z)
    return HandR(HPos(x, y, z, false), FL_DefaultWrist())
end

-- Feet
AnimParts_DefaultEffects["FootL"] = function(x, y, z, snap)
    if snap ~= 0 then
        return FootL(WSurface(TPos(x, y, z), 0, -1, 0, 1.0))
    else
        return FootL(WPos(x, y, z))
    end
end

AnimParts_DefaultEffects["FootR"] = function(x, y, z, snap)
    if snap ~= 0 then
        return FootR(WSurface(TPos(x, y, z), 0, -1, 0, 1.0))
    else
        return FootR(WPos(x, y, z))
    end
end

--===================================================================================================================================================================
--Misc Helpers
--===================================================================================================================================================================

function FL_randomRange(min, max)
    return min + (max - min) * math.random()
end

function FL_roundTo(v, step)
	return math.floor(v / step + 0.5) * step
end

function FL_snipM(value, decimals) -- menu, trailing numbers
    decimals = decimals or 1
    return string.format("%." .. decimals .. "f", value)
end

function FL_length(list) -- menu safe return
	length = #list
	return length
end

function NonZero(v)
    if math.abs(v) < 0.0001 then
        return 0.0001
    end
    return v
end

function FL_get(t, key)
    if t and t[key] ~= nil then
        return t[key]
    end
    return 0
end

-- local trueColor = #54b095
-- local falseColor = #9a646f
local function coTog(condition, text, trueColor, falseColor) -- menu color toggle
	local c = condition and (trueColor or "FF10694E") or (falseColor or "FF631928")
	return "<color=" .. c .. "><i>" .. text
end
local colortest = "<color=" .. "FF104169" .. "><i>"
-- "#243DAB"
--toggle state


function FL_GetOtherHumans(human)
    return game.GetHumans(function(h)
        return h ~= human
    end)
end
--===================================================================================================================================================================
--active tests
--===================================================================================================================================================================


---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--failed
--[[-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--]]--===============================================================================================================================================================
--===================================================================================================================================================================

function FL_GetBoneRB(human, boneId)
    local ok, rb = pcall(function()
        return human:GetRigidbody(boneId)
    end)
    if ok and rb then
        return rb
    end
    return nil
end

function FL_InitBoneMass(human)
    local key = tostring(human.m_instanceId)
    FL_boneMass[key] = {}
    for i, name in ipairs(FL_puppetBones) do
        local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
        if rb then
            FL_boneMass[key][name] = rb.mass
        end
    end
end

function FL_getBoneMass(human, name)
    local key = tostring(human.m_instanceId)
    if FL_boneMass[key] then
        return FL_boneMass[key][name] or 0
    end
    return 0
end

function FL_InitBreastPhysicsDefaults(human)
	if not RBX then return end
	local rbl = FL_GetBoneRB(human, FL_puppetBoneIds["Breast_L"])
	local rbr = FL_GetBoneRB(human, FL_puppetBoneIds["Breast_R"])
	if not rbl or not rbr then return end
	local key = tostring(human.m_instanceId)
	FL_breastDefaults = FL_breastDefaults or {}
	if not FL_breastDefaults[key] then
		FL_breastDefaults[key] = {
			dragL = RBX.GetDrag(rbl), dragR = RBX.GetDrag(rbr),
			comL = RBX.GetCenterOfMass(rbl), comR = RBX.GetCenterOfMass(rbr),
			itL = RBX.GetInertiaTensor(rbl), itR = RBX.GetInertiaTensor(rbr),
		}
	end
	log("Breast Defaults Defined!")
end

function FL_InitAssPhysicsDefaults(human)
	if not RBX then return end
	local rbl = FL_GetBoneRB(human, FL_puppetBoneIds["Ass_L"])
	local rbr = FL_GetBoneRB(human, FL_puppetBoneIds["Ass_R"])
	if not rbl or not rbr then return end
	local key = tostring(human.m_instanceId)
	FL_AssDefaults = FL_AssDefaults or {}
	if not FL_AssDefaults[key] then
		FL_AssDefaults[key] = {
			dragL = RBX.GetDrag(rbl), dragR = RBX.GetDrag(rbr),
			comL = RBX.GetCenterOfMass(rbl), comR = RBX.GetCenterOfMass(rbr),
			itL = RBX.GetInertiaTensor(rbl), itR = RBX.GetInertiaTensor(rbr),
		}
	end
end

function FL_ConnectPenisToHole(human, connectedGirl, holeName)
	-- human.Penis.ConnectedGirl
    local clip = human.GetCurrentClip(MotionLayer.PlayerPose)
    if clip == nil then return false end
    local data = clip.ExtractData({human, connectedGirl})
    data = data:gsub('Penis%(TargetActor%.A, "[^"]*"', 'Penis(TargetActor.A, "' .. holeName .. '"')
    actorA = human
    actorB = connectedGirl
    fadeTime = 0.3
    local fn, err = load(data)
    if fn == nil then
        log("load error: " .. tostring(err))
        return false
    end
    fn()
    return true
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

Faunalabs.bodyOverrides =
    Faunalabs.bodyOverrides or function() end

Faunalabs.clothingOverrides =
    Faunalabs.clothingOverrides or function() end

Faunalabs.characterOverrides =
    Faunalabs.characterOverrides or {}

function FL_ApplyDefaults(defaults, target)
    target = target or {}

    for k, v in pairs(defaults) do
        if target[k] == nil then
            target[k] = v
        end
    end

	log("Config Merged!")

    return target
end

function FL_humanCustomDefaults(human)
    local s = Faunalabs.state

    if s.FL_custom_Body_Enabled then
		log("Custom Body Fired!")
        Faunalabs.bodyOverrides(human)
    end

    if s.FL_custom_Clothing_Enabled then
		log("Custom Clothing Fired!")
        Faunalabs.clothingOverrides(human)
    end

    if s.FL_custom_Characters_Enabled then
        local override =
            Faunalabs.characterOverrides[human.Name]

        if type(override) == "function" then
			log("Custom Characters Fired!")
            override(human)
        end
    end
end

function ShuffleTable(t)
    local n = #t
    for i = n, 2, -1 do
        local j = math.random(1, i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

function GetNextShuffledIndex(key, effectCount)
    local s = ActiveAnimShuffles[key]

    if not s or not s.queue or #s.queue == 0 then
        local lastPlayed = s and s.last or nil

        local indices = {}
        for i = 1, effectCount do indices[i] = i end

        ShuffleTable(indices)
		while effectCount > 1 and indices[1] == lastPlayed do
			ShuffleTable(indices)
		end

		log("[AnimLAB] " .. key .. " new shuffle order=[" .. table.concat(indices, ", ") .. "]")

		ActiveAnimShuffles[key] = { queue = indices, last = nil }
        s = ActiveAnimShuffles[key]
    end

    local index = table.remove(s.queue, 1)
    s.last = index
    return index
end

-- Core parts for "toggle all" mesh render

function toggleAllRenderParts(human, enabled)
    local allParts = getFBXParts(human)
    for _, partName in ipairs(allParts) do
        toggleBodyPart(human, partName, enabled)
    end
end

function toggleCoreRenderParts(human, enabled)
    for _, partName in ipairs(FL_meshTargets) do
        toggleBodyPart(human, partName, enabled)
    end
end


-- function FL_FindByNameRecursive(root, targetName)
--     if not root then return nil end

--     if root.name == targetName then
--         return root
--     end

--     for i = 0, root.childCount - 1 do
--         local child = root:GetChild(i)
--         local result = FL_FindByNameRecursive(child, targetName)
--         if result then return result end
--     end

--     return nil
-- end

-- function corneaTest(human)
--     local root = human.m_puppetRig.transform.parent
--     if not root then return end

--     local fbx = root:Find("FBX")
--     if not fbx then return end

--     local corneaL = FL_FindByNameRecursive(fbx, "Cornea++")

--     if corneaL then
--         corneaL.gameObject:SetActive(false)
--     else
--         log("Cornea++ not found")
--     end
-- end

function FL_FindByNameRecursive(root, targetName)
    if not root then return nil end
    if root.name == targetName then
        return root
    end
    for i = 0, root.childCount - 1 do
        local child = root:GetChild(i)
        local result = FL_FindByNameRecursive(child, targetName)
        if result then return result end
    end
    return nil
end

function corneaToggle(human, enable)
    local key = tostring(human.m_instanceId)
    local entry = FL_ActiveHumans[key]
    if not entry then log("FL | corneaToggle | no entry for human") return end

    local src = entry.corneaL or entry.corneaR
    if not src then log("FL | corneaToggle | no cornea nodes for " .. human.Name) return end

    if enable == nil then
        enable = not src.gameObject.activeSelf
    end

    if entry.corneaL then entry.corneaL.gameObject:SetActive(enable) end
    if entry.corneaR then entry.corneaR.gameObject:SetActive(enable) end
end

-- Build dynamic list of all MeshRenderer nodes under FBX for individual toggling
function getFBXParts(human)
    local root = human.m_puppetRig.transform.parent
    if not root then return {} end
    local fbx = root:Find("FBX")
    if not fbx then return {} end
    local parts = {}
    for i = 0, fbx.childCount - 1 do
        local child = fbx:GetChild(i)
        if child:Find("MeshRenderer") then
            table.insert(parts, child.name)
        end
    end

    -- Eye glint (Cornea++) hardcoded entries — not present on all characters
    local eyeGlints = {
        "Bone_Root/Spine_Base/Bone_Spine/chestLower_ParentIK/Bone_Chest/Bone_Head/Bone_Eye_L/New Game Object/lEye/Cornea++",
        "Bone_Root/Spine_Base/Bone_Spine/chestLower_ParentIK/Bone_Chest/Bone_Head/Bone_Eye_R/New Game Object/rEye/Cornea++",
    }
    for _, path in ipairs(eyeGlints) do
        if fbx:Find(path) then
            table.insert(parts, path)
        else
            print("[getFBXParts] Eye glint not found (may not exist on this character): " .. path)
        end
    end

    return parts
end

function toggleBodyPart(human, partName, enabled)
    local root = human.m_puppetRig.transform.parent
    if not root then return false end
    local fbx = root:Find("FBX")
    if not fbx then return false end
    local part = fbx:Find(partName)
    if not part then return false end
    local mrNode = part:Find("MeshRenderer")
    if not mrNode then return false end
    local go = mrNode.gameObject
    if enabled == nil then
        go:SetActive(not go.activeSelf)
    else
        go:SetActive(enabled)
    end
    return true
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------


--===================================================================================================================================================================
--===================================================================================================================================================================

function FL_CleanupHumanTracking(state)
    if state.headClip then
        state.headClip:Stop()
        state.headClip = nil
    end
    state.headTracking = false
    state.target = nil
	-- log("Head Tracking: Cleanup")
end

function FL_RemoveHuman(key, state)
    FL_CleanupHumanTracking(state)
    FL_ActiveHumans[key] = nil
end

function FL_EnableHeadTracking(human, state)
    local others = FL_GetOtherHumans(human)
    if not others or #others == 0 then
        return false
    end
    state.targetIndex = state.targetIndex or 1
    state.target = others[state.targetIndex]
    state.headTracking = true
    log("Head Tracking: enabled, target = " .. tostring(state.target and state.target.Name))
    return true
end

function FL_DisableHeadTracking(state)
    if not state.headTracking and not state.target and not state.headClip then
        return
    end
    log("Head Tracking: disabled")
    -- local savedIndex = state.targetIndex
    FL_CleanupHumanTracking(state)
    -- state.targetIndex = savedIndex
end

function FL_ToggleHeadTracking(human)
    local key = tostring(human.m_instanceId)
    local state = FL_ActiveHumans[key]
    if not state then return end

    if state.headTracking then
        FL_DisableHeadTracking(state)
    else
        FL_EnableHeadTracking(human, state)
    end
end

function FL_CycleHeadTarget(human)
    local state = FL_ActiveHumans[tostring(human.m_instanceId)]
    if not state then return end
    local others = FL_GetOtherHumans(human)
    if not others or #others == 0 then return end
    state.targetIndex = (state.targetIndex % #others) + 1
    state.target = others[state.targetIndex]
    log("Head Tracking: enabled, target = " .. tostring(state.target and state.target.Name))
end

function FL_UpdateHeadTracking(human, state)
	if not state.headTracking then return end
	local tgt = state.target
	if not tgt then
		FL_CleanupHumanTracking(state)
		return
	end

	local ok, rig = pcall(function() return tgt.m_puppetRig end)
	if not ok or not rig then
		FL_CleanupHumanTracking(state)
		return
	end

	local ok2, headTransform = pcall(function()
		if not rig.transform then return nil end
		return rig.transform:Find("Head")
	end)
	if not ok2 or not headTransform then
		FL_CleanupHumanTracking(state)
		return
	end

	local ok3, pos = pcall(function() return headTransform.position end)
	if not ok3 or not pos then
		FL_CleanupHumanTracking(state)
		return
	end

	local eyeLevel = 0.1
	human:AddInvoluntaryAnim(
		"HeadTrack",
		0.5,
		0.1,
		0.1,
		HeadLookAt(WorldPos(pos.x, pos.y + eyeLevel, pos.z), 0.8, 120)
	)
end

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

function FL_cycleStep(current, steps)
    for i, v in ipairs(steps) do
        if math.abs(v - current) < 0.000001 then
            return steps[(i % #steps) + 1]
        end
    end
    return steps[1]
end

--====================================================
-- CORE UTILITIES
--====================================================

function FL_GetBoneNode(human, i)
    local index = tonumber(i)
    if not index then
        log("Invalid bone index: " .. tostring(i))
        return nil
    end

    return human.m_puppetRig.transform:GetChild(index - 1)
end

--====================================================
-- BONE TARGET RESOLVER
--====================================================

function FL_GetBoneTargets(human, i)

    local index = tonumber(i)
    if not index then return {} end

    local bone = FL_GetBoneNode(human, index)
    if not bone then return {} end

    if index == 10 then
        local targets = {}

        if bone.childCount >= 1 then
            table.insert(targets, bone:GetChild(0))
        end

        if bone.childCount >= 2 then
            table.insert(targets, bone:GetChild(1))
        end

        return targets
    end

    if bone.childCount > 0 then
        return { bone:GetChild(0) }
    end

    return { bone }
end

--====================================================
-- SCALE FUNCTIONS
--====================================================

function FL_SetBoneScale(human, i, x, y, z)

    y = y or x
    z = z or x

    local targets = FL_GetBoneTargets(human, i)

    for _, b in ipairs(targets) do
        b.localScale = Vector3(x, y, z)
    end
end

function FL_AdjustBoneScale(human, i, dx, dy, dz)
    dy = (dy ~= nil) and dy or dx
    dz = (dz ~= nil) and dz or dx
    local targets = FL_GetBoneTargets(human, i)
    for _, b in ipairs(targets) do
        local s = b.localScale
        b.localScale = Vector3(
            tonumber(s.x) + dx,
            tonumber(s.y) + dy,
            tonumber(s.z) + dz
        )
    end
end

function FL_AdjustAxisScale(transform, axis, delta)
    local s = transform.localScale

    if axis == "x" then
        transform.localScale = Vector3(s.x + delta, s.y, s.z)
    elseif axis == "y" then
        transform.localScale = Vector3(s.x, s.y + delta, s.z)
    elseif axis == "z" then
        transform.localScale = Vector3(s.x, s.y, s.z + delta)
    end
end
--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

for partName, partData in pairs(FL_BodyPartDefs) do
    if partData.category == "Core" then
        table.insert(FL_CoreParts, partName)
    elseif partData.category == "Face" then
        table.insert(FL_FaceParts, partName)
    elseif partData.category == "Arms" then
        if partData.sub == "Fingers - L" then
            table.insert(FL_FingerLParts, partName)
        elseif partData.sub == "Fingers - R" then
            table.insert(FL_FingerRParts, partName)
        else
            table.insert(FL_ArmParts, partName)
        end
    elseif partData.category == "Legs" then
        table.insert(FL_LegParts, partName)
    end
end

function FL_DefaultWrist()
    return Wrist(HPoint(0, -0.3, 0.7, 90), 0, -1)
end

function FL_DefaultAnkle()
    return Ankle(HPoint(0, 0, 1, 0), true)
end

function RegisterEyeEffects(human)
    AnimParts_DefaultEffects["EyeL"] = function(x, y, z)
        local m = FL_EyeMode_Get("EyeL")
        if m == 1 then
            return EyeL(CameraPos())
        else
            return EyeL(x + 0.0, y + 0.0, z + 0.0)
        end
    end

    AnimParts_DefaultEffects["EyeR"] = function(x, y, z)
        local m = FL_EyeMode_Get("EyeR")
        if m == 1 then
            return EyeR(CameraPos())
        else
            return EyeR(x + 0.0, y + 0.0, z + 0.0)
        end
    end
end

function FL_RegisterEyeOverride()
    AnimParts_DefaultEffects["Eyes"] = function(x, y, z)
        local m = FL_EyeMode_Get("Eyes")
        if m == 1 then
            return EyeL(CameraPos()), EyeR(CameraPos())
        else
            return EyeL(x, y, z), EyeR(x, y, z)
        end
    end
    AnimParts_DefaultEffects["EyeL"] = nil
    AnimParts_DefaultEffects["EyeR"] = nil
end

FL_RegisterEyeOverride()

function FL_HipsMode_Get()
    if not ActiveAnimHuman then return 0 end
    FL_HipsMode[ActiveAnimHuman] = FL_HipsMode[ActiveAnimHuman] or 0
    return FL_HipsMode[ActiveAnimHuman]
end

function FL_HipsMode_Toggle()
    if not ActiveAnimHuman then return end
    FL_HipsMode[ActiveAnimHuman] = (FL_HipsMode[ActiveAnimHuman] == 0) and 1 or 0
    Anim_OnValueChanged(ActiveAnimHumanObj, "Hips")
end

function FL_HipsModeName()
    return (FL_HipsMode_Get() == 0) and "Float" or "WPos"
end

function FL_EyeMode_Get(partName)
    if not ActiveAnimHuman then return 0 end
    if not partName then return 0 end
    local hid = ActiveAnimHuman
    FL_EyeMode[hid] = FL_EyeMode[hid] or {}
    return FL_EyeMode[hid][partName] or 0
end

function FL_EyeMode_Cycle(partName, delta)
    if not ActiveAnimHuman then return end
    if not partName then return end
    local hid = ActiveAnimHuman
    if type(FL_EyeMode) ~= "table" then FL_EyeMode = {} end
    FL_EyeMode[hid] = FL_EyeMode[hid] or {}
    local current = FL_EyeMode[hid][partName] or 0
    local next = current + delta
    if next > 1 then next = 0 end
    if next < 0 then next = 1 end
    FL_EyeMode[hid][partName] = next
    Anim_OnValueChanged(ActiveAnimHumanObj, partName)
end

function FL_EyeModeName(mode)
    local m = math.floor((mode or 0) + 0.5)
    if m == 0 then return "Float" end
    return "Camera"
end

-- Separate toggle functions for foot snap
function FootSnap_ToggleCurrentPose()
    local p = AP()
    if not p then return end
    local pose = p.Poses[p.ActivePose]
    if not pose then return end
    pose[4]    = (pose[4] ~= 0) and 0 or 1
    Anim_Menu4 = pose[4]
    Anim_OnValueChanged(ActiveAnimHumanObj, ActiveAnimPart)
end

function FootSnap_ToggleAllPoses()
    local hid  = ActiveAnimHuman
    local part = AnimParts[hid] and AnimParts[hid][ActiveAnimPart]
    if not part then return end
    local current = part.Poses[part.ActivePose][4] or 1
    local newSnap = (current ~= 0) and 0 or 1
    Anim_ApplyToAllPoses(ActiveAnimHuman, ActiveAnimPart, 4, "=", newSnap)
    Anim_Menu4 = newSnap
    Anim_OnValueChanged(ActiveAnimHumanObj, ActiveAnimPart)
end

-- Generate global wrapper variables dynamically
function FL_CreateBodyVars()
    for part, def in pairs(FL_BodyPartDefs) do
        local axes = def.axes
        local defaults = def.defaults
        for axis = 1, axes do
            local defaultValue = defaults and defaults[axis] or 0
            for pose = 1, FL_POSES do
                local varName = part..axis.."_Pose"..pose
                _G[varName] = defaultValue
            end
        end
    end
end

-- Initialize all wrapper globals at startup
FL_CreateBodyVars()

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

if mouthParams == nil or #mouthParams ~= 16 then
    mouthParams = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
end
if cheeksParams == nil or #cheeksParams ~= 2 then
    cheeksParams = {0, 0}
end
if browsParams == nil or #browsParams ~= 4 then
    browsParams = {0, 0, 0, 0}
end
if fingerParams == nil or #fingerParams ~= 5 then
	fingerParams = {
    ThumbL = {0, 0, 0, 0, 0},
    IndexL = {0, 0, 0, 0, 0},
    MidL   = {0, 0, 0, 0, 0},
    RingL  = {0, 0, 0, 0, 0},
    PinkyL = {0, 0, 0, 0, 0},
    ThumbR = {0, 0, 0, 0, 0},
    IndexR = {0, 0, 0, 0, 0},
    MidR   = {0, 0, 0, 0, 0},
    RingR  = {0, 0, 0, 0, 0},
    PinkyR = {0, 0, 0, 0, 0}
}
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
label fauna_LABS_Menu(human, hitTri)
	+ "Remove Penis"[if human.m_isMale == false and human.Penis.IsActive]
		human.Customize("Penis", 0)
	+ "Stop All Animations" [if HasAnyAnimation(human)]
		StopAllAnimations(human)
		Return()
	+ "Stop Music"
		StopMusic()
		Return()
	+ "Stop auto cumming."[if human.Penis.IsActive and game.HasAnim(human.Penis)]
			game.RemoveAnim(human.Penis)
	+ "Start thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false]
		human.Penis.Interaction.AutoActive = true
		human.Penis.Interaction.AutoPenisWeight = 1
		Return()
	+ "Stop thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == true]
		human.Penis.Interaction.AutoActive = false
		Return()
	+ "Start sucking!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == false]
		human.Mouth.Fucker.Penis.Interaction.AutoActive = true
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = 0
		Return()
	+ "Stop sucking!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true]
		human.Mouth.Fucker.Penis.Interaction.AutoActive = false
		Return()
	+ "Start hj" [if human.Penis.m_holdDepth ~= 0 and human.Penis.Interaction.m_autoHandActive == false]
		human.Penis.Interaction.m_autoHandActive = true
		Return()
	+ "Stop hj" [if human.Penis.m_holdDepth ~= 0 and human.Penis.Interaction.m_autoHandActive == true]
		human.Penis.Interaction.m_autoHandActive = false
		Return()
	+ "Options.."[gold]
		local s = Faunalabs.state
		+ "Config.."[gold]
			+ ("Custom Overrides: " .. tostring(s.FL_custom_Overrides_Enabled))
				s.FL_custom_Overrides_Enabled = not s.FL_custom_Overrides_Enabled
				Return()
			+ ("Custom Body: " .. tostring(s.FL_custom_Body_Enabled))
				s.FL_custom_Body_Enabled = not s.FL_custom_Body_Enabled
				Return()
			+ ("Custom Clothing: " .. tostring(s.FL_custom_Clothing_Enabled))
				s.FL_custom_Clothing_Enabled = not s.FL_custom_Clothing_Enabled
				Return()
			+ ("Custom Characters: " .. tostring(s.FL_custom_Characters_Enabled))
				s.FL_custom_Characters_Enabled = not s.FL_custom_Characters_Enabled
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Music.."[gold]
			local tracklist = {"01_Dreamy_Whisper", "02_Moon-blind", "03_OpenMeBabe", "04_What_an_Easy_Good-bye", "05_Somtimes", "06_Love_in_Fareast", "07_Tender_Passion", "08_Orbit", "09_Dancing_Queen", "10_Memories_of_Childhood", "11_Raggae_Fever", "12_Why", "13_Comma", "14_NoWar", "15_Special_Light", "16_Enjoy_Yaslef", "17_Lyve_Live", "18_Aquabelle", "19_1st_Mission", "20_Time_to_Groove", "21_Love_is_Bubble", "22_Flower_Bearing", "23_Secret_Garden_Before", "24_X-ray", "25_CallousCall", "26_Order_Circle", "27_This_is_My_Stage", "28_Wait_4_U", "29_Welcome_to_Radux_World", "30_Journey_to_You"}
			--game "Choose a track"
			+ "<color=#54b095><i>Back."
				Return (2)
			+ for i, track in ipairs(tracklist)
				+ "Play " .. track
					Music(track , 0.05, 0)
			+ "Stop Music"
				StopMusic()
				Return(2)
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Cum.."[gold]
			+ "Fluid Speed = " .. FL_Fluidspeed .. ".."[gold]
				+ "^ ~ 5"
					FL_Fluidspeed = FL_Fluidspeed + 5
					human.Body("Fluid speed", FL_Fluidspeed)
					Return()
				+ "-"
					FL_Fluidspeed = FL_Fluidspeed - 5
					human.Body("Fluid speed", FL_Fluidspeed)
					Return()
				+ "^ ~ 2"
					FL_Fluidspeed = FL_Fluidspeed + 2
					human.Body("Fluid speed", FL_Fluidspeed)
					Return()
				+ "-"
					FL_Fluidspeed = FL_Fluidspeed - 2
					human.Body("Fluid speed", FL_Fluidspeed)
					Return()
				+ "^ ~ 0.25"
					FL_Fluidspeed = FL_Fluidspeed + 0.25
					human.Body("Fluid speed", FL_Fluidspeed)
					Return()
				+ "-"
					FL_Fluidspeed = FL_Fluidspeed - 0.25
					human.Body("Fluid speed", FL_Fluidspeed)
					Return()
				+ "<color=#54b095><i>Back. | " .. FL_Fluidspeed .. ""
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Fluid Spread = " .. FL_Fluidspread .. ".."[gold]
				+ "^ ~ 5"
					FL_Fluidspread = FL_Fluidspread + 5
					human.Body("Fluid spread", FL_Fluidspread)
					Return()
				+ "-"
					FL_Fluidspread = FL_Fluidspread - 5
					human.Body("Fluid spread", FL_Fluidspread)
					Return()
				+ "^ ~ 2"
					FL_Fluidspread = FL_Fluidspread + 2
					human.Body("Fluid spread", FL_Fluidspread)
					Return()
				+ "-"
					FL_Fluidspread = FL_Fluidspread - 2
					human.Body("Fluid spread", FL_Fluidspread)
					Return()
				+ "^ ~ 0.25"
					FL_Fluidspread = FL_Fluidspread + 0.25
					human.Body("Fluid spread", FL_Fluidspread)
					Return()
				+ "-"
					FL_Fluidspread = FL_Fluidspread - 0.25
					human.Body("Fluid spread", FL_Fluidspread)
					Return()
				+ "<color=#54b095><i>Back. | " .. FL_Fluidspread .. ""
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Fluid Amount = " .. FL_Fluidamount .. ".."[gold]
				+ "^ ~ 5"
					FL_Fluidamount = FL_Fluidamount + 5
					human.Body("Fluid amount", FL_Fluidamount)
					Return()
				+ "-"
					FL_Fluidamount = FL_Fluidamount - 5
					human.Body("Fluid amount", FL_Fluidamount)
					Return()
				+ "^ ~ 2"
					FL_Fluidamount = FL_Fluidamount + 2
					human.Body("Fluid amount", FL_Fluidamount)
					Return()
				+ "-"
					FL_Fluidamount = FL_Fluidamount - 2
					human.Body("Fluid amount", FL_Fluidamount)
					Return()
				+ "^ ~ 0.25"
					FL_Fluidamount = FL_Fluidamount + 0.25
					human.Body("Fluid amount", FL_Fluidamount)
					Return()
				+ "-"
					FL_Fluidamount = FL_Fluidamount - 0.25
					human.Body("Fluid amount", FL_Fluidamount)
					Return()
				+ "<color=#54b095><i>Back. = " .. FL_Fluidamount .. ""
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Fluid Force = " .. FL_Fluidforce .. ".."[gold]
				+ "^ ~ 5"
					FL_Fluidforce = FL_Fluidforce + 5
					human.Body("Fluid force", FL_Fluidforce)
					Return()
				+ "-"
					FL_Fluidforce = FL_Fluidforce - 5
					human.Body("Fluid force", FL_Fluidforce)
					Return()
				+ "^ ~ 2"
					FL_Fluidforce = FL_Fluidforce + 2
					human.Body("Fluid force", FL_Fluidforce)
					Return()
				+ "-"
					FL_Fluidforce = FL_Fluidforce - 2
					human.Body("Fluid force", FL_Fluidforce)
					Return()
				+ "^ ~ 0.25"
					FL_Fluidforce = FL_Fluidforce + 0.25
					human.Body("Fluid force", FL_Fluidforce)
					Return()
				+ "-"
					FL_Fluidforce = FL_Fluidforce - 0.25
					human.Body("Fluid force", FL_Fluidforce)
					Return()
				+ "<color=#54b095><i>Back. " .. FL_Fluidforce .. ""
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Fluid Gravity = " .. FL_Fluidgravity .. ".."[gold]
				+ "^ ~ 5"
					FL_Fluidgravity = FL_Fluidgravity + 5
					human.Body("Fluid gravity", FL_Fluidgravity)
					Return()
				+ "-"
					FL_Fluidgravity = FL_Fluidgravity - 5
					human.Body("Fluid gravity", FL_Fluidgravity)
					Return()
				+ "^ ~ 2"
					FL_Fluidgravity = FL_Fluidgravity + 2
					human.Body("Fluid gravity", FL_Fluidgravity)
					Return()
				+ "-"
					FL_Fluidgravity = FL_Fluidgravity - 2
					human.Body("Fluid gravity", FL_Fluidgravity)
					Return()
				+ "^ ~ 0.25"
					FL_Fluidgravity = FL_Fluidgravity + 0.25
					human.Body("Fluid gravity", FL_Fluidgravity)
					Return()
				+ "-"
					FL_Fluidgravity = FL_Fluidgravity - 0.25
					human.Body("Fluid gravity", FL_Fluidgravity)
					Return()
				+ "<color=#54b095><i>Back. " .. FL_Fluidgravity .. ""
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ if human.Penis.IsActive
				+ "Reset foreskin"
					human.Penis.m_penisSkinOut = 0
					Return()
				+ "Auto Cumming.."[gold]
					+ "2 sec."
						Faun_autoCUM = 2
						game.AddRepeatAnim(Faun_autoCUM, || human.Shoot(), human.Penis)
						Return()
					+ "10 sec."
						Faun_autoCUM = 10
						game.AddRepeatAnim(Faun_autoCUM, || human.Shoot(), human.Penis)
						Return()
					-- + "WIP - Random - 7 > 90"
					-- 	game.AddRepeatAnim(Faun_autoCUM, || human.Shoot(), human.Penis)
					-- 	Return()
					+ "30 sec."
						Faun_autoCUM = 30
						game.AddRepeatAnim(Faun_autoCUM, || human.Shoot(), human.Penis)
						Return()
					+ "^ 5 sec"
						Faun_autoCUM = Faun_autoCUM + 5
						Return()
					+ "^ 10 sec"
						Faun_autoCUM = Faun_autoCUM + 10
						Return()
					+ "- 10 sec"
						Faun_autoCUM = Faun_autoCUM - 10
						Return()
					+ "Start: " .. Faun_autoCUM .. " Seconds."
						game.AddRepeatAnim(Faun_autoCUM, || human.Shoot(), human.Penis)
						Return()
					+ if human.Penis.IsActive and game.HasAnim(human.Penis)
						+ "Stop auto cumming."
							game.RemoveAnim(human.Penis)
							Return()
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "<color=#9a646f><i>Done. Must toggle to update increment."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Vagina Wetness.."[gold]
			+ "^ | 500"[gold]
				human.m_vagina.m_wetness = human.m_vagina.m_wetness + 500
				Return()
			+ "^ | 200"[gold]
				human.m_vagina.m_wetness = human.m_vagina.m_wetness + 200
				Return()
			+ "-"
				human.m_vagina.m_wetness = math.max(0, human.m_vagina.m_wetness - 200)
				Return()
			+ "Reset. | Wetness = " .. human.m_vagina.m_wetness .. ""
				human.m_vagina.m_wetness = 500
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Mouth Wetness.."[gold]
			+ "^ | 500"[gold]
				human.m_mouth.m_wetness = human.m_mouth.m_wetness + 500
				Return()
			+ "^ | 200"[gold]
				human.m_mouth.m_wetness = human.m_mouth.m_wetness + 200
				Return()
			+ "-"
				human.m_mouth.m_wetness = math.max(0, human.m_mouth.m_wetness - 200)
				Return()
			+ "Reset. | Wetness = " .. human.m_mouth.m_wetness .. ""
				human.m_mouth.m_wetness = 200
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ if human.m_isMale == false
			+ "<color=#90ee90><i>Penetration is Turned On"
				human.m_isMale = true
				Return()
		+ if human.m_isMale == true
			+ "<color=#f08080><i>Penetration is Turned Off"
				human.m_isMale = false
				Return()
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "<color=#9a646f><i>Done."
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	+ "Poses.."[gold]
		+ "Default.."[gold]
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
			+ for i, pres in ipairs (bodystr)
				+ " " .. pres
					human.Pose(bodypresets[i]())
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
			+ for i, preset in ipairs(Faun_Body)
				+ " " .. preset.name
					human.Pose(preset.pose())
					Return()
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
		+ "poseLAB.."[gold]
			+ "face.."[gold]
				+ "0.5"
					FACE_PARAM_INCREMENT = 0.5
					Return()
				+ "0.25"
					FACE_PARAM_INCREMENT = 0.25
					Return()
				+ "0.1"
					FACE_PARAM_INCREMENT = 0.1
					Return()
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				+ "Cheeks.."[gold]
					+ "Left/Right.."[gold]
						+ "^ | Left"[gold]
							human.Pose(Cheekspar1_A())
							Return()
						+ "-"
							human.Pose(Cheekspar1_B())
							Return()
						+ "Reset Cheek Parameter 1"
							human.Pose(ResetCheeksParam(human, 1))
							Return()
						+ "^ | Right"[gold]
							human.Pose(Cheekspar2_A())
							Return()
						+ "-"
							human.Pose(Cheekspar2_B())
							Return()
						+ "Reset Cheek Parameter 2"
							human.Pose(ResetCheeksParam(human, 2))
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "Both.."[gold]
						+ "^ | Both"[gold]
							human.Pose(Cheekspar1_A())
							human.Pose(Cheekspar2_A())
							Return()
						+ "-"
							human.Pose(Cheekspar1_B())
							human.Pose(Cheekspar2_B())
							Return()
						+ "Reset Cheek Parameters"
							human.Pose(ResetCheeksParam(human, 1))
							human.Pose(ResetCheeksParam(human, 2))
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "<color=#9a646f><i>Done."
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				+ "Brows.."[gold]
					+ "Right Brow.."[gold]
						+ "^ | Right Inner"[gold]
							human.Pose(Browspar1_A())
							Return()
						+ "-"
							human.Pose(Browspar1_B())
							Return()
						+ "Reset Brows Parameter 1"
							human.Pose(ResetBrowsParam(human, 1))
							Return()
						+ "^ | Right Outer"[gold]
							human.Pose(Browspar3_A())
							Return()
						+ "-"
							human.Pose(Browspar3_B())
							Return()
						+ "Reset Brows Parameter 3"
							human.Pose(ResetBrowsParam(human, 3))
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "Left Brow.."[gold]
						+ "^ | Left Inner"[gold]
							human.Pose(Browspar2_A())
							Return()
						+ "-"
							human.Pose(Browspar2_B())
							Return()
						+ "Reset Brows Parameter 2"
							human.Pose(ResetBrowsParam(human, 2))
							Return()
						+ "^ | Left Outer"[gold]
							human.Pose(Browspar4_A())
							Return()
						+ "-"
							human.Pose(Browspar4_B())
							Return()
						+ "Reset Brows Parameter 4"
							human.Pose(ResetBrowsParam(human, 4))
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "Both Brows.."[gold]
						+ "^ | Left"[gold]
							human.Pose(Browspar4_A())
							human.Pose(Browspar2_A())
							Return()
						+ "-"
							human.Pose(Browspar4_B())
							human.Pose(Browspar2_B())
							Return()
						+ "^ | Right"[gold]
							human.Pose(Browspar1_A())
							human.Pose(Browspar3_A())
							Return()
						+ "-"
							human.Pose(Browspar1_B())
							human.Pose(Browspar3_B())
							Return()
						+ "^ | Inner"[gold]
							human.Pose(Browspar1_A())
							human.Pose(Browspar2_A())
							Return()
						+ "-"
							human.Pose(Browspar1_B())
							human.Pose(Browspar2_B())
							Return()
						+ "^ | Outer"[gold]
							human.Pose(Browspar3_A())
							human.Pose(Browspar4_A())
							Return()
						+ "-"
							human.Pose(Browspar3_B())
							human.Pose(Browspar4_B())
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "^ | Both"[gold]
						human.Pose(Browspar1_A())
						human.Pose(Browspar2_A())
						human.Pose(Browspar3_A())
						human.Pose(Browspar4_A())
						Return()
					+ "-"
						human.Pose(Browspar1_B())
						human.Pose(Browspar2_B())
						human.Pose(Browspar3_B())
						human.Pose(Browspar4_B())
						Return()
					+ "Reset Both Brows"
						human.Pose(ResetALLBrowsParam(human))
						Return()
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "<color=#9a646f><i>Done."
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				+ "Mouth.."[gold]
					+ "Jaw V/H.."[gold]
						+ "^ | Vertical"[gold]
							human.Pose(Mouthpar1_A())
							Return()
						+ "-"
							human.Pose(Mouthpar1_B())
							Return()
						+ "Reset Mouth Parameter 1"
							human.Pose(ResetMouthParam(human, 1))
							Return()
						+ "^ | Horizontal"[gold]
							human.Pose(Mouthpar2_A())
							Return()
						+ "-"
							human.Pose(Mouthpar2_B())
							Return()
						+ "Reset Mouth Parameter 2"
							human.Pose(ResetMouthParam(human, 2))
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "Jaw Length.."[gold]
						+ "^ | Length"[gold]
							human.Pose(Mouthpar3_A())
							Return()
						+ "-"
							human.Pose(Mouthpar3_B())
							Return()
						+ "Reset Mouth Parameter 3"
							ResetMouthParam(human, 3)
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "Lips.." [gold]
						+ "Lip Top.."[gold]
							+ "^ | Top Right"[gold]
								human.Pose(Mouthpar4_A())
								Return()
							+ "-"
								human.Pose(Mouthpar4_B())
								Return()
							+ "Reset Mouth Parameter 4"
								ResetMouthParam(human, 4)
								Return()
							+ "^ | Top Left"[gold]
								human.Pose(Mouthpar5_A())
								Return()
							+ "-"
								human.Pose(Mouthpar5_B())
								Return()
							+ "Reset Mouth Parameter 5"
								ResetMouthParam(human, 5)
								Return()
							+ "^ | Both"[gold]
								human.Pose(Mouthpar4_A())
								human.Pose(Mouthpar5_A())
								Return()
							+ "-"
								human.Pose(Mouthpar4_B())
								human.Pose(Mouthpar5_B())
								Return()
							+ "<color=#54b095><i>Back."
								Return(2)
							+ "<color=#9a646f><i>Done."
						+ "Lip Bottom.."[gold]
							+ "^ | Bottom Right"[gold]
								human.Pose(Mouthpar6_A())
								Return()
							+ "-"
								human.Pose(Mouthpar6_B())
								Return()
							+ "Reset Mouth Parameter 6"
								ResetMouthParam(human, 6)
								Return()
							+ "^ | Bottom Left"[gold]
								human.Pose(Mouthpar7_A())
								Return()
							+ "-"
								human.Pose(Mouthpar7_B())
								Return()
							+ "Reset Mouth Parameter 7"
								ResetMouthParam(human, 7)
								Return()
							+ "^ | Both"[gold]
								human.Pose(Mouthpar6_A())
								human.Pose(Mouthpar7_A())
								Return()
							+ "-"
								human.Pose(Mouthpar6_B())
								human.Pose(Mouthpar7_B())
								Return()
							+ "<color=#54b095><i>Back."
								Return(2)
							+ "<color=#9a646f><i>Done."
						+ "Smile.."[gold]
							+ "^ | Right"[gold]
								human.Pose(Mouthpar8_A())
								Return()
							+ "-"
								human.Pose(Mouthpar8_B())
								Return()
							+ "Reset Mouth Parameter 8"
								ResetMouthParam(human, 8)
								Return()
							+ "^ | Left"[gold]
								human.Pose(Mouthpar9_A())
								Return()
							+ "-"
								human.Pose(Mouthpar9_B())
								Return()
							+ "Reset Mouth Parameter 9"
								ResetMouthParam(human, 9)
								Return()
							+ "^ | Both"[gold]
								human.Pose(Mouthpar8_A())
								human.Pose(Mouthpar9_A())
								Return()
							+ "-"
								human.Pose(Mouthpar8_B())
								human.Pose(Mouthpar9_B())
								Return()
							+ "<color=#54b095><i>Back."
								Return(2)
							+ "<color=#9a646f><i>Done."
						+ "Lip Horizontal.."[gold]
							+ "^ | Right"[gold]
								human.Pose(Mouthpar10_A())
								Return()
							+ "-"
								human.Pose(Mouthpar10_B())
								Return()
							+ "Reset Mouth Parameter 10"
								ResetMouthParam(human, 10)
								Return()
							+ "^ | Left"[gold]
								human.Pose(Mouthpar11_A())
								Return()
							+ "-"
								human.Pose(Mouthpar11_B())
								Return()
							+ "Reset Mouth Parameter 11"
								ResetMouthParam(human, 11)
								Return()
							+ "^ | Both"[gold]
								human.Pose(Mouthpar10_A())
								human.Pose(Mouthpar11_A())
								Return()
							+ "-"
								human.Pose(Mouthpar10_B())
								human.Pose(Mouthpar11_B())
								Return()
							+ "<color=#54b095><i>Back."
								Return(2)
							+ "<color=#9a646f><i>Done."
						+ "Lip Vertical.."[gold]
							+ "^ | Height"[gold]
								human.Pose(Mouthpar12_A())
								Return()
							+ "-"
								human.Pose(Mouthpar12_B())
								Return()
							+ "Reset Mouth Parameter 12"
								ResetMouthParam(human, 12)
								Return()
							+ "<color=#54b095><i>Back."
								Return(2)
							+ "<color=#9a646f><i>Done."
						+ "Lip Length / Curve.."[gold]
							+ "^ | Length"[gold]
								human.Pose(Mouthpar13_A())
								Return()
							+ "-"
								human.Pose(Mouthpar13_B())
								Return()
							+ "Reset Mouth Parameter 13"
								ResetMouthParam(human, 13)
								Return()
							+ "<color=#54b095><i>Back."
								Return(2)
							+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "Tongue Length.."[gold]
						+ "^ | Length"[gold]
							human.Pose(Mouthpar14_A())
							Return()
						+ "-"
							human.Pose(Mouthpar14_B())
							Return()
						+ "Reset Mouth Parameter 14"
							ResetMouthParam(human, 14)
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "Tongue Horizontal / Vertical.."[gold]
						+ "^ | Horizontal"[gold]
							human.Pose(Mouthpar15_A())
							Return()
						+ "-"
							human.Pose(Mouthpar15_B())
							Return()
						+ "Reset Mouth Parameter 15"
							ResetMouthParam(human, 15)
							Return()
						+ "^ | Vertical"[gold]
							human.Pose(Mouthpar16_A())
							Return()
						+ "-"
							human.Pose(Mouthpar16_B())
							Return()
						+ "Reset Mouth Parameter 16"
							ResetMouthParam(human, 16)
							Return()
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "<color=#9a646f><i>Done."
					+ "Reset Mouth"
						human.Pose(ResetALLMouthParam(human))
						Return()
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back. | Increment = "  .. FACE_PARAM_INCREMENT .. ""
					Return(2)
				+ "<color=#9a646f><i>Done."
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------






	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------
			+ "Fingers.."[gold]
				+ "  5"
					FINGER_PARAM_INCREMENT = 5
					Return()
				+ "  2"
					FINGER_PARAM_INCREMENT = 2
					Return()
				+ "  1"
					FINGER_PARAM_INCREMENT = 1
					Return()
				+ "0.25"
					FINGER_PARAM_INCREMENT = 0.25
					Return()
				+ "Left Hand.."[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "ThumbL.."[gold]
						+ "Reset ThumbL"
							ResetAllFingerParams(human, "ThumbL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "ThumbL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "ThumbL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "ThumbL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "ThumbL", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(ThumbL_J1_Inc())
							Return()
						+ "-"
							human.Pose(ThumbL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(ThumbL_J2_Inc())
							Return()
						+ "-"
							human.Pose(ThumbL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(ThumbL_J3_Inc())
							Return()
						+ "-"
							human.Pose(ThumbL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(ThumbL_J4_Inc())
							Return()
						+ "-"
							human.Pose(ThumbL_J4_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "IndexL.."[gold]
						+ "Reset IndexL"
							ResetAllFingerParams(human, "IndexL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "IndexL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "IndexL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "IndexL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "IndexL", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(IndexL_J1_Inc())
							Return()
						+ "-"
							human.Pose(IndexL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(IndexL_J2_Inc())
							Return()
						+ "-"
							human.Pose(IndexL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(IndexL_J3_Inc())
							Return()
						+ "-"
							human.Pose(IndexL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(IndexL_J4_Inc())
							Return()
						+ "-"
							human.Pose(IndexL_J4_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "MidL.."[gold]
						+ "Reset MidL"
							ResetAllFingerParams(human, "MidL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "MidL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "MidL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "MidL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "MidL", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(MidL_J1_Inc())
							Return()
						+ "-"
							human.Pose(MidL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(MidL_J2_Inc())
							Return()
						+ "-"
							human.Pose(MidL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(MidL_J3_Inc())
							Return()
						+ "-"
							human.Pose(MidL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(MidL_J4_Inc())
							Return()
						+ "-"
							human.Pose(MidL_J4_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "RingL.."[gold]
						+ "Reset RingL"
							ResetAllFingerParams(human, "RingL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "RingL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "RingL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "RingL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "RingL", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(RingL_J1_Inc())
							Return()
						+ "-"
							human.Pose(RingL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(RingL_J2_Inc())
							Return()
						+ "-"
							human.Pose(RingL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(RingL_J3_Inc())
							Return()
						+ "-"
							human.Pose(RingL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(RingL_J4_Inc())
							Return()
						+ "-"
							human.Pose(RingL_J4_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "PinkyL.."[gold]
						+ "Reset PinkyL"
							ResetAllFingerParams(human, "PinkyL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "PinkyL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "PinkyL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "PinkyL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "PinkyL", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(PinkyL_J1_Inc())
							Return()
						+ "-"
							human.Pose(PinkyL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(PinkyL_J2_Inc())
							Return()
						+ "-"
							human.Pose(PinkyL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(PinkyL_J3_Inc())
							Return()
						+ "-"
							human.Pose(PinkyL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(PinkyL_J4_Inc())
							Return()
						+ "-"
							human.Pose(PinkyL_J4_Dec())
							Return()
					-- Repeat for IndexL, MidL, RingL, PinkyL
					+ "Reset All Left Fingers"
						human.Pose(ResetALLleftFingerParams(human))
						Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------






				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				+ "Right Hand.."[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "ThumbR.."[gold]
						+ "Reset ThumbR"
							ResetAllFingerParams(human, "ThumbR")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "ThumbR", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "ThumbR", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "ThumbR", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "ThumbR", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(ThumbR_J1_Inc())
							Return()
						+ "-"
							human.Pose(ThumbR_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(ThumbR_J2_Inc())
							Return()
						+ "-"
							human.Pose(ThumbR_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(ThumbR_J3_Inc())
							Return()
						+ "-"
							human.Pose(ThumbR_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(ThumbR_J4_Inc())
							Return()
						+ "-"
							human.Pose(ThumbR_J4_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "IndexR.."[gold]
						+ "Reset IndexR"
							ResetAllFingerParams(human, "IndexR")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "IndexR", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "IndexR", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "IndexR", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "IndexR", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(IndexR_J1_Inc())
							Return()
						+ "-"
							human.Pose(IndexR_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(IndexR_J2_Inc())
							Return()
						+ "-"
							human.Pose(IndexR_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(IndexR_J3_Inc())
							Return()
						+ "-"
							human.Pose(IndexR_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(IndexR_J4_Inc())
							Return()
						+ "-"
							human.Pose(IndexR_J4_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "MidR.."[gold]
						+ "Reset MidR"
							ResetAllFingerParams(human, "MidR")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "MidR", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "MidR", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "MidR", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "MidR", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(MidR_J1_Inc())
							Return()
						+ "-"
							human.Pose(MidR_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(MidR_J2_Inc())
							Return()
						+ "-"
							human.Pose(MidR_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(MidR_J3_Inc())
							Return()
						+ "-"
							human.Pose(MidR_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(MidR_J4_Inc())
							Return()
						+ "-"
							human.Pose(MidR_J4_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "RingR.."[gold]
						+ "Reset RingR"
							ResetAllFingerParams(human, "RingR")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "RingR", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "RingR", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "RingR", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "RingR", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(RingR_J1_Inc())
							Return()
						+ "-"
							human.Pose(RingR_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(RingR_J2_Inc())
							Return()
						+ "-"
							human.Pose(RingR_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(RingR_J3_Inc())
							Return()
						+ "-"
							human.Pose(RingR_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(RingR_J4_Inc())
							Return()
						+ "-"
							human.Pose(RingR_J4_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "PinkyR.."[gold]
						+ "Reset PinkyR"
							ResetAllFingerParams(human, "PinkyR")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "PinkyR", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "PinkyR", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "PinkyR", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "PinkyR", 4)
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(PinkyR_J1_Inc())
							Return()
						+ "-"
							human.Pose(PinkyR_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(PinkyR_J2_Inc())
							Return()
						+ "-"
							human.Pose(PinkyR_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(PinkyR_J3_Inc())
							Return()
						+ "-"
							human.Pose(PinkyR_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(PinkyR_J4_Inc())
							Return()
						+ "-"
							human.Pose(PinkyR_J4_Dec())
							Return()
					+ "Reset All Right Fingers."
						human.Pose(ResetALLrightFingerParams())
						Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------






				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------

				+ "Both Hands"[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "Both Thumbs"
						+ "Reset Thumbs"
							ResetAllFingerParams(human, "ThumbR")
							ResetAllFingerParams(human, "ThumbL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "ThumbR", 1)
							ResetFingerParam(human, "ThumbL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "ThumbR", 2)
							ResetFingerParam(human, "ThumbL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "ThumbR", 3)
							ResetFingerParam(human, "ThumbL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "ThumbR", 4)
							ResetFingerParam(human, "ThumbL", 4)
							Return()
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(ThumbR_J1_Inc())
							human.Pose(ThumbL_J1_Inc())
							Return()
						+ "-"
							human.Pose(ThumbR_J1_Dec())
							human.Pose(ThumbL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(ThumbR_J2_Inc())
							human.Pose(ThumbL_J2_Inc())
							Return()
						+ "-"
							human.Pose(ThumbR_J2_Dec())
							human.Pose(ThumbL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(ThumbR_J3_Inc())
							human.Pose(ThumbL_J3_Inc())
							Return()
						+ "-"
							human.Pose(ThumbR_J3_Dec())
							human.Pose(ThumbL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(ThumbR_J4_Inc())
							human.Pose(ThumbL_J4_Inc())
							Return()
						+ "-"
							human.Pose(ThumbR_J4_Dec())
							human.Pose(ThumbL_J4_Dec())
							Return()
							human.Pose(ThumbL_J5_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "Both Index"
						+ "Reset Index"
							ResetAllFingerParams(human, "IndexR")
							ResetAllFingerParams(human, "IndexL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "IndexR", 1)
							ResetFingerParam(human, "IndexL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "IndexR", 2)
							ResetFingerParam(human, "IndexL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "IndexR", 3)
							ResetFingerParam(human, "IndexL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "IndexR", 4)
							ResetFingerParam(human, "IndexL", 4)
							Return()
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(IndexR_J1_Inc())
							human.Pose(IndexL_J1_Inc())
							Return()
						+ "-"
							human.Pose(IndexR_J1_Dec())
							human.Pose(IndexL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(IndexR_J2_Inc())
							human.Pose(IndexL_J2_Inc())
							Return()
						+ "-"
							human.Pose(IndexR_J2_Dec())
							human.Pose(IndexL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(IndexR_J3_Inc())
							human.Pose(IndexL_J3_Inc())
							Return()
						+ "-"
							human.Pose(IndexR_J3_Dec())
							human.Pose(IndexL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(IndexR_J4_Inc())
							human.Pose(IndexL_J4_Inc())
							Return()
						+ "-"
							human.Pose(IndexR_J4_Dec())
							human.Pose(IndexL_J4_Dec())
							Return()
							human.Pose(IndexL_J5_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "Both Mid"
						+ "Reset Mid"
							ResetAllFingerParams(human, "MidR")
							ResetAllFingerParams(human, "MidL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "MidR", 1)
							ResetFingerParam(human, "MidL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "MidR", 2)
							ResetFingerParam(human, "MidL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "MidR", 3)
							ResetFingerParam(human, "MidL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "MidR", 4)
							ResetFingerParam(human, "MidL", 4)
							Return()
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(MidR_J1_Inc())
							human.Pose(MidL_J1_Inc())
							Return()
						+ "-"
							human.Pose(MidR_J1_Dec())
							human.Pose(MidL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(MidR_J2_Inc())
							human.Pose(MidL_J2_Inc())
							Return()
						+ "-"
							human.Pose(MidR_J2_Dec())
							human.Pose(MidL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(MidR_J3_Inc())
							human.Pose(MidL_J3_Inc())
							Return()
						+ "-"
							human.Pose(MidR_J3_Dec())
							human.Pose(MidL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(MidR_J4_Inc())
							human.Pose(MidL_J4_Inc())
							Return()
						+ "-"
							human.Pose(MidR_J4_Dec())
							human.Pose(MidL_J4_Dec())
							Return()
							human.Pose(MidL_J5_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "Both Ring"
						+ "Reset Ring"
							ResetAllFingerParams(human, "RingR")
							ResetAllFingerParams(human, "RingL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "RingR", 1)
							ResetFingerParam(human, "RingL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "RingR", 2)
							ResetFingerParam(human, "RingL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "RingR", 3)
							ResetFingerParam(human, "RingL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "RingR", 4)
							ResetFingerParam(human, "RingL", 4)
							Return()
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(RingR_J1_Inc())
							human.Pose(RingL_J1_Inc())
							Return()
						+ "-"
							human.Pose(RingR_J1_Dec())
							human.Pose(RingL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(RingR_J2_Inc())
							human.Pose(RingL_J2_Inc())
							Return()
						+ "-"
							human.Pose(RingR_J2_Dec())
							human.Pose(RingL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(RingR_J3_Inc())
							human.Pose(RingL_J3_Inc())
							Return()
						+ "-"
							human.Pose(RingR_J3_Dec())
							human.Pose(RingL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(RingR_J4_Inc())
							human.Pose(RingL_J4_Inc())
							Return()
						+ "-"
							human.Pose(RingR_J4_Dec())
							human.Pose(RingL_J4_Dec())
							Return()
							human.Pose(RingL_J5_Dec())
							Return()
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
				---------------------------------------------------------------------------------------------------------------------------------------------------------------------
					+ "Both Pinky"
						+ "Reset Pinky"
							ResetAllFingerParams(human, "PinkyR")
							ResetAllFingerParams(human, "PinkyL")
							Return()
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back."
							Return(2)
						+ "Reset Joint 1"
							ResetFingerParam(human, "PinkyR", 1)
							ResetFingerParam(human, "PinkyL", 1)
							Return()
						+ "Reset Joint 2"
							ResetFingerParam(human, "PinkyR", 2)
							ResetFingerParam(human, "PinkyL", 2)
							Return()
						+ "Reset Joint 3"
							ResetFingerParam(human, "PinkyR", 3)
							ResetFingerParam(human, "PinkyL", 3)
							Return()
						+ "Reset Joint 4"
							ResetFingerParam(human, "PinkyR", 4)
							ResetFingerParam(human, "PinkyL", 4)
							Return()
							Return()
						+ "^ | Joint 1"[gold]
							human.Pose(PinkyR_J1_Inc())
							human.Pose(PinkyL_J1_Inc())
							Return()
						+ "-"
							human.Pose(PinkyR_J1_Dec())
							human.Pose(PinkyL_J1_Dec())
							Return()
						+ "^ | Joint 2"[gold]
							human.Pose(PinkyR_J2_Inc())
							human.Pose(PinkyL_J2_Inc())
							Return()
						+ "-"
							human.Pose(PinkyR_J2_Dec())
							human.Pose(PinkyL_J2_Dec())
							Return()
						+ "^ | Joint 3"[gold]
							human.Pose(PinkyR_J3_Inc())
							human.Pose(PinkyL_J3_Inc())
							Return()
						+ "-"
							human.Pose(PinkyR_J3_Dec())
							human.Pose(PinkyL_J3_Dec())
							Return()
						+ "^ | Joint 4"[gold]
							human.Pose(PinkyR_J4_Inc())
							human.Pose(PinkyL_J4_Inc())
							Return()
						+ "-"
							human.Pose(PinkyR_J4_Dec())
							human.Pose(PinkyL_J4_Dec())
							Return()
							human.Pose(PinkyL_J5_Dec())
							Return()
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "<color=#9a646f><i>Done."
				+ "Reset All Fingers"
					ResetAllFingers(human)
					Return()
				+ "<color=#54b095><i>Back. | Increment = " .. FINGER_PARAM_INCREMENT .. ".."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "<color=#9a646f><i>Done."
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

	+ "Faces.."[gold]
		+ "Neutral face."
			human.Pose(FaceNeutral())
			Return()
		+ "Default.."[gold]
			+ for i, pres in ipairs (facestr)
				+ " " .. pres
					human.Pose(facepresets[i]())
					Return()
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
			+ for i, preset in ipairs(Faun_Face)
				+ " " .. preset.name
					human.Pose(preset.pose())
					Return()
			+ "Kiss / Tongue.."[gold]
				+ for i, preset in ipairs(Faun_Kiss)
					+ " " .. preset.name
						human.Pose(preset.pose())
						Return()
				+ "Neutral face."
					human.Pose(FaceNeutral())
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
		+ "Loops.."[gold]
			+ "Neutral face."
				human.Pose(FaceNeutral())
				Return()
			+ "Smile > Ahegao"
				game.AddRepeatAnim(2, || CustomLoopsX(human, "Smile > Ahegao", FaceSmile, FaceAhegao), human)
				Return()
			+ "Neutral > Scared"
				game.AddRepeatAnim(3, || CustomLoopsX(human, "Neutral > Scared", FaceNeutral, FaceScared), human)
				Return()
			+ "Angry > Surprised"
				game.AddRepeatAnim(4, || CustomLoopsX(human, "Angry > Surprised", FaceAngry, FaceSurprised), human) 
				Return()
			-- + "Look Actor > Look Camera"
			-- 	game.AddRepeatAnim((math.random(5, 20)), || CustomLoopsX(human, "Look Actor > Look Camera", LookActorA, LookCam), human) 
			-- 	Return()
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
			+ "Toggle Head Tracking"
				FL_ToggleHeadTracking(human)
				Return()
			+ "Cycle Target"
				FL_CycleHeadTarget(human)
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
	+ "Animations.." [gold]	
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
			-- 	game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Grope Breasts", GropebreastBoth1a, GropebreastBoth1b), human.forearmNames)
			-- 	Return(2)
			+ "Right hand.."[if game.HasAnim(human.handNames) == false][gold]
				+ "BJ Gesture"
					human.pose(BJGesture())
					human.pose(TongueOut2())
					game.AddRepeatAnim(0.2/CL_SMult*1.4, || CustomLoopsX(human, "BJ Gesture", Bjgesture_Ra, Bjgesture_Rb), human.handNames)
					Return()
				+ "WIP | Spank"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Spank", Slap_Ra, Slap_Rb), human.handNames)
					Return()
				+ "Beckon"
					human.Pose(Beckon())
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Beckon", Beckon_Ra, Beckon_Rb), human.handNames)
					Return()
				+ "Touch Herself"
					human.Pose(TouchHerself_1R())
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Touch Herself R", TouchHerself_Ra, TouchHerself_Rb), human.handNames)
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
					game.AddRepeatAnim(0.3/CL_SMult*2, || CustomLoopsX(human, "Grope Breast 2 R", Gropebreast_2Ra, Gropebreast_2Rb), human.handNames)
					Return()
				+ "Fingering index"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Rhand", FingeringIMr1, FingeringIMr2), human.handNames)
					Return()
				+ "Fingering middle"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Rhand", FingeringMRr1, FingeringMRr2), human.handNames)
					Return()
				+ "Fingering middle - 2"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Rhand", FingeringMRr3, FingeringMRr4), human.handNames)
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
					human.Pose(TouchHerself_1L())
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Touch Herself L", TouchHerself_La, TouchHerself_Lb), human.forearmNames)
					Return()
				+ "Fingering index"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Lhand", FingeringIMl1, FingeringIMl2), human.forearmNames)
					Return()
				+ "Fingering middle"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Lhand", FingeringMRl1, FingeringMRl2), human.forearmNames)
					Return()
				+ "Fingering middle - 2"
					game.AddRepeatAnim(0.3/CL_SMult, || CustomLoopsX(human, "Rhand", FingeringMRl3, FingeringMRl4), human.forearmNames)
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
					game.AddRepeatAnim(0.6/CL_SMult, || CustomLoopsX(human, "Swaying", HipSway_A, HipSway_B), human)
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
				+ "Stop Humping" [if game.HasAnim(human) == true]
					game.RemoveAnim(human)
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Stop Hip moves" [if game.HasAnim(human.Anus) == true]
				game.RemoveAnim(human.Anus)
				Return()
			+ "Stop Twisting" [if game.HasAnim(human.thighNames) == true]
				game.RemoveAnim(human.thighNames)
				Return()
			+ "Stop Humping"[if game.HasAnim(human) == true]
				game.RemoveAnim(human)
				Return()
			+ "speedlab.."[gold]
				+ "Reset | Ease In"[gold]
					CLV_A = 2
					Return()
				+ "Reset | Ease Out"[gold]
					CLV_B = 2
					Return()
				+ "Reset | Anim Speed"[gold]
					CL_SMult = 1
					Return()
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "^ | Ease In = " .. CLV_A .. ""[gold]
					CLV_A = CLV_A + FL_easeInc
					Return()
				+ "-"
					CLV_A = CLV_A - FL_easeInc
					Return()
				+ "^ | Ease Out = " .. CLV_B .. ""[gold]
					CLV_B = CLV_B + FL_easeInc
					Return()
				+ "-"
					CLV_B = CLV_B - FL_easeInc
					Return()
				+ "^ | Easement = " .. CLV_A .. "/" .. CLV_B .. ""[gold]
					CLV_A = CLV_A + FL_easeInc
					CLV_B = CLV_B + FL_easeInc
					Return()
				+ "-"
					CLV_A = CLV_A - FL_easeInc
					CLV_B = CLV_B - FL_easeInc
					Return()
				+ "^ | speed = " .. CL_SMult .. ""[gold]
					CL_SMult = CL_SMult + FL_speedInc
					Return()
				+ "-"
					CL_SMult = CL_SMult - FL_speedInc
					Return()
				+ "^ | Duration = " .. FL_DurMult .. ""[gold]
					FL_DurMult = FL_DurMult + 0.25
					Return()
				+ "-"
					FL_DurMult = FL_DurMult - 0.25
					Return()
		+ "speedlab.."[gold]
			+ "Reset | Ease In"[gold]
				CLV_A = 2
				Return()
			+ "Reset | Ease Out"[gold]
				CLV_B = 2
				Return()
			+ "Reset | Anim Speed"[gold]
				CL_SMult = 1
				Return()
			+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "^ | Ease In = " .. CLV_A .. ""[gold]
				CLV_A = CLV_A + FL_easeInc
				Return()
			+ "-"
				CLV_A = CLV_A - FL_easeInc
				Return()
			+ "^ | Ease Out = " .. CLV_B .. ""[gold]
				CLV_B = CLV_B + FL_easeInc
				Return()
			+ "^ | Easement = " .. CLV_A .. "/" .. CLV_B .. ""[gold]
				CLV_A = CLV_A + FL_easeInc
				CLV_B = CLV_B + FL_easeInc
				Return()
			+ "-"
				CLV_A = CLV_A - FL_easeInc
				CLV_B = CLV_B - FL_easeInc
				Return()
			+ "^ | speed = " .. CL_SMult .. ""[gold]
				CL_SMult = CL_SMult + FL_speedInc
				Return()
			+ "-"
				CL_SMult = CL_SMult - FL_speedInc
				Return()
			+ "^ | Duration = " .. FL_DurMult .. ""[gold]
				FL_DurMult = FL_DurMult + 0.25
				Return()
			+ "-"
				FL_DurMult = FL_DurMult - 0.25
				Return()

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
	+ "".. human.Name ..".."[gold]
		local p = human.Penis
		local cg = human.Penis.ConnectedGirl
		+ "Status"
			-- local others = game.GetHumans(|h| h ~= human)
			local humans = game.GetHumans()
			local h = human
			local p = h and h.Penis
			local cg = p and p.ConnectedGirl
			+ "Name: " .. tostring(h.Name)
				Return()
			+ if cg
				+ "Connected Girl: " .. tostring(cg or "n/a")
					Return()
			+ if p and p.hole
				+ "Connected Hole: " .. tostring(p and p.hole or "n/a")
					Return()
			+ "Session ID: " .. tostring(h.m_instanceId)
				Return()
			-- + "Mouth Wetness: " .. tostring(h.Mouth.m_wetness)
			-- 	Return()
			-- + "Vagina Wetness: " .. tostring(h.Vagina.m_wetness)
			-- 	Return()
			+ if h.Anus.Fucker
				+ "Anus Fucker: " .. tostring(h.Anus.Fucker)
					Return()
			+ if h.Vagina.Fucker
				+ "Vagina Fucker: " .. tostring(h.Vagina.Fucker)
					Return()
			+ if h.Mouth.Fucker
				+ "Mouth Fucker: " .. tostring(h.Mouth.Fucker)
					Return()
			+ if p.Interaction
				+ "Auto Active: " .. tostring(p.Hole ~= nil and p.Interaction.AutoActive or "n/a")
					Return()
				+ "Auto Speed: " .. tostring(p.Hole ~= nil and FL_snipM(p.Interaction.m_autoSpeed, 2) or "n/a")
					Return()
				+ "Auto Thrust Weight: " .. tostring(p.Hole ~= nil and FL_snipM(p.Interaction.m_autoThrustWeight, 2) or "n/a")
					Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ if human.Penis.IsActive
			+ "Reset foreskin"
				human.Penis.m_penisSkinOut = 0
				Return()
		+ "Bukkake"
			local humans = game.GetHumans()
			for i, targetHuman in ipairs(humans)
				if targetHuman.Penis.IsActive
					local timer = math.random(1, 50) / 100
					Delayed(timer, function() targetHuman.shoot() end)
			Return()
		+ if human.Penis.IsActive
			+ "Cum"
				human.shoot()
				Return()
		+ if human.Penis.ConnectedGirl ~= nil
			+ "Switch Holes."
				if tostring(p.hole) == "Vagina (Hole)"
					FL_ConnectPenisToHole(human, cg, "Anus")
				if tostring(p.hole) == "Anus (Hole)"
					FL_ConnectPenisToHole(human, cg, "Vagina")
				Return()
		+ "Hands.."[gold]
			+ "Open."
				human.Pose(HandsOpen())
				Return()
			+ "Infront."
				human.Pose(HandsInfront_1())
				Return()
			+ "Behind."
				human.Pose(HandsBehind0())
				Return()
			+ "Closed."
				human.Pose(HandsClosed())
				Return()
			+ "Rest."
				human.Pose(HandsOpen_2())
				Return()
			+ "Half."
				human.Pose(HandsClosed_Half())
				Return()
			+ "Claw."
				human.Pose(HandsOpen_Claw())
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Kneel!"
			human.Pose(KneelDown1())
			Return()
		+ "Stand!"
			human.Pose(StandUp1())
			Return()
		+ "On your back!"
			human.Pose(LayDownBack1())
			Return()
		+ "Look!.."[gold]
			+ "Toggle Head Tracking"
				FL_ToggleHeadTracking(human)
				Return()
			+ "Cycle Target"
				FL_CycleHeadTarget(human)
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
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "<color=#9a646f><i>Done."
--===================================================================================================================================================================
--===================================================================================================================================================================





--===================================================================================================================================================================
--===================================================================================================================================================================

	+ "<color=#" .. "144999" .. "><i>animLAB.."[gold]
		-- + for partName, partData in pairs(FL_BodyPartDefs)
		-- 	+ partName
		-- 		Anim_SelectPart(human, partName)
		-- 		Jump("animationLAB", human, hitTri)
		-- + "Character List.. nothing yet, WIP"[gold]
		-- 	local humans = game.GetHumans()
		-- 	+ for i, targetHuman in ipairs(humans)
		-- 		+ "" .. targetHuman.Name
		-- 			Return()
		-- 	+ "<color=#54b095><i>Back"
		-- 		Return(2)
		-- 	+ "<color=#9a646f><i>Done"
		+ "Leg.."[gold]
			+ for i, partName in ipairs(FL_LegParts)
				+ partName
					Anim_SelectPart(human, partName)
					Jump("animationLAB", human, hitTri)
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Arm.."[gold]
			+ for i, partName in ipairs(FL_ArmParts)
				+ partName
					Anim_SelectPart(human, partName)
					Jump("animationLAB", human, hitTri)
			+ "Fingers - L.."[gold]
				+ for i, partName in ipairs(FL_FingerLParts)
					+ partName
						Anim_SelectPart(human, partName)
						Jump("animationLAB", human, hitTri)
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Fingers - R.."[gold]
				+ for i, partName in ipairs(FL_FingerRParts)
					+ partName
						Anim_SelectPart(human, partName)
						Jump("animationLAB", human, hitTri)
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		-- + "Core.."[gold]
		+ "Face.."[gold]
			+ for i, partName in ipairs(FL_FaceParts)
				+ partName
					Anim_SelectPart(human, partName)
					Jump("animationLAB", human, hitTri)
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ for i, partName in ipairs(FL_CoreParts)
			+ partName
				Anim_SelectPart(human, partName)
				Jump("animationLAB", human, hitTri)
			-- + "<color=#54b095><i>Back."
			-- 	Return(2)
			-- + "<color=#9a646f><i>Done."
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "<color=#9a646f><i>Done."
--===================================================================================================================================================================
--===================================================================================================================================================================



--===================================================================================================================================================================
--===================================================================================================================================================================

	+ "Physics.."[gold]
		local rb  = FL_GetBoneRB(human, 97)
		local key = tostring(human.m_instanceId)
		+ "Penis.."[gold]
			+ "^^ | Penis Ragdoll Length"
				human.Penis.m_ragdollLength = human.Penis.m_ragdollLength + 0.1
				Return()
			+ "-"
				human.Penis.m_ragdollLength = human.Penis.m_ragdollLength - 0.1
				Return()
			+ "^"
				human.Penis.m_ragdollLength = human.Penis.m_ragdollLength + 0.01
				Return()
			+ "-"
				human.Penis.m_ragdollLength = human.Penis.m_ragdollLength - 0.01
				Return()
			+ "Reset. | Ragdoll = " .. FL_snipM(human.Penis.m_ragdollLength, 2) .. ""
				human.Penis.m_ragdollLength = 0.2
				Return()
			+ "^ | Penis Damper = " .. human.Penis.m_damper
				human.Penis.m_damper = human.Penis.m_damper + 1
				Return()
			+ "-"
				human.Penis.m_damper = human.Penis.m_damper - 1
				Return()
			-- + "swingForce.."[gold] -- find alt access -- ScriptRuntimeException: cannot access field m_swingForce of userdata<Penis>
			-- 	+ "^ | swingForce = " .. FL_snipM(human.penis.m_swingForce)
			-- 		human.penis.m_swingForce = FL_roundTo(human.penis.m_swingForce + 1, 0.1)
			-- 		Return()
			-- 	+ "-"
			-- 		human.penis.m_swingForce = FL_roundTo(human.penis.m_swingForce - 1, 0.1)
			-- 		Return()
			-- 	+ "^ | swingForceHold = " .. FL_snipM(human.penis.m_swingForceHold)
			-- 		human.penis.m_swingForceHold = FL_roundTo(human.penis.m_swingForceHold + 1, 0.1)
			-- 		Return()
			-- 	+ "-"
			-- 		human.penis.m_swingForceHold = FL_roundTo(human.penis.m_swingForceHold - 1, 0.1)
			-- 		Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ (human.m_puppet.mappingWeight == 1 and "<color=#54b095>" or "<color=#9a646f>") .. "muscleSpring = " .. human.m_puppet.mappingWeight
			human.m_puppet.mappingWeight = (human.m_puppet.mappingWeight == 1) and 0 or 1
			Return()
		+ "muscle.."[gold]
			+ "^^ | muscleSpring = " .. human.m_puppet.muscleSpring
				human.m_puppet.muscleSpring = FL_roundTo(human.m_puppet.muscleSpring + 100, 1)
				Return()
			+ "-"
				human.m_puppet.muscleSpring = FL_roundTo(human.m_puppet.muscleSpring - 100, 1)
				Return()
			+ "^ | muscleSpring = " .. human.m_puppet.muscleSpring
				human.m_puppet.muscleSpring = FL_roundTo(human.m_puppet.muscleSpring + 10, 1)
				Return()
			+ "-"
				human.m_puppet.muscleSpring = FL_roundTo(human.m_puppet.muscleSpring - 5, 1)
				Return()
			+ "^ | muscleWeight = " .. FL_snipM(human.m_puppet.muscleWeight)
				human.m_puppet.muscleWeight = FL_roundTo(human.m_puppet.muscleWeight + 0.1, 0.1)
				Return()
			+ "-"
				human.m_puppet.muscleWeight = FL_roundTo(human.m_puppet.muscleWeight - 0.1, 0.1)
				Return()
			+ "^ | muscleDamper = " .. human.m_puppet.muscleDamper
				human.m_puppet.muscleDamper = FL_roundTo(human.m_puppet.muscleDamper + 1, 1)
				Return()
			+ "-"
				human.m_puppet.muscleDamper = FL_roundTo(human.m_puppet.muscleDamper - 1, 1)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+"Rendering.."[gold]
			local parts = getFBXParts(human)
			local mid = math.ceil(#parts / 2)
			+ "Toggle All Off"
				corneaToggle(human, false)
				toggleAllRenderParts(human, false)
				Return()
			+ "Toggle All On"
				corneaToggle(human, true)
				toggleAllRenderParts(human, true)
				Return()
			+ "Toggle Core"
				corneaToggle(human)
				toggleCoreRenderParts(human)
				Return()
			+ "Toggle Hair"
				toggleBodyPart(human, "Hair")
				Return()
			+ "Individual (1).."[gold]
				+ for i, name in ipairs(parts)
					+ if i <= mid
						+ "" .. name
							toggleBodyPart(human, name)
							Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Individual (2).."[gold]
				+ for i, name in ipairs(parts)
					+ if i > mid
						+ "" .. name
							toggleBodyPart(human, name)
							Return()
				+ "Eye Reflection"
					corneaToggle(human)
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "pin.."[gold]
			+ "^ | pinDistanceFalloff = " .. FL_snipM(human.m_puppet.pinDistanceFalloff)
				human.m_puppet.pinDistanceFalloff = FL_roundTo(human.m_puppet.pinDistanceFalloff + 0.5, 0.1)
				Return()
			+ "-"
				human.m_puppet.pinDistanceFalloff = FL_roundTo(human.m_puppet.pinDistanceFalloff - 0.5, 0.1)
				Return()
			+ "^ | pinPow = " .. FL_snipM(human.m_puppet.pinPow)
				human.m_puppet.pinPow = FL_roundTo(human.m_puppet.pinPow + 0.1, 0.1)
				Return()
			+ "-"
				human.m_puppet.pinPow = FL_roundTo(human.m_puppet.pinPow - 0.1, 0.1)
				Return()
			+ "^ | pinWeight = " .. FL_snipM(human.m_puppet.pinWeight)
				human.m_puppet.pinWeight = FL_roundTo(human.m_puppet.pinWeight + 0.1, 0.1)
				Return()
			+ "-"
				human.m_puppet.pinWeight = FL_roundTo(human.m_puppet.pinWeight - 0.1, 0.1)
				Return()
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Collision Hitbox.." [gold]
			local mid = math.ceil(#FL_puppetBones / 2)
			local puppetRigChest = human.m_puppetRig.transform:GetChild(9) -- fragile? replace with Find("str") or ?
			local neckTransform  = puppetRigChest:GetChild(0)
			local chestTransform = puppetRigChest:GetChild(1)
			+ "<color=#9a646f><i>Done"
			+ "<color=#54b095><i>Back"
				Return(2)
			+ "Set Hitbox | All | 0.1"
				for i, bone in ipairs(FL_puppetBones)
					FL_SetBoneScale(human, i, 0.1)
				Return()
			+ "Restore Hitbox | All | " .. FL_snipM(neckTransform.localScale.x)
				for i, bone in ipairs(FL_puppetBones)
					FL_SetBoneScale(human, i, 1.0)
				Return()
			+ "Increase All | 0.1"
				for i, bone in ipairs(FL_puppetBones)
					FL_AdjustBoneScale(human, i, 0.1)
				Return()
			+ "-"
				for i, bone in ipairs(FL_puppetBones)
					FL_AdjustBoneScale(human, i, -0.1)
				Return()
			+ "Bodypart | (1).." [gold]
				+ "<color=#9a646f><i>Done"
				+ "<color=#54b095><i>Back"
					Return(2)
				+ for i, bone in ipairs(FL_puppetBones)
					+ if i ~= 10 and i <= mid
						local boneTarget = FL_GetBoneTargets(human, i)[1]
						+ "" .. bone
							+ "^ | X = " .. FL_snipM(boneTarget and boneTarget.localScale.x or 0)
								FL_AdjustBoneScale(human, i, 0.1, 0, 0)
								Return()
							+ "-"
								FL_AdjustBoneScale(human, i, -0.1, 0, 0)
								Return()
							+ "^ | Y = " .. FL_snipM(boneTarget and boneTarget.localScale.y or 0)
								FL_AdjustBoneScale(human, i, 0, 0.1, 0)
								Return()
							+ "-"
								FL_AdjustBoneScale(human, i, 0, -0.1, 0)
								Return()
							+ "^ | Z = " .. FL_snipM(boneTarget and boneTarget.localScale.z or 0)
								FL_AdjustBoneScale(human, i, 0, 0, 0.1)
								Return()
							+ "-"
								FL_AdjustBoneScale(human, i, 0, 0, -0.1)
								Return()
							+ "^ | All"
								FL_AdjustBoneScale(human, i, 0.1)
								Return()
							+ "-"
								FL_AdjustBoneScale(human, i, -0.1)
								Return()
							+ "<color=#54b095><i>Back"
								Return(2)
							+ "<color=#9a646f><i>Done"
				+ "Neck"
					+ "^ | X = " .. FL_snipM(neckTransform.localScale.x)
						local v = neckTransform.localScale
						neckTransform.localScale = Vector3(v.x + 0.1, v.y, v.z)
						Return()
					+ "-"
						local v = neckTransform.localScale
						neckTransform.localScale = Vector3(v.x - 0.1, v.y, v.z)
						Return()
					+ "^ | Y = " .. FL_snipM(neckTransform.localScale.y)
						local v = neckTransform.localScale
						neckTransform.localScale = Vector3(v.x, v.y + 0.1, v.z)
						Return()
					+ "-"
						local v = neckTransform.localScale
						neckTransform.localScale = Vector3(v.x, v.y - 0.1, v.z)
						Return()
					+ "^ | Z = " .. FL_snipM(neckTransform.localScale.z)
						local v = neckTransform.localScale
						neckTransform.localScale = Vector3(v.x, v.y, v.z + 0.1)
						Return()
					+ "-"
						local v = neckTransform.localScale
						neckTransform.localScale = Vector3(v.x, v.y, v.z - 0.1)
						Return()
					+ "^ | All"
						local v = neckTransform.localScale
						neckTransform.localScale = Vector3(v.x + 0.1, v.y + 0.1, v.z + 0.1)
						Return()
					+ "-"
						local v = neckTransform.localScale
						neckTransform.localScale = Vector3(v.x - 0.1, v.y - 0.1, v.z - 0.1)
						Return()
					+ "<color=#54b095><i>Back"
						Return(2)
					+ "<color=#9a646f><i>Done"
				+ "<color=#54b095><i>Back"
					Return(2)
				+ "<color=#9a646f><i>Done"
			+ "Bodypart | (2).." [gold]
				+ "<color=#9a646f><i>Done"
				+ "<color=#54b095><i>Back"
					Return(2)
				+ for i, bone in ipairs(FL_puppetBones)
					+ if i ~= 10 and i > mid
						local boneTarget = FL_GetBoneTargets(human, i)[1]
						+ "" .. bone
							+ "^ | X = " .. FL_snipM(boneTarget and boneTarget.localScale.x or 0)
								FL_AdjustBoneScale(human, i, 0.1, 0, 0)
								Return()
							+ "-"
								FL_AdjustBoneScale(human, i, -0.1, 0, 0)
								Return()
							+ "^ | Y = " .. FL_snipM(boneTarget and boneTarget.localScale.y or 0)
								FL_AdjustBoneScale(human, i, 0, 0.1, 0)
								Return()
							+ "-"
								FL_AdjustBoneScale(human, i, 0, -0.1, 0)
								Return()
							+ "^ | Z = " .. FL_snipM(boneTarget and boneTarget.localScale.z or 0)
								FL_AdjustBoneScale(human, i, 0, 0, 0.1)
								Return()
							+ "-"
								FL_AdjustBoneScale(human, i, 0, 0, -0.1)
								Return()
							+ "^ | All"
								FL_AdjustBoneScale(human, i, 0.1)
								Return()
							+ "-"
								FL_AdjustBoneScale(human, i, -0.1)
								Return()
							+ "<color=#54b095><i>Back"
								Return(2)
							+ "<color=#9a646f><i>Done"
				+ "Chest"
					+ "^ | X = " .. FL_snipM(chestTransform.localScale.x)
						local v = chestTransform.localScale
						chestTransform.localScale = Vector3(v.x + 0.1, v.y, v.z)
						Return()
					+ "-"
						local v = chestTransform.localScale
						chestTransform.localScale = Vector3(v.x - 0.1, v.y, v.z)
						Return()
					+ "^ | Y = " .. FL_snipM(chestTransform.localScale.y)
						local v = chestTransform.localScale
						chestTransform.localScale = Vector3(v.x, v.y + 0.1, v.z)
						Return()
					+ "-"
						local v = chestTransform.localScale
						chestTransform.localScale = Vector3(v.x, v.y - 0.1, v.z)
						Return()
					+ "^ | Z = " .. FL_snipM(chestTransform.localScale.z)
						local v = chestTransform.localScale
						chestTransform.localScale = Vector3(v.x, v.y, v.z + 0.1)
						Return()
					+ "-"
						local v = chestTransform.localScale
						chestTransform.localScale = Vector3(v.x, v.y, v.z - 0.1)
						Return()
					+ "^ | All"
						local v = chestTransform.localScale
						chestTransform.localScale = Vector3(v.x + 0.1, v.y + 0.1, v.z + 0.1)
						Return()
					+ "-"
						local v = chestTransform.localScale
						chestTransform.localScale = Vector3(v.x - 0.1, v.y - 0.1, v.z - 0.1)
						Return()
					+ "<color=#54b095><i>Back"
						Return(2)
					+ "<color=#9a646f><i>Done"
				+ "<color=#54b095><i>Back"
					Return(2)
				+ "<color=#9a646f><i>Done"
			+ "<color=#54b095><i>Back"
				Return(2)
			+ "<color=#9a646f><i>Done"
		+ if rb
			+ "Mass.."[gold]
				local mid = math.ceil(#FL_puppetBones / 2)
				+ "Page (1).."[gold]
					+ for i, name in ipairs(FL_puppetBones)
						+ if i >= mid
							+ name .. ".."[gold]
								+ "Increment = " .. FL_boneMassStep
									FL_boneMassStep = FL_cycleStep(FL_boneMassStep, {0.01, 0.1, 0.5, 1.0})
									Return()
								+ "^ | " .. name .. " = " .. FL_snipM(FL_getBoneMass(human, name))
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = FL_roundTo(rb.mass + FL_boneMassStep, 0.01)
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "-"
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = FL_roundTo(rb.mass - FL_boneMassStep, 0.01)
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "Reset | Default = " .. FL_snipM(FL_get(FL_puppetBoneDefaults, name))
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = FL_puppetBoneDefaults[name]
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "Set | 1.0"
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = 1.0
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "Set | 0.1"
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = 0.1
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "<color=#54b095><i>Back."
									Return(2)
								+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "<color=#9a646f><i>Done."
				+ "Page (2).."[gold]
					+ for i, name in ipairs(FL_puppetBones)
						+ if i < mid
							+ name .. ".."[gold]
								+ "Increment = " .. FL_boneMassStep
									FL_boneMassStep = FL_cycleStep(FL_boneMassStep, {0.01, 0.1, 0.5, 1.0})
									Return()
								+ "^ | " .. name .. " = " .. FL_snipM(FL_getBoneMass(human, name))
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = FL_roundTo(rb.mass + FL_boneMassStep, 0.01)
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "-"
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = FL_roundTo(rb.mass - FL_boneMassStep, 0.01)
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "Reset | Default = " .. FL_snipM(FL_get(FL_puppetBoneDefaults, name))
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = FL_puppetBoneDefaults[name]
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "Set | 1.0"
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = 1.0
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "Set | 0.1"
									local rb = FL_GetBoneRB(human, FL_puppetBoneIds[name])
									if rb
										rb.mass = 0.1
										FL_boneMass[tostring(human.m_instanceId)][name] = rb.mass
									Return()
								+ "<color=#54b095><i>Back."
									Return(2)
								+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "<color=#9a646f><i>Done."
				+ "Set All | 1.0"
					for i, pname in ipairs(FL_puppetBones)
						local rb = human:GetRigidbody(FL_puppetBoneIds[pname])
						if rb
							rb.mass = 1.0
							FL_boneMass[tostring(human.m_instanceId)][pname] = rb.mass
					Return()
				+ "Set All | 0.1"
					for i, pname in ipairs(FL_puppetBones)
						local rb = human:GetRigidbody(FL_puppetBoneIds[pname])
						if rb
							rb.mass = 0.1
							FL_boneMass[tostring(human.m_instanceId)][pname] = rb.mass
					Return()
				+ "Reset All | Default"
					for i, pname in ipairs(FL_puppetBones)
						local rb = human:GetRigidbody(FL_puppetBoneIds[pname])
						if rb
							rb.mass = FL_puppetBoneDefaults[pname]
							FL_boneMass[tostring(human.m_instanceId)][pname] = rb.mass
					Return()
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ if FL_GetBoneRB(human, FL_puppetBoneIds["Breast_L"]) and FL_GetBoneRB(human, FL_puppetBoneIds["Breast_R"])
				+ "Breasts.."[gold]
					local rbl = FL_GetBoneRB(human, FL_puppetBoneIds["Breast_L"])
					local rbr = FL_GetBoneRB(human, FL_puppetBoneIds["Breast_R"])
					+ "Mass.."[gold]
						+ "Increment = " .. FL_breastMassInc
							FL_breastMassInc = FL_cycleStep(FL_breastMassInc, {0.1, 0.25, 0.5, 1.0})
							Return()
						+ "^ | Breasts = " .. FL_snipM(FL_getBoneMass(human, "Breast_L"), 2)
							rbl.mass = FL_roundTo(rbl.mass + FL_breastMassInc, 0.01)
							rbr.mass = FL_roundTo(rbr.mass + FL_breastMassInc, 0.01)
							FL_boneMass[tostring(human.m_instanceId)]["Breast_L"] = rbl.mass
							FL_boneMass[tostring(human.m_instanceId)]["Breast_R"] = rbr.mass
							Return()
						+ "-"
							rbl.mass = FL_roundTo(rbl.mass - FL_breastMassInc, 0.01)
							rbr.mass = FL_roundTo(rbr.mass - FL_breastMassInc, 0.01)
							FL_boneMass[tostring(human.m_instanceId)]["Breast_L"] = rbl.mass
							FL_boneMass[tostring(human.m_instanceId)]["Breast_R"] = rbr.mass
							Return()
						+ "Reset | Default = " .. FL_snipM(FL_get(FL_puppetBoneDefaults, "Breast_L"))
							rbl.mass = FL_puppetBoneDefaults["Breast_L"]
							rbr.mass = FL_puppetBoneDefaults["Breast_R"]
							FL_boneMass[tostring(human.m_instanceId)]["Breast_L"] = rbl.mass
							FL_boneMass[tostring(human.m_instanceId)]["Breast_R"] = rbr.mass
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "Drag.."[gold]
						+ "Increment = " .. FL_breastDragInc
							FL_breastDragInc = FL_cycleStep(FL_breastDragInc, {0.1, 0.2, 0.5, 1.0})
							Return()
						+ "^ | Drag = " .. FL_snipM(RBX.GetDrag(rbl))
							RBX.SetDrag(rbl, FL_roundTo(RBX.GetDrag(rbl) + FL_breastDragInc, 0.01))
							RBX.SetDrag(rbr, FL_roundTo(RBX.GetDrag(rbr) + FL_breastDragInc, 0.01))
							Return()
						+ "-"
							RBX.SetDrag(rbl, FL_roundTo(RBX.GetDrag(rbl) - FL_breastDragInc, 0.01))
							RBX.SetDrag(rbr, FL_roundTo(RBX.GetDrag(rbr) - FL_breastDragInc, 0.01))
							Return()
						+ "Reset"
							FL_InitBreastPhysicsDefaults(human, rbl, rbr)
							if FL_breastDefaults[key]
								RBX.SetDrag(rbl, FL_breastDefaults[key].dragL)
								RBX.SetDrag(rbr, FL_breastDefaults[key].dragR)
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "Center of Mass.."[gold]
						+ "Increment = " .. FL_breastComInc
							FL_breastComInc = FL_cycleStep(FL_breastComInc, {0.0001, 0.001, 0.01, 0.1})
							Return()
						+ "^ X | " .. FL_snipM(RBX.GetCenterOfMass(rbl).x, 4)
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(FL_roundTo(cl.x + FL_breastComInc, 0.0001), cl.y, cl.z))
							RBX.SetCenterOfMass(rbr, Vector3(FL_roundTo(cr.x - FL_breastComInc, 0.0001), cr.y, cr.z))
							Return()
						+ "-"
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(FL_roundTo(cl.x - FL_breastComInc, 0.0001), cl.y, cl.z))
							RBX.SetCenterOfMass(rbr, Vector3(FL_roundTo(cr.x + FL_breastComInc, 0.0001), cr.y, cr.z))
							Return()
						+ "^ Y | " .. FL_snipM(RBX.GetCenterOfMass(rbl).y, 4)
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(cl.x, FL_roundTo(cl.y + FL_breastComInc, 0.0001), cl.z))
							RBX.SetCenterOfMass(rbr, Vector3(cr.x, FL_roundTo(cr.y + FL_breastComInc, 0.0001), cr.z))
							Return()
						+ "-"
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(cl.x, FL_roundTo(cl.y - FL_breastComInc, 0.0001), cl.z))
							RBX.SetCenterOfMass(rbr, Vector3(cr.x, FL_roundTo(cr.y - FL_breastComInc, 0.0001), cr.z))
							Return()
						+ "^ Z | " .. FL_snipM(RBX.GetCenterOfMass(rbl).z, 4)
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(cl.x, cl.y, FL_roundTo(cl.z + FL_breastComInc, 0.0001)))
							RBX.SetCenterOfMass(rbr, Vector3(cr.x, cr.y, FL_roundTo(cr.z + FL_breastComInc, 0.0001)))
							Return()
						+ "-"
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(cl.x, cl.y, FL_roundTo(cl.z - FL_breastComInc, 0.0001)))
							RBX.SetCenterOfMass(rbr, Vector3(cr.x, cr.y, FL_roundTo(cr.z - FL_breastComInc, 0.0001)))
							Return()
						+ "Reset"
							FL_InitBreastPhysicsDefaults(human, rbl, rbr)
							if FL_breastDefaults[key]
								RBX.SetCenterOfMass(rbl, FL_breastDefaults[key].comL)
								RBX.SetCenterOfMass(rbr, FL_breastDefaults[key].comR)
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "Inertia Tensor.."[gold]
						+ "Increment = " .. FL_breastITInc
							FL_breastITInc = FL_cycleStep(FL_breastITInc, {0.0001, 0.001, 0.01, 0.1})
							Return()
						+ "^ X | " .. FL_snipM(RBX.GetInertiaTensor(rbl).x, 4)
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(FL_roundTo(il.x + FL_breastITInc, 0.0001), il.y, il.z))
							RBX.SetInertiaTensor(rbr, Vector3(FL_roundTo(ir.x + FL_breastITInc, 0.0001), ir.y, ir.z))
							Return()
						+ "-"
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(FL_roundTo(il.x - FL_breastITInc, 0.0001), il.y, il.z))
							RBX.SetInertiaTensor(rbr, Vector3(FL_roundTo(ir.x - FL_breastITInc, 0.0001), ir.y, ir.z))
							Return()
						+ "^ Y | " .. FL_snipM(RBX.GetInertiaTensor(rbl).y, 4)
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(il.x, FL_roundTo(il.y + FL_breastITInc, 0.0001), il.z))
							RBX.SetInertiaTensor(rbr, Vector3(ir.x, FL_roundTo(ir.y + FL_breastITInc, 0.0001), ir.z))
							Return()
						+ "-"
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(il.x, FL_roundTo(il.y - FL_breastITInc, 0.0001), il.z))
							RBX.SetInertiaTensor(rbr, Vector3(ir.x, FL_roundTo(ir.y - FL_breastITInc, 0.0001), ir.z))
							Return()
						+ "^ Z | " .. FL_snipM(RBX.GetInertiaTensor(rbl).z, 4)
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(il.x, il.y, FL_roundTo(il.z + FL_breastITInc, 0.0001)))
							RBX.SetInertiaTensor(rbr, Vector3(ir.x, ir.y, FL_roundTo(ir.z + FL_breastITInc, 0.0001)))
							Return()
						+ "-"
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(il.x, il.y, FL_roundTo(il.z - FL_breastITInc, 0.0001)))
							RBX.SetInertiaTensor(rbr, Vector3(ir.x, ir.y, FL_roundTo(ir.z - FL_breastITInc, 0.0001)))
							Return()
						+ "Reset"
							FL_InitBreastPhysicsDefaults(human, rbl, rbr)
							if FL_breastDefaults[key]
								RBX.SetInertiaTensor(rbl, FL_breastDefaults[key].itL)
								RBX.SetInertiaTensor(rbr, FL_breastDefaults[key].itR)
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "Presets.."[gold]
						+ "D1 - Natural"
							rbl.mass = 1.5
							RBX.SetDrag(rbl, 1.5)
							RBX.SetCenterOfMass(rbl, Vector3(-0.02, 0.015, 0.08))
							RBX.SetInertiaTensor(rbl, Vector3(0.001, 0.001, 0.001))
							rbr.mass = 1.5
							RBX.SetDrag(rbr, 1.5)
							RBX.SetCenterOfMass(rbr, Vector3(0.02, 0.015, 0.08))
							RBX.SetInertiaTensor(rbr, Vector3(0.001, 0.001, 0.001))
							Return()
						+ "D2 - Heavy"
							rbl.mass = 2
							RBX.SetDrag(rbl, 2.1)
							RBX.SetCenterOfMass(rbl, Vector3(-0.02, 0.015, 0.08))
							RBX.SetInertiaTensor(rbl, Vector3(0.001, 0.001, 0.001))
							rbr.mass = 2
							RBX.SetDrag(rbr, 2.1)
							RBX.SetCenterOfMass(rbr, Vector3(0.02, 0.015, 0.08))
							RBX.SetInertiaTensor(rbr, Vector3(0.001, 0.001, 0.001))
							Return()
						+ "FL - 1"
							rbl.mass = 1.2
							RBX.SetDrag(rbl, 0)
							RBX.SetCenterOfMass(rbl, Vector3(-0.5, -0.1, 0.5))
							RBX.SetInertiaTensor(rbl, Vector3(0.001, 0.001, 0.001))
							rbr.mass = 1.2
							RBX.SetDrag(rbr, 0)
							RBX.SetCenterOfMass(rbr, Vector3(0.5, -0.1, 0.5))
							RBX.SetInertiaTensor(rbr, Vector3(0.001, 0.001, 0.001))
							Return()
						+ "Syen - 1"
							rbl.mass = 1.5
							RBX.SetDrag(rbl, -0.5)
							RBX.SetCenterOfMass(rbl, Vector3(-0.02, 0.0156, 0.08))
							RBX.SetInertiaTensor(rbl, Vector3(0.0001, 0.0001, 0.0001))
							rbr.mass = 2
							RBX.SetDrag(rbr, -0.5)
							RBX.SetCenterOfMass(rbr, Vector3(-0.02, 0.0156, 0.08))
							RBX.SetInertiaTensor(rbr, Vector3(0.0001, 0.0001, 0.0001))
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "<color=#54b095><i>Back"
						Return(2)
					+ "<color=#9a646f><i>Done"
			+ if FL_GetBoneRB(human, FL_puppetBoneIds["Ass_L"]) and FL_GetBoneRB(human, FL_puppetBoneIds["Ass_R"])
				+ "Ass.."[gold]
					local rbl = FL_GetBoneRB(human, FL_puppetBoneIds["Ass_L"])
					local rbr = FL_GetBoneRB(human, FL_puppetBoneIds["Ass_R"])
					+ "Mass.."[gold]
						+ "Increment = " .. FL_assMassStep
							FL_assMassStep = FL_cycleStep(FL_assMassStep, {0.1, 0.25, 0.5, 1.0})
							Return()
						+ "^ | Mass = " .. FL_snipM(FL_getBoneMass(human, "Ass_L"), 2)
							rbl.mass = FL_roundTo(rbl.mass + FL_assMassStep, 0.01)
							rbr.mass = FL_roundTo(rbr.mass + FL_assMassStep, 0.01)
							FL_boneMass[tostring(human.m_instanceId)]["Ass_L"] = rbl.mass
							FL_boneMass[tostring(human.m_instanceId)]["Ass_R"] = rbr.mass
							Return()
						+ "-"
							rbl.mass = FL_roundTo(rbl.mass - FL_assMassStep, 0.01)
							rbr.mass = FL_roundTo(rbr.mass - FL_assMassStep, 0.01)
							FL_boneMass[tostring(human.m_instanceId)]["Ass_L"] = rbl.mass
							FL_boneMass[tostring(human.m_instanceId)]["Ass_R"] = rbr.mass
							Return()
						+ "Reset | Default = " .. FL_snipM(FL_get(FL_puppetBoneDefaults, "Ass_L"))
							rbl.mass = FL_puppetBoneDefaults["Ass_L"]
							rbr.mass = FL_puppetBoneDefaults["Ass_R"]
							FL_boneMass[tostring(human.m_instanceId)]["Ass_L"] = rbl.mass
							FL_boneMass[tostring(human.m_instanceId)]["Ass_R"] = rbr.mass
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "Drag.."[gold]
						+ "Increment = " .. FL_assDragStep
							FL_assDragStep = FL_cycleStep(FL_assDragStep, {0.1, 0.2, 0.5, 1.0})
							Return()
						+ "^ | Drag = " .. FL_snipM(RBX.GetDrag(rbl))
							RBX.SetDrag(rbl, FL_roundTo(RBX.GetDrag(rbl) + FL_assDragStep, 0.01))
							RBX.SetDrag(rbr, FL_roundTo(RBX.GetDrag(rbr) + FL_assDragStep, 0.01))
							Return()
						+ "-"
							RBX.SetDrag(rbl, FL_roundTo(RBX.GetDrag(rbl) - FL_assDragStep, 0.01))
							RBX.SetDrag(rbr, FL_roundTo(RBX.GetDrag(rbr) - FL_assDragStep, 0.01))
							Return()
						+ "Reset"
							FL_InitAssPhysicsDefaults(human, rbl, rbr)
							if FL_AssDefaults[key]
								RBX.SetDrag(rbl, FL_AssDefaults[key].dragL)
								RBX.SetDrag(rbr, FL_AssDefaults[key].dragR)
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "Center of Mass.."[gold]
						+ "Increment = " .. FL_assComStep
							FL_assComStep = FL_cycleStep(FL_assComStep, {0.001, 0.01, 0.1})
							Return()
						+ "^ X | " .. FL_snipM(RBX.GetCenterOfMass(rbl).x, 3)
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(FL_roundTo(cl.x + FL_assComStep, 0.001), cl.y, cl.z))
							RBX.SetCenterOfMass(rbr, Vector3(FL_roundTo(cr.x - FL_assComStep, 0.001), cr.y, cr.z))
							Return()
						+ "-"
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(FL_roundTo(cl.x - FL_assComStep, 0.001), cl.y, cl.z))
							RBX.SetCenterOfMass(rbr, Vector3(FL_roundTo(cr.x + FL_assComStep, 0.001), cr.y, cr.z))
							Return()
						+ "^ Y | " .. FL_snipM(RBX.GetCenterOfMass(rbl).y, 3)
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(cl.x, FL_roundTo(cl.y + FL_assComStep, 0.001), cl.z))
							RBX.SetCenterOfMass(rbr, Vector3(cr.x, FL_roundTo(cr.y + FL_assComStep, 0.001), cr.z))
							Return()
						+ "-"
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(cl.x, FL_roundTo(cl.y - FL_assComStep, 0.001), cl.z))
							RBX.SetCenterOfMass(rbr, Vector3(cr.x, FL_roundTo(cr.y - FL_assComStep, 0.001), cr.z))
							Return()
						+ "^ Z | " .. FL_snipM(RBX.GetCenterOfMass(rbl).z, 3)
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(cl.x, cl.y, FL_roundTo(cl.z + FL_assComStep, 0.001)))
							RBX.SetCenterOfMass(rbr, Vector3(cr.x, cr.y, FL_roundTo(cr.z + FL_assComStep, 0.001)))
							Return()
						+ "-"
							local cl = RBX.GetCenterOfMass(rbl)
							local cr = RBX.GetCenterOfMass(rbr)
							RBX.SetCenterOfMass(rbl, Vector3(cl.x, cl.y, FL_roundTo(cl.z - FL_assComStep, 0.001)))
							RBX.SetCenterOfMass(rbr, Vector3(cr.x, cr.y, FL_roundTo(cr.z - FL_assComStep, 0.001)))
							Return()
						+ "Reset"
							FL_InitAssPhysicsDefaults(human, rbl, rbr)
							if FL_AssDefaults[key]
								RBX.SetCenterOfMass(rbl, FL_AssDefaults[key].comL)
								RBX.SetCenterOfMass(rbr, FL_AssDefaults[key].comR)
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "Inertia Tensor.."[gold]
						+ "Increment = " .. FL_assITStep
							FL_assITStep = FL_cycleStep(FL_assITStep, {0.0001, 0.001, 0.01, 0.1})
							Return()
						+ "^ X | " .. FL_snipM(RBX.GetInertiaTensor(rbl).x, 4)
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(FL_roundTo(il.x + FL_assITStep, 0.0001), il.y, il.z))
							RBX.SetInertiaTensor(rbr, Vector3(FL_roundTo(ir.x + FL_assITStep, 0.0001), ir.y, ir.z))
							Return()
						+ "-"
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(FL_roundTo(il.x - FL_assITStep, 0.0001), il.y, il.z))
							RBX.SetInertiaTensor(rbr, Vector3(FL_roundTo(ir.x - FL_assITStep, 0.0001), ir.y, ir.z))
							Return()
						+ "^ Y | " .. FL_snipM(RBX.GetInertiaTensor(rbl).y, 4)
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(il.x, FL_roundTo(il.y + FL_assITStep, 0.0001), il.z))
							RBX.SetInertiaTensor(rbr, Vector3(ir.x, FL_roundTo(ir.y + FL_assITStep, 0.0001), ir.z))
							Return()
						+ "-"
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(il.x, FL_roundTo(il.y - FL_assITStep, 0.0001), il.z))
							RBX.SetInertiaTensor(rbr, Vector3(ir.x, FL_roundTo(ir.y - FL_assITStep, 0.0001), ir.z))
							Return()
						+ "^ Z | " .. FL_snipM(RBX.GetInertiaTensor(rbl).z, 4)
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(il.x, il.y, FL_roundTo(il.z + FL_assITStep, 0.0001)))
							RBX.SetInertiaTensor(rbr, Vector3(ir.x, ir.y, FL_roundTo(ir.z + FL_assITStep, 0.0001)))
							Return()
						+ "-"
							local il = RBX.GetInertiaTensor(rbl)
							local ir = RBX.GetInertiaTensor(rbr)
							RBX.SetInertiaTensor(rbl, Vector3(il.x, il.y, FL_roundTo(il.z - FL_assITStep, 0.0001)))
							RBX.SetInertiaTensor(rbr, Vector3(ir.x, ir.y, FL_roundTo(ir.z - FL_assITStep, 0.0001)))
							Return()
						+ "Reset"
							FL_InitAssPhysicsDefaults(human, rbl, rbr)
							if FL_AssDefaults[key]
								RBX.SetInertiaTensor(rbl, FL_AssDefaults[key].itL)
								RBX.SetInertiaTensor(rbr, FL_AssDefaults[key].itR)
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "Presets.."[gold]
						+ "Natural"
							rbl.mass = 1.5
							RBX.SetDrag(rbl, 1.5)
							RBX.SetCenterOfMass(rbl, Vector3(-0.02, 0.015, 0.08))
							RBX.SetInertiaTensor(rbl, Vector3(0.001, 0.001, 0.001))
							rbr.mass = 1.5
							RBX.SetDrag(rbr, 1.5)
							RBX.SetCenterOfMass(rbr, Vector3(0.02, 0.015, 0.08))
							RBX.SetInertiaTensor(rbr, Vector3(0.001, 0.001, 0.001))
							Return()
						+ "Heavy"
							rbl.mass = 2
							RBX.SetDrag(rbl, 2.1)
							RBX.SetCenterOfMass(rbl, Vector3(-0.02, 0.015, 0.08))
							RBX.SetInertiaTensor(rbl, Vector3(0.001, 0.001, 0.001))
							rbr.mass = 2
							RBX.SetDrag(rbr, 2.1)
							RBX.SetCenterOfMass(rbr, Vector3(0.02, 0.015, 0.08))
							RBX.SetInertiaTensor(rbr, Vector3(0.001, 0.001, 0.001))
							Return()
						+ "<color=#54b095><i>Back"
							Return(2)
						+ "<color=#9a646f><i>Done"
					+ "<color=#54b095><i>Back"
						Return(2)
					+ "<color=#9a646f><i>Done"
		+ "<color=#54b095><i>Back"
			Return(2)
		+ "<color=#9a646f><i>Done"
	+ if FL_pluginMenuEnabled
		+ "Plugins.."[gold]
			+ "Character Menu.."[gold]
				Jump("faunaCharMenu", human, hitTri)
			-- + "Your Menu Name.."[gold]
			-- 	Jump("yourMenuLabel", human, hitTri)
			+ "<color=#54b095><i>Back"
				Return(2)
			+ "<color=#9a646f><i>Done"
	+ else
		+ "Character Menu.."[gold]
			Jump("faunaCharMenu", human, hitTri)
	+ if game.PovHuman ~= human
		+ "POV"
			game.PovHuman = human
			Return()
	+ if game.PovHuman ~= nil
		+ "Exit POV"
			game.PovHuman = nil
			Return()
	-- + "force penis active"
	-- 	forcePenisActive(human)
	-- 	Return()
	-- + "testLAB"
	-- 	+ "Test RBX"
--===================================================================================================================================================================
--===================================================================================================================================================================
	+ "<color=#9a646f><i>Done."
stop
--===================================================================================================================================================================
--===================================================================================================================================================================
















--===================================================================================================================================================================
--===================================================================================================================================================================

label animationLAB(human, hitTri)
	local _human = human
	+ if human.m_isMale == false
		+ "<color=#90ee90><i>Penetration is Turned On"
			human.m_isMale = true
			Return()
	+ if human.m_isMale == true
		+ "<color=#f08080><i>Penetration is Turned Off"
			human.m_isMale = false
			Return()
	+ "<color=#9a646f><i>Done."
	+ "<color=#54b095><i>Back. | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
        Jump("fauna_LABS_Menu", human, hitTri)
	+ "Select Anim" [gold]
		+ "<color=#9a646f><i>Done."
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "Leg.."[gold]
			+ for i, partName in ipairs(FL_LegParts)
				+ partName
					Anim_SelectPart(human, partName)
					Jump("animationLAB", human, hitTri)
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Arm.."[gold]
			+ for i, partName in ipairs(FL_ArmParts)
				+ partName
					Anim_SelectPart(human, partName)
					Jump("animationLAB", human, hitTri)
			+ "Fingers - L.."[gold]
				+ for i, partName in ipairs(FL_FingerLParts)
					+ partName
						Anim_SelectPart(human, partName)
						Jump("animationLAB", human, hitTri)
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "Fingers - R.."[gold]
				+ for i, partName in ipairs(FL_FingerRParts)
					+ partName
						Anim_SelectPart(human, partName)
						Jump("animationLAB", human, hitTri)
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back."
				Return(2)
			+ "<color=#9a646f><i>Done."
		+ "Face.."[gold]
			+ for i, partName in ipairs(FL_FaceParts)
				+ partName
					Anim_SelectPart(human, partName)
					Jump("animationLAB", human, hitTri)
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "<color=#9a646f><i>Done."	
		-- + "Core.."[gold]
		+ for i, partName in ipairs(FL_CoreParts)
			+ partName
				Anim_SelectPart(human, partName)
				Jump("animationLAB", human, hitTri)
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "<color=#9a646f><i>Done."
	+ "Reset Current Pose" [if ActiveAnimHuman and ActiveAnimPart]
		Anim_ResetPoses(ActiveAnimHuman, ActiveAnimPart, false)
		Return()
	+ "Reset All Poses" [if ActiveAnimHuman and ActiveAnimPart]
		Anim_ResetPoses(ActiveAnimHuman, ActiveAnimPart, true)
		Return()
	+ "Remove Pose"
		Anim_StopCurrent(human)
		Anim_RemovePose(human)
		Return()
	+ "Add Pose"
		Anim_AddPose(human)
		Return()
	+ "Randomizer Values.."[gold]
		local cfg = InitFL_RandomizerConfig(ActiveAnimPart)
		+ "<color=#9a646f><i>Done"
		+ "<color=#54b095><i>Back"
			Return(2)
		+ "Mode: " .. cfg.mode
			Randomizer_ToggleMode(ActiveAnimPart)
			Return()
		+ if cfg.mode == "percent"
			+ "Reset Values"
				Randomizer_ResetValues(ActiveAnimPart)
				Return()
			+ "Adjust: " .. cfg.adjust
				Randomizer_ToggleAdjust(ActiveAnimPart)
				Return()
			+ "Sign: " .. cfg.signtext
				Randomizer_ToggleSign(cfg)
				Return()
			+ "10%"
				Anim_ChangeRandomizer(ActiveAnimPart, 10)
				Return()
			+ "25% | " .. cfg.low .. " | " .. cfg.high
				Anim_ChangeRandomizer(ActiveAnimPart, 25)
				Return()
		+ if cfg.mode == "flat"
			+ "Reset Values"
				Randomizer_ResetValues(ActiveAnimPart)
				Return()
			+ "Adjust: " .. cfg.adjust
				Randomizer_ToggleAdjust(ActiveAnimPart)
				Return()
			+ "Sign: " .. cfg.signtext
				Randomizer_ToggleSign(cfg)
				Return()
			+ "30"
				Anim_ChangeRandomizer(ActiveAnimPart, 30)
				Return()
			+ "15"
				Anim_ChangeRandomizer(ActiveAnimPart, 15)
				Return()
			+ "5"
				Anim_ChangeRandomizer(ActiveAnimPart, 5)
				Return()
			+ "1"
				Anim_ChangeRandomizer(ActiveAnimPart, 1)
				Return()
			+ "0.1"
				Anim_ChangeRandomizer(ActiveAnimPart, 0.1)
				Return()
			+ "0.05"
				Anim_ChangeRandomizer(ActiveAnimPart, 0.05)
				Return()
			+ "0.025"
				Anim_ChangeRandomizer(ActiveAnimPart, 0.025)
				Return()
			+ "0.001 | " .. cfg.flatLow .. " | " .. cfg.flatHigh
				Anim_ChangeRandomizer(ActiveAnimPart, 0.001)
				Return()
	+ "Edit All.."[gold]
		Anim_Pose1(human)
		+ "<color=#9a646f><i>Done."
		+ "<color=#54b095><i>Back. | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
			Return(2)
		+ if FL_BodyPartDefs[ActiveAnimPart] and FL_BodyPartDefs[ActiveAnimPart].stepType == "foot"
			local snapVal = Anim_Menu4 or 0
			local snapLabel = (snapVal ~= 0) and "On" or "Off"
			+ "Ground Snap: " .. snapLabel
				FootSnap_ToggleCurrentPose()
				Return()
		+ if FL_BodyPartDefs[ActiveAnimPart] and FL_BodyPartDefs[ActiveAnimPart].stepType == "eye"
			local FL_eyeMode = ActiveAnimPart and FL_EyeMode_Get(ActiveAnimPart) or 0
			+ "Mode: " .. FL_EyeModeName(FL_eyeMode)
				FL_EyeMode_Cycle(ActiveAnimPart, 1)
				Return()
		-- + if ActiveAnimPart == "Hips" -- worthless?
		-- 	+ "Mode: " .. FL_HipsModeName()
		-- 		FL_HipsMode_Toggle()
		-- 		Return()
		+ if ActiveAnimPart == "Mouth"
			+ "5-8.."[gold]
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
				+ "5 = " .. Anim_Menu5 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 5, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 5, "-", faunInc)
					Return()
				+ "6 = " .. Anim_Menu6 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 6, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 6, "-", faunInc)
					Return()
				+ "7 = " .. Anim_Menu7 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 7, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 7, "-", faunInc)
					Return()
				+ "8 = " .. Anim_Menu8 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 8, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 8, "-", faunInc)
					Return()
			+ "9-12.."[gold]
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "9 = " .. Anim_Menu9 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 9, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 9, "-", faunInc)
					Return()
				+ "10 = " .. Anim_Menu10 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 10, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 10, "-", faunInc)
					Return()
				+ "11 = " .. Anim_Menu11 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 11, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 11, "-", faunInc)
					Return()
				+ "12 = " .. Anim_Menu12 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 12, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 12, "-", faunInc)
					Return()
			+ "13-16.."[gold]
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "13 = " .. Anim_Menu13 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 13, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 13, "-", faunInc)
					Return()
				+ "14 = " .. Anim_Menu14 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 14, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 14, "-", faunInc)
					Return()
				+ "15 = " .. Anim_Menu15 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 15, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 15, "-", faunInc)
					Return()
				+ "16 = " .. Anim_Menu16 .. "" [gold]
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 16, "+", faunInc)
					Return()
				+ "-"
					Anim_ApplyToAllPoses(human, ActiveAnimPart, 16, "-", faunInc)
					Return()(human)
		+ "1 = " .. Anim_Menu1  .. "" [gold]
			Anim_ApplyToAllPoses(human, ActiveAnimPart, 1, "+", faunInc)
			Return()
		+ "-"
			Anim_ApplyToAllPoses(human, ActiveAnimPart, 1, "-", faunInc)
			Return()			
		+ "2 = " .. Anim_Menu2 .. "" [gold]
			Anim_ApplyToAllPoses(human, ActiveAnimPart, 2, "+", faunInc)
			Return()
		+ "-"
			Anim_ApplyToAllPoses(human, ActiveAnimPart, 2, "-", faunInc)
			Return()
		+ "3 = " .. Anim_Menu3 .. "" [gold]
			Anim_ApplyToAllPoses(human, ActiveAnimPart, 3, "+", faunInc)
			Return()
		+ "-"
			Anim_ApplyToAllPoses(human, ActiveAnimPart, 3, "-", faunInc)
			Return()
		+ "4 = " .. Anim_Menu4 .. "" [gold]
			Anim_ApplyToAllPoses(human, ActiveAnimPart, 4, "+", faunInc)
			Return()
		+ "-"
			Anim_ApplyToAllPoses(human, ActiveAnimPart, 4, "-", faunInc)
			Return()
		+ "Change Increment | " .. faunInc .. ""
			+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
				Return(2)
			+ "Increment = 30"
				faunInc = 30
				Return(2)
			+ "Increment = 15"
				faunInc = 15
				Return(2)
			+ "Increment = 5"
				faunInc = 5
				Return(2)
			+ "Increment = 2.5"
				faunInc = 2.5
				Return(2)
			+ "Increment = 1"
				faunInc = 1
				Return(2)
			+ "Increment = 0.2"
				faunInc = 0.2
				Return(2)
			+ "Increment = 0.1"
				faunInc = 0.1
				Return(2)
			+ "Increment = 0.01"
				faunInc = 0.01
				Return(2)
			+ "Increment = 0.025"
				faunInc = 0.025
				Return(2)
			+ "Increment = 0.001"
				faunInc = 0.001
				Return(2)
	+ "Edit One.." [gold]
		Anim_Pose1(human)
		+ "<color=#9a646f><i>Done."
		+ "<color=#54b095><i>Back."
			Return(2)
		+ if FL_BodyPartDefs[ActiveAnimPart] and FL_BodyPartDefs[ActiveAnimPart].stepType == "foot"
			local snapVal = Anim_Menu4 or 0
			local snapLabel = (snapVal ~= 0) and "On" or "Off"
			+ "Ground Snap: " .. snapLabel
				FootSnap_ToggleCurrentPose()
				Return()
		+ if FL_BodyPartDefs[ActiveAnimPart] and FL_BodyPartDefs[ActiveAnimPart].stepType == "eye"
			local FL_eyeMode = ActiveAnimPart and FL_EyeMode_Get(ActiveAnimPart) or 0
			+ "Mode: " .. FL_EyeModeName(FL_eyeMode)
				FL_EyeMode_Cycle(ActiveAnimPart, 1)
				Return()
		-- + if ActiveAnimPart == "Hips"
		-- 	+ "Mode: " .. FL_HipsModeName()
		-- 		FL_HipsMode_Toggle()
		-- 		Return()
		+ if ActiveAnimPart == "Mouth"
			+ "Jaw V/H.."[gold]
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "Prev Pose"[if Anim_MenuPoseCount > 1]
					Anim_PrevPose(human)
					Return()
				+ "Next Pose"[if Anim_MenuPoseCount > 1]
					Anim_NextPose(human)
					Return()
				+ "^ | Vertical = " .. Anim_Menu1 .. "" [gold]
					Anim_ApplyDelta(human, 1, faunInc)
					Return()
				+ "-"
					Anim_ApplyDelta(human, 1, -faunInc)
					Return()
				+ "^ | Horizontal = " .. Anim_Menu2 .. "" [gold]
					Anim_ApplyDelta(human, 2, faunInc)
					Return()
				+ "-"
					Anim_ApplyDelta(human, 2, -faunInc)
					Return()
				+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
						Return(2)
					+ "Increment = 30"
						faunInc = 30
						Return(2)
					+ "Increment = 15"
						faunInc = 15
						Return(2)
					+ "Increment = 5"
						faunInc = 5
						Return(2)
					+ "Increment = 2.5"
						faunInc = 2.5
						Return(2)
					+ "Increment = 1"
						faunInc = 1
						Return(2)
					+ "Increment = 0.2"
						faunInc = 0.2
						Return(2)
					+ "Increment = 0.1"
						faunInc = 0.1
						Return(2)
					+ "Increment = 0.01"
						faunInc = 0.01
						Return(2)
					+ "Increment = 0.025"
						faunInc = 0.025
						Return(2)
					+ "Increment = 0.001"
						faunInc = 0.001
						Return(2)
			+ "Jaw Length.."[gold]
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "Prev Pose"[if Anim_MenuPoseCount > 1]
					Anim_PrevPose(human)
					Return()
				+ "Next Pose"[if Anim_MenuPoseCount > 1]
					Anim_NextPose(human)
					Return()
				+ "^ | Length = " .. Anim_Menu3 .. "" [gold]
					Anim_ApplyDelta(human, 3, faunInc)
					Return()
				+ "-"
					Anim_ApplyDelta(human, 3, -faunInc)
					Return()
				+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
						Return(2)
					+ "Increment = 30"
						faunInc = 30
						Return(2)
					+ "Increment = 15"
						faunInc = 15
						Return(2)
					+ "Increment = 5"
						faunInc = 5
						Return(2)
					+ "Increment = 2.5"
						faunInc = 2.5
						Return(2)
					+ "Increment = 1"
						faunInc = 1
						Return(2)
					+ "Increment = 0.2"
						faunInc = 0.2
						Return(2)
					+ "Increment = 0.1"
						faunInc = 0.1
						Return(2)
					+ "Increment = 0.01"
						faunInc = 0.01
						Return(2)
					+ "Increment = 0.025"
						faunInc = 0.025
						Return(2)
					+ "Increment = 0.001"
						faunInc = 0.001
						Return(2)
			+ "Lips.."[gold]
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "Lip Top.."[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "Prev Pose"[if Anim_MenuPoseCount > 1]
						Anim_PrevPose(human)
						Return()
					+ "Next Pose"[if Anim_MenuPoseCount > 1]
						Anim_NextPose(human)
						Return()
					+ "^ | Top Right = " .. Anim_Menu4 .. "" [gold]
						Anim_ApplyDelta(human, 4, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 4, -faunInc)
						Return()
					+ "^ | Top Left = " .. Anim_Menu5 .. "" [gold]
						Anim_ApplyDelta(human, 5, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 5, -faunInc)
						Return()
					+ "^ | Both = " .. Anim_Menu4 .. "|" .. Anim_Menu5 .. "" [gold]
						Anim_ApplyDelta(human, 4, faunInc)
						Anim_ApplyDelta(human, 5, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 4, -faunInc)
						Anim_ApplyDelta(human, 5, -faunInc)
						Return()
					+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
							Return(2)
						+ "Increment = 30"
							faunInc = 30
							Return(2)
						+ "Increment = 15"
							faunInc = 15
							Return(2)
						+ "Increment = 5"
							faunInc = 5
							Return(2)
						+ "Increment = 2.5"
							faunInc = 2.5
							Return(2)
						+ "Increment = 1"
							faunInc = 1
							Return(2)
						+ "Increment = 0.2"
							faunInc = 0.2
							Return(2)
						+ "Increment = 0.1"
							faunInc = 0.1
							Return(2)
						+ "Increment = 0.01"
							faunInc = 0.01
							Return(2)
						+ "Increment = 0.025"
							faunInc = 0.025
							Return(2)
						+ "Increment = 0.001"
							faunInc = 0.001
							Return(2)
				+ "Lip Bottom.."[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "Prev Pose"[if Anim_MenuPoseCount > 1]
						Anim_PrevPose(human)
						Return()
					+ "Next Pose"[if Anim_MenuPoseCount > 1]
						Anim_NextPose(human)
						Return()
					+ "^ | Top Right = " .. Anim_Menu6 .. "" [gold]
						Anim_ApplyDelta(human, 6, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 6, -faunInc)
						Return()
					+ "^ | Top Left = " .. Anim_Menu7 .. "" [gold]
						Anim_ApplyDelta(human, 7, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 7, -faunInc)
						Return()
					+ "^ | Both = " .. Anim_Menu6 .. "|" .. Anim_Menu7 .. "" [gold]
						Anim_ApplyDelta(human, 6, faunInc)
						Anim_ApplyDelta(human, 7, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 6, -faunInc)
						Anim_ApplyDelta(human, 7, -faunInc)
						Return()
					+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
							Return(2)
						+ "Increment = 30"
							faunInc = 30
							Return(2)
						+ "Increment = 15"
							faunInc = 15
							Return(2)
						+ "Increment = 5"
							faunInc = 5
							Return(2)
						+ "Increment = 2.5"
							faunInc = 2.5
							Return(2)
						+ "Increment = 1"
							faunInc = 1
							Return(2)
						+ "Increment = 0.2"
							faunInc = 0.2
							Return(2)
						+ "Increment = 0.1"
							faunInc = 0.1
							Return(2)
						+ "Increment = 0.01"
							faunInc = 0.01
							Return(2)
						+ "Increment = 0.025"
							faunInc = 0.025
							Return(2)
						+ "Increment = 0.001"
							faunInc = 0.001
							Return(2)
				+ "Smile.."[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "Prev Pose"[if Anim_MenuPoseCount > 1]
						Anim_PrevPose(human)
						Return()
					+ "Next Pose"[if Anim_MenuPoseCount > 1]
						Anim_NextPose(human)
						Return()
					+ "^ | Top Right = " .. Anim_Menu8 .. "" [gold]
						Anim_ApplyDelta(human, 8, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 8, -faunInc)
						Return()
					+ "^ | Top Left = " .. Anim_Menu9 .. "" [gold]
						Anim_ApplyDelta(human, 9, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 9, -faunInc)
						Return()
					+ "^ | Both = " .. Anim_Menu8 .. "|" .. Anim_Menu9 .. "" [gold]
						Anim_ApplyDelta(human, 8, faunInc)
						Anim_ApplyDelta(human, 9, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 8, -faunInc)
						Anim_ApplyDelta(human, 9, -faunInc)
						Return()
					+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
							Return(2)
						+ "Increment = 30"
							faunInc = 30
							Return(2)
						+ "Increment = 15"
							faunInc = 15
							Return(2)
						+ "Increment = 5"
							faunInc = 5
							Return(2)
						+ "Increment = 2.5"
							faunInc = 2.5
							Return(2)
						+ "Increment = 1"
							faunInc = 1
							Return(2)
						+ "Increment = 0.2"
							faunInc = 0.2
							Return(2)
						+ "Increment = 0.1"
							faunInc = 0.1
							Return(2)
						+ "Increment = 0.01"
							faunInc = 0.01
							Return(2)
						+ "Increment = 0.025"
							faunInc = 0.025
							Return(2)
						+ "Increment = 0.001"
							faunInc = 0.001
							Return(2)
				+ "Lip Horizontal.."[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "Prev Pose"[if Anim_MenuPoseCount > 1]
						Anim_PrevPose(human)
						Return()
					+ "Next Pose"[if Anim_MenuPoseCount > 1]
						Anim_NextPose(human)
						Return()
					+ "^ | Right = " .. Anim_Menu10 .. "" [gold]
						Anim_ApplyDelta(human, 10, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 10, -faunInc)
						Return()
					+ "^ | Left = " .. Anim_Menu11 .. "" [gold]
						Anim_ApplyDelta(human, 11, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 11, -faunInc)
						Return()
					+ "^ | Both = " .. Anim_Menu10 .. "|" .. Anim_Menu11 .. "" [gold]
						Anim_ApplyDelta(human, 10, faunInc)
						Anim_ApplyDelta(human, 11, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 10, -faunInc)
						Anim_ApplyDelta(human, 11, -faunInc)
						Return()
					+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
							Return(2)
						+ "Increment = 30"
							faunInc = 30
							Return(2)
						+ "Increment = 15"
							faunInc = 15
							Return(2)
						+ "Increment = 5"
							faunInc = 5
							Return(2)
						+ "Increment = 2.5"
							faunInc = 2.5
							Return(2)
						+ "Increment = 1"
							faunInc = 1
							Return(2)
						+ "Increment = 0.2"
							faunInc = 0.2
							Return(2)
						+ "Increment = 0.1"
							faunInc = 0.1
							Return(2)
						+ "Increment = 0.01"
							faunInc = 0.01
							Return(2)
						+ "Increment = 0.025"
							faunInc = 0.025
							Return(2)
						+ "Increment = 0.001"
							faunInc = 0.001
							Return(2)
				+ "Lip Vertical.."[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "Prev Pose"[if Anim_MenuPoseCount > 1]
						Anim_PrevPose(human)
						Return()
					+ "Next Pose"[if Anim_MenuPoseCount > 1]
						Anim_NextPose(human)
						Return()
					+ "^ | Height = " .. Anim_Menu12 .. "" [gold]
						Anim_ApplyDelta(human, 12, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 12, -faunInc)
						Return()
					+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
							Return(2)
						+ "Increment = 30"
							faunInc = 30
							Return(2)
						+ "Increment = 15"
							faunInc = 15
							Return(2)
						+ "Increment = 5"
							faunInc = 5
							Return(2)
						+ "Increment = 2.5"
							faunInc = 2.5
							Return(2)
						+ "Increment = 1"
							faunInc = 1
							Return(2)
						+ "Increment = 0.2"
							faunInc = 0.2
							Return(2)
						+ "Increment = 0.1"
							faunInc = 0.1
							Return(2)
						+ "Increment = 0.01"
							faunInc = 0.01
							Return(2)
						+ "Increment = 0.025"
							faunInc = 0.025
							Return(2)
						+ "Increment = 0.001"
							faunInc = 0.001
							Return(2)
				+ "Lip Length / Curve.."[gold]
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back."
						Return(2)
					+ "Prev Pose"[if Anim_MenuPoseCount > 1]
						Anim_PrevPose(human)
						Return()
					+ "Next Pose"[if Anim_MenuPoseCount > 1]
						Anim_NextPose(human)
						Return()
					+ "^ | Length = " .. Anim_Menu13 .. "" [gold]
						Anim_ApplyDelta(human, 13, faunInc)
						Return()
					+ "-"
						Anim_ApplyDelta(human, 13, -faunInc)
						Return()
					+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
						+ "<color=#9a646f><i>Done."
						+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
							Return(2)
						+ "Increment = 30"
							faunInc = 30
							Return(2)
						+ "Increment = 15"
							faunInc = 15
							Return(2)
						+ "Increment = 5"
							faunInc = 5
							Return(2)
						+ "Increment = 2.5"
							faunInc = 2.5
							Return(2)
						+ "Increment = 1"
							faunInc = 1
							Return(2)
						+ "Increment = 0.2"
							faunInc = 0.2
							Return(2)
						+ "Increment = 0.1"
							faunInc = 0.1
							Return(2)
						+ "Increment = 0.01"
							faunInc = 0.01
							Return(2)
						+ "Increment = 0.025"
							faunInc = 0.025
							Return(2)
						+ "Increment = 0.001"
							faunInc = 0.001
							Return(2)
			+ "Tongue Length.."[gold]
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "Prev Pose"[if Anim_MenuPoseCount > 1]
					Anim_PrevPose(human)
					Return()
				+ "Next Pose"[if Anim_MenuPoseCount > 1]
					Anim_NextPose(human)
					Return()
				+ "^ | Length = " .. Anim_Menu14 .. "" [gold]
					Anim_ApplyDelta(human, 14, faunInc)
					Return()
				+ "-"
					Anim_ApplyDelta(human, 14, -faunInc)
					Return()
				+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
						Return(2)
					+ "Increment = 30"
						faunInc = 30
						Return(2)
					+ "Increment = 15"
						faunInc = 15
						Return(2)
					+ "Increment = 5"
						faunInc = 5
						Return(2)
					+ "Increment = 2.5"
						faunInc = 2.5
						Return(2)
					+ "Increment = 1"
						faunInc = 1
						Return(2)
					+ "Increment = 0.2"
						faunInc = 0.2
						Return(2)
					+ "Increment = 0.1"
						faunInc = 0.1
						Return(2)
					+ "Increment = 0.01"
						faunInc = 0.01
						Return(2)
					+ "Increment = 0.025"
						faunInc = 0.025
						Return(2)
					+ "Increment = 0.001"
						faunInc = 0.001
						Return(2)
			+ "Tongue Horizontal / Vertical.."[gold]
				+ "<color=#9a646f><i>Done."
				+ "<color=#54b095><i>Back."
					Return(2)
				+ "Prev Pose"[if Anim_MenuPoseCount > 1]
					Anim_PrevPose(human)
					Return()
				+ "Next Pose"[if Anim_MenuPoseCount > 1]
					Anim_NextPose(human)
					Return()
				+ "^ | Horizontal = " .. Anim_Menu15 .. "" [gold]
					Anim_ApplyDelta(human, 15, faunInc)
					Return()
				+ "-"
					Anim_ApplyDelta(human, 15, -faunInc)
					Return()
				+ "^ | Vertical = " .. Anim_Menu16 .. "" [gold]
					Anim_ApplyDelta(human, 16, faunInc)
					Return()
				+ "-"
					Anim_ApplyDelta(human, 16, -faunInc)
					Return()
				+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
					+ "<color=#9a646f><i>Done."
					+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
						Return(2)
					+ "Increment = 30"
						faunInc = 30
						Return(2)
					+ "Increment = 15"
						faunInc = 15
						Return(2)
					+ "Increment = 5"
						faunInc = 5
						Return(2)
					+ "Increment = 2.5"
						faunInc = 2.5
						Return(2)
					+ "Increment = 1"
						faunInc = 1
						Return(2)
					+ "Increment = 0.2"
						faunInc = 0.2
						Return(2)
					+ "Increment = 0.1"
						faunInc = 0.1
						Return(2)
					+ "Increment = 0.01"
						faunInc = 0.01
						Return(2)
					+ "Increment = 0.025"
						faunInc = 0.025
						Return(2)
					+ "Increment = 0.001"
						faunInc = 0.001
						Return(2)

		+ "Prev Pose"[if Anim_MenuPoseCount > 1]
			Anim_PrevPose(human)
			Return()
		+ "Next Pose"[if Anim_MenuPoseCount > 1]
			Anim_NextPose(human)
			Return()

		+ if ActiveAnimPart ~= "Mouth"
			+ "1 = " .. Anim_Menu1  .. "" [gold]
				Anim_ApplyDelta(human, 1,  faunInc)
				Return()
			+ "-"
				Anim_ApplyDelta(human, 1, -faunInc)
				Return()
			+ "2 = " .. Anim_Menu2 .. "" [gold]
				Anim_ApplyDelta(human, 2,  faunInc)
				Return()
			+ "-"
				Anim_ApplyDelta(human, 2,  -faunInc)
				Return()
			+ "3 = " .. Anim_Menu3 .. "" [gold]
				Anim_ApplyDelta(human, 3,  faunInc)
				Return()
			+ "-"
				Anim_ApplyDelta(human, 3,  -faunInc)
				Return()
		+ if ActiveAnimPart == "Brows"
			+ "4 = " .. Anim_Menu4 .. "" [gold]
				Anim_ApplyDelta(human, 4,  faunInc)
				Return()
			+ "-"
				Anim_ApplyDelta(human, 4,  -faunInc)
				Return()
		+ "Change Increment | " .. faunInc .. " | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
			+ "<color=#9a646f><i>Done."
			+ "<color=#54b095><i>Back. Increment = " .. faunInc .. ""
				Return(2)
			+ "Increment = 30"
				faunInc = 30
				Return(2)
			+ "Increment = 15"
				faunInc = 15
				Return(2)
			+ "Increment = 5"
				faunInc = 5
				Return(2)
			+ "Increment = 2.5"
				faunInc = 2.5
				Return(2)
			+ "Increment = 1"
				faunInc = 1
				Return(2)
			+ "Increment = 0.2"
				faunInc = 0.2
				Return(2)
			+ "Increment = 0.1"
				faunInc = 0.1
				Return(2)
			+ "Increment = 0.01"
				faunInc = 0.01
				Return(2)
			+ "Increment = 0.025"
				faunInc = 0.025
				Return(2)
			+ "Increment = 0.001"
				faunInc = 0.001
				Return(2)
	+ "Start | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
		Anim_StopCurrent(human)
		Anim_Start(human)
		Return()
	+ (AP() and AP().RandomizeLoop and "<color=#54b095>" or "<color=#9a646f>") .. "Randomize Pose Order"
		Anim_ToggleRandomLoop()
		Return()
	+ (AP() and AP().RandomizeValues and "<color=#54b095>" or "<color=#9a646f>") .. "Randomize Pose Values"
		Anim_ToggleRandomValues()
		Return()
	+ "Stop This Animation" [if GetActiveAnimCount(human) > 0]
		Anim_StopCurrent(human)
		Return()
	+ "Stop All Animations" [if GetActiveAnimCount(human) > 1]
		StopAllAnimations2(human)
		Return()
	+ "speedLAB.."[gold]
		+ "Reset | Ease In"[gold]
			CLV_A = 2
			Return()
		+ "Reset | Ease Out"[gold]
			CLV_B = 2
			Return()
		+ "Reset | Anim Speed"[gold]
			CL_SMult = 1
			Return()
		+ "<color=#9a646f><i>Done."
		+ "<color=#54b095><i>Back."
			Return(2)
		+ "^ | Ease In = " .. CLV_A .. ""[gold]
			CLV_A = CLV_A + FL_easeInc
			Return()
		+ "-"
			CLV_A = CLV_A - FL_easeInc
			Return()
		+ "^ | Ease Out = " .. CLV_B .. ""[gold]
			CLV_B = CLV_B + FL_easeInc
			Return()
		+ "^ | Easement = " .. CLV_A .. "/" .. CLV_B .. ""[gold]
			CLV_A = CLV_A + FL_easeInc
			CLV_B = CLV_B + FL_easeInc
			Return()
		+ "-"
			CLV_A = CLV_A - FL_easeInc
			CLV_B = CLV_B - FL_easeInc
			Return()
		+ "^ | speed = " .. CL_SMult .. ""[gold]
			CL_SMult = CL_SMult + FL_speedInc
			Return()
		+ "-"
			CL_SMult = CL_SMult - FL_speedInc
			Return()
		+ "^ | Duration = " .. FL_DurMult .. ""[gold]
			FL_DurMult = FL_DurMult + 0.25
			Return()
		+ "-"
			FL_DurMult = FL_DurMult - 0.25
			Return()
		+ "Start | Pose | " .. Anim_MenuPose  .. " | " .. Anim_MenuPoseCount
			Anim_StopCurrent(human)
			Anim_Start(human)
			Return()
stop

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

-----------------------------Crashlab Functions----------------------------------------------------------------------------------------------------------------------

--===================================================================================================================================================================
--===================================================================================================================================================================

function forcePenisActive(human, enabled) -- penis through clothing? something turns it back off
    if not human then
        log("[forcePenisActive] ERROR: human is nil")
        return false
    end
    if not human.m_puppetRig then
        log("[forcePenisActive] ERROR: m_puppetRig is nil")
        return false
    end
    local root = human.m_puppetRig.transform.parent
    if not root then
        log("[forcePenisActive] ERROR: transform.parent is nil")
        return false
    end
    local Penis = root:Find("Penis")
    if not Penis then
        log("[forcePenisActive] ERROR: could not find 'Penis' under root: " .. tostring(root.name))
        return false
    end
    local go = Penis.gameObject
    if not go then
        log("[forcePenisActive] ERROR: gameObject is nil on Penis")
        return false
    end
    if enabled == nil then
        go:SetActive(not go.activeSelf)
    else
        go:SetActive(enabled)
    end
    return true
end






--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

function Anim_OnValueChanged(human, partName)
    -- log("Anim_OnValueChanged: human=" .. tostring(human) .. " part=" .. tostring(partName))
    local hid = tostring(human)
    if not ActiveAnimParts[hid] then
		-- log("Anim_OnValueChanged: no ActiveAnimParts for hid") 
	return end
    if not ActiveAnimParts[hid][partName] then
		-- log("Anim_OnValueChanged: part not active, skipping rebuild") 
	return end
    Anim_RebuildPart(human, partName)
end

function Anim_RebuildPart(human, partName)
    -- log("Anim_RebuildPart: human=" .. tostring(human) .. " part=" .. tostring(partName))
    local parts    = LAB_GetPartIDs(human)
    local animData = parts[partName]
    if not animData then 
		-- log("Anim_RebuildPart: no animData") 
	return end
    -- log("Anim_RebuildPart: animID=" .. tostring(animData.animID))
    game.RemoveAnim(animData.animID)
    Anim_BakePart(human, partName)
end

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

--al2.0 functions
--------------------------------------------------
-- Animation part initialization
--------------------------------------------------

function AnimPart_Init(human, name, effectFunc, paramCount)
    local hid = tostring(human)
    AnimParts[hid] = AnimParts[hid] or {}
    if AnimParts[hid][name] then return end

    paramCount = paramCount or 3 -- default XYZ

    local pose = {}
    for i = 1, paramCount do
        pose[i] = 0
    end

    AnimParts[hid][name] = {
        ParamCount   = paramCount,
        Poses        = { pose },
        PoseCount    = 1,
        ActivePose   = 1,
        Effect       = effectFunc,

        RandomizeLoop = false,
        LoopOrder     = nil
    }
end

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

function LAB_ShuffleIndices(n)
    local t = {}
    for i = 1, n do t[i] = i end
    for i = n, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

-- Convenience accessor
function AP()
    if not ActiveAnimHuman or not ActiveAnimPart then return nil end
    return AnimParts[ActiveAnimHuman]
       and AnimParts[ActiveAnimHuman][ActiveAnimPart]
end



--------------------------------------------------
-- Pose load/save
--------------------------------------------------

function Anim_LoadPoseToMenu()
    local p = AP()
    if not p then return end

    local pose = p.Poses[p.ActivePose]
    if not pose then return end

    Anim_MenuPose      = p.ActivePose
    Anim_MenuPoseCount = p.PoseCount

    for i = 1, p.ParamCount do
        _G["Anim_Menu"..i] = pose[i] or 0
    end
end


function Anim_SaveMenuToPose()
    local p = AP()
    if not p then return end

    local pose = p.Poses[p.ActivePose]
    if not pose then return end

    for i = 1, p.ParamCount do
        pose[i] = _G["Anim_Menu"..i] or 0
    end
end

--------------------------------------------------
-- Pose navigation
--------------------------------------------------

function Anim_NextPose()
    Anim_SaveMenuToPose()

	local p = AnimParts[ActiveAnimHuman][ActiveAnimPart]
    p.ActivePose = p.ActivePose + 1

    if p.ActivePose > p.PoseCount then
        p.ActivePose = 1
    end

    Anim_LoadPoseToMenu()
end

function Anim_PrevPose()
    Anim_SaveMenuToPose()

	local p = AnimParts[ActiveAnimHuman][ActiveAnimPart]
    p.ActivePose = p.ActivePose - 1

    if p.ActivePose < 1 then
        p.ActivePose = p.PoseCount
    end

    Anim_LoadPoseToMenu()
end

function Anim_AddPose()
    Anim_SaveMenuToPose()

    local p = AP()
    if not p then return end

    local hid = ActiveAnimHuman
    local partName = ActiveAnimPart

    local partDef = FL_BodyPartDefs[partName]
    local defaults = partDef and partDef.defaults

    p.PoseCount = p.PoseCount + 1

    local pose = {}

    for i = 1, p.ParamCount do
        if defaults then
            pose[i] = defaults[i] or 0
        else
            pose[i] = 0
        end
    end

    p.Poses[p.PoseCount] = pose
    p.ActivePose = p.PoseCount

    Anim_LoadPoseToMenu()
end

function Anim_RemovePose()
    local p = AP()
    if not p or p.PoseCount <= 1 then return end

    table.remove(p.Poses, p.ActivePose)
    p.PoseCount = p.PoseCount - 1

    if p.ActivePose > p.PoseCount then
        p.ActivePose = p.PoseCount
    end

    Anim_OnValueChanged(ActiveAnimHuman, ActiveAnimPart)
    Anim_LoadPoseToMenu()
end

function Anim_ApplyDelta(human, axis, delta)
    local p = AP()
    if not p then return end

    if axis > p.ParamCount then return end

    local pose = p.Poses[p.ActivePose]
    pose[axis] = FL_roundTo((pose[axis] or 0) + delta, 0.0001)

    _G["Anim_Menu"..axis] = pose[axis]

    Anim_OnValueChanged(human, ActiveAnimPart)
end

function Anim_ApplyToAllPoses(human, partName, axis, operator, delta)
    local hid  = tostring(human)
    local part = AnimParts[hid] and AnimParts[hid][partName]
    if not part then return end

    for i = 1, part.PoseCount do
        local v = part.Poses[i][axis]

        if operator == "+" then
            v = v + delta
        elseif operator == "-" then
            v = v - delta
        elseif operator == "*" then
            v = v * delta
        elseif operator == "=" then
            v = delta
        end

        part.Poses[i][axis] = FL_roundTo(v, 0.0001)
    end

    Anim_OnValueChanged(human, partName)

    if ActiveAnimHuman == hid and ActiveAnimPart == partName then
        Anim_LoadPoseToMenu()
    end
end

--------------------------------------------------
-- Select an animation part in the menu
--------------------------------------------------

function Anim_SelectPart(human, partName)
    ActiveAnimHumanObj = human

    local hid = tostring(human)
    local partDef = FL_BodyPartDefs[partName]
    local paramCount = partDef and partDef.axes or 3
    local defaults = partDef and partDef.defaults

    local checkDefault = AnimParts[hid] and AnimParts[hid][partName]

    AnimPart_Init(human, partName, AnimParts_DefaultEffects[partName], paramCount)

    if not checkDefault and defaults then
        local p = AnimParts[hid][partName]
        if p and p.Poses and p.Poses[1] then
            for i = 1, paramCount do
                p.Poses[1][i] = defaults[i] or 0
            end
        end
    end

    ActiveAnimHuman = hid
    ActiveAnimPart  = partName

    faunInc = (partDef and partDef.increment) or 5

    Anim_LoadPoseToMenu()
end

--------------------------------------------------
-- Start animating the currently selected part
--------------------------------------------------

function Anim_Start(human)
    local hid = tostring(human)
    ActiveAnimParts[hid] = ActiveAnimParts[hid] or {}
    if ActiveAnimParts[hid][ActiveAnimPart] then return end
    ActiveAnimParts[hid][ActiveAnimPart] = true
    Anim_BakePart(human, ActiveAnimPart)
end

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

--------------------------------------------------
-- Build and start the repeat animation for a part
--------------------------------------------------
function Anim_BakePart(human, partName)
    local hid  = tostring(human)
    local part = AnimParts[hid][partName]
    if not part then return end

    local effectFunc = AnimParts_DefaultEffects[partName]
    if not effectFunc then return end

    local parts    = LAB_GetPartIDs(human)
    local animData = parts[partName]
    if not animData or not animData.animID then return end

    local cfg = InitFL_RandomizerConfig(partName)
	FL_DurMult = FL_DurMult or 2.5

	local speed = 0.3 / CL_SMult
	local loopDuration = speed * FL_DurMult

	local function resolveEffect(func, poseIndex)
		local p = part.Poses[poseIndex]
		local values = {}
		for k = 1, part.ParamCount do
			values[k] = p[k] or 0
		end

		if part.RandomizeValues then
			values = FL_ApplyRandomizerConfig(cfg, values, partName)
		end

		-- log("[AnimLAB] " .. partName .. " pose=" .. poseIndex .. " values=[" .. table.concat(values, ", ") .. "]")

		local ok, result = pcall(func, unpack(values))
		if not ok then
			-- log("[AnimLAB] resolveEffect FAILED pose=" .. poseIndex .. " err=" .. tostring(result))
			return nil
		end
		return result
	end

    if partName == "Eyes" then
        local effectL = AnimParts_DefaultEffects["EyeL"]
        local effectR = AnimParts_DefaultEffects["EyeR"]
        if not effectL or not effectR then
            local effectEyes = AnimParts_DefaultEffects["Eyes"]
            if effectEyes then
                effectL = function(...) return select(1, effectEyes(...)) end
                effectR = function(...) return select(2, effectEyes(...)) end
            end
        end
        if not effectL or not effectR then return end

        local animDataR = parts["Eyes_R"]
        if not animDataR or not animDataR.animID then return end

        local effectsL, effectsR = {}, {}
        for i = 1, part.PoseCount do
            effectsL[i] = resolveEffect(effectL, i)
            effectsR[i] = resolveEffect(effectR, i)
            if not effectsL[i] or not effectsR[i] then return end
        end

        activeloops[animData.animID]  = loopDuration
        activeloops[animDataR.animID] = loopDuration

        game.AddRepeatAnim(speed,
            || CustomLoopsVX(human, partName, activeloops[animData.animID], unpack(effectsL)),
            animData.animID)
        game.AddRepeatAnim(speed,
            || CustomLoopsVX(human, partName, activeloops[animDataR.animID], unpack(effectsR)),
            animDataR.animID)
        return
    end

    -- Standard case
    local effects = {}
    for i = 1, part.PoseCount do
        local result = resolveEffect(effectFunc, i)
        if not result then return end
        effects[i] = result
    end

    activeloops[animData.animID] = loopDuration
    game.AddRepeatAnim(speed,
        || CustomLoopsVX(human, partName, activeloops[animData.animID], unpack(effects)),
        animData.animID)
end

--===================================================================================================================================================================
--===================================================================================================================================================================

function Anim_ToggleRandomValues()
    local p = AP()
    if not p then return end
    if p.PoseCount <= 1 then
        p.RandomizeValues = false
        return
    end
    p.RandomizeValues = not p.RandomizeValues
end

function FL_ApplyRandomizerConfig(cfg, values, partName)
    local partDef = FL_BodyPartDefs[partName]
    local noRandom = partDef and partDef.noRandom  -- e.g. {4} for FootL/FootR

    -- Build a lookup for protected axes
    local protected = {}
    if noRandom then
        for _, axis in ipairs(noRandom) do protected[axis] = true end
    end

    local out = {}
    for i, v in ipairs(values) do
        if protected[i] then
            out[i] = v
		elseif cfg.mode == "percent" then
			local lo = cfg.low  / 100
			local hi = cfg.high / 100
			local factor = lo + math.random() * (hi - lo)
			out[i] = v * factor * cfg.sign
			out[i] = FL_roundTo(out[i], 0.001)
        else  -- "flat"
			local delta = cfg.flatLow + math.random() * (cfg.flatHigh - cfg.flatLow)
			out[i] = v + delta * cfg.sign
			out[i] = FL_roundTo(out[i], 0.001)
		end
    end
    return out
end
--===================================================================================================================================================================
--===================================================================================================================================================================

function Anim_ToggleRandomLoop()
    local p = AP()
    if not p then return end
    if p.PoseCount <= 1 then
        p.RandomizeLoop = false
        return
    end
    p.RandomizeLoop = not p.RandomizeLoop
end

function Anim_StopPart(human, partName)
    local hid = tostring(human)
    if not ActiveAnimParts[hid] then return end
    if not ActiveAnimParts[hid][partName] then return end

    local parts    = LAB_GetPartIDs(human)
    local animData = parts[partName]
    if not animData then return end

    game.RemoveAnim(animData.animID)

    -- clean up Eyes_R if stopping Eyes
    if partName == "Eyes" then
        local animDataR = parts["Eyes_R"]
        if animDataR and animDataR.animID then
            game.RemoveAnim(animDataR.animID)
        end
    end

    ActiveAnimShuffles[tostring(human) .. partName] = nil  -- << here

    ActiveAnimParts[hid][partName] = nil

    if next(ActiveAnimParts[hid]) == nil then
        ActiveAnimParts[hid] = nil
    end
end

function GetActiveAnimCount(human)
    local hid = tostring(human)
    if not ActiveAnimParts[hid] then return 0 end

    local count = 0
    for _ in pairs(ActiveAnimParts[hid]) do
        count = count + 1
    end

    return count
end

function StopAllAnimations2(human)
    local hid = tostring(human)
    if not ActiveAnimParts[hid] then return end

    for partName, _ in pairs(ActiveAnimParts[hid]) do
        Anim_StopPart(human, partName)
    end

    ActiveAnimParts[hid] = nil
end

function Anim_StopCurrent(human)
    Anim_StopPart(human, ActiveAnimPart)
end

function Anim_ResetPoses(human, partName, resetAll)
    local hid  = tostring(human)
    local part = AnimParts[hid] and AnimParts[hid][partName]
    if not part then return end

    local function resetPose(pose)
        for i = 1, part.ParamCount do
            pose[i] = 0
        end
    end

    if resetAll then
        for i = 1, part.PoseCount do
            resetPose(part.Poses[i])
        end
        part.ActivePose = 1
    else
        resetPose(part.Poses[part.ActivePose])
    end

    Anim_LoadPoseToMenu()
    Anim_OnValueChanged(human, partName)
end

-- Toggle percentage/flat mode
function Randomizer_ToggleMode(partName)
    local cfg = InitFL_RandomizerConfig(partName)
    if not cfg then return end

    if cfg.mode == "percent" then
        cfg.mode = "flat"
    else
        cfg.mode = "percent"
    end
end

-- Toggle sign (+/-)
function Randomizer_ToggleSign(cfg)
    if cfg.sign == 1 then
        cfg.sign = -1
        cfg.signtext = "Decrease"
    else
        cfg.sign = 1
        cfg.signtext = "Increase"
    end
end

-- Toggle adjust target (top / bottom / both)
function Randomizer_ToggleAdjust(partName)
    local cfg = InitFL_RandomizerConfig(partName)
    if not cfg then return end

    if cfg.adjust == "both" then
        cfg.adjust = "top"
    elseif cfg.adjust == "top" then
        cfg.adjust = "bottom"
    else
        cfg.adjust = "both"
    end
end

-- Reset values to default
function Randomizer_ResetValues(partName)
    local cfg = InitFL_RandomizerConfig(partName)
    if not cfg then return end

    cfg.flatLow  = 0
    cfg.flatHigh = 0
    cfg.low      = 80
    cfg.high     = 120
end

function Anim_ChangeRandomizer(partName, delta)
    local cfg = InitFL_RandomizerConfig(partName)
    if not cfg then return end

    if cfg.mode == "percent" then
        if cfg.adjust == "top" then
            -- move top up or down depending on sign
            cfg.high = cfg.high + delta * cfg.sign
        elseif cfg.adjust == "bottom" then
            -- move bottom up or down depending on sign
            cfg.low = cfg.low + delta * cfg.sign
        elseif cfg.adjust == "both" then
            -- widen or shrink the range based on sign
            cfg.high = cfg.high + delta * cfg.sign
            cfg.low  = cfg.low  - delta * cfg.sign
        end

        -- Clamp percent values
        if cfg.high < cfg.low then cfg.high = cfg.low end
        if cfg.low < 0 then cfg.low = 0 end

    else -- flat mode
        if cfg.adjust == "top" then
            cfg.flatHigh = cfg.flatHigh + delta * cfg.sign
        elseif cfg.adjust == "bottom" then
            cfg.flatLow = cfg.flatLow + delta * cfg.sign
        elseif cfg.adjust == "both" then
            cfg.flatHigh = cfg.flatHigh + delta * cfg.sign
            cfg.flatLow  = cfg.flatLow  - delta * cfg.sign
        end
        -- flat values can go negative
    end
end

function InitFL_RandomizerConfig(partName)
    if not partName then return nil end

    if not FL_RandomizerConfig[partName] then
        FL_RandomizerConfig[partName] = {
            low      = 80,
            high     = 120,
            flatLow  = 0,
            flatHigh = 0,
            mode     = "percent",
            adjust   = "both",
            sign     = 1,
            signtext = "Increase",
        }
    end

    return FL_RandomizerConfig[partName]
end

function Anim_Pose1(human)
    local hid = tostring(human)
    if AnimParts[hid] and ActiveAnimPart then
        local part = AnimParts[hid][ActiveAnimPart]
        if part then
            part.ActivePose = 1
            Anim_LoadPoseToMenu()
        end
    end
end

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

--===================================================================================================================================================================
--===================================================================================================================================================================

--animation infrastructure

-- Dynamic loop system - takes any number of loops/effects
-- Usage: CustomLoopsX(human, id, loop1, loop2, loop3, ...) - any number of loops
function CustomLoopsVX(actor, id, duration, ...)
    local effects = {...}
    local key = tostring(actor) .. id

    if activeloops[key] == nil then
        activeloops[key] = 1
    end

    local currentIndex = activeloops[key]

    -- Play current pose first, then advance
    actor.AddInvoluntaryAnim(id, duration, (duration / CLV_A), duration / CLV_B, effects[currentIndex])

    local nextIndex = currentIndex + 1
	if nextIndex > #effects then
		local hid  = tostring(actor)
		local part = AnimParts[hid] and AnimParts[hid][id]

		if part and part.RandomizeLoop and #effects > 1 then
			activeloops[key] = GetNextShuffledIndex(key, #effects)
		else
			activeloops[key] = 1  -- always reset regardless
		end

		if part and part.RandomizeValues and #effects > 1 then
			local parts    = LAB_GetPartIDs(actor)
			local animData = parts and parts[id]
			if animData then
				game.RemoveAnim(animData.animID)
				Anim_BakePart(actor, id)
			end
		end
	else
		activeloops[key] = nextIndex
	end
end

function CustomLoops6(human, loop1, loop2, loop3, loop4, loop5, loop6, id)
	CustomLoopsX(human, id, loop1, loop2, loop3, loop4, loop5, loop6)
end

function CustomLoopsV2(actor, id, duration, effect1, effect2)
	CustomLoopsVX(actor, id, duration, effect1, effect2)
end

function CustomLoopsV4(actor, id, duration, effect1, effect2, effect3, effect4)
	CustomLoopsVX(actor, id, duration, effect1, effect2, effect3, effect4)
end

function CustomLoopsV6(actor, id, duration, effect1, effect2, effect3, effect4, effect5, effect6)
	CustomLoopsVX(actor, id, duration, effect1, effect2, effect3, effect4, effect5, effect6)
end

function GetActiveAnimations(human)
    local active = {}

    for partName, partData in pairs(LAB_GetPartIDs(human)) do
        if game.HasAnim(partData.animID) then
            table.insert(active, {
                name = partName,
                animID = partData.animID
            })
        end
    end

    return active
end

function StopAllAnimations(human)
    for _, partData in pairs(LAB_GetPartIDs(human)) do
		game.RemoveAnim(partData.animID)
    end
end

function HasAnyAnimation(human)
    for _, partData in pairs(LAB_GetPartIDs(human)) do
        if game.HasAnim(partData.animID) then
            return true
        end
    end
    return false
end

--===================================================================================================================================================================
--===================================================================================================================================================================
-- EVENT HOOKS
--===================================================================================================================================================================
--===================================================================================================================================================================

local tick = 0

function faunaHooks()
	-- hmm, does this break anything?
    if type(TM_TrueMoan_Enable) == "function" and type(TM_AddFunctionHook) ~= "function" then
        local _prevTMEnable = TM_TrueMoan_Enable
        TM_TrueMoan_Enable = function()
            _prevTMEnable()
            Delayed(0.5, function()
                if init == false then init = true end
            end)
            local _prevTMOnGameUpdate = _TMOnGameUpdate
            _TMOnGameUpdate = function()
                if _prevTMOnGameUpdate then _prevTMOnGameUpdate() end
                FL_OnGameUpdate()
            end
            load([[function OnCreateHuman(human) FL_OnCreateHuman(human) if type(_TMOnCreateHuman) == "function" then _TMOnCreateHuman(human) end end]])()
            load([[function OnRemoveHuman(human) FL_OnRemoveHuman() if type(_TMOnRemoveHuman) == "function" then _TMOnRemoveHuman(human) end end]])()
        end
    end

    if type(TM_AddFunctionHook) == "function" then
        log("FL | Talk Menu Mod Manager activated!")
        TM_AddFunctionHook("FL Mod", "OnCreateHuman", 1, "FL_OnCreateHuman", true, false)
        TM_AddFunctionHook("FL Mod", "OnRemoveHuman", 1, "FL_OnRemoveHuman", true, false)
        TM_AddFunctionHook("FL Mod", "OnGameUpdate", 0, "FL_OnGameUpdate", true, false)
    elseif type(TM_TrueMoan_Enable) == "function" then
        log("FL | TrueMoan standalone activated!")
        load([[function OnGameUpdate() FL_OnGameUpdate() end]])()
        load([[function OnCreateHuman(human) FL_OnCreateHuman(human) end]])()
        load([[function OnRemoveHuman(human) FL_OnRemoveHuman() end]])()
    else
        log("FL | Freemode standalone activated!")
        load([[function OnGameUpdate() FL_OnGameUpdate() end]])()
        load([[function OnCreateHuman(human) FL_OnCreateHuman(human) end]])()
        load([[function OnRemoveHuman(human) FL_OnRemoveHuman() end]])()
    end
end

--===================================================================================================================================================================
--===================================================================================================================================================================
local corneaCache = {}

function FL_OnCreateHuman(human)
    if human then
        local key = tostring(human.m_instanceId)
        if FL_ActiveHumans[key] == nil then
            -- Resolve cornea transforms once at spawn
            local corneaL, corneaR = nil, nil
            local root = human.m_puppetRig and human.m_puppetRig.transform.parent
            if root then
                local fbx = root:Find("FBX")
                if fbx then
                    local boneEyeL = FL_FindByNameRecursive(fbx, "Bone_Eye_L")
                    local boneEyeR = FL_FindByNameRecursive(fbx, "Bone_Eye_R")
                    corneaL = boneEyeL and FL_FindByNameRecursive(boneEyeL, "Cornea++") or nil
                    corneaR = boneEyeR and FL_FindByNameRecursive(boneEyeR, "Cornea++") or nil
                end
            end

            FL_ActiveHumans[key] = {
                human = human,
                headTracking = false,
                targetIndex = 1,
                target = nil,
                reset = false,
                headClip = nil,
                pendingInit = 3,
                corneaL = corneaL,
                corneaR = corneaR,
            }
            log("FL | OnCreateHuman | " .. human.Name .. " added with key: " .. key)
			-- if state.pendingInit == nil then
			-- 	FL_InitBoneMass(human)
			-- 	FL_InitAssPhysicsDefaults(human)
			-- 	FL_InitBreastPhysicsDefaults(human)
			-- end
        end
        if type(FL_humanCustomDefaults) == "function"
        and (Faunalabs.state.FL_custom_Overrides_Enabled) then
            FL_humanCustomDefaults(human)
        end
    end
end

function FL_OnGameUpdate()
    if init == false then return end

    -- tick = (tick or 0) + 1
    -- if tick % 3600 == 0 then log("3600 frames passed") end

    for key, state in pairs(FL_ActiveHumans) do
        local human = state.human
        if not human then goto continue end
        if state.headTracking then
            FL_UpdateHeadTracking(human, state)
        end
        if state.pendingInit ~= nil then
            if state.pendingInit > 0 then
                state.pendingInit = state.pendingInit - 1
            else
                state.pendingInit = nil
				FL_gameStart()
				FL_InitBoneMass(human)
                FL_InitAssPhysicsDefaults(human)
                FL_InitBreastPhysicsDefaults(human)
                if type(FL_SetBoneScale) == "function" and FL_puppetBones then
                    for i = 1, #FL_puppetBones do
                        FL_SetBoneScale(human, i, Faunalabs.state.FL_customHitbox)
                    end
                else
                    log("FL - FL_SetBoneScale or FL_puppetBones not ready!")
                end
            end
        end
        ::continue::
    end
end

--===================================================================================================================================================================
--===================================================================================================================================================================

function FL_OnRemoveHuman()
    local humans = game.GetHumans()
	for key, state in pairs(FL_ActiveHumans) do
		local foundSelf = false
		local foundTarget = false

		local targetId = nil
		if state.target then
			local ok, id = pcall(function() return tostring(state.target.m_instanceId) end)
			if ok then targetId = id end
		end

		if humans then
			for i = 1, #humans do
				local h = humans[i]
				if h and tostring(h.m_instanceId) == key then
					foundSelf = true
				end
				if targetId and h and tostring(h.m_instanceId) == targetId then
					foundTarget = true
				end
			end
		end

		if state.target and not foundTarget then
			FL_CleanupHumanTracking(state)
		end

		if not foundSelf then
			FL_RemoveHuman(key, state)
		end
	end
end

-- --===================================================================================================================================================================

-- if type(TM_AddFunctionHook) == "function" then
-- 	TM_AddFunctionHook("FL Mod", "OnHumanClick", 2, "FL_OnHumanClick", true, false)
-- else
-- 	local funcCode = [[
-- 	function OnHumanClick(human, hitTri)
--     	FL_OnHumanClick(human, hitTri)
-- 	end
-- 	]]
-- 	load(funcCode)()
-- end

-- function FL_OnHumanClick(human, hitTri)

-- end

-- if type(TM_AddFunctionOverride) == "function" then
-- 	TM_AddFunctionOverride("FL Mod", "OnGameUpdate", 0, "FL_OnGameUpdate", 199, true)
-- else
-- 	local funcCode = [[
-- 	function OnGameUpdate()
--     	return FL_OnGameUpdate()
-- 	end
-- 	]]
-- 	load(funcCode)()
-- end
-- function FL_OnGameUpdate()
-- 
-- end

--===================================================================================================================================================================
--===================================================================================================================================================================

--poses


function FaceAhegao1() return Preset(
	EyeL(346.076, 28.61, 0),
	EyeR(347.849, 328.86, 0),
	Mouth(-1, 0.196, 0, 0.504, 0.504, 0, 0, 1, 1, 0.451, 0.451, 0, 0, 2, 0, -2),
	Brows(1, 1, 0.072, 0.072),
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
	SpineRot()
	-- Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	-- Brows(1, 1, 0.072, 0.072),
	-- EyelidL(),
	-- EyelidR(),
	-- Cheeks(-1, -1)
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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

function TouchHerself_1R() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", -0.15, -0.24, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ElbowR(0.16),
	WristR(56.042, 0, 1.53)
end

function TouchHerself_1L() return
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", 0.15, -0.24, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ElbowL(0.16),
	WristR(-56.042, 0, 1.53)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

--version 0.2M
--FAUN Body Presets

function OnBreasts_1() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", -0.066, -0.177, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", -0.066, 0.177, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-0.5),
	ElbowR(-0.5),
	WristL(),
	WristR()
end


function OnThigh_1() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Thigh_L", 0.4, -0.2, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", 0.4, 0.2, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	ElbowL(-0.5),
	ElbowR(-0.5),
	WristL(),
	WristR()
end

function OnHisAnkle_1() return
	HandL(BoneMesh(TargetActor.A, "Bone_Calf_R", 0.024, -0.5, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_R"),
	IndexL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_R"),
	MidL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_R"),
	RingL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_R"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_R"),
	HandR(BoneMesh(TargetActor.A, "Bone_Calf_L", 0.024, 0.5, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_L"),
	IndexR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_L"),
	MidR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_L"),
	RingR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_L"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Calf_L"),
	ElbowL(-0.5),
	ElbowR(-0.5),
	WristL(),
	WristR()
end

function HandsInfront_B1() return
	HandL(HPos(0.2, -0.63, 0.45), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(15, 90, 90, 20, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.2, -0.63, 0.45), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(15, 90, 90, 20, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ElbowL(-1),
	ElbowR(-1),
	WristL(-55, 0, 35),
	WristR(-55, 0, 35)
end

function BallFondler_1A() return --an entire baseball
	HandL(BoneMesh(TargetActor.A, "Bone_Calf_R", 0.024, -0.5, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	IndexL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	MidL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	RingL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	HandR(BoneMesh(TargetActor.A, "Bone_Hips", 1.785, 0.817, 0.03), Wrist(HPoint(0, 0, 0.3, 0, 0, 0, "Bone_Index3_L"), 70)),
	ThumbR(54, 0, 0, -16, -28, TargetActor.Null, "Null"),
	IndexR(-6, 34, 46, 0, 0, TargetActor.Null, "Null"),
	MidR(0, 46, 12, 4, 0, TargetActor.Null, "Null"),
	RingR(6, 22, 26, 6, 0, TargetActor.Null, "Null"),
	PinkyR(24, 18, 0, 14, 0, TargetActor.Null, "Null"),
	ElbowL(-0.451),
	ElbowR(-0.158),
	WristL(-43.272, 0, 107.704),
	WristR(-69.861, 0, 120)
end

function BallFondler_1B() return
	HandL(BoneMesh(TargetActor.A, "Bone_Calf_R", 0.024, -0.5, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	IndexL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	MidL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	RingL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	HandR(BoneMesh(TargetActor.A, "Bone_Hips", 1.785, 0.817, 0.03), Wrist(HPoint(0, 0, 0.3, 0, 0, 0, "Bone_Index3_L"), 70)),
	ThumbR(28, 0, 0, -22, -28, TargetActor.Null, "Null"),
	IndexR(-6, 34, 46, 0, 0, TargetActor.Null, "Null"),
	MidR(0, 46, 12, 4, 0, TargetActor.Null, "Null"),
	RingR(6, 22, 26, 6, 0, TargetActor.Null, "Null"),
	PinkyR(24, 18, 0, 14, 0, TargetActor.Null, "Null"),
	ElbowL(-0.451),
	ElbowR(-0.158),
	WristL(-43.272, 0, 107.704),
	WristR(-69.861, 0, 120)
end

function GrabAss_BJ_1() return
	HandL(BoneMesh(TargetActor.A, "Bone_Thigh_R", 0.2, -0.85, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	IndexL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	MidL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	RingL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	HandR(BoneMesh(TargetActor.A, "Bone_Thigh_L", 0.2, 0.85, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	IndexR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	MidR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	RingR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	ElbowL(-0.2),
	ElbowR(-0.2),
	WristL(-69, 0, 110),
	WristR(-69, 0, 110)
end

function HandsOnChest_1() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", 0.4, -0.2, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", 0.4, 0.2, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-1),
	ElbowR(-1),
	WristL(),
	WristR()
end

function HandsOnChest_2() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", 0.58, -0.35, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", 0.58, 0.35, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(0.26),
	ElbowR(0.26),
	WristL(),
	WristR()
end

function Gag_1() return
	EyeL(WorldPos(-0.003, 1.912, -0.405)),
	EyeR(WorldPos(-0.003, 1.912, -0.405)),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(2.5, 2.5),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(4, 4)
end

function HandsOnHead_1() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Head", 1.601, -0.628, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Head", 1.825, 0.87, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Head"),
	ElbowL(0.2),
	ElbowR(0.2)
end

function StarePenis_Angry_1() return
	HeadRot(303.73, 350.071, 356.457),
	EyeL(BoneMesh(TargetActor.A, "Bone_Penis", 0.854, 0.875, 0.03)),
	EyeR(BoneMesh(TargetActor.A, "Bone_Penis", 0.854, 0.875, 0.03)),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(-0.75, -0.75),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(-1.5, -1.5)
end

function StarePenis_Shocked_1() return
	HeadRot(303.73, 350.071, 356.457),
	EyeL(BoneMesh(TargetActor.A, "Bone_Penis", 0.854, 0.875, 0.03)),
	EyeR(BoneMesh(TargetActor.A, "Bone_Penis", 0.854, 0.875, 0.03)),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(3, 3, -1.25, -1.25),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(-1.5, -1.5)
end

function StarePenis_1() return
	HeadRot(303.73, 350.071, 356.457),
	EyeL(BoneMesh(TargetActor.A, "Bone_Penis", 0.854, 0.875, 0.03)),
	EyeR(BoneMesh(TargetActor.A, "Bone_Penis", 0.854, 0.875, 0.03)),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(1.5, 1.5, -1.5, -1.5),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(-1.5, -1.5)
end

function Cough_1() return
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(1.5, 1.5, -1.5, -1.5),
	EyelidL(0.246),
	EyelidR(0.246),
	Cheeks(2.25, 2.25)
end


function Wince_1() return
	EyeL(WorldPos(-0.003, 1.912, -0.405)),
	EyeR(WorldPos(-0.003, 1.912, -0.405)),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(2.5, 2.5),
	EyelidL(-0.35),
	EyelidR(-0.35),
	Cheeks(2.5, 2.5)
end

function Wince_2() return
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(1.5, 1.5, -1.5, -1.5),
	EyelidL(),
	EyelidR(),
	Cheeks(4.5, 4.5)
end

function Scowl_1() return
	HeadRot(303.73, 350.071, 356.457),
	EyeL(EyeContact(TargetActor.A)),
	EyeR(EyeContact(TargetActor.A)),
	Mouth(0, 0, 0, -0.211, -0.211, 0.302, 0.302, -0.356, -0.356, -1, -1, -1, 1),
	Brows(-0.25, -0.25, -1.5, -1.5),
	EyelidL(),
	EyelidR(),
	Cheeks(2.5, 2.5)
end

function HandsOnAss_1() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Hips", 0.98, 0.8, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Hips", 0.98, -0.8, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Hips")
end

function GrabBreasts_1() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Chest", -0.15, -0.24, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Chest", -0.15, 0.24, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Chest"),
	ElbowL(-1),
	ElbowR(-1),
	WristL(),
	WristR()
end

function ScratchStomach_1() return
	HandL(BoneMesh(TargetActor.A, "Bone_Spine", 0.147, 0.089, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Spine"),
	IndexL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Spine"),
	MidL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Spine"),
	RingL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Spine"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Spine"),
	HandR(BoneMesh(TargetActor.A, "Bone_Thigh_L", 0.156, 0.605, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	IndexR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	MidR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	RingR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	ElbowL(0.212),
	ElbowR(-0.258),
	WristL(),
	WristR(0.303, 0, 25.759)
end

function ScratchStomach_2() return
	HandL(BoneMesh(TargetActor.A, "Bone_Spine", 0.193, 0.118, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Spine"),
	IndexL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Spine"),
	MidL(22, 0, 0, -8, 0, TargetActor.Null, "Null"),
	RingL(14, 0, 0, -16, 0, TargetActor.Null, "Null"),
	PinkyL(14, 0, 0, -26, 0, TargetActor.Null, "Null"),
	HandR(BoneMesh(TargetActor.A, "Bone_Thigh_L", 0.257, 0.79, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	IndexR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	MidR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	RingR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	ElbowL(-0.132),
	ElbowR(-0.258),
	WristL(),
	WristR(54.517, 0, -41.731)
end

function ScratchStomach_3() return
	HandL(BoneMesh(TargetActor.A, "Bone_Spine", 0.193, 0.118, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(0, 16, 46, -8, 0, TargetActor.Null, "Null"),
	IndexL(4, 30, 36, 0, 0, TargetActor.Null, "Null"),
	MidL(4, 32, 34, -8, 0, TargetActor.Null, "Null"),
	RingL(-4, 28, 40, -20, 0, TargetActor.Null, "Null"),
	PinkyL(-4, 26, 32, -26, 0, TargetActor.Null, "Null"),
	HandR(BoneMesh(TargetActor.A, "Bone_Thigh_L", 0.257, 0.79, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	IndexR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	MidR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	RingR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	ElbowL(-0.132),
	ElbowR(-0.258),
	WristL(),
	WristR(54.517, 0, -41.731)
end

function ScratchStomach_4() return
	HandL(BoneMesh(TargetActor.A, "Bone_Spine", 0.193, 0.118, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(-4, 62, 56, -14, 0, TargetActor.Null, "Null"),
	IndexL(-16, 82, 36, 0, 0, TargetActor.Null, "Null"),
	MidL(-10, 84, 34, -8, 0, TargetActor.Null, "Null"),
	RingL(-18, 78, 40, -20, 0, TargetActor.Null, "Null"),
	PinkyL(-18, 86, 32, -26, 0, TargetActor.Null, "Null"),
	HandR(BoneMesh(TargetActor.A, "Bone_Thigh_L", 0.257, 0.79, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	IndexR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	MidR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	RingR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	ElbowL(-0.132),
	ElbowR(-0.258),
	WristL(),
	WristR(54.517, 0, -41.731)
end

function HandsOnHisHips_1() return
	EyeL(EyeContact(TargetActor.A)),
	EyeR(EyeContact(TargetActor.A)),
	HandL(BoneMesh(TargetActor.A, "Bone_Thigh_R", 0.282, -0.186, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	IndexL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	MidL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	RingL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_R"),
	HandR(BoneMesh(TargetActor.A, "Bone_Thigh_L", 0.338, 0.225, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	IndexR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	MidR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	RingR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.A, "Bone_Thigh_L"),
	ElbowL(-0.527),
	ElbowR(-0.258),
	WristL(),
	WristR(0.303, 0, 25.759)
end

function HandsOnHerHips_1() return
	HandL(BoneMesh(TargetActor.Main, "Bone_Thigh_L", 0.214, 0.108, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	IndexL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	MidL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	RingL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	PinkyL(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_L"),
	HandR(BoneMesh(TargetActor.Main, "Bone_Thigh_R", -0.214, 0.108, 0.03), Wrist(HPoint(0, -0.3, 0.7, 90), 0, 35)),
	ThumbR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	IndexR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	MidR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	RingR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	PinkyR(20, 20, 20, 0, 0, TargetActor.Main, "Bone_Thigh_R"),
	ElbowL(-0.993),
	ElbowR(-1),
	WristL(),
	WristR(0.303, 0, 25.759)
end

function _1() return

end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

function HandsBehind0() return
	HandL(HPos(0.494, -0.595, -0.119), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbL(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyL(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	HandR(HPos(-0.542, -0.532, -0.28), Wrist(HPoint(0, 0.3, 0.7, -90), 0, 0)),
	ThumbR(14.977, 89.644, 89.644, 20, 0, TargetActor.Null, "Null"),
	IndexR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	MidR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	RingR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	PinkyR(85, 95, 95, 0, 0, TargetActor.Null, "Null"),
	ElbowL(0.144),
	ElbowR(0.277),
	WristL(-37.201, 0, 15.149),
	WristR(-20.904, 0, 16.528)
end

function HandsBehind1() return
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
end

function HandsBehind2() return
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
end

function HandsBehind3() return
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
end

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

function FacePog() return Preset(
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
	Mouth(-0.12, -0.112, 0, -0.033, -0.77, -0.605, 1, 0.127, 0.416, 0.34, 0.961, 1.2),
	Brows(1, 1, -0.745, -0.745),
	EyelidL(0.31),
	EyelidR(0.31),
	Cheeks(1, 1)
) end

function FaceNervous() return Preset(
	Mouth(0.25, 0, 0, 0, 0, 0, 0, 0, 0, 1.5, 1, 1),
	Brows(2.75, 2.75),
	EyelidL(-0.35),
	EyelidR(-0.35),
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
	EyelidL(0.184),
	EyelidR(0.184),
	Cheeks(-1, -1)
) end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

--Lists
facepresets = {OpenWide, LookCam, FaceCam}
facestr = {"Open Wide", "Look at Camera", "Face the Camera"}
bodypresets = {DoubleV, JackO, HandsBehind}
bodystr = {"Double Vs", "Jack-O Pose", "Hands behind"}

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Lists

-- Ensure all functions in the preset lists are defined
Faun_Face = {
    { name = "Grit Teeth",        pose = GritTeeth },
    { name = "Grit Teeth - 2",    pose = GritTeeth2 },
    { name = "Pogged",            pose = FacePog },
    { name = "Pursed Lips",       pose = Pursedlips },
    { name = "Pursed Smile",      pose = Pursedsmile },
    { name = "Lipbite",           pose = Lipbite },
    { name = "Lipbite - 2",       pose = Lipbite2 },
    { name = "Nervous",           pose = FaceNervous },
    { name = "Disappointed",      pose = FaceDisappointed },
    { name = "Unimpressed",       pose = FaceUnimpressed },
}

Faun_Body = {
    { name = "Infront",        pose = HandsInfront_1 },
    { name = "Infront - 2",    pose = HandsInfront_2 },
    { name = "Behind",         pose = HandsBehind1 },
    { name = "Behind - 2",     pose = HandsBehind2 },
    { name = "Behind - 3",     pose = HandsBehind3 },
    { name = "Hands on Heels", pose = HandsHeels },
}

Faun_Kiss = {
    { name = "Tongue Out",      pose = TongueOut },
    { name = "Tongue Out - 2",  pose = TongueOut2 },
    { name = "Tongue Out - 3",  pose = TongueOut3 },
    { name = "Kiss - 1",        pose = Kiss1 },
    { name = "Kiss - 2",        pose = Kiss2 },
    { name = "Kiss - 3",        pose = Kiss3 },
    { name = "Kiss - 4",        pose = Kiss4 },
}

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---facelab

local eyelidSuccess, eyelidResult = pcall(function()
	return Preset(Eyelid(table.unpack(EyelidParams)))
end)
if not eyelidSuccess then
	print("Error creating preset:", eyelidResult)
else
	if human then
		human.Pose(eyelidResult)
	else
		print("Error: 'human' is undefined.")
	end
end

-- Initialize a table to store all 2 Eyelid parameters
local EyelidParams = {0, 0}

-- reset specific eyelid parameter
function ResetEyelidParam(index)
    if index >= 1 and index <= #EyelidParams then
        EyelidParams[index] = 0
        print("ResetEyelidParam: Resetting parameter " .. index)
        local success, result = pcall(function()
            return Eyelid(table.unpack(EyelidParams))
        end)
        if success then
            human.Pose(result)
        else
            print("Error in ResetEyelidParam: " .. result)
        end
    else
        print("Invalid parameter index: " .. index)
    end
	for eyelidIndex = 1, #EyelidParams do
  end
end

-- reset all eyelid parameters
function ResetALLEyelidParam(human)
    for i = 1, #EyelidParams do
        EyelidParams[i] = 0
    end
    print("ResetALLEyelidParam: Resetting all parameters")  -- Eyelid (0, 0)
    local success, result = pcall(function()
        return Eyelid(table.unpack(EyelidParams))
    end)
    if success then
        human.Pose(result)
    else
        print("Error in ResetALLEyelidParam: " .. result)
    end
end

-- Adjust eyelid increments
function AdjustEyelidParam(index, increment)
    if index >= 1 and index <= #EyelidParams then
        EyelidParams[index] = EyelidParams[index] + increment
        return (Eyelid(table.unpack(EyelidParams)))
    end
end

-- Adjusts the first Eyelid parameter by +0.25
function Eyelidpar1_A()
    return AdjustEyelidParam(1, FACE_PARAM_INCREMENT)
end

-- Adjusts the second Eyelid parameter by +0.25
function Eyelidpar2_A()
  return AdjustEyelidParam(2, FACE_PARAM_INCREMENT)
end

-- Adjusts the first Eyelid parameter by -0.25
function Eyelidpar1_B()
    return AdjustEyelidParam(1, FACE_PARAM_INCREMENT)
end

-- Adjusts the second Eyelid parameter by -0.25
function Eyelidpar2_B()
  return AdjustEyelidParam(2, FACE_PARAM_INCREMENT)
end

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- reset specific cheek parameter

local cheeksSuccess, cheeksResult = pcall(function()
	return Preset(Cheeks(table.unpack(cheeksParams)))
end)
if not cheeksSuccess then
	print("Error creating preset:", cheeksResult)
else
	if human then
		human.Pose(cheeksResult)
	else
		print("Error: 'human' is undefined.")
	end
end

-- --Initialize a table to store all 2 cheeks parameters
local cheeksParams = {0, 0}



FACE_PARAM_INCREMENT = 0.25
cheeksParams[1] = cheeksParams[1] + FACE_PARAM_INCREMENT

for paramIndex = 1, #cheeksParams do
  cheeksParams[paramIndex] = 0
end

if human and human.Pose then
  human.Pose(result)
else
  print("Error: 'human' is nil or does not have a Pose method")
end

-- Reset a specific cheeks parameter
function ResetCheeksParam(human, index)
    if human == nil then
        print("Error: 'human' parameter is missing.")
        return
    end

    if cheeksParams == nil or index < 1 or index > #cheeksParams then
        print("Error: Invalid cheeks parameter index:", index)
        return
    end

    cheeksParams[index] = 0
    local success, result = pcall(function()
        return Preset(Cheeks(table.unpack(cheeksParams)))
    end)
    if success then
        if human.Pose then
            human.Pose(result)
        else
            print("Error: 'human' does not have a Pose method.")
        end
    else
        print("Error in ResetCheeksParam:", result)
    end
end

-- Reset all cheeks parameters
function ResetALLCheeksParam(human)
    -- Check if human is provided
    if human == nil then
        print("Error: 'human' parameter is missing.")
        return
    end

    -- Reset all parameters in the cheeksParams table
    for paramIndex = 1, #cheeksParams do
        cheeksParams[paramIndex] = 0
    end
    print("ResetALLCheeksParam: Resetting all parameters")

    -- Attempt to apply the reset parameters to the human
    local success, result = pcall(function()
        return Preset(Cheeks(table.unpack(cheeksParams)))
    end)
    if success then
        if human.Pose then
            human.Pose(result)
        else
            print("Error: 'human' does not have a Pose method.")
        end
    else
        print("Error in ResetALLCheeksParam:", result)
    end
end

function AdjustCheeksParam(paramIndex, increment)
    if cheeksParams and paramIndex and paramIndex >= 1 and paramIndex <= #cheeksParams then
        cheeksParams[paramIndex] = cheeksParams[paramIndex] + increment
        print("Adjusting cheeksParams:", table.unpack(cheeksParams)) -- Debug print
        return Cheeks(table.unpack(cheeksParams))
    else
        print("Invalid paramIndex or cheeksParams is nil")
    end
end

-- Adjusts the first cheeks parameter by +0.25
function Cheekspar1_A()
    return AdjustCheeksParam(1, FACE_PARAM_INCREMENT)
end

-- Adjusts the second cheeks parameter by +0.25
function Cheekspar2_A()
  return AdjustCheeksParam(2, FACE_PARAM_INCREMENT)
end

-- Adjusts the first cheeks parameter by -0.25
function Cheekspar1_B()
    return AdjustCheeksParam(1, -FACE_PARAM_INCREMENT)
end

-- Adjusts the second cheeks parameter by -0.25
function Cheekspar2_B()
  return AdjustCheeksParam(2, -FACE_PARAM_INCREMENT)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

local browsSuccess, browsResult = pcall(function()
	return Preset(Brows(table.unpack(browsParams)))
end)
if not browsSuccess then
	print("Error creating preset:", browsResult)
else
	if human then
		human.Pose(browsResult)
	else
		print("Error: 'human' is undefined.")
	end
end

-- --Initialize a table to store all 4 brows parameters
local browsParams = {0, 0, 0, 0}

FACE_PARAM_INCREMENT = 0.25
browsParams[1] = browsParams[1] + FACE_PARAM_INCREMENT

for paramIndex = 1, #browsParams do
  browsParams[paramIndex] = 0
end

if human and human.Pose then
  human.Pose(result)
else
  print("Error: 'human' is nil or does not have a Pose method")
end

-- Reset a specific brows parameter
function ResetBrowsParam(human, index)
    if human == nil then
        print("Error: 'human' parameter is missing.")
        return
    end

    if browsParams == nil or index < 1 or index > #browsParams then
        print("Error: Invalid brows parameter index:", index)
        return
    end

    browsParams[index] = 0
    local success, result = pcall(function()
        return Preset(Brows(table.unpack(browsParams)))
    end)
    if success then
        if human.Pose then
            human.Pose(result)
        else
            print("Error: 'human' does not have a Pose method.")
        end
    else
        print("Error in ResetBrowsParam:", result)
    end
end

-- Reset all brows parameters
function ResetALLBrowsParam(human)
    -- Check if human is provided
    if human == nil then
        print("Error: 'human' parameter is missing.")
        return
    end

    -- Reset all parameters in the browsParams table
    for paramIndex = 1, #browsParams do
        browsParams[paramIndex] = 0
    end
    print("ResetALLBrowsParam: Resetting all parameters")

    -- Attempt to apply the reset parameters to the human
    local success, result = pcall(function()
        return Preset(Brows(table.unpack(browsParams)))
    end)
    if success then
        if human.Pose then
            human.Pose(result)
        else
            print("Error: 'human' does not have a Pose method.")
        end
    else
        print("Error in ResetALLBrowsParam:", result)
    end
end

function AdjustBrowsParam(paramIndex, increment)
    if browsParams and paramIndex and paramIndex >= 1 and paramIndex <= #browsParams then
        browsParams[paramIndex] = browsParams[paramIndex] + increment
        print("Adjusting browsParams:", table.unpack(browsParams)) -- Debug print
        return Brows(table.unpack(browsParams))
    else
        print("Invalid paramIndex or browsParams is nil")
    end
end

-- Adjusts the first brows parameter by +0.25
function Browspar1_A()
    return AdjustBrowsParam(1, FACE_PARAM_INCREMENT)
end

-- Adjusts the second brows parameter by +0.25
function Browspar2_A()
  return AdjustBrowsParam(2, FACE_PARAM_INCREMENT)
end

-- Adjusts the third brows parameter by +0.25
function Browspar3_A()
    return AdjustBrowsParam(3, FACE_PARAM_INCREMENT)
end

-- Adjusts the fourth brows parameter by +0.25
function Browspar4_A()
  return AdjustBrowsParam(4, FACE_PARAM_INCREMENT)
end

-- Adjusts the first brows parameter by +0.25
function Browspar1_B()
    return AdjustBrowsParam(1, -FACE_PARAM_INCREMENT)
end

-- Adjusts the second brows parameter by +0.25
function Browspar2_B()
  return AdjustBrowsParam(2, -FACE_PARAM_INCREMENT)
end

-- Adjusts the third brows parameter by +0.25
function Browspar3_B()
  return AdjustBrowsParam(3, -FACE_PARAM_INCREMENT)
end

-- Adjusts the fourth brows parameter by +0.25
function Browspar4_B()
  return AdjustBrowsParam(4, -FACE_PARAM_INCREMENT)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

local mouthSuccess, mouthResult = pcall(function()
	return Preset(Mouth(table.unpack(mouthParams)))
end)
if not mouthSuccess then
	print("Error creating preset:", mouthResult)
else
	if human then
		human.Pose(mouthResult)
	else
		print("Error: 'human' is undefined.")
	end
end

-- --Initialize a table to store all 16 mouth parameters
local mouthParams = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}



FACE_PARAM_INCREMENT = 0.25
mouthParams[1] = mouthParams[1] + FACE_PARAM_INCREMENT

for paramIndex = 1, #mouthParams do
  mouthParams[paramIndex] = 0
end

if human and human.Pose then
  human.Pose(result)
else
  print("Error: 'human' is nil or does not have a Pose method")
end

-- Reset a specific mouth parameter
function ResetMouthParam(human, index)
    -- Check if human is provided
    if human == nil then
        print("Error: 'human' parameter is missing.")
        return
    end

    -- Validate the index
    if mouthParams == nil or index < 1 or index > #mouthParams then
        print("Error: Invalid mouth parameter index:", index)
        return
    end

    -- Reset the specified mouth parameter
    print("ResetMouthParam: Resetting parameter", index)
    mouthParams[index] = 0

    -- Attempt to apply the reset parameter to the human
    local success, result = pcall(function()
        return Preset(Mouth(table.unpack(mouthParams)))
    end)
    if success then
        if human.Pose then
            human.Pose(result)
        else
            print("Error: 'human' does not have a Pose method.")
        end
    else
        print("Error in ResetMouthParam:", result)
    end
end

-- Reset all mouth parameters
function ResetALLMouthParam(human)
    -- Check if human is provided
    if human == nil then
        print("Error: 'human' parameter is missing.")
        return
    end

    -- Reset all parameters in the mouthParams table
    for paramIndex = 1, #mouthParams do
        mouthParams[paramIndex] = 0
    end
    print("ResetALLMouthParam: Resetting all parameters")

    -- Attempt to apply the reset parameters to the human
    local success, result = pcall(function()
        return Preset(Mouth(table.unpack(mouthParams)))
    end)
    if success then
        if human.Pose then
            human.Pose(result)
        else
            print("Error: 'human' does not have a Pose method.")
        end
    else
        print("Error in ResetALLMouthParam:", result)
    end
end

function AdjustMouthParam(paramIndex, increment)
  if mouthParams and paramIndex and paramIndex >= 1 and paramIndex <= #mouthParams then
      mouthParams[paramIndex] = mouthParams[paramIndex] + increment
      return Mouth(table.unpack(mouthParams)) -- Return the updated mouth parameters
  else
      print("Invalid paramIndex or mouthParams is nil")
  end
end

-- Adjusts the first mouth parameter by +0.25
function Mouthpar1_A()
    return AdjustMouthParam(1, FACE_PARAM_INCREMENT)
end

-- Adjusts the second mouth parameter by +0.25
function Mouthpar2_A()
  return AdjustMouthParam(2, FACE_PARAM_INCREMENT)
end

-- Adjusts the third mouth parameter by +0.25
function Mouthpar3_A()
  return AdjustMouthParam(3, FACE_PARAM_INCREMENT)
end

-- Adjusts the fourth mouth parameter by +0.25
function Mouthpar4_A()
  return AdjustMouthParam(4, FACE_PARAM_INCREMENT)
end

-- Adjusts the fifth mouth parameter by +0.25
function Mouthpar5_A()
  return AdjustMouthParam(5, FACE_PARAM_INCREMENT)
end

-- Adjusts the sixth mouth parameter by +0.25
function Mouthpar6_A()
  return AdjustMouthParam(6, FACE_PARAM_INCREMENT)
end

-- Adjusts the seventh mouth parameter by +0.25
function Mouthpar7_A()
  return AdjustMouthParam(7, FACE_PARAM_INCREMENT)
end

-- Adjusts the eighth mouth parameter by +0.25
function Mouthpar8_A()
  return AdjustMouthParam(8, FACE_PARAM_INCREMENT)
end

-- Adjusts the ninth mouth parameter by +0.25
function Mouthpar9_A()
  return AdjustMouthParam(9, FACE_PARAM_INCREMENT)
end

-- Adjusts the tenth mouth parameter by +0.25
function Mouthpar10_A()
    return AdjustMouthParam(10, FACE_PARAM_INCREMENT)
end

-- Adjusts the eleventh mouth parameter by +0.25
function Mouthpar11_A()
    return AdjustMouthParam(11, FACE_PARAM_INCREMENT)
end

-- Adjusts the twelfth mouth parameter by +0.25
function Mouthpar12_A()
    return AdjustMouthParam(12, FACE_PARAM_INCREMENT)
end

-- Adjusts the thirteenth mouth parameter by +0.25
function Mouthpar13_A()
    return AdjustMouthParam(13, FACE_PARAM_INCREMENT)
end

-- Adjusts the fourteenth mouth parameter by +0.25
function Mouthpar14_A()
    return AdjustMouthParam(14, FACE_PARAM_INCREMENT)
end

-- Adjusts the fifteenth mouth parameter by +0.25
function Mouthpar15_A()
    return AdjustMouthParam(15, FACE_PARAM_INCREMENT)
end

-- Adjusts the sixteenth mouth parameter by +0.25
function Mouthpar16_A()
    return AdjustMouthParam(16, FACE_PARAM_INCREMENT)
end

------------------------------------------------------------------

-- Adjusts the first mouth parameter by -0.25
function Mouthpar1_B()
    return AdjustMouthParam(1, -FACE_PARAM_INCREMENT)
end

-- Adjusts the second mouth parameter by -0.25
function Mouthpar2_B()
  return AdjustMouthParam(2, -FACE_PARAM_INCREMENT)
end

-- Adjusts the third mouth parameter by -0.25
function Mouthpar3_B()
  return AdjustMouthParam(3, -FACE_PARAM_INCREMENT)
end

-- Adjusts the fourth mouth parameter by -0.25
function Mouthpar4_B()
  return AdjustMouthParam(4, -FACE_PARAM_INCREMENT)
end

-- Adjusts the fifth mouth parameter by -0.25
function Mouthpar5_B()
  return AdjustMouthParam(5, -FACE_PARAM_INCREMENT)
end

-- Adjusts the sixth mouth parameter by -0.25
function Mouthpar6_B()
  return AdjustMouthParam(6, -FACE_PARAM_INCREMENT)
end

-- Adjusts the seventh mouth parameter by -0.25
function Mouthpar7_B()
  return AdjustMouthParam(7, -FACE_PARAM_INCREMENT)
end

-- Adjusts the eighth mouth parameter by -0.25
function Mouthpar8_B()
  return AdjustMouthParam(8, -FACE_PARAM_INCREMENT)
end

-- Adjusts the ninth mouth parameter by -0.25
function Mouthpar9_B()
  return AdjustMouthParam(9, -FACE_PARAM_INCREMENT)
end

-- Adjusts the tenth mouth parameter by -0.25
function Mouthpar10_B()
    return AdjustMouthParam(10, -FACE_PARAM_INCREMENT)
end

-- Adjusts the eleventh mouth parameter by -0.25
function Mouthpar11_B()
    return AdjustMouthParam(11, -FACE_PARAM_INCREMENT)
end

-- Adjusts the twelfth mouth parameter by -0.25
function Mouthpar12_B()
    return AdjustMouthParam(12, -FACE_PARAM_INCREMENT)
end

-- Adjusts the thirteenth mouth parameter by -0.25
function Mouthpar13_B()
    return AdjustMouthParam(13, -FACE_PARAM_INCREMENT)
end

-- Adjusts the fourteenth mouth parameter by -0.25
function Mouthpar14_B()
    return AdjustMouthParam(14, -FACE_PARAM_INCREMENT)
end

-- Adjusts the fifteenth mouth parameter by -0.25
function Mouthpar15_B()
    return AdjustMouthParam(15, -FACE_PARAM_INCREMENT)
end

-- Adjusts the sixteenth mouth parameter by -0.25
function Mouthpar16_B()
    return AdjustMouthParam(16, -FACE_PARAM_INCREMENT)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Initialize parameter tables for each finger
local fingerParams = {
    ThumbL = {0, 0, 0, 0, 0},
    IndexL = {0, 0, 0, 0, 0},
    MidL   = {0, 0, 0, 0, 0},
    RingL  = {0, 0, 0, 0, 0},
    PinkyL = {0, 0, 0, 0, 0},
    ThumbR = {0, 0, 0, 0, 0},
    IndexR = {0, 0, 0, 0, 0},
    MidR   = {0, 0, 0, 0, 0},
    RingR  = {0, 0, 0, 0, 0},
    PinkyR = {0, 0, 0, 0, 0}
}

FINGER_PARAM_INCREMENT = 2

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Reset all joints of a finger
function ResetAllFingerParams(human, fingerName)
    local params = fingerParams[fingerName]
    if not params then
        print("Error: Invalid finger name:", fingerName)
        return
    end

    for i = 1, #params do
        params[i] = 0
    end
    print("ResetAllFingerParams: Resetting", fingerName)

    local success, result = pcall(function()
        return Preset(_G[fingerName](table.unpack(params)))
    end)
    if success and human and human.Pose then
        human.Pose(result)
    else
        print("Error resetting all finger params:", result)
    end
end

-- Reset all fingers on both hands
function ResetAllFingers(human)
    local fingers = {"ThumbL", "IndexL", "MidL", "RingL", "PinkyL", "ThumbR", "IndexR", "MidR", "RingR", "PinkyR"}
    for _, finger in ipairs(fingers) do
        ResetAllFingerParams(human, finger)
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Resets all left and right finger params
function ResetALLleftFingerParams(human)
    local fingers = {"ThumbL", "IndexL", "MidL", "RingL", "PinkyL"}
    for _, finger in ipairs(fingers) do
        ResetAllFingerParams(human, finger)
    end
end
function ResetALLrightFingerParams(human)
    local fingers = {"ThumbR", "IndexR", "MidR", "RingR", "PinkyR"}
    for _, finger in ipairs(fingers) do
        ResetAllFingerParams(human, finger)
    end
end

-- -- Menu call
-- + "Reset All Fingers (Both Hands)"
--     ResetALLFingerParamsBothHands(human)
--     Return()

-- Adjust a specific finger's joint parameter
function AdjustFingerParam(human, fingerName, jointIndex, increment)
    local params = fingerParams[fingerName]
    if params and jointIndex >= 1 and jointIndex <= #params then
        params[jointIndex] = params[jointIndex] + increment
        print("Adjusting " .. fingerName .. ":", table.unpack(params)) -- Debug print

        local success, result = pcall(function()
            return Preset(_G[fingerName](table.unpack(params)))
        end)
        if success then
            return result  -- ✨ Now returning the pose
        else
            print("Error applying finger pose:", result)
        end
    else
        print("Invalid finger name or joint index")
    end
end
-- Reset a specific joint of a finger
function ResetFingerParam(human, fingerName, jointIndex)
    local params = fingerParams[fingerName]
    if params and jointIndex >= 1 and jointIndex <= #params then
        params[jointIndex] = 0
        print("Reset " .. fingerName .. " joint", jointIndex)

        local success, result = pcall(function()
            return Preset(_G[fingerName](table.unpack(params)))
        end)
        if success and human and human.Pose then
            human.Pose(result)
        else
            print("Error resetting finger param:", result)
        end
    else
        print("Invalid finger name or joint index")
    end
end

-- Reset all joints of a finger
function ResetAllFingerParams(human, fingerName)
    local params = fingerParams[fingerName]
    if not params then
        print("Error: Invalid finger name:", fingerName)
        return
    end

    for i = 1, #params do
        params[i] = 0
    end
    print("ResetAllFingerParams: Resetting", fingerName)

    local success, result = pcall(function()
        return Preset(_G[fingerName](table.unpack(params)))
    end)
    if success and human and human.Pose then
        human.Pose(result)
    else
        print("Error resetting all finger params:", result)
    end
end

-- Example helper functions for UI buttons to adjust joint 1 of each finger
-- Auto-generated finger joint adjustment functions

-- ThumbL
function ThumbL_J1_Inc() return AdjustFingerParam(human, "ThumbL", 1, FINGER_PARAM_INCREMENT) end
function ThumbL_J1_Dec() return AdjustFingerParam(human, "ThumbL", 1, -FINGER_PARAM_INCREMENT) end
function ThumbL_J2_Inc() return AdjustFingerParam(human, "ThumbL", 2, FINGER_PARAM_INCREMENT) end
function ThumbL_J2_Dec() return AdjustFingerParam(human, "ThumbL", 2, -FINGER_PARAM_INCREMENT) end
function ThumbL_J3_Inc() return AdjustFingerParam(human, "ThumbL", 3, FINGER_PARAM_INCREMENT) end
function ThumbL_J3_Dec() return AdjustFingerParam(human, "ThumbL", 3, -FINGER_PARAM_INCREMENT) end
function ThumbL_J4_Inc() return AdjustFingerParam(human, "ThumbL", 4, FINGER_PARAM_INCREMENT) end
function ThumbL_J4_Dec() return AdjustFingerParam(human, "ThumbL", 4, -FINGER_PARAM_INCREMENT) end
function ThumbL_J5_Inc() return AdjustFingerParam(human, "ThumbL", 5, FINGER_PARAM_INCREMENT) end
function ThumbL_J5_Dec() return AdjustFingerParam(human, "ThumbL", 5, -FINGER_PARAM_INCREMENT) end

-- IndexL
function IndexL_J1_Inc() return AdjustFingerParam(human, "IndexL", 1, FINGER_PARAM_INCREMENT) end
function IndexL_J1_Dec() return AdjustFingerParam(human, "IndexL", 1, -FINGER_PARAM_INCREMENT) end
function IndexL_J2_Inc() return AdjustFingerParam(human, "IndexL", 2, FINGER_PARAM_INCREMENT) end
function IndexL_J2_Dec() return AdjustFingerParam(human, "IndexL", 2, -FINGER_PARAM_INCREMENT) end
function IndexL_J3_Inc() return AdjustFingerParam(human, "IndexL", 3, FINGER_PARAM_INCREMENT) end
function IndexL_J3_Dec() return AdjustFingerParam(human, "IndexL", 3, -FINGER_PARAM_INCREMENT) end
function IndexL_J4_Inc() return AdjustFingerParam(human, "IndexL", 4, FINGER_PARAM_INCREMENT) end
function IndexL_J4_Dec() return AdjustFingerParam(human, "IndexL", 4, -FINGER_PARAM_INCREMENT) end
function IndexL_J5_Inc() return AdjustFingerParam(human, "IndexL", 5, FINGER_PARAM_INCREMENT) end
function IndexL_J5_Dec() return AdjustFingerParam(human, "IndexL", 5, -FINGER_PARAM_INCREMENT) end

-- MidL
function MidL_J1_Inc() return AdjustFingerParam(human, "MidL", 1, FINGER_PARAM_INCREMENT) end
function MidL_J1_Dec() return AdjustFingerParam(human, "MidL", 1, -FINGER_PARAM_INCREMENT) end
function MidL_J2_Inc() return AdjustFingerParam(human, "MidL", 2, FINGER_PARAM_INCREMENT) end
function MidL_J2_Dec() return AdjustFingerParam(human, "MidL", 2, -FINGER_PARAM_INCREMENT) end
function MidL_J3_Inc() return AdjustFingerParam(human, "MidL", 3, FINGER_PARAM_INCREMENT) end
function MidL_J3_Dec() return AdjustFingerParam(human, "MidL", 3, -FINGER_PARAM_INCREMENT) end
function MidL_J4_Inc() return AdjustFingerParam(human, "MidL", 4, FINGER_PARAM_INCREMENT) end
function MidL_J4_Dec() return AdjustFingerParam(human, "MidL", 4, -FINGER_PARAM_INCREMENT) end
function MidL_J5_Inc() return AdjustFingerParam(human, "MidL", 5, FINGER_PARAM_INCREMENT) end
function MidL_J5_Dec() return AdjustFingerParam(human, "MidL", 5, -FINGER_PARAM_INCREMENT) end

-- RingL
function RingL_J1_Inc() return AdjustFingerParam(human, "RingL", 1, FINGER_PARAM_INCREMENT) end
function RingL_J1_Dec() return AdjustFingerParam(human, "RingL", 1, -FINGER_PARAM_INCREMENT) end
function RingL_J2_Inc() return AdjustFingerParam(human, "RingL", 2, FINGER_PARAM_INCREMENT) end
function RingL_J2_Dec() return AdjustFingerParam(human, "RingL", 2, -FINGER_PARAM_INCREMENT) end
function RingL_J3_Inc() return AdjustFingerParam(human, "RingL", 3, FINGER_PARAM_INCREMENT) end
function RingL_J3_Dec() return AdjustFingerParam(human, "RingL", 3, -FINGER_PARAM_INCREMENT) end
function RingL_J4_Inc() return AdjustFingerParam(human, "RingL", 4, FINGER_PARAM_INCREMENT) end
function RingL_J4_Dec() return AdjustFingerParam(human, "RingL", 4, -FINGER_PARAM_INCREMENT) end
function RingL_J5_Inc() return AdjustFingerParam(human, "RingL", 5, FINGER_PARAM_INCREMENT) end
function RingL_J5_Dec() return AdjustFingerParam(human, "RingL", 5, -FINGER_PARAM_INCREMENT) end

-- PinkyL
function PinkyL_J1_Inc() return AdjustFingerParam(human, "PinkyL", 1, FINGER_PARAM_INCREMENT) end
function PinkyL_J1_Dec() return AdjustFingerParam(human, "PinkyL", 1, -FINGER_PARAM_INCREMENT) end
function PinkyL_J2_Inc() return AdjustFingerParam(human, "PinkyL", 2, FINGER_PARAM_INCREMENT) end
function PinkyL_J2_Dec() return AdjustFingerParam(human, "PinkyL", 2, -FINGER_PARAM_INCREMENT) end
function PinkyL_J3_Inc() return AdjustFingerParam(human, "PinkyL", 3, FINGER_PARAM_INCREMENT) end
function PinkyL_J3_Dec() return AdjustFingerParam(human, "PinkyL", 3, -FINGER_PARAM_INCREMENT) end
function PinkyL_J4_Inc() return AdjustFingerParam(human, "PinkyL", 4, FINGER_PARAM_INCREMENT) end
function PinkyL_J4_Dec() return AdjustFingerParam(human, "PinkyL", 4, -FINGER_PARAM_INCREMENT) end
function PinkyL_J5_Inc() return AdjustFingerParam(human, "PinkyL", 5, FINGER_PARAM_INCREMENT) end
function PinkyL_J5_Dec() return AdjustFingerParam(human, "PinkyL", 5, -FINGER_PARAM_INCREMENT) end

-- ThumbR
function ThumbR_J1_Inc() return AdjustFingerParam(human, "ThumbR", 1, FINGER_PARAM_INCREMENT) end
function ThumbR_J1_Dec() return AdjustFingerParam(human, "ThumbR", 1, -FINGER_PARAM_INCREMENT) end
function ThumbR_J2_Inc() return AdjustFingerParam(human, "ThumbR", 2, FINGER_PARAM_INCREMENT) end
function ThumbR_J2_Dec() return AdjustFingerParam(human, "ThumbR", 2, -FINGER_PARAM_INCREMENT) end
function ThumbR_J3_Inc() return AdjustFingerParam(human, "ThumbR", 3, FINGER_PARAM_INCREMENT) end
function ThumbR_J3_Dec() return AdjustFingerParam(human, "ThumbR", 3, -FINGER_PARAM_INCREMENT) end
function ThumbR_J4_Inc() return AdjustFingerParam(human, "ThumbR", 4, FINGER_PARAM_INCREMENT) end
function ThumbR_J4_Dec() return AdjustFingerParam(human, "ThumbR", 4, -FINGER_PARAM_INCREMENT) end
function ThumbR_J5_Inc() return AdjustFingerParam(human, "ThumbR", 5, FINGER_PARAM_INCREMENT) end
function ThumbR_J5_Dec() return AdjustFingerParam(human, "ThumbR", 5, -FINGER_PARAM_INCREMENT) end

-- IndexR
function IndexR_J1_Inc() return AdjustFingerParam(human, "IndexR", 1, FINGER_PARAM_INCREMENT) end
function IndexR_J1_Dec() return AdjustFingerParam(human, "IndexR", 1, -FINGER_PARAM_INCREMENT) end
function IndexR_J2_Inc() return AdjustFingerParam(human, "IndexR", 2, FINGER_PARAM_INCREMENT) end
function IndexR_J2_Dec() return AdjustFingerParam(human, "IndexR", 2, -FINGER_PARAM_INCREMENT) end
function IndexR_J3_Inc() return AdjustFingerParam(human, "IndexR", 3, FINGER_PARAM_INCREMENT) end
function IndexR_J3_Dec() return AdjustFingerParam(human, "IndexR", 3, -FINGER_PARAM_INCREMENT) end
function IndexR_J4_Inc() return AdjustFingerParam(human, "IndexR", 4, FINGER_PARAM_INCREMENT) end
function IndexR_J4_Dec() return AdjustFingerParam(human, "IndexR", 4, -FINGER_PARAM_INCREMENT) end
function IndexR_J5_Inc() return AdjustFingerParam(human, "IndexR", 5, FINGER_PARAM_INCREMENT) end
function IndexR_J5_Dec() return AdjustFingerParam(human, "IndexR", 5, -FINGER_PARAM_INCREMENT) end

-- MidR
function MidR_J1_Inc() return AdjustFingerParam(human, "MidR", 1, FINGER_PARAM_INCREMENT) end
function MidR_J1_Dec() return AdjustFingerParam(human, "MidR", 1, -FINGER_PARAM_INCREMENT) end
function MidR_J2_Inc() return AdjustFingerParam(human, "MidR", 2, FINGER_PARAM_INCREMENT) end
function MidR_J2_Dec() return AdjustFingerParam(human, "MidR", 2, -FINGER_PARAM_INCREMENT) end
function MidR_J3_Inc() return AdjustFingerParam(human, "MidR", 3, FINGER_PARAM_INCREMENT) end
function MidR_J3_Dec() return AdjustFingerParam(human, "MidR", 3, -FINGER_PARAM_INCREMENT) end
function MidR_J4_Inc() return AdjustFingerParam(human, "MidR", 4, FINGER_PARAM_INCREMENT) end
function MidR_J4_Dec() return AdjustFingerParam(human, "MidR", 4, -FINGER_PARAM_INCREMENT) end
function MidR_J5_Inc() return AdjustFingerParam(human, "MidR", 5, FINGER_PARAM_INCREMENT) end
function MidR_J5_Dec() return AdjustFingerParam(human, "MidR", 5, -FINGER_PARAM_INCREMENT) end

-- RingR
function RingR_J1_Inc() return AdjustFingerParam(human, "RingR", 1, FINGER_PARAM_INCREMENT) end
function RingR_J1_Dec() return AdjustFingerParam(human, "RingR", 1, -FINGER_PARAM_INCREMENT) end
function RingR_J2_Inc() return AdjustFingerParam(human, "RingR", 2, FINGER_PARAM_INCREMENT) end
function RingR_J2_Dec() return AdjustFingerParam(human, "RingR", 2, -FINGER_PARAM_INCREMENT) end
function RingR_J3_Inc() return AdjustFingerParam(human, "RingR", 3, FINGER_PARAM_INCREMENT) end
function RingR_J3_Dec() return AdjustFingerParam(human, "RingR", 3, -FINGER_PARAM_INCREMENT) end
function RingR_J4_Inc() return AdjustFingerParam(human, "RingR", 4, FINGER_PARAM_INCREMENT) end
function RingR_J4_Dec() return AdjustFingerParam(human, "RingR", 4, -FINGER_PARAM_INCREMENT) end
function RingR_J5_Inc() return AdjustFingerParam(human, "RingR", 5, FINGER_PARAM_INCREMENT) end
function RingR_J5_Dec() return AdjustFingerParam(human, "RingR", 5, -FINGER_PARAM_INCREMENT) end

-- PinkyR
function PinkyR_J1_Inc() return AdjustFingerParam(human, "PinkyR", 1, FINGER_PARAM_INCREMENT) end
function PinkyR_J1_Dec() return AdjustFingerParam(human, "PinkyR", 1, -FINGER_PARAM_INCREMENT) end
function PinkyR_J2_Inc() return AdjustFingerParam(human, "PinkyR", 2, FINGER_PARAM_INCREMENT) end
function PinkyR_J2_Dec() return AdjustFingerParam(human, "PinkyR", 2, -FINGER_PARAM_INCREMENT) end
function PinkyR_J3_Inc() return AdjustFingerParam(human, "PinkyR", 3, FINGER_PARAM_INCREMENT) end
function PinkyR_J3_Dec() return AdjustFingerParam(human, "PinkyR", 3, -FINGER_PARAM_INCREMENT) end
function PinkyR_J4_Inc() return AdjustFingerParam(human, "PinkyR", 4, FINGER_PARAM_INCREMENT) end
function PinkyR_J4_Dec() return AdjustFingerParam(human, "PinkyR", 4, -FINGER_PARAM_INCREMENT) end
function PinkyR_J5_Inc() return AdjustFingerParam(human, "PinkyR", 5, FINGER_PARAM_INCREMENT) end
function PinkyR_J5_Dec() return AdjustFingerParam(human, "PinkyR", 5, -FINGER_PARAM_INCREMENT) end

