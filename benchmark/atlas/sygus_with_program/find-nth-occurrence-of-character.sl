(set-logic SLIA)
(constraint (= (f "replies to _aya, _tasisuke, and _chan" 1) 12))
(constraint (= (f "replies to _aya, _tasisuke, and _chan" 2) 18))
(constraint (= (f "replies to _aya, _tasisuke, and _chan" 3) 33))
(check-synth)
(synth-fun f ((_arg_0 String) (_arg_1 Int)) Int ((Start Int (ntInt)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " " "_")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5 _arg_1))))
