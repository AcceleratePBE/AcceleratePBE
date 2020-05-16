(set-logic SLIA)
(constraint (= (f "Launa" "Withers") "L. Withers"))
(constraint (= (f "Lakenya" "Edison") "L. Edison"))
(constraint (= (f "Brendan" "Hage") "B. Hage"))
(constraint (= (f "Bradford" "Lango") "B. Lango"))
(constraint (= (f "Rudolf" "Akiyama") "R. Akiyama"))
(constraint (= (f "Lara" "Constable") "L. Constable"))
(constraint (= (f "Madelaine" "Ghoston") "M. Ghoston"))
(constraint (= (f "Salley" "Hornak") "S. Hornak"))
(constraint (= (f "Micha" "Junkin") "M. Junkin"))
(constraint (= (f "Teddy" "Bobo") "T. Bobo"))
(constraint (= (f "Coralee" "Scalia") "C. Scalia"))
(constraint (= (f "Jeff" "Quashie") "J. Quashie"))
(constraint (= (f "Vena" "Babiarz") "V. Babiarz"))
(constraint (= (f "Karrie" "Lain") "K. Lain"))
(constraint (= (f "Tobias" "Dermody") "T. Dermody"))
(constraint (= (f "Celsa" "Hopkins") "C. Hopkins"))
(constraint (= (f "Kimberley" "Halpern") "K. Halpern"))
(constraint (= (f "Phillip" "Rowden") "P. Rowden"))
(constraint (= (f "Elias" "Neil") "E. Neil"))
(constraint (= (f "Lashanda" "Cortes") "L. Cortes"))
(constraint (= (f "Mackenzie" "Spell") "M. Spell"))
(constraint (= (f "Kathlyn" "Eccleston") "K. Eccleston"))
(constraint (= (f "Georgina" "Brescia") "G. Brescia"))
(constraint (= (f "Beata" "Miah") "B. Miah"))
(constraint (= (f "Desiree" "Seamons") "D. Seamons"))
(constraint (= (f "Jeanice" "Soderstrom") "J. Soderstrom"))
(constraint (= (f "Mariel" "Jurgens") "M. Jurgens"))
(constraint (= (f "Alida" "Bogle") "A. Bogle"))
(constraint (= (f "Jacqualine" "Olague") "J. Olague"))
(constraint (= (f "Joaquin" "Clasen") "J. Clasen"))
(constraint (= (f "Samuel" "Richert") "S. Richert"))
(constraint (= (f "Malissa" "Marcus") "M. Marcus"))
(constraint (= (f "Alaina" "Partida") "A. Partida"))
(constraint (= (f "Trinidad" "Mulloy") "T. Mulloy"))
(constraint (= (f "Carlene" "Garrard") "C. Garrard"))
(constraint (= (f "Melodi" "Chism") "M. Chism"))
(constraint (= (f "Bess" "Chilcott") "B. Chilcott"))
(constraint (= (f "Chong" "Aylward") "C. Aylward"))
(constraint (= (f "Jani" "Ramthun") "J. Ramthun"))
(constraint (= (f "Jacquiline" "Heintz") "J. Heintz"))
(constraint (= (f "Hayley" "Marquess") "H. Marquess"))
(constraint (= (f "Andria" "Spagnoli") "A. Spagnoli"))
(constraint (= (f "Irwin" "Covelli") "I. Covelli"))
(constraint (= (f "Gertude" "Montiel") "G. Montiel"))
(constraint (= (f "Stefany" "Reily") "S. Reily"))
(constraint (= (f "Rae" "Mcgaughey") "R. Mcgaughey"))
(constraint (= (f "Cruz" "Latimore") "C. Latimore"))
(constraint (= (f "Maryann" "Casler") "M. Casler"))
(constraint (= (f "Annalisa" "Gregori") "A. Gregori"))
(constraint (= (f "Jenee" "Pannell") "J. Pannell"))
(check-synth)
(synth-fun f ((firstname String) (lastname String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (firstname lastname)) (ConstString String (firstname lastname " " ".")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((firstname String) (lastname String)) String (str.++ (str.++ (str.++ (Str (SubStr firstname (Int 0) (Int 0))) (Str ".")) (Str " ")) (Str lastname)))