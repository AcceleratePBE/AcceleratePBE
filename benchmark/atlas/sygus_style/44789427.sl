(set-logic SLIA)
(constraint (= (f "1/17/16-1/18/17" 1) "1/17/16"))
(constraint (= (f "1/17/16-1/18/17" 2) "1/18/17"))
(constraint (= (f "01/17/2016-01/18/2017" 1) "01/17/2016"))
(constraint (= (f "01/17/2016-01/18/2017" 2) "01/18/2017"))
(check-synth)
(synth-fun f ((_arg_0 String) (_arg_1 Int)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " " "-")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5 _arg_1))))
