--fauna_LABS_v1.02

label faunap_presets_Menu(human, hitTri)
    + "outfit.."[gold]
        + "<color=#9a646f><i>Done."
        + "<color=#54b095><i>Back."
            Return(2)
        + "2b"
            game.ReplaceClothing(human, "2b")
        + "Aunt Cass"
            game.ReplaceClothing(human, "aunt cass")
        + "Cindy Aurum"
            game.ReplaceClothing(human, "cindy aurum")
        + "Hailey"
            game.ReplaceClothing(human, "hailey")
        + "Marie Rose"
            game.ReplaceClothing(human, "marie rose")
        + "Pharah"
            game.ReplaceClothing(human, "pharah")
        + "Primrose Office"
            game.ReplaceClothing(human, "Primrose Office")
        + "Queen"
            game.ReplaceClothing(human, "Queen")
        + "Tifa"
            game.ReplaceClothing(human, "tifa")
        + "Yennefer"
            game.ReplaceClothing(human, "yennefer")
    + "Summon.."[gold]
        + "A-M.."[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "Aerith - Aunt Cass"
                actor = Human(girl, "aerith", "aunt cass")
                Return()
            + "Aerith - Pharah"
                actor = Human(girl, "aerith", "pharah")
                Return()
            + "DVa - Cindy Aurum"
                actor = Human(girl, "dva", "cindy aurum")
                Return()
            + "Harley Quinn"
                actor = Human(girl, "harley quinn")
                Return()
            + "Marie Rose - 2b"
                actor = Human(girl, "marie rose", "2b")
                Return()
            + "Mercy - Pharah"
                actor = Human(girl, "mercy", "pharah")
                Return()
            + "MrX"
                actor = Human(girl, "mrx")
                Return()
        + "N-Z.."[gold]
            + "<color=#9a646f><i>Done."
            + "<color=#54b095><i>Back."
                Return(2)
            + "Nyotengu - Pharah"
                actor = Human(girl, "nyotengu", "pharah")
                Return()
            + "Rangiku - Queen"
                actor = Human(girl, "rangiku", "Queen")
                Return()
            + "Raven - Mrx"
                actor = Human(girl, "raven", "mrx")
                Return()
            + "Tifa!"
                actor = Human(girl, "tifa")
                Return()
            + "Tifa - Pharah"
                actor = Human(girl, "tifa", "pharah")
                Return()
            + "Tracer - Hailey"
                actor = Human(girl, "tracer", "hailey")
                Return()
            + "Yennefer"
                actor = Human(girl, "yennefer")
                Return()
            + "Yennefer - Queen"
                actor = Human(girl, "yennefer", "Queen")
                Return()
            + "Y'shtola - Aunt Cass"
                actor = Human(girl, "y'shtola", "aunt cass")
                Return()
            + "Y'shtola - Black Cat"
                actor = Human(girl, "y'shtola", "black cat")
                Return()
            + "Y'shtola - Queen"
                actor = Human(girl, "y'shtola", "Queen")
                Return()
        + "<color=#54b095><i>Back."
            Return(2)
        + "<color=#9a646f><i>Done."
    + "Body.."[gold]
        + "Slim"
            human.Body("Ass size", -0.85, "Waist size", -0.25, "Hips size", -0.25, "Thigh size", -0.2)
            Return()
        + "Slim^"
            human.Body("Ass size", -0.7, "Waist size", -0.125, "Hips size", -0.125, "Thigh size", -0.18)
            Return()
        + "<color=#54b095><i>Back."
            Return(2)
        + "<color=#9a646f><i>Done."
    + "Cum.."[gold]
        + "Faunap Custom"
            human.Body("Fluid speed", 1, "Fluid spread", 1.2, "Fluid amount", -0.4, "Fluid force", 1, "Fluid gravity", 2)
            Return()
        + "Default - Max"
            human.Body("Fluid speed", 1, "Fluid spread", 1.2, "Fluid amount", 2, "Fluid force", 1, "Fluid gravity", 2)
            Return()
        + "Max x 2"
            human.Body("Fluid speed", 2, "Fluid spread", 1.2, "Fluid amount", 4, "Fluid force", 2, "Fluid gravity", 4)
            Return()
        + "Max x 4"
            human.Body("Fluid speed", 4, "Fluid spread", 1.2, "Fluid amount", 8, "Fluid force", 4, "Fluid gravity", 8)
            Return()
        + "Max x 8"
            human.Body("Fluid speed", 8, "Fluid spread", 1.2, "Fluid amount", 16, "Fluid force", 8, "Fluid gravity", 16)
            Return()
        + "<color=#54b095><i>Back."
            Return(2)
        + "<color=#9a646f><i>Done."
    + "<color=#54b095><i>Back."
        Jump("fauna_LABS_Menu", human, hitTri)
    + "<color=#9a646f><i>Done."
stop

-- -- Initialize a table to store actors
-- local actors = {}
-- local actorIndex = 1 -- Start with 'A'

-- label Presets_Menu(human, hitTri)
--     + "Summon.."[gold]
--         + "Tifa!"
--             actors[actorIndex] = Human(girl, "tifa")
--             actorIndex = actorIndex + 1 -- Increment the index
--             Return()
--         + "Aerith!"
--             actors[actorIndex] = Human(girl, "aerith", "pharah")
--             actorIndex = actorIndex + 1 -- Increment the index
--             Return()
--         -- Add more options as needed