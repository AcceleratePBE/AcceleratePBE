(set-logic SLIA)
(constraint (= (f "Tire Pressure ABC123873 Monitor") "ABC123873"))
(constraint (= (f " Oil Life ABC849999999021 gauge") "ABC849999999021"))
(constraint (= (f " Air conditioner GHF211 maintenance") "GHF211"))
(check-synth)
(synth-fun f ((_arg_0 String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " ")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
