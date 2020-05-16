(set-logic SLIA)
(constraint (= (f "apple" "apple") true))
(constraint (= (f "orange" "Orange") false))
(constraint (= (f "peach" "peach") true))
(constraint (= (f "cherry" "cherrY") false))
(check-synth)
(synth-fun f ((_arg_0 String) (_arg_1 String)) Bool ((Start Bool (ntBool)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0 _arg_1)) (ConstString String (_arg_0 _arg_1 "" " ")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))