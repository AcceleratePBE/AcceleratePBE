(set-logic SLIA)
(constraint (= (f "011016_assignment.xlsx" 1) "011016"))
(constraint (= (f "011016_assignment.xlsx" 2) "assignment.xlsx"))
(constraint (= (f "030116_cost.xlsx" 1) "030116"))
(constraint (= (f "030116_cost.xlsx" 2) "cost.xlsx"))
(check-synth)
(synth-fun f ((_arg_0 String) (_arg_1 Int)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " " "_")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5 _arg_1))))
