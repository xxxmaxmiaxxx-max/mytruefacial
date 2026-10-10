-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxx SNAPPY SEQUENCES by snapsnap 	      xxx
-- xxx     Version 1.13 BETA (3/30/2026) TMMM xxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxx EVENTHANDLER OVERRIDES      xxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if type(TM_AddFunctionOverride) == "function" then
	TM_AddFunctionOverride("Snappy Sequences", "OnHumanClick", 2, "snap_ClickEventHandler", 200, true)
else
	local funcCode = [[
	function OnHumanClick(human, hitTri)
		snap_ClickEventHandler(human, hitTri)	
	end
	]]
	load(funcCode)()
end

function snap_ClickEventHandler(human, hitTri) 	
	if hitTri.IsHead == true and snap_g_bDisableSnapMenu == false then	
		Jump("snap_SnapMenu", human, hitTri)
		return
	end
	
	if snap_g_bSequencerActive == true and  snap_g_bIgnoreClickEvents == false then
		snap_SequencerClickEvent(human, hitTri)
	else
		if type(TM_AddMenuMod) == "function" then 
			TM_ModListShow(human, hitTri)
		elseif TalkMenu ~= nil then
			Jump("TalkMenu", human, hitTri)
		end
	end
	
	return
end


-- xxxxxxxxxxxxxxxxxxxxxx
-- xxxx SEQUENCER   xxxxx
-- xxxxxxxxxxxxxxxxxxxxxx


-- state of the sequencer
snap_g_bSequencerActive = false
snap_g_bInterludeRunning = false

-- state flags for controlling the sequencer via scripting
snap_g_bIgnoreClickEvents = false
snap_g_bDisableSnapMenu = false

-- mod UI info - show filename of currently running pose 
snap_g_currentPoseFileName = "nothing"
snap_g_bShowCurrentPoseFileName = true
snap_g_bIsPaused = false

-- OMNI mode
snap_g_bOmniModeActive = false
snap_g_OmniModeActor = nil

-- other globals
snap_g_currentSequenceNumber = 1
snap_g_mainSequenceLastActor = nil
snap_g_sequenceInitiator = nil
snap_g_interludes = {}

snap_g_AGirlSeqFu = {}
snap_g_AGirl2SeqFu = {}
snap_g_AGirl3SeqFu = {}
snap_g_AGirl4SeqFu = {}
snap_g_AGirl5SeqFu = {}
snap_g_AGirl6SeqFu = {}
snap_g_AGirl7SeqFu = {}
snap_g_AGirl8SeqFu = {}
snap_g_AGirl9SeqFu = {}

snap_g_AGuySeqFu = {}
snap_g_AGuy2SeqFu = {}
snap_g_AGuy3SeqFu = {}
snap_g_AGuy4SeqFu = {}
snap_g_AGuy5SeqFu = {}
snap_g_AGuy6SeqFu = {}
snap_g_AGuy7SeqFu = {}
snap_g_AGuy8SeqFu = {}
snap_g_AGuy9SeqFu = {}


snap_g_tmp_AGirlSeqFu = {}
snap_g_tmp_AGirl2SeqFu = {}
snap_g_tmp_AGirl3SeqFu = {}
snap_g_tmp_AGirl4SeqFu = {}
snap_g_tmp_AGirl5SeqFu = {}
snap_g_tmp_AGirl6SeqFu = {}
snap_g_tmp_AGirl7SeqFu = {}
snap_g_tmp_AGirl8SeqFu = {}
snap_g_tmp_AGirl9SeqFu = {}

snap_g_tmp_AGuySeqFu = {}
snap_g_tmp_AGuy2SeqFu = {}
snap_g_tmp_AGuy3SeqFu = {}
snap_g_tmp_AGuy4SeqFu = {}
snap_g_tmp_AGuy5SeqFu = {}
snap_g_tmp_AGuy6SeqFu = {}
snap_g_tmp_AGuy7SeqFu = {}
snap_g_tmp_AGuy8SeqFu = {}
snap_g_tmp_AGuy9SeqFu = {}

snap_g_AGirlGuySeqIndices = {
	["AGirl"] = {},
	["AGirl2"] = {},
	["AGirl3"] = {},
	["AGirl4"] = {},
	["AGirl5"] = {},
	["AGirl6"] = {},
	["AGirl7"] = {},
	["AGirl8"] = {},
	["AGirl9"] = {},
	
	["AGuy"] = {},
	["AGuy2"] = {},
	["AGuy3"] = {},
	["AGuy4"] = {},
	["AGuy5"] = {},
	["AGuy6"] = {},
	["AGuy7"] = {},
	["AGuy8"] = {},
	["AGuy9"] = {},
}

function snap_util_GetInterludeUIData(interludeNumber, dataIndex)
	return tostring(snap_g_interludes[interludeNumber][dataIndex])
end

function snap_GetSequenceIndex(actorName)	
	local retVal = -1	
		
	retval = snap_g_AGirlGuySeqIndices[actorName][snap_g_currentSequenceNumber]
	
	return retval
end

function snap_SetSequenceIndex(actorName, index)			
	snap_g_AGirlGuySeqIndices[actorName][snap_g_currentSequenceNumber] = index	
end

function snap_SequencerRestart()

	local numberOfSequences = tablelength(snap_g_interludes) +1

	for g = 1, numberOfSequences,1 do		
		snap_g_AGirlGuySeqIndices["AGirl"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl2"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl3"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl4"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl5"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl6"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl7"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl8"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl9"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy2"][g] = 0	
		snap_g_AGirlGuySeqIndices["AGuy3"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy4"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy5"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy6"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy7"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy8"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy9"][g] = 0
	end
	snap_g_bInterludeRunning = false
	snap_g_currentSequenceNumber = 1	
	snap_SequencerUpdate(snap_g_sequenceInitiator, "init")
end

function snap_SequencerStop()
	
	snap_g_bSequencerActive = false
	snap_g_bIsPaused = false
	snap_g_bIgnoreClickEvents = false
	snap_g_bInterludeRunning = false
	snap_g_mainSequenceLastActor = nil
	snap_g_sequenceInitiator = nil
	snap_g_currentSequenceNumber = 1
	snap_g_currentPoseFileName = "nothing"
	snap_g_bOmniModeActive = false
	snap_g_OmniModeActor = nil

	snap_g_AGirlSeqFu = {}
	snap_g_AGirl2SeqFu = {}
	snap_g_AGirl3SeqFu = {}
	snap_g_AGirl4SeqFu = {}
	snap_g_AGirl5SeqFu = {}
	snap_g_AGirl6SeqFu = {}
	snap_g_AGirl7SeqFu = {}
	snap_g_AGirl8SeqFu = {}
	snap_g_AGirl9SeqFu = {}	
	
	snap_g_AGuySeqFu = {}
	snap_g_AGuy2SeqFu = {}
	snap_g_AGuy3SeqFu = {}
	snap_g_AGuy4SeqFu = {}
	snap_g_AGuy5SeqFu = {}
	snap_g_AGuy6SeqFu = {}
	snap_g_AGuy7SeqFu = {}
	snap_g_AGuy8SeqFu = {}
	snap_g_AGuy9SeqFu = {}
	
	snap_g_interludes = {}
	
	snap_g_AGirlGuySeqIndices = {}
	
	snap_g_AGirlGuySeqIndices = {
		["AGirl"] = {},
		["AGirl2"] = {},
		["AGirl3"] = {},
		["AGirl4"] = {},
		["AGirl5"] = {},
		["AGirl6"] = {},
		["AGirl7"] = {},
		["AGirl8"] = {},
		["AGirl9"] = {},
		
		["AGuy"] = {},
		["AGuy2"] = {},
		["AGuy3"] = {},
		["AGuy4"] = {},
		["AGuy5"] = {},
		["AGuy6"] = {},
		["AGuy7"] = {},
		["AGuy8"] = {},
		["AGuy9"] = {},
	}	
end


function snap_SequencerClickEvent(human, hitTri)
	local hitTriZone = snap_GetHitTriZone(hitTri)
	
	if snap_g_bOmniModeActive == true and snap_g_OmniModeActor ~= nil then
		human = snap_g_OmniModeActor
	end
	
	if hitTriZone == 1 then
		snap_SequencerUpdate(human, "next")
	elseif hitTriZone == 2 then
		snap_SequencerUpdate(human, "current")
	elseif hitTriZone == 3 then
		snap_SequencerUpdate(human, "previous")
	end
end


function snap_util_CheckActions(human)
	local curPoseTbl
	
	
	if snap_g_bOmniModeActive == true then
		human = snap_g_OmniModeActor		
	end
	
	
	if (human == AGirl) then
		curPoseTbl = snap_g_AGirlSeqFu		
	elseif (human == AGirl2)  then
		curPoseTbl = snap_g_AGirl2SeqFu		
	elseif (human == AGirl3)  then
		curPoseTbl = snap_g_AGirl3SeqFu					
	elseif (human == AGirl4)  then
		curPoseTbl = snap_g_AGirl4SeqFu				
	elseif (human == AGirl5)  then
		curPoseTbl = snap_g_AGirl5SeqFu					
	elseif (human == AGirl6)  then
		curPoseTbl = snap_g_AGirl6SeqFu					
	elseif (human == AGirl7)  then
		curPoseTbl = snap_g_AGirl7SeqFu				
	elseif (human == AGirl8)  then
		curPoseTbl = snap_g_AGirl8SeqFu			
	elseif (human == AGirl9)  then
		curPoseTbl = snap_g_AGirl9SeqFu					
	elseif (human == AGuy)  then
		curPoseTbl = snap_g_AGuySeqFu
	elseif (human == AGuy2)  then
		curPoseTbl = snap_g_AGuy2SeqFu
	elseif (human == AGuy3)  then
		curPoseTbl = snap_g_AGuy3SeqFu	
	elseif (human == AGuy4)  then
		curPoseTbl = snap_g_AGuy4SeqFu
	elseif (human == AGuy5)  then
		curPoseTbl = snap_g_AGuy5SeqFu	
	elseif (human == AGuy6)  then
		curPoseTbl = snap_g_AGuy6SeqFu
	elseif (human == AGuy7)  then
		curPoseTbl = snap_g_AGuy7SeqFu	
	elseif (human == AGuy8)  then
		curPoseTbl = snap_g_AGuy8SeqFu
	elseif (human == AGuy9)  then
		curPoseTbl = snap_g_AGuy9SeqFu	
	else		
		return 0
	end	
	
	return tablelength(curPoseTbl[snap_g_currentSequenceNumber]) 
end


function snap_SequencerUpdate(human, strAction, fadeOverrideTime)	

	local curPoseTbl	
	local splitfuncCompTbl = {}	
	local paramCount = 0
	local curFuncName
	local p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19
	local iCurrentActionIndex = -1
	local iNumberOfActions  = 0
	local ActorName = nil
	
	if (human == AGirl) then
		curPoseTbl = snap_g_AGirlSeqFu	
		ActorName = "AGirl"		
	elseif (human == AGirl2)  then
		curPoseTbl = snap_g_AGirl2SeqFu
		ActorName = "AGirl2"		
	elseif (human == AGirl3)  then
		curPoseTbl = snap_g_AGirl3SeqFu			
		ActorName = "AGirl3"		
	elseif (human == AGirl4)  then
		curPoseTbl = snap_g_AGirl4SeqFu			
		ActorName = "AGirl4"		
	elseif (human == AGirl5)  then
		curPoseTbl = snap_g_AGirl5SeqFu			
		ActorName = "AGirl5"		
	elseif (human == AGirl6)  then
		curPoseTbl = snap_g_AGirl6SeqFu			
		ActorName = "AGirl6"		
	elseif (human == AGirl7)  then
		curPoseTbl = snap_g_AGirl7SeqFu			
		ActorName = "AGirl7"		
	elseif (human == AGirl8)  then
		curPoseTbl = snap_g_AGirl8SeqFu			
		ActorName = "AGirl8"
	elseif (human == AGirl9)  then
		curPoseTbl = snap_g_AGirl9SeqFu			
		ActorName = "AGirl9"		
	elseif (human == AGuy)  then
		curPoseTbl = snap_g_AGuySeqFu
		ActorName = "AGuy"
	elseif (human == AGuy2)  then
		curPoseTbl = snap_g_AGuy2SeqFu
		ActorName = "AGuy2"
	elseif (human == AGuy3)  then
		curPoseTbl = snap_g_AGuy3SeqFu
		ActorName = "AGuy3"		
	elseif (human == AGuy4)  then
		curPoseTbl = snap_g_AGuy4SeqFu
		ActorName = "AGuy4"		
	elseif (human == AGuy5)  then
		curPoseTbl = snap_g_AGuy5SeqFu
		ActorName = "AGuy5"		
	elseif (human == AGuy6)  then
		curPoseTbl = snap_g_AGuy6SeqFu
		ActorName = "AGuy6"		
	elseif (human == AGuy7)  then
		curPoseTbl = snap_g_AGuy7SeqFu
		ActorName = "AGuy7"		
	elseif (human == AGuy8)  then
		curPoseTbl = snap_g_AGuy8SeqFu
		ActorName = "AGuy8"		
	elseif (human == AGuy9)  then
		curPoseTbl = snap_g_AGuy9SeqFu
		ActorName = "AGuy9"		
	else		
		return
	end	
	
	if tablelength(curPoseTbl[snap_g_currentSequenceNumber]) == 0 then
		return
	end
	
	
	if strAction  ~= "init" then						
		iNumberOfActions = tablelength(curPoseTbl[snap_g_currentSequenceNumber])				
		iCurrentActionIndex = snap_GetSequenceIndex(ActorName)	
				
		if strAction == "next" then
			if iCurrentActionIndex < iNumberOfActions then
				iCurrentActionIndex = iCurrentActionIndex + 1
			end	
		elseif strAction == "current" then
			if iCurrentActionIndex  == 0 then
				return
			end
		elseif strAction == "previous" then
			if iCurrentActionIndex > 1 then
				iCurrentActionIndex = iCurrentActionIndex - 1
			end
		else
			return
		end		
		
		splitstring(curPoseTbl[snap_g_currentSequenceNumber][iCurrentActionIndex] , splitfuncCompTbl )		
		snap_SetSequenceIndex(ActorName, iCurrentActionIndex)
	else					
		splitstring(curPoseTbl[snap_g_currentSequenceNumber][1], splitfuncCompTbl)
		snap_SetSequenceIndex(ActorName, 1)
		snap_g_bSequencerActive = true
	end	
	
	if snap_g_currentSequenceNumber == 1 then
		snap_g_mainSequenceLastActor = human
	end
	
	curFuncName = splitfuncCompTbl[1]	
	paramCount = tablelength(splitfuncCompTbl) - 1
	
	p1 = _G[splitfuncCompTbl[2]]
	
	if paramCount >= 2 then
		p2 = _G[splitfuncCompTbl[3]]

		if p2 == nil then
			p2 = tonumber(splitfuncCompTbl[3])
			if fadeOverrideTime ~= nil then
				p2 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 3 then
		p3 = _G[splitfuncCompTbl[4]]
		
		if p3 == nil then
			p3 = tonumber(splitfuncCompTbl[4])
			if fadeOverrideTime ~= nil then
				p3 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 4 then
		p4 = _G[splitfuncCompTbl[5]]

		if p4 == nil then
			p4 = tonumber(splitfuncCompTbl[5])
			if fadeOverrideTime ~= nil then
				p4 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 5 then
		p5 = _G[splitfuncCompTbl[6]]

		if p5 == nil then
			p5 = tonumber(splitfuncCompTbl[6])
			if fadeOverrideTime ~= nil then
				p5 = fadeOverrideTime
			end
		end
	end	
	if paramCount >= 6 then
		p6 = _G[splitfuncCompTbl[7]]

		if p6 == nil then
			p6 = tonumber(splitfuncCompTbl[7])
			if fadeOverrideTime ~= nil then
				p6 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 7 then
		p7 = _G[splitfuncCompTbl[8]]

		if p7 == nil then
			p7 = tonumber(splitfuncCompTbl[8])
			if fadeOverrideTime ~= nil then
				p7 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 8 then
		p8 = _G[splitfuncCompTbl[9]]

		if p8 == nil then
			p8 = tonumber(splitfuncCompTbl[9])
			if fadeOverrideTime ~= nil then
				p8 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 9 then
		p9 = _G[splitfuncCompTbl[10]]

		if p9 == nil then
			p9 = tonumber(splitfuncCompTbl[10])
			if fadeOverrideTime ~= nil then
				p9 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 10 then
		p10 = _G[splitfuncCompTbl[11]]

		if p10 == nil then
			p10 = tonumber(splitfuncCompTbl[11])
			if fadeOverrideTime ~= nil then
				p10 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 11 then
		p11 = _G[splitfuncCompTbl[12]]

		if p11 == nil then
			p11 = tonumber(splitfuncCompTbl[12])
			if fadeOverrideTime ~= nil then
				p11 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 12 then
		p12 = _G[splitfuncCompTbl[13]]

		if p12 == nil then
			p12 = tonumber(splitfuncCompTbl[13])
			if fadeOverrideTime ~= nil then
				p12 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 13 then
		p13 = _G[splitfuncCompTbl[14]]

		if p13 == nil then
			p13 = tonumber(splitfuncCompTbl[14])
			if fadeOverrideTime ~= nil then
				p13 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 14 then
		p14 = _G[splitfuncCompTbl[15]]

		if p14 == nil then
			p14 = tonumber(splitfuncCompTbl[15])
			if fadeOverrideTime ~= nil then
				p14 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 15 then
		p15 = _G[splitfuncCompTbl[16]]

		if p15 == nil then
			p15 = tonumber(splitfuncCompTbl[16])
			if fadeOverrideTime ~= nil then
				p15 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 16 then
		p16 = _G[splitfuncCompTbl[17]]

		if p16 == nil then
			p16 = tonumber(splitfuncCompTbl[17])
			if fadeOverrideTime ~= nil then
				p16 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 17 then
		p17 = _G[splitfuncCompTbl[18]]

		if p17 == nil then
			p17 = tonumber(splitfuncCompTbl[18])
			if fadeOverrideTime ~= nil then
				p17 = fadeOverrideTime
			end
		end
	end
	if paramCount >= 18 then
		p18 = _G[splitfuncCompTbl[19]]

		if p18 == nil then
			p18 = tonumber(splitfuncCompTbl[19])
			if fadeOverrideTime ~= nil then
				p18 = fadeOverrideTime
			end
		end
	end
	if paramCount == 19 then
		p19 = _G[splitfuncCompTbl[20]]

		if p19 == nil then
			p19 = tonumber(splitfuncCompTbl[20])
			if fadeOverrideTime ~= nil then
				p19 = fadeOverrideTime
			end
		end
	end
	
-- store the current function name (for debugging etc.)
	snap_g_currentPoseFileName = curFuncName
	
	
	-- check for character specific version of the current function - we only feature this for human = AGirl's name!!- if it exist we use it	
	local customFuncName = nil
	
	if AGirl ~= nil then
		customFuncName = snap_g_currentPoseFileName .."_" .. snap_toLowerCaseNoSpaces(AGirl.Name)
	end	

	if _G[customFuncName] ~= nil then
		curFuncName = customFuncName
	end
			
	if paramCount == 1 then
		_G[curFuncName](p1)
	elseif paramCount == 2 then
		_G[curFuncName](p1, p2)
	elseif paramCount == 3 then
		_G[curFuncName](p1, p2, p3)
	elseif paramCount == 4 then
		_G[curFuncName](p1, p2, p3, p4)
	elseif paramCount == 5 then
		_G[curFuncName](p1, p2, p3, p4, p5)
	elseif paramCount == 6 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6)
	elseif paramCount == 7 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7)	
	elseif paramCount == 8 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8)
	elseif paramCount == 9 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9)
	elseif paramCount == 10 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	elseif paramCount == 11 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11)
	elseif paramCount == 12 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
	elseif paramCount == 13 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13)
	elseif paramCount == 14 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14)
	elseif paramCount == 15 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15)
	elseif paramCount == 16 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16)
	elseif paramCount == 17 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17)
	elseif paramCount == 18 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18)
	elseif paramCount == 19 then
		_G[curFuncName](p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19)		
	end	
end


function snap_SequencerSetup(sequenceName)

	if snap_g_bSequencerActive == true then
		snap_SequencerStop()
	end

	
	local tablePrefix = "snap_g_"
	local tableSuffix = "SeqFu"
	local currentTableName = nil
	local currentFuncString = nil
	local sequenceInitiator
	local currentActor = nil
	local funcName =  nil

	local funcParam1 = nil
	local funcParam2 = nil
	local funcParam3 = nil
	local funcParam4 = nil
	local funcParam5 = nil
	local funcParam6 = nil
	local funcParam7 = nil
	local funcParam8 = nil
	local funcParam9 = nil
	local funcParam10 = nil
	local funcParam11 = nil
	local funcParam12 = nil
	local funcParam13 = nil
	local funcParam14 = nil
	local funcParam15 = nil
	local funcParam16 = nil
	local funcParam17 = nil
	local funcParam18 = nil
	local funcParam19 = nil
	

	local sequenceList = {}
	local currentSequence = nil
	local currentSequenceName = ""
  
	local funcCallToStore = ""
	local lineData = {}  
	local paramCount
	sequence = _G[sequenceName]
	
	-- check omni tag, if sequence is an omni sequence set the parameters
	local interludeStartIndex = 1
	
	splitstring(sequence[1], lineData )
	
	
	if lineData[1] == "omni" then
		snap_g_bOmniModeActive = true
		snap_g_OmniModeActor = _G[lineData[2]]
		interludeStartIndex = 2 
	end
	
	
	table.insert(sequenceList, sequenceName .. " main")	
	
	for h = interludeStartIndex, tablelength(sequence),1 do
		lineData = {}

		splitstring(sequence[h], lineData )

		if lineData[1] ~= "interlude" then
			break
		end
		
		table.insert(sequenceList, lineData[2] .. " " .. lineData[3])
		
		table.insert(snap_g_interludes, { lineData[3], "NONE" })
	end
  
	for g = 1, tablelength(sequenceList),1 do		
		snap_g_AGirlGuySeqIndices["AGirl"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl2"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl3"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl4"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl5"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl6"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl7"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl8"][g] = 0
		snap_g_AGirlGuySeqIndices["AGirl9"][g] = 0
		
		snap_g_AGirlGuySeqIndices["AGuy"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy2"][g] = 0	
		snap_g_AGirlGuySeqIndices["AGuy3"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy4"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy5"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy6"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy7"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy8"][g] = 0
		snap_g_AGirlGuySeqIndices["AGuy9"][g] = 0
	end
	
	lineData = {}
	local bInitiatorSet = false

	for i = 1, tablelength(sequenceList),1 do
		splitstring(sequenceList[i], lineData )
	
		bInitiatorSet = false
		
		currentSequence = _G[lineData[1]]
		currentSequenceName = lineData[2]
		
		lineData = {}		
		
		for j = 1, tablelength(currentSequence),1 do
			splitstring(currentSequence[j], lineData )
			
			if lineData[1] == "interlude" then 				
				goto nextIndex 
			end
			
			if lineData[1] == "omni" then
				goto nextIndex 
			end	
			
			if lineData[1] == "pose" then				
				paramCount = tablelength(lineData) - 3

				currentActor = lineData[2]    
				
				if bInitiatorSet == false and i == 1 then
					sequenceInitiator = currentActor					
					bInitiatorSet = true
				end
				
				if bInitiatorSet == false and i > 1 then
					snap_g_interludes[i-1][2] = currentActor
					bInitiatorSet = true
				end
				
				funcName = lineData[3]
				funcParam1 = lineData[4]

				funcCallToStore = funcCallToStore .. funcName .. " " .. funcParam1 .. " "

				if paramCount >= 2 then
					funcParam2 = lineData[5]
					funcCallToStore = funcCallToStore .. funcParam2 .. " "
				end
				if paramCount >= 3 then 
					funcParam3 = lineData[6]
					funcCallToStore = funcCallToStore .. funcParam3 .. " "
				end
				if paramCount >= 4 then   
					funcParam4 = lineData[7]
					funcCallToStore = funcCallToStore .. funcParam4 .. " "
				end
				if paramCount >= 5 then   
					funcParam5 = lineData[8]
					funcCallToStore = funcCallToStore .. funcParam5 .. " "
				end
				if paramCount >= 6 then   
					funcParam6 = lineData[9]
					funcCallToStore = funcCallToStore .. funcParam6 .. " "
				end				
				if paramCount >= 7 then   
					funcParam7 = lineData[10]
					funcCallToStore = funcCallToStore .. funcParam7 .. " "
				end
				if paramCount >= 8 then   
					funcParam8= lineData[11]
					funcCallToStore = funcCallToStore .. funcParam8 .. " "
				end
				if paramCount >= 9 then   
					funcParam9 = lineData[12]
					funcCallToStore = funcCallToStore .. funcParam9 .. " "
				end
				if paramCount >= 10 then   
					funcParam10 = lineData[13]
					funcCallToStore = funcCallToStore .. funcParam10 .. " "
				end
				if paramCount >= 11 then   
					funcParam11 = lineData[14]
					funcCallToStore = funcCallToStore .. funcParam11 .. " "
				end
				if paramCount >= 12 then   
					funcParam12 = lineData[15]
					funcCallToStore = funcCallToStore .. funcParam12 .. " "
				end
				if paramCount >= 13 then   
					funcParam13 = lineData[16]
					funcCallToStore = funcCallToStore .. funcParam13 .. " "
				end
				if paramCount >= 14 then   
					funcParam14 = lineData[17]
					funcCallToStore = funcCallToStore .. funcParam14 .. " "
				end
				if paramCount >= 15 then   
					funcParam15 = lineData[18]
					funcCallToStore = funcCallToStore .. funcParam15 .. " "
				end
				if paramCount >= 16 then   
					funcParam16 = lineData[19]
					funcCallToStore = funcCallToStore .. funcParam16 .. " "
				end
				if paramCount >= 17 then   
					funcParam17 = lineData[20]
					funcCallToStore = funcCallToStore .. funcParam17 .. " "
				end
				if paramCount >= 18 then   
					funcParam18 = lineData[21]
					funcCallToStore = funcCallToStore .. funcParam18 .. " "
				end		
				if paramCount == 19 then   
					funcParam19 = lineData[22]
					funcCallToStore = funcCallToStore .. funcParam19
				end
			end 


			currentTableName = "snap_g_tmp_" .. currentActor .. tableSuffix     
			table.insert(_G[currentTableName], funcCallToStore)

			::nextIndex::

			funcCallToStore = ""

			lineData = {}
			
			funcParam1 = nil
			funcParam2 = nil
			funcParam3 = nil
			funcParam4 = nil
			funcParam5 = nil
			funcParam6 = nil
			funcParam7 = nil
			funcParam8 = nil
			funcParam9 = nil
			funcParam10 = nil
			funcParam11 = nil
			funcParam12 = nil
			funcParam13 = nil
			funcParam14 = nil
			funcParam15 = nil
			funcParam16 = nil
			funcParam17 = nil
			funcParam18 = nil
			funcParam19 = nil
		end 
		
		table.insert(snap_g_AGirlSeqFu, snap_g_tmp_AGirlSeqFu)		
		table.insert(snap_g_AGirl2SeqFu, snap_g_tmp_AGirl2SeqFu)
		table.insert(snap_g_AGirl3SeqFu, snap_g_tmp_AGirl3SeqFu)
		table.insert(snap_g_AGirl4SeqFu, snap_g_tmp_AGirl4SeqFu)
		table.insert(snap_g_AGirl5SeqFu, snap_g_tmp_AGirl5SeqFu)
		table.insert(snap_g_AGirl6SeqFu, snap_g_tmp_AGirl6SeqFu)
		table.insert(snap_g_AGirl7SeqFu, snap_g_tmp_AGirl7SeqFu)
		table.insert(snap_g_AGirl8SeqFu, snap_g_tmp_AGirl8SeqFu)
		table.insert(snap_g_AGirl9SeqFu, snap_g_tmp_AGirl9SeqFu)
		
		table.insert(snap_g_AGuySeqFu, snap_g_tmp_AGuySeqFu)
		table.insert(snap_g_AGuy2SeqFu, snap_g_tmp_AGuy2SeqFu)
		table.insert(snap_g_AGuy3SeqFu, snap_g_tmp_AGuy3SeqFu)
		table.insert(snap_g_AGuy4SeqFu, snap_g_tmp_AGuy4SeqFu)
		table.insert(snap_g_AGuy5SeqFu, snap_g_tmp_AGuy5SeqFu)
		table.insert(snap_g_AGuy6SeqFu, snap_g_tmp_AGuy6SeqFu)
		table.insert(snap_g_AGuy7SeqFu, snap_g_tmp_AGuy7SeqFu)
		table.insert(snap_g_AGuy8SeqFu, snap_g_tmp_AGuy8SeqFu)
		table.insert(snap_g_AGuy9SeqFu, snap_g_tmp_AGuy9SeqFu)

		snap_g_tmp_AGirlSeqFu = {}
		snap_g_tmp_AGirl2SeqFu = {}
		snap_g_tmp_AGirl3SeqFu = {}
		snap_g_tmp_AGirl4SeqFu = {}
		snap_g_tmp_AGirl5SeqFu = {}
		snap_g_tmp_AGirl6SeqFu = {}
		snap_g_tmp_AGirl7SeqFu = {}
		snap_g_tmp_AGirl8SeqFu = {}
		snap_g_tmp_AGirl9SeqFu = {}
		
		snap_g_tmp_AGuySeqFu = {}
		snap_g_tmp_AGuy2SeqFu = {}
		snap_g_tmp_AGuy3SeqFu = {}
		snap_g_tmp_AGuy4SeqFu = {}
		snap_g_tmp_AGuy5SeqFu = {}
		snap_g_tmp_AGuy6SeqFu = {}
		snap_g_tmp_AGuy7SeqFu = {}
		snap_g_tmp_AGuy8SeqFu = {}
		snap_g_tmp_AGuy9SeqFu = {}
		
	end 
	
	snap_g_currentSequenceNumber = 1
	snap_g_sequenceInitiator = _G[sequenceInitiator]
	snap_SequencerUpdate(snap_g_sequenceInitiator, "init")
end

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxxx UTILITY DATA & FUNCTIONS    xxxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- actorNames = "role-name" : these are just humans (objects of class Girl), number is fixed to 6 characters max
-- named for clarity (therefore no snap_ prefix) and ease of setting up poses/sequences - AGirl can be male, AGuy female and vice versa
AGirl = nil
AGirl2 = nil
AGirl3 = nil
AGirl4 = nil
AGirl5 = nil
AGirl6 = nil
AGirl7 = nil
AGirl8 = nil
AGirl9 = nil

AGuy = nil
AGuy2 = nil
AGuy3 = nil
AGuy4 = nil
AGuy5 = nil
AGuy6 = nil
AGuy7 = nil
AGuy8 = nil
AGuy9 = nil


function snap_SetAGirlAGuy(human, strAGirlGuy)
	if AGirl == human then
		AGirl = nil
	elseif AGirl2 == human then
		AGirl2 = nil
	elseif AGirl3 == human then
		AGirl3 = nil
	elseif AGirl4 == human then
		AGirl4 = nil
	elseif AGirl5 == human then
		AGirl5 = nil
	elseif AGirl6 == human then
		AGirl6 = nil
	elseif AGirl7 == human then
		AGirl7 = nil
	elseif AGirl8 == human then
		AGirl8 = nil
	elseif AGirl9 == human then
		AGirl9 = nil				
	elseif AGuy == human then
		AGuy = nil
	elseif AGuy2 == human then
		AGuy2 = nil
	elseif AGuy3 == human then
		AGuy3 = nil		
	elseif AGuy4 == human then
		AGuy4 = nil
	elseif AGuy5 == human then
		AGuy5 = nil
	elseif AGuy6 == human then
		AGuy6 = nil
	elseif AGuy7 == human then
		AGuy7 = nil
	elseif AGuy8 == human then
		AGuy8 = nil
	elseif AGuy9 == human then
		AGuy9 = nil
	end
	
	_G[strAGirlGuy] = human
	
	return
end

function snap_GetHitTriZone(hitTri)

	if hitTri == nil then
		return -1
	end

	if hitTri.IsNeck == true or hitTri.IsBreast == true or hitTri.IsChest == true or hitTri.IsSpine == true then
		return 1
	elseif hitTri.IsRightShoulder == true or hitTri.IsLeftShoulder == true then
		return 1
	elseif hitTri.IsRightUpperArm == true or hitTri.IsLeftUpperArm == true then
		return 1
	elseif hitTri.IsRightElbow == true or hitTri.IsLeftElbow == true then
		return 1
	elseif hitTri.IsRightForearm == true or hitTri.IsLeftForearm == true then
		return 1
	elseif hitTri.IsHips == true then
		return 2
	elseif hitTri.IsRightUpperLeg == true or hitTri.IsLeftUpperLeg == true then
		return 3
	elseif hitTri.IsRightKnee == true or hitTri.IsLeftKnee == true then
		return 3
	elseif hitTri.IsRightLowerLeg == true or hitTri.IsLeftLowerLeg == true then
		return 3
	elseif hitTri.IsRightFoot == true or hitTri.IsLeftFoot == true then
		return 3
	end
	
	return -1	
end


-- func: splitstring / params: stringToSplit, table ref to insert return values in, separator
function splitstring(inputstr, outTable, sep)
  if sep == nil then
    sep = "%s"
  end

  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(outTable, str)
  end
end

function snap_util_GetSequenceUIData(sequenceNumber, dataIndex)
	-- dataIndex = 1 Name of the Sequence
	-- dataIndex = 2 String of SequenceTable
	
	--if dataIndex is -1, data is not a table - just return the sequenceNumber index
	if dataIndex ~= -1 then
		return tostring(snap_g_sequences[sequenceNumber][dataIndex])
	else	
		return tostring(snap_g_sequences[sequenceNumber])
	end
end


function snap_util_GetSequenceUIDataRange(currentIndex)
	for i = currentIndex, tablelength(snap_g_sequences), 1 do
		 if type(snap_g_sequences[i]) ~= "table" then	
			return i
		end
	end
	
	return tablelength(snap_g_sequences)
end

function snap_toLowerCaseNoSpaces(strName)
	local lowerCaseName = string.lower(strName)
	lowerCaseName = lowerCaseName:gsub("%s+", "")
	return lowerCaseName
end


function snap_CustomizeActor(actor, clothingItem, value)
	actor.Customize(clothingItem, value)	
end


-- xxxxxxxxxxxxxxxxxxx
-- xxxx UI MENUS  xxxx
-- xxxxxxxxxxxxxxxxxxx

label snap_SnapMenu(human, hitTri)		
	+ "Toggle Handjob" [if human.Penis.Interaction and human.Penis.Interaction.handName ~= ""] [gold]
		if human.Penis.GetInteraction().m_autoHandActive == false 
			human.Penis.GetInteraction().m_autoHandActive = true
		else
			human.Penis.GetInteraction().m_autoHandActive = false
		ReturnTo("closeDialogue")			
	+ "Start thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == false] [gold]
		human.Penis.Interaction.AutoActive = true
		human.Penis.Interaction.AutoPenisWeight = 1
		ReturnTo("closeDialogue")
	+ "Stop thrusting!" [if human.Penis.Hole ~= nil and human.Penis.Interaction.AutoActive == true] [gold]
		human.Penis.Interaction.AutoActive = false
		ReturnTo("closeDialogue")
	+ "Start sucking!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == false] [gold]
		human.Mouth.Fucker.Penis.Interaction.AutoPenisWeight = 0
		human.Mouth.Fucker.Penis.Interaction.AutoActive = true
		ReturnTo("closeDialogue")
	+ "Stop sucking!" [if human.Mouth.Fucker ~= nil and human.Mouth.Fucker.Penis.Interaction.AutoActive == true] [gold]
		human.Mouth.Fucker.Penis.Interaction.AutoActive = false
		ReturnTo("closeDialogue")
	+ "Eyes and Mouth"
		+ "Open Eyes"
			human.Pose(Preset(EyelidL(0),EyelidR(0)))			
			Return()
		+ "Close Eyes"
			human.Pose(Preset(EyelidL(1),EyelidR(1)))		
			Return()
		+ "Look At Viewer"
			human.Pose(Preset(EyeL(CameraPos()),EyeR(CameraPos())))	
			Return()
		+ "Face The Camera"
			human.Pose(Preset(HeadLookAt(CameraPos())))	
			Return()
		+ "Open mouth"
			human.Pose(Preset(Mouth(-1)))			
			Return()
		+ "Close mouth"
			human.Pose(Preset(Mouth(0)))
			Return()
		+ "<color=#959C99> Back."
			Return(2)
		+ "<color=#1f2022> Close."
			ReturnTo("closeDialogue")
	+ (snap_g_bIsPaused == false) and "Sequences" or "Sequences <color=#F4364C> ( paused ) " [GOLD]
		+ "<color=#92969C><i>" .. snap_g_currentPoseFileName  [if snap_g_bSequencerActive == true and snap_g_bShowCurrentPoseFileName == true]
			Return(1)		
		+ "Play Interlude" [gold] [if snap_g_bSequencerActive == true and tablelength(snap_g_interludes) > 0]
			+ for i, interludes in ipairs(snap_g_interludes)
				+ "" .. snap_util_GetInterludeUIData(i, 1) .. " interlude"
					snap_g_bInterludeRunning = true
					snap_g_currentSequenceNumber = i + 1
					snap_SetSequenceIndex(snap_util_GetInterludeUIData(i, 2), 1)				
					snap_SequencerUpdate(_G[snap_util_GetInterludeUIData(i, 2)], "current", 0)
					ReturnTo("closeDialogue")
			+ "<color=#959C99> Back."
				Return(2)
			+ "<color=#1f2022> Close."
				ReturnTo("closeDialogue")
		+ "<color=#E10600> Stop Interlude" [if snap_g_bInterludeRunning == true ]		
			snap_g_bInterludeRunning = false
			snap_g_currentSequenceNumber = 1	
			snap_SequencerUpdate(snap_g_mainSequenceLastActor, "current", 0)
			ReturnTo("closeDialogue")
		+ "Restart Sequence" [if snap_g_bSequencerActive == true]
			snap_SequencerRestart()
			ReturnTo("closeDialogue")
		+ "<color=#F4364C>Pause Sequence" [if snap_g_bSequencerActive == true and snap_g_bIgnoreClickEvents == false]
			snap_g_bIgnoreClickEvents = true
			snap_g_bIsPaused = true
			ReturnTo("closeDialogue")
		+ "<color=#00AE58>Resume Sequence" [if snap_g_bSequencerActive == true and snap_g_bIgnoreClickEvents == true]
			snap_g_bIgnoreClickEvents = false
			snap_g_bIsPaused = false
			ReturnTo("closeDialogue")			
		+ "<color=#E10600>Stop Sequence" [if snap_g_bSequencerActive == true]
			snap_SequencerStop()
			ReturnTo("closeDialogue")	
		+ "<color=#FFA400>Set Sequence Actors"
			local humanTable = game.GetHumans()
			if tablelength(humanTable) > 0				
				+ (AGirl ~= nil ) and "<color=#FF82C1><i>1. AGirl  " .. tostring(AGirl.Name) or "<color=#80345A>1. set AGirl "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl")
							Return(2)
					+ "clear" [gold]
						AGirl = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
				+ (AGirl2 ~= nil ) and "<color=#FF82C1><i>2. AGirl2  " .. tostring(AGirl2.Name) or "<color=#80345A>2. set AGirl2 "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl2")
							Return(2)
					+ "clear" [gold]
						AGirl2 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGirl3 ~= nil ) and "<color=#FF82C1><i>3. AGirl3  " .. tostring(AGirl3.Name) or "<color=#80345A>3. set AGirl3 "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl3")
							Return(2)
					+ "clear" [gold]
						AGirl3 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGirl4 ~= nil ) and "<color=#FF82C1><i>4. AGirl4  " .. tostring(AGirl4.Name) or "<color=#80345A>4. set AGirl4 "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl4")
							Return(2)
					+ "clear" [gold]
						AGirl4 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGirl5 ~= nil ) and "<color=#FF82C1><i>5. AGirl5  " .. tostring(AGirl5.Name) or "<color=#80345A>5. set AGirl5 "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl5")
							Return(2)
					+ "clear" [gold]
						AGirl5 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGirl6 ~= nil ) and "<color=#FF82C1><i>6. AGirl6  " .. tostring(AGirl6.Name) or "<color=#80345A>6. set AGirl6 "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl6")
							Return(2)
					+ "clear" [gold]
						AGirl6 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGirl7 ~= nil ) and "<color=#FF82C1><i>7. AGirl7  " .. tostring(AGirl7.Name) or "<color=#80345A>7. set AGirl7 "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl7")
							Return(2)
					+ "clear" [gold]
						AGirl7 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGirl8 ~= nil ) and "<color=#FF82C1><i>8. AGirl8  " .. tostring(AGirl8.Name) or "<color=#80345A>8. set AGirl8 "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl8")
							Return(2)
					+ "clear" [gold]
						AGirl8 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGirl9 ~= nil ) and "<color=#FF82C1><i>9. AGirl9  " .. tostring(AGirl9.Name) or "<color=#80345A>9. set AGirl9 "
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGirl9")
							Return(2)
					+ "clear" [gold]
						AGirl9 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()		
				+ (AGuy ~= nil ) and "<color=#82A3FF><i>1. AGuy  " .. tostring(AGuy.Name) or "<color=#415280>1. set AGuy "			
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy")
							Return(2)
					+ "clear" [gold]
						AGuy = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()
				+ (AGuy2 ~= nil ) and "<color=#82A3FF><i>2. AGuy2  " .. tostring(AGuy2.Name) or "<color=#415280>2. set AGuy2 "	 
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy2")
							Return(2)
					+ "clear" [gold]
						AGuy2 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)		
					Return()			
				+ (AGuy3 ~= nil ) and "<color=#82A3FF><i>3. AGuy3  " .. tostring(AGuy3.Name) or "<color=#415280>3. set AGuy3 "	 
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy3")
							Return(2)
					+ "clear" [gold]
						AGuy3 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGuy4 ~= nil ) and "<color=#82A3FF><i>4. AGuy4  " .. tostring(AGuy4.Name) or "<color=#415280>4. set AGuy4 "	 
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy4")
							Return(2)
					+ "clear" [gold]
						AGuy4 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGuy5 ~= nil ) and "<color=#82A3FF><i>5. AGuy5  " .. tostring(AGuy5.Name) or "<color=#415280>5. set AGuy5 "	 
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy5")
							Return(2)
					+ "clear" [gold]
						AGuy5 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGuy6 ~= nil ) and "<color=#82A3FF><i>6. AGuy6  " .. tostring(AGuy6.Name) or "<color=#415280>6. set AGuy6 "	 
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy6")
							Return(2)
					+ "clear" [gold]
						AGuy6 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGuy7 ~= nil ) and "<color=#82A3FF><i>7. AGuy7  " .. tostring(AGuy7.Name) or "<color=#415280>7. set AGuy7 "	 
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy7")
							Return(2)
					+ "clear" [gold]
						AGuy7 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGuy8 ~= nil ) and "<color=#82A3FF><i>8. AGuy8  " .. tostring(AGuy8.Name) or "<color=#415280>8. set AGuy8 "	 
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy8")
							Return(2)
					+ "clear" [gold]
						AGuy8 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()				
				+ (AGuy9 ~= nil ) and "<color=#82A3FF><i>9. AGuy9  " .. tostring(AGuy9.Name) or "<color=#415280>9. set AGuy9 "	 
					+ for i, DaHuman in ipairs(humanTable)
						+ "" .. DaHuman.Name
							snap_SetAGirlAGuy(DaHuman, "AGuy9")
							Return(2)
					+ "clear" [gold]
						AGuy9 = nil
						Return(2)
					+ "<color=#959C99> Back."
						Return(2)
					Return()
						
				+ "<color=#959C99> Back."
					Return(3)
				+ "<color=#1f2022> Close."
					ReturnTo("closeDialogue")
		+ (snap_g_bSequencerActive == false) and "Start Sequence" or "Start Sequence" .. " <color=#E10600>(stops current !)" [GOLD]					
			+ for i = 1, tablelength(snap_g_sequences), 1
				+ if type(snap_g_sequences[i]) ~= "table"
					+ "" .. snap_util_GetSequenceUIData(i, -1)
						i = i +1
						+	for j = i, snap_util_GetSequenceUIDataRange(i), 1
							+ if type(snap_g_sequences[j]) == "table"
								+ "" .. snap_util_GetSequenceUIData(j, 1)
									snap_SequencerSetup(snap_util_GetSequenceUIData(j, 2))
						+ "<color=#959C99> Back."
							Return(2)
			+ "<color=#959C99> Back."
				Return(2)
			+ "<color=#1f2022> Close."
				ReturnTo("closeDialogue")
		+ "Actions" [if snap_g_bSequencerActive == true and snap_util_CheckActions(human) > 0 and snap_g_bOmniModeActive == false]
			+ "<color=#92969C><i>" .. snap_g_currentPoseFileName  [if snap_g_bSequencerActive == true and snap_g_bShowCurrentPoseFileName == true]
				Return(1)			
			+ "Next"
				snap_SequencerUpdate(human, "next")
				Return(1)
			+ "Repeat Current" 
				snap_SequencerUpdate(human, "current")
				Return(1)
			+ "Previous" 
				snap_SequencerUpdate(human, "previous")
				Return(1)
			+ "<color=#959C99> Back."
				Return(2)
			+ "<color=#1f2022> Close."
				ReturnTo("closeDialogue")
		+ "Actions  <color=#92969C><i>omni" [if snap_g_bSequencerActive == true and snap_g_bOmniModeActive == true]
			+ "<color=#92969C><i>" .. snap_g_currentPoseFileName  [if snap_g_bSequencerActive == true and snap_g_bShowCurrentPoseFileName == true]
				Return(1)		
			+ "Next"
				snap_SequencerUpdate(snap_g_OmniModeActor, "next")
				Return(1)
			+ "Repeat Current" 
				snap_SequencerUpdate(snap_g_OmniModeActor, "current")
				Return(1)
			+ "Previous" 
				snap_SequencerUpdate(snap_g_OmniModeActor, "previous")
				Return(1)
			+ "<color=#959C99> Back."
				Return(2)
			+ "<color=#1f2022> Close."
				ReturnTo("closeDialogue")				
		+ "<color=#959C99> Back."
			Return(2)
		+ "<color=#1f2022> Close."
			ReturnTo("closeDialogue")
	+ "open Talk Menu" [if TalkMenu ~= nil]
		Jump("TalkMenu", human, hitTri)	
	+ "faunaLABS" [if fauna_LABS_Menu ~= nil]
		fauna_LABS_Menu(human, hitTri)
	+ "open Mod Menu" [gold] [if TM_ModMenu ~= nil]
		TM_ModMenu(human, hitTri)
	+ "<color=#1f2022> Close."
	
	= closeDialogue		
stop

-- EOF