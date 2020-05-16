(set-logic SLIA)
(constraint (= (f "cat" "dog" "cat") "cat"))
(constraint (= (f "blue" "red" "red") "red"))
(constraint (= (f "firm" "firm" "soft") "firm"))
(constraint (= (f "soft" "soft" "soft") "soft"))
(check-synth)
(synth-fun f ((_arg_0 String) (_arg_1 String) (_arg_2 String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0 _arg_1 _arg_2)) (ConstString String (_arg_0 _arg_1 _arg_2 "" " ")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
