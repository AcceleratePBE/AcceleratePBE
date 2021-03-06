(set-logic SLIA)
(constraint (= (f "Launa" "Withers") "Launa Withers"))
(constraint (= (f "Lakenya" "Edison") "Lakenya Edison"))
(constraint (= (f "Brendan" "Hage") "Brendan Hage"))
(constraint (= (f "Bradford" "Lango") "Bradford Lango"))
(constraint (= (f "Rudolf" "Akiyama") "Rudolf Akiyama"))
(constraint (= (f "Lara" "Constable") "Lara Constable"))
(constraint (= (f "Madelaine" "Ghoston") "Madelaine Ghoston"))
(constraint (= (f "Salley" "Hornak") "Salley Hornak"))
(constraint (= (f "Micha" "Junkin") "Micha Junkin"))
(constraint (= (f "Teddy" "Bobo") "Teddy Bobo"))
(constraint (= (f "Coralee" "Scalia") "Coralee Scalia"))
(constraint (= (f "Jeff" "Quashie") "Jeff Quashie"))
(constraint (= (f "Vena" "Babiarz") "Vena Babiarz"))
(constraint (= (f "Karrie" "Lain") "Karrie Lain"))
(constraint (= (f "Tobias" "Dermody") "Tobias Dermody"))
(constraint (= (f "Celsa" "Hopkins") "Celsa Hopkins"))
(constraint (= (f "Kimberley" "Halpern") "Kimberley Halpern"))
(constraint (= (f "Phillip" "Rowden") "Phillip Rowden"))
(constraint (= (f "Elias" "Neil") "Elias Neil"))
(constraint (= (f "Lashanda" "Cortes") "Lashanda Cortes"))
(constraint (= (f "Mackenzie" "Spell") "Mackenzie Spell"))
(constraint (= (f "Kathlyn" "Eccleston") "Kathlyn Eccleston"))
(constraint (= (f "Georgina" "Brescia") "Georgina Brescia"))
(constraint (= (f "Beata" "Miah") "Beata Miah"))
(constraint (= (f "Desiree" "Seamons") "Desiree Seamons"))
(constraint (= (f "Jeanice" "Soderstrom") "Jeanice Soderstrom"))
(constraint (= (f "Mariel" "Jurgens") "Mariel Jurgens"))
(constraint (= (f "Alida" "Bogle") "Alida Bogle"))
(constraint (= (f "Jacqualine" "Olague") "Jacqualine Olague"))
(constraint (= (f "Joaquin" "Clasen") "Joaquin Clasen"))
(constraint (= (f "Samuel" "Richert") "Samuel Richert"))
(constraint (= (f "Malissa" "Marcus") "Malissa Marcus"))
(constraint (= (f "Alaina" "Partida") "Alaina Partida"))
(constraint (= (f "Trinidad" "Mulloy") "Trinidad Mulloy"))
(constraint (= (f "Carlene" "Garrard") "Carlene Garrard"))
(constraint (= (f "Melodi" "Chism") "Melodi Chism"))
(constraint (= (f "Bess" "Chilcott") "Bess Chilcott"))
(constraint (= (f "Chong" "Aylward") "Chong Aylward"))
(constraint (= (f "Jani" "Ramthun") "Jani Ramthun"))
(constraint (= (f "Jacquiline" "Heintz") "Jacquiline Heintz"))
(constraint (= (f "Hayley" "Marquess") "Hayley Marquess"))
(constraint (= (f "Andria" "Spagnoli") "Andria Spagnoli"))
(constraint (= (f "Irwin" "Covelli") "Irwin Covelli"))
(constraint (= (f "Gertude" "Montiel") "Gertude Montiel"))
(constraint (= (f "Stefany" "Reily") "Stefany Reily"))
(constraint (= (f "Rae" "Mcgaughey") "Rae Mcgaughey"))
(constraint (= (f "Cruz" "Latimore") "Cruz Latimore"))
(constraint (= (f "Maryann" "Casler") "Maryann Casler"))
(constraint (= (f "Annalisa" "Gregori") "Annalisa Gregori"))
(constraint (= (f "Jenee" "Pannell") "Jenee Pannell"))
(check-synth)
(synth-fun f ((firstname String) (lastname String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (firstname lastname)) (ConstString String (firstname lastname " ")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((firstname String) (lastname String)) String (str.++ (str.++ (Str (Str firstname)) (Str " ")) (Str lastname)))
