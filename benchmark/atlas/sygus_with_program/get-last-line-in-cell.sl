(set-logic SLIA)
(constraint (= (f "11/1/2015 - First call/n12/3/2015-order placed/n11/15/2015-follow-up,interested") "11/15/2015-follow-up,interested"))
(constraint (= (f "11/1/2015 - First call/n12/3/2015-order placed") "12/3/2015-order placed"))
(constraint (= (f "11/1/2015 - First call") "11/1/2015 - First call"))
(check-synth)
(synth-fun f ((_arg_0 String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " " "/n")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((_arg_0 String)) String (Str (SubStr _arg_0 (Pos _arg_0 "Digits" -3 0) (Pos _arg_0 "Alphabets" -1 1))))
