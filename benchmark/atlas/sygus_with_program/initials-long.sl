(set-logic SLIA)
(constraint (= (f "Nancy FreeHafer") "N.F."))
(constraint (= (f "Andrew Cencici") "A.C."))
(constraint (= (f "Jan Kotas") "J.K."))
(constraint (= (f "Mariya Sergienko") "M.S."))
(constraint (= (f "Launa Withers") "L.W."))
(constraint (= (f "Lakenya Edison") "L.E."))
(constraint (= (f "Brendan Hage") "B.H."))
(constraint (= (f "Bradford Lango") "B.L."))
(constraint (= (f "Rudolf Akiyama") "R.A."))
(constraint (= (f "Lara Constable") "L.C."))
(constraint (= (f "Madelaine Ghoston") "M.G."))
(constraint (= (f "Salley Hornak") "S.H."))
(constraint (= (f "Micha Junkin") "M.J."))
(constraint (= (f "Teddy Bobo") "T.B."))
(constraint (= (f "Coralee Scalia") "C.S."))
(constraint (= (f "Jeff Quashie") "J.Q."))
(constraint (= (f "Vena Babiarz") "V.B."))
(constraint (= (f "Karrie Lain") "K.L."))
(constraint (= (f "Tobias Dermody") "T.D."))
(constraint (= (f "Celsa Hopkins") "C.H."))
(constraint (= (f "Kimberley Halpern") "K.H."))
(constraint (= (f "Phillip Rowden") "P.R."))
(constraint (= (f "Elias Neil") "E.N."))
(constraint (= (f "Lashanda Cortes") "L.C."))
(constraint (= (f "Mackenzie Spell") "M.S."))
(constraint (= (f "Kathlyn Eccleston") "K.E."))
(constraint (= (f "Georgina Brescia") "G.B."))
(constraint (= (f "Beata Miah") "B.M."))
(constraint (= (f "Desiree Seamons") "D.S."))
(constraint (= (f "Jeanice Soderstrom") "J.S."))
(constraint (= (f "Mariel Jurgens") "M.J."))
(constraint (= (f "Alida Bogle") "A.B."))
(constraint (= (f "Jacqualine Olague") "J.O."))
(constraint (= (f "Joaquin Clasen") "J.C."))
(constraint (= (f "Samuel Richert") "S.R."))
(constraint (= (f "Malissa Marcus") "M.M."))
(constraint (= (f "Alaina Partida") "A.P."))
(constraint (= (f "Trinidad Mulloy") "T.M."))
(constraint (= (f "Carlene Garrard") "C.G."))
(constraint (= (f "Melodi Chism") "M.C."))
(constraint (= (f "Bess Chilcott") "B.C."))
(constraint (= (f "Chong Aylward") "C.A."))
(constraint (= (f "Jani Ramthun") "J.R."))
(constraint (= (f "Jacquiline Heintz") "J.H."))
(constraint (= (f "Hayley Marquess") "H.M."))
(constraint (= (f "Andria Spagnoli") "A.S."))
(constraint (= (f "Irwin Covelli") "I.C."))
(constraint (= (f "Gertude Montiel") "G.M."))
(constraint (= (f "Stefany Reily") "S.R."))
(constraint (= (f "Rae Mcgaughey") "R.M."))
(constraint (= (f "Cruz Latimore") "C.L."))
(constraint (= (f "Maryann Casler") "M.C."))
(constraint (= (f "Annalisa Gregori") "A.G."))
(constraint (= (f "Jenee Pannell") "J.P."))
(check-synth)
(synth-fun f ((name String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (name)) (ConstString String (name " " ".")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((name String)) String (str.++ (str.++ (str.++ (Str (SubStr name (Int 0) (Int 0))) (Str ".")) (SubStr name (Pos name "Alphabets" 1 0) (Pos name "Alphabets" 1 0))) (Str ".")))
