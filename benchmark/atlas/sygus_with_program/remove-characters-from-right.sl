(set-logic SLIA)
(constraint (= (f "736 miles") "736"))
(constraint (= (f "1255 miles") "1255"))
(constraint (= (f "1221 miles") "1221"))
(constraint (= (f "790 miles") "790"))
(check-synth)
(synth-fun f ((_arg_0 String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " ")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((_arg_0 String)) String (Str (SubStr _arg_0 (Int 0) (Pos _arg_0 "Alphanumeric" 0 1))))
