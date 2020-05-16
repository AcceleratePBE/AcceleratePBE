(set-logic SLIA)
(constraint (= (f "An example string with _username in it RT _AwesomeUser says _username is awesome" "username") 2))
(constraint (= (f "An example string with _username in it RT _AwesomeUser says _username is awesome" "AwesomeUser") 1))
(constraint (= (f "An _example string with _example in it is awesome _example" "example") 3))
(check-synth)
(synth-fun f ((_arg_0 String) (_arg_1 String)) Int ((Start Int (ntInt)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0 _arg_1)) (ConstString String (_arg_0 _arg_1 "" " " "_")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))