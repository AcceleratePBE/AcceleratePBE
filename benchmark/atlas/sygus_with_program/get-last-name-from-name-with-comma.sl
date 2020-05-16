(set-logic SLIA)
(constraint (= (f "chang,amy") "amy,chang"))
(constraint (= (f "smith,bobby") "bobby,smith"))
(constraint (= (f "lennox,aaron") "aaron,lennox"))
(check-synth)
(synth-fun f ((_arg_0 String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " " ",")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((_arg_0 String)) String (str.++ (str.++ (Str (SubStr _arg_0 (Pos _arg_0 "Alphabets" 1 0) (Pos _arg_0 "Alphabets" 1 1))) (Str ",")) (SubStr _arg_0 (Int 0) (Pos _arg_0 "Alphabets" 0 1))))