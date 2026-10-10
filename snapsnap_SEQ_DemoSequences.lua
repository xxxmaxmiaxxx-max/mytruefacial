-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- xxx SEQUENCE DEFINITIONS    xxx
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- sequence line syntax
-- entries are separated by whitespace
-- 0. omni : omniActor
-- 1. interlude : table name of the sequence which acts as an interlude : interlude UI-Name
-- Interludes entries must be placed at the beginning of a sequence table
-- 2. pose : OwningActor : functionNameOfThePose : Actor1 : Actor2 ... Actor6: fadeInTime"

-- *********************************
-- 		Casting Couch
-- *********************************

snap_SEQ_FMM_CastingCouch01 = {
	[1] = "interlude snap_SEQ_FMM_CastingCouch02 DP",
	[2] = "pose AGirl snap_SEQ_FMM_CastingCouch01_01 AGirl AGuy AGuy2 0",
	[3] = "pose AGirl snap_SEQ_FMM_CastingCouch01_02 AGirl AGuy AGuy2 2",
	[4] = "pose AGirl snap_SEQ_FMM_CastingCouch01_03 AGirl AGuy AGuy2 2",
	[5] = "pose AGirl snap_SEQ_FMM_CastingCouch01_04 AGirl AGuy AGuy2 2",
	[6] = "pose AGirl snap_SEQ_FMM_CastingCouch01_05 AGirl AGuy AGuy2 2",
	[7] = "pose AGirl snap_SEQ_FMM_CastingCouch01_06 AGirl AGuy AGuy2 1",
	[8] = "pose AGirl snap_SEQ_FMM_CastingCouch01_07 AGirl AGuy AGuy2 0",
	[9] = "pose AGirl snap_SEQ_FMM_CastingCouch01_08 AGirl AGuy AGuy2 0",
	[10] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_09 AGirl AGuy AGuy2 0",
	[11] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_10 AGirl AGuy AGuy2 2",
	[12] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_11 AGirl AGuy AGuy2 2",
	[13] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_12 AGirl AGuy AGuy2 2",
	[14] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_13 AGirl AGuy AGuy2 0",
	[15] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_14 AGirl AGuy AGuy2 2",
	[16] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_15 AGirl AGuy AGuy2 2",
	[17] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_16 AGirl AGuy AGuy2 2",
	[18] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_17 AGirl AGuy AGuy2 2",
	[19] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_18 AGirl AGuy AGuy2 2",
	[20] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_19 AGirl AGuy AGuy2 2",
	[21] = "pose AGuy2 snap_SEQ_FMM_CastingCouch01_20 AGirl AGuy AGuy2 2",
	[22] = "pose AGuy snap_SEQ_FMM_CastingCouch01_21 AGirl AGuy AGuy2 2",
	[23] = "pose AGuy snap_SEQ_FMM_CastingCouch01_22 AGirl AGuy AGuy2 0",
	[24] = "pose AGuy snap_SEQ_FMM_CastingCouch01_23 AGirl AGuy AGuy2 2",
	[25] = "pose AGuy snap_SEQ_FMM_CastingCouch01_24 AGirl AGuy AGuy2 2",
	[26] = "pose AGuy snap_SEQ_FMM_CastingCouch01_25 AGirl AGuy AGuy2 2",
	[27] = "pose AGuy snap_SEQ_FMM_CastingCouch01_26 AGirl AGuy AGuy2 2",
	[28] = "pose AGuy snap_SEQ_FMM_CastingCouch01_27 AGirl AGuy AGuy2 2",
	[29] = "pose AGuy snap_SEQ_FMM_CastingCouch01_28 AGirl AGuy AGuy2 2",
	[30] = "pose AGuy snap_SEQ_FMM_CastingCouch01_29 AGirl AGuy AGuy2 2",
	[31] = "pose AGuy snap_SEQ_FMM_CastingCouch01_30 AGirl AGuy AGuy2 2",	
}

-- omni sequence: all poses are owned by the omni actor. In this cae AGirl
-- use this format for non branching linear sequences.

snap_SEQ_FMM_CastingCouch02 = {
	[1] = "omni AGirl",	
	[2] = "pose AGirl snap_SEQ_FMM_CastingCouch02_01 AGirl AGuy AGuy2 0",
	[3] = "pose AGirl snap_SEQ_FMM_CastingCouch02_02 AGirl AGuy AGuy2 2",
	[4] = "pose AGirl snap_SEQ_FMM_CastingCouch02_03 AGirl AGuy AGuy2 2",
	[5] = "pose AGirl snap_SEQ_FMM_CastingCouch02_04 AGirl AGuy AGuy2 2",
	[6] = "pose AGirl snap_SEQ_FMM_CastingCouch02_05 AGirl AGuy AGuy2 2",
	[7] = "pose AGirl snap_SEQ_FMM_CastingCouch02_06 AGirl AGuy AGuy2 0",
	[8] = "pose AGirl snap_SEQ_FMM_CastingCouch02_07 AGirl AGuy AGuy2 0",
	[9] = "pose AGirl snap_SEQ_FMM_CastingCouch02_08 AGirl AGuy AGuy2 0",	
	[10] = "pose AGirl snap_SEQ_FMM_CastingCouch02_09 AGirl AGuy AGuy2 0",	
}