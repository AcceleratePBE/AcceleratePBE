(set-logic SLIA)
(constraint (= (f "Chang,Amy" 1) "Amy"))
(constraint (= (f "Chang,Amy" 2) "Chang"))
(constraint (= (f "smith,bobby" 2) "smith"))
(constraint (= (f "smith,bobby" 1) "bobby"))
(check-synth)
(synth-fun f ((_arg_0 String) (_arg_1 Int)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " " ",")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5 _arg_1))))