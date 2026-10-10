--fauna_LABS_v1.05
-- log("faunaLABS v1.05 - Character Menu fired!")
FL_charList = {
    {
        "2b", 
        "ada wong re4", 
        "ada wong", 
        "aerith", 
        "ahri kda", 
        "akali", 
        "android 18", 
        "artoria", 
        "ashley maid", 
        "ashley", 
        "asuna", 
        "aunt cass", 
    },
    {
        "bayonetta", 
        "black cat", 
        "black male", 
        "cammy", 
        "cheri nowlin", 
        "chunli", 
        "cindy aurum", 
        "ciri", 
        "claire redfield", 
        "cloud", 
    },
    {
        "daniela dimitrescu",
        "dante", 
        "dark elf", 
        "dimitrescu", 
        "dva", 
        "elizabethbas", 
        "elizabethyoung", 
        "ellie", 
        "emilie de rochefort", 
        "eva", 
        "eve", 
        "eve_xmas", 
        "faye valentine", 
    },
    {
        "gemma", 
        "generic male", 
        "geralt", 
        "grace ashcroft", 
        "hailey", 
        "harley quinn arkham", 
        "harley quinn", 
        "honoka", 
        "ifalna", 
        "invisible woman", 
        "irelia", 
        "ivy", 
    },
    {
        "jessie rasberry", 
        "jill valentine", 
        "jinx", 
        "judy alvarez", 
        "juliet", 
        "juno", 
        "juri sf6", 
        "juri", 
        "kaine", 
        "kasumi", 
        "kitana", 
    },
    {
        "lara croft", 
        "leon s kennedy", 
        "lily artemis", 
        "link warriors", 
        "loba", 
        "luna", 
        "lunafreya", 
        "lune", 
    },
    {
        "maddie", 
        "maelle", 
        "mai shiranui", 
        "makima", 
        "male v", 
        "malenia", 
        "marie rose", 
        "marin kitagawa", 
        "mercy", 
        "miss fortune", 
        "miya ryona", 
        "morrigan", 
        "mrx", 
        "nayo", 
        "nyotengu", 
    },
    {
        "panam", 
        "pharah", 
        "power", 
        "primrose office", 
        "primrose", 
        "psylocke", 
        "queen", 
        "quiet", 
        "rangiku", 
        "raven", 
        "raven teentitan", 
        "raven stellarblade", 
        "rosemary", 

        "samus", 
        "sara moreau", 
        "scarlet", 
        "shadowheart", 
        "sheva alomar", 
        "sombra", 
        "succubus", 
    },
    {
        "tachy", 
        "tifa lifeguard", 
        "tifa", 
        "tifa_f", 
        "tifa_kimono", 
        "tracer", 
        "triss", 
        "ultimate bunny", 
        "widowmaker", 
        "widowmaker sylvanas", 
        "witch mercy", 
        "yennefer", 
        "y'shtola", 
        "yuffie", 
        "zelda"
    }
}

-- Core parts for "toggle all" mesh render
local meshTargets = {
    "Eyes",
    "Eyebrows",
    "Brows",
    "Eyelashes",
    "Body_",
    "Mouth",
    "Teeth",
    "Tongue",
    "Hair",
}

function toggleAllRenderParts(human, enabled)
    local allParts = getFBXParts(human)
    for _, partName in ipairs(allParts) do
        toggleBodyPart(human, partName, enabled)
    end
end

function toggleCoreRenderParts(human, enabled)
    for _, partName in ipairs(meshTargets) do
        toggleBodyPart(human, partName, enabled)
    end
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

label faunaCharMenu(human, hitTri)
    + "wear less..."
        human.CustomizeAll(99)
        if (human.m_isMale == false)
            human.Customize("Penis", 0)
        Return()
    + "wear more..."
        human.CustomizeAll(0)
        Return()
    + "Swap your clothes with.."[gold]
        local humans = game.GetHumans(|h| h ~= human)
        + for i, targetHuman in ipairs(humans)
            + "Swap with " .. targetHuman.Name .. "."
                if targetHuman.ClothingName == human.ClothingName
                    Return(2)
                else
                    > fade
                    game.ReplaceClothing(human, targetHuman.ClothingName);
                    game.ReplaceClothing(targetHuman, human.ClothingName);
            + "Copy " .. targetHuman.Name .. "."
                if targetHuman.ClothingName == human.ClothingName
                    Return(2)
                else
                    > fade
                    game.ReplaceClothing(human, targetHuman.ClothingName)

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
    + "Outfits.."[gold]
        + "Alphabetical"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "0 | A"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[1])
                    + "" .. name
                        game.ReplaceClothing(human, name)
            + "B | C"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[2])
                    + "" .. name
                        game.ReplaceClothing(human, name)
            + "D | E | F"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[3])
                    + "" .. name
                        game.ReplaceClothing(human, name)
            + "G | H | I"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[4])
                    + "" .. name
                        game.ReplaceClothing(human, name)
            + "J | K"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[5])
                    + "" .. name
                        game.ReplaceClothing(human, name)
            + "L"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[6])
                    + "" .. name
                        game.ReplaceClothing(human, name)
            + "M | N | O"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[7])
                    + "" .. name
                        game.ReplaceClothing(human, name)
            + "P | Q | R | S"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[8])
                    + "" .. name
                        game.ReplaceClothing(human, name)
            + "T | U | V | W | X | Y | Z"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[9])
                    + "" .. name
                        game.ReplaceClothing(human, name)
        + "Males.."[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "Cloud"
                game.ReplaceClothing(human, "Cloud")
                Return(2)
            + "Leon"
                game.ReplaceClothing(human, "leon s kennedy")
                Return(2)
            + "Geralt"
                game.ReplaceClothing(human, "geralt")
                Return(2)
            + "White Male"
                game.ReplaceClothing(human, "generic male")
                Return(2)
            + "Black Male"
                game.ReplaceClothing(human, "black male")
                Return(2)
            + "Kaine"
                game.ReplaceClothing(human, "kaine")
                Return(2)
            + "Dante"
                game.ReplaceClothing(human, "dante")
                Return(2)
            + "Mr X"
                game.ReplaceClothing(human, "mrx")
                Return(2)
            + "Link"
                game.ReplaceClothing(human, "link warriors")
                Return(2)
            + "Male V"
                game.ReplaceClothing(human, "male v")
                Return(2)
        + "Style - WIP"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "Lingerie"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Ada Wong"
                    game.ReplaceClothing(human, "ada wong")
                + "Akali"
                    game.ReplaceClothing(human, "akali")
                + "Dimitrescu"
                    game.ReplaceClothing(human, "dimitrescu")
                + "Primrose Office"
                    game.ReplaceClothing(human, "Primrose Office")
                + "Scarlet"
                    game.ReplaceClothing(human, "scarlet")
            + "Bikini"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Cindy Aurum"
                    game.ReplaceClothing(human, "cindy aurum")
                + "Emilie de Rochefort"
                    game.ReplaceClothing(human, "emilie de rochefort")
                + "Eva"
                    game.ReplaceClothing(human, "eva")
                + "Morrigan"
                    game.ReplaceClothing(human, "morrigan")
                + "Quiet"
                    game.ReplaceClothing(human, "quiet")
                + "Succubus"
                    game.ReplaceClothing(human, "succubus")
                + "Tifa - Lifeguard"
                    game.ReplaceClothing(human, "tifa lifguard")
            + "Casual"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Android 18"
                    game.ReplaceClothing(human, "android 18")
                + "Aunt Cass"
                    game.ReplaceClothing(human, "aunta cass")
                + "Jill Valentine"
                    game.ReplaceClothing(human, "jill valentine")
                + "Lara Croft"
                    game.ReplaceClothing(human, "lara croft")
                + "Panam"
                    game.ReplaceClothing(human, "panam")
                + "Pharah"
                    game.ReplaceClothing(human, "pharah")
                + "Power"
                    game.ReplaceClothing(human, "power")
                + "Rosemary"
                    game.ReplaceClothing(human, "rosemary")
                + "Yuffie"
                    game.ReplaceClothing(human, "yuffie")
            + "Formal"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Emilie de Rochefort"
                    game.ReplaceClothing(human, "emilie de rochefort")
                + "Lunafreya"
                    game.ReplaceClothing(human, "lunafreya")
                + "Primrose Office"
                    game.ReplaceClothing(human, "primrose office")
                + "Queen Marika"
                    game.ReplaceClothing(human, "queen")
                + "Maelle"
                    game.ReplaceClothing(human, "maelle")
                + "Scarlet"
                    game.ReplaceClothing(human, "scarlet")
            + "School"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Ashley"
                    game.ReplaceClothing(human, "ashley")
                + "Marie Rose"
                    game.ReplaceClothing(human, "marie rose")
                + "Honoka"
                    game.ReplaceClothing(human, "honoka")
                + "Juliet"
                    game.ReplaceClothing(human, "juliet")
            + "Bodysuit"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Black Cat"
                    game.ReplaceClothing(human, "black cat")
                + "Invisible Woman"
                    game.ReplaceClothing(human, "invisible woman")
                + "Eve"
                    game.ReplaceClothing(human, "eve")
                + "Dva"
                    game.ReplaceClothing(human, "dva")
                + "Samus"
                    game.ReplaceClothing(human, "samus")
                + "Widowmaker"
                    game.ReplaceClothing(human, "widowmaker")
            + "Bunnysuit"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Akali"
                    game.ReplaceClothing(human, "akali")
                + "Artoria"
                    game.ReplaceClothing(human, "artoria")
                + "Irelia"
                    game.ReplaceClothing(human, "irelia")
                + "Ultimate Bunny"
                    game.ReplaceClothing(human, "ultimate bunny")
            + "<color=#54b095><i>Back."
                Return(2)
            + "<color=#9a646f><i>Done."
        + "Patch"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "5.92"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Ada Wong - RE4"
                    game.ReplaceClothing(human, "ada wong re4")
                + "Ashley - Maid"
                    game.ReplaceClothing(human, "ashley maid")
                + "Nayo"
                    game.ReplaceClothing(human, "nayo")
                + "Sombra"
                    game.ReplaceClothing(human, "sombra")
            + "5.93"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Maelle"
                    game.ReplaceClothing(human, "maelle")
                + "Makima"
                    game.ReplaceClothing(human, "makima")
                + "Rosemary"
                    game.ReplaceClothing(human, "rosemary")
            + "5.94"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Asuna"
                    game.ReplaceClothing(human, "asuna")
                + "Claire Redfield"
                    game.ReplaceClothing(human, "claire redfield")
                + "Male V"
                    game.ReplaceClothing(human, "male v")
                + "Psylocke"
                    game.ReplaceClothing(human, "psylocke")
            + "5.95"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Dark Elf"
                    game.ReplaceClothing(human, "dark elf")
                + "Grace Ashcroft"
                    game.ReplaceClothing(human, "grace ashcroft")
                + "Lune"
                    game.ReplaceClothing(human, "lune")
                + "Marin Kitagawa"
                    game.ReplaceClothing(human, "marin kitagawa")
            + "5.96"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Miya Ryona"
                    game.ReplaceClothing(human, "Miya Ryona")
                + "Sara Moreau"
                    game.ReplaceClothing(human, "sara moreau")
                + "Sheva Alomar"
                    game.ReplaceClothing(human, "sheva alomar")
            + "5.97"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Daniela Dimitrescu"
                    game.ReplaceClothing(human, "daniela dimitrescu")
                + "Juno"
                    game.ReplaceClothing(human, "juno")
                + "Raven SB"
                    game.ReplaceClothing(human, "raven stellarblade")
                + "Sylvanas"
                    game.ReplaceClothing(human, "widowmaker sylvanas")
            + "<color=#54b095><i>Back."
                Return(2)
            + "<color=#9a646f><i>Done."
        + "<color=#54b095><i>Back."
            Return(2)
        + "<color=#9a646f><i>Done. | Outfits"
    + "Summon.."[gold]
        + "Alphabetical"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "0 | A"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[1])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
            + "B | C"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[2])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
            + "D | E | F"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[3])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
            + "G | H | I"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[4])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
            + "J | K"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[5])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
            + "L"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[6])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
            + "M | N | O"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[7])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
            + "P | Q | R | S"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[8])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
            + "T | U | V | W | X | Y | Z"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[9])
                    + "" .. name
                        game.CreateHuman(name)
                        Return(2)
        + "Males.."[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "Cloud"
                game.CreateHuman("Cloud")
                Return(2)
            + "Leon"
                game.CreateHuman("leon s kennedy")
                Return(2)
            + "Geralt"
                game.CreateHuman("geralt")
                Return(2)
            + "White Male"
                game.CreateHuman("generic male")
                Return(2)
            + "Black Male"
                game.CreateHuman("black male")
                Return(2)
            + "Kaine"
                game.CreateHuman("kaine")
                Return(2)
            + "Dante"
                game.CreateHuman("dante")
                Return(2)
            + "Mr X"
                game.CreateHuman("mrx")
                Return(2)
            + "Link"
                game.CreateHuman("link warriors")
                Return(2)
            + "Male V"
                game.CreateHuman("male v")
                Return(2)
        + "Patch"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "5.7"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Bayonetta"
                    game.CreateHuman("bayonetta")
                    Return(2)
                + "Eve"
                    game.CreateHuman("eve")
                    Return(2)
                + "Emilie De Rochefort"
                    game.CreateHuman("emilie de rochefort")
                    Return(2)
                + "Faye Valentine"
                    game.CreateHuman("faye valentine")
                    Return(2)
                + "Ivy Valentine"
                    game.CreateHuman("ivy")
                    Return(2)
                + "Lily Artemis"
                    game.CreateHuman("lily artemis")
                    Return(2)
                + "Madeline Pumps"
                    game.CreateHuman("maddie")
                    Return(2)
                + "Power"
                    game.CreateHuman("power")
                    Return(2)
                + "Scarlet"
                    game.CreateHuman("scarlet")
                    Return(2)
                + "Yuffie Kisaragi"
                    game.CreateHuman("yuffie")
                    Return(2)
            + "5.8"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Dante"
                    game.CreateHuman("dante")
                    Return(2)
                + "Eva"
                    game.CreateHuman("eva")
                    Return(2)
                + "Juliet Starlight"
                    game.CreateHuman("juliet")
                    Return(2)
                + "Lady Alcina Dimitrescu"
                    game.CreateHuman("dimitrescu")
                    Return(2)
            + "5.9"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Chunli"
                    game.CreateHuman("chunli")
                    Return(2)
                + "Eve | Xmas"
                    game.CreateHuman("eve_xmas")
                    Return(2)
                + "Irelia"
                    game.CreateHuman("irelia")
                    Return(2)
                + "Tachy"
                    game.CreateHuman("tachy")
                    Return(2)
            + "5.91"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Artoria"
                    game.CreateHuman("artoria")
                    Return(2)
                + "Harley Quinn | Knight"
                    game.CreateHuman("harley quinn arkham")
                    Return(2)
                + "Kaine"
                    game.CreateHuman("kaine")
                    Return(2)
                + "Kasumi"
                    game.CreateHuman("kasumi")
                    Return(2)
            + "5.92"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Ada Wong - RE4"
                    game.CreateHuman("ada wong", "ada wong re4")
                    Return(2)
                + "Ashley - Maid"
                    game.CreateHuman("ashley maid")
                    Return(2)
                + "Nayo"
                    game.CreateHuman("nayo")
                    Return(2)
                + "Sombra"
                    game.CreateHuman("sombra")
                    Return(2)
            + "5.93"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Maelle"
                    game.CreateHuman("maelle")
                    Return(2)
                + "Makima"
                    game.CreateHuman("makima")
                    Return(2)
                + "Rosemary"
                    game.CreateHuman("rosemary")
                    Return(2)
            + "5.94"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Asuna"
                    game.CreateHuman("asuna")
                    Return(2)
                + "Claire Redfield"
                    game.CreateHuman("claire redfield")
                    Return(2)
                + "Male V"
                    game.CreateHuman("male v")
                    Return(2)
                + "Psylocke"
                    game.CreateHuman("psylocke")
                    Return(2)
            + "5.95"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Dark Elf"
                    game.CreateHuman("dark elf")
                    Return(2)
                + "Grace Ashcroft"
                    game.CreateHuman("grace ashcroft")
                    Return(2)
                + "Lune"
                    game.CreateHuman("lune")
                    Return(2)
                + "Marin Kitagaw"
                    game.CreateHuman("marin kitagawa")
                    Return(2)
            + "5.96"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Miya Ryona"
                    game.CreateHuman("miya ryona")
                    Return(2)
                + "Sara Moreau"
                    game.CreateHuman("sara moreau")
                    Return(2)
                + "Sheva Alomar"
                    game.CreateHuman("sheva alomar")
                    Return(2)
            + "5.97"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Daniela Dimitrescu"
                    game.CreateHuman("daniela dimitrescu")
                    Return(2)
                + "Juno"
                    game.CreateHuman("juno")
                    Return(2)
                + "Raven SB"
                    game.CreateHuman("raven stellarblade")
                    Return(2)
                + "Sylvanas"
                    game.CreateHuman("widowmaker sylvanas")
                    Return(2)
            + "<color=#54b095><i>Back."
                Return(2)
            + "<color=#9a646f><i>Done."
        + "insertMods"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "Goth Kaine"
                game.CreateHuman("pc_goth kaine")
                Return(2)
            + "Goth Nyotengu"
                game.CreateHuman("pc_goth nyotengu")
                Return(2)
            + "Goth Ashley"
                game.CreateHuman("pc_goth ashley")
                Return(2)
            + "Goth Ahri"
                game.CreateHuman("goth ahri")
                Return(2)
            + "Goth Tachy"
                game.CreateHuman("goth tachy")
                Return(2)
            + "Goth Aerith"
                game.CreateHuman("goth aerith")
                Return(2)
            + "Goth 2B"
                game.CreateHuman("goth2b")
                Return(2)
            + "Goth Cloud"
                game.CreateHuman("pc_goth cloud")
                Return(2)
            + "Goth Harley Quinn"
                game.CreateHuman("pc_goth harley quinn")
                Return(2)
            + "Goth Dva"
                game.CreateHuman("pc_goth dva")
                Return(2)
            + "Goth Ada"
                game.CreateHuman("goth ada")
                Return(2)
            + "Goth Lily Artemis"
                game.CreateHuman("goth lily artemis")
                Return(2)
            + "Goth Eve"
                game.CreateHuman("goth eve")
                Return(2)
            + "Kaine"
                game.CreateHuman("kaine_stylized.rev")
                Return(2)
            + "Irelia"
                game.CreateHuman("irelia_tweaked.rev")
                Return(2)
            + "Hailey"
                game.CreateHuman("hailey_tweaked.rev")
                Return(2)
            + "Bayonetta"
                game.CreateHuman("bayo_tweaked.rev")
                Return(2)
            + "Cindy"
                game.CreateHuman("lara_athletik.rev")
                Return(2)
            + "Tifa"
                game.CreateHuman("tifa_stylized.rev")
                Return(2)
            + "Tifa - Beach"
                game.CreateHuman("tifa_beach.rev")
                Return(2)
            + "Emilie De Rochefort"
                game.CreateHuman("emilie_refined.rev")
                Return(2)
            + "Yennefer"
                game.CreateHuman("yen_refined.rev")
                Return(2)
            + "Samus"
                game.CreateHuman("samus_stylized.rev")
                Return(2)
            + "<color=#54b095><i>Back."
                Return(2)
            + "<color=#9a646f><i>Done."
        + "<color=#54b095><i>Back."
            Return(2)
        + "<color=#9a646f><i>Done. | Summon"
    + "Replace Character.."[gold]
        + "Alphabetical"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "0 | A"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[1])
                    + "" .. name
                        game.ReplaceHuman(name, human)
            + "B | C"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[2])
                    + "" .. name
                        game.ReplaceHuman(name, human)
            + "D | E | F"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[3])
                    + "" .. name
                        game.ReplaceHuman(name, human)
            + "G | H | I"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[4])
                    + "" .. name
                        game.ReplaceHuman(name, human)
            + "J | K"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[5])
                    + "" .. name
                        game.ReplaceHuman(name, human)
            + "L"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[6])
                    + "" .. name
                        game.ReplaceHuman(name, human)
            + "M | N | O"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[7])
                    + "" .. name
                        game.ReplaceHuman(name, human)
            + "P | Q | R | S"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[8])
                    + "" .. name
                        game.ReplaceHuman(name, human)
            + "T | U | V | W | X | Y | Z"
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + for i, name in ipairs(FL_charList[9])
                    + "" .. name
                        game.ReplaceHuman(name, human)        
        + "Male"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "Cloud"
                game.ReplaceHuman("Cloud", human)
            + "Leon"
                game.ReplaceHuman("leon s kennedy", human)
            + "Geralt"
                game.ReplaceHuman("geralt", human)
            + "White Male"
                game.ReplaceHuman("generic male", human)
            + "Black Male"
                game.ReplaceHuman("black male", human)
            + "Kaine"
                game.ReplaceHuman("kaine", human)
            + "Dante"
                game.ReplaceHuman("Dante", human)
            + "Mr X"
                game.ReplaceHuman("mrx", human)
            + "Link"
                game.ReplaceHuman("link warriors", human)
            + "Male V"
                game.ReplaceHuman("male v", human)
        + "Patch"[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "5.7"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Bayonetta"
                    game.ReplaceHuman("bayonetta", human)
                + "Eve"
                    game.ReplaceHuman("eve", human)
                + "Emilie De Rochefort"
                    game.ReplaceHuman("emilie de rochefort", human)
                + "Faye Valentine"
                    game.ReplaceHuman("faye valentine", human)
                + "Ivy Valentine"
                    game.ReplaceHuman("ivy", human)
                + "Lily Artemis"
                    game.ReplaceHuman("lily artemis", human)
                + "Madeline Pumps"
                    game.ReplaceHuman("maddie", human)
                + "Power"
                    game.ReplaceHuman("power", human)
                + "Scarlet"
                    game.ReplaceHuman("scarlet", human)
                + "Yuffie Kisaragi"
                    game.ReplaceHuman("yuffie", human)
            + "5.8"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Dante"
                    game.ReplaceHuman("dante", human)
                + "Eva"
                    game.ReplaceHuman("eva", human)
                + "Juliet Starlight"
                    game.ReplaceHuman("juliet", human)
                + "Lady Alcina Dimitrescu"
                    game.ReplaceHuman("dimitrescu", human)
            + "5.9"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Chunli"
                    game.ReplaceHuman("chunli", human)
                + "Eve | Xmas"
                    game.ReplaceHuman("eve_xmas", human)
                + "Irelia"
                    game.ReplaceHuman("irelia", human)
                + "Tachy"
                    game.ReplaceHuman("tachy", human)
            + "5.91"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Artoria"
                    game.ReplaceHuman("artoria", human)
                + "Harley Quinn | Knight"
                    game.ReplaceHuman("harley quinn arkham", human)
                + "Kaine"
                    game.ReplaceHuman("kaine", human)
                + "Kasumi"
                    game.ReplaceHuman("kasumi", human)
            + "5.92"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Ada Wong - RE4"
                    game.ReplaceHuman("ada wong", "ada wong re4", human)
                + "Ashley - Maid"
                    game.ReplaceHuman("ashley maid", human)
                + "Nayo"
                    game.ReplaceHuman("nayo", human)
                + "Sombra"
                    game.ReplaceHuman("sombra", human)
            + "5.93"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Maelle"
                    game.ReplaceHuman("maelle", human)
                + "Makima"
                    game.ReplaceHuman("makima", human)
                + "Rosemary"
                    game.ReplaceHuman("rosemary", human)
            + "5.94"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Asuna"
                    game.ReplaceHuman("asuna", human)
                + "Claire Redfield"
                    game.ReplaceHuman("claire redfield", human)
                + "Male V"
                    game.ReplaceHuman("male v", human)
                + "Psylocke"
                    game.ReplaceHuman("psylocke", human)
            + "5.95"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Dark Elf"
                    game.ReplaceHuman("dark elf", human)
                + "Grace Ashcroft"
                    game.ReplaceHuman("grace ashcroft", human)
                + "Lune"
                    game.ReplaceHuman("lune", human)
                + "Marin Kitagaw"
                    game.ReplaceHuman("marin kitagawa", human)
            + "5.96"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Miya Ryona"
                    game.ReplaceHuman("miya ryona", human)
                + "Sara Moreau"
                    game.ReplaceHuman("sara moreau", human)
                + "Sheva Alomar"
                    game.ReplaceHuman("sheva alomar", human)
            + "5.97"[gold]
                + "<color=#9a646f><i>Done."
                + "<color=#54b095><i>Back."
                    Return(2)
                + "Daniela Dimitrescu"
                    game.ReplaceHuman("daniela dimitrescu", human)
                + "Juno"
                    game.ReplaceHuman("juno", human)
                + "Raven SB"
                    game.ReplaceHuman("raven stellarblade", human)
                + "Sylvanas"
                    game.ReplaceHuman("widowmaker sylvanas", human)
            + "<color=#54b095><i>Back."
                Return(2)
            + "<color=#9a646f><i>Done."
        + "<color=#54b095><i>Back."
            Return(2)
        + "<color=#9a646f><i>Done. | Replace Character"
    + "<color=#54b095><i>Back."
        Jump("fauna_LABS_Menu", human, hitTri)
    + "<color=#9a646f><i>Done."
stop