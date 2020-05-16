(set-logic SLIA)
(constraint (= (f "yellow") true))
(constraint (= (f "gray") false))
(constraint (= (f "black") false))
(constraint (= (f "blue") true))
(constraint (= (f "pink") true))
(constraint (= (f "orange") true))
(constraint (= (f "turkey") false))
(check-synth)
(synth-fun f ((_arg_0 String)) Bool ((Start Bool (ntBool)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " " "yellow" "orange" "green" "blue" "pink")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))