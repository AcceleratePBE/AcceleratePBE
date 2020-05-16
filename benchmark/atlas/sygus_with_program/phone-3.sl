(set-logic SLIA)
(constraint (= (f "938-242-504") "(938) 242-504"))
(constraint (= (f "308-916-545") "(308) 916-545"))
(constraint (= (f "623-599-749") "(623) 599-749"))
(constraint (= (f "981-424-843") "(981) 424-843"))
(constraint (= (f "118-980-214") "(118) 980-214"))
(constraint (= (f "244-655-094") "(244) 655-094"))
(constraint (= (f "830-941-991") "(830) 941-991"))
(check-synth)
(synth-fun f ((name String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (name)) (ConstString String (name " " "(" ")" "-")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((name String)) String (str.++ (str.++ (str.++ (str.++ (Str (Str "(")) (SubStr name (Int 0) (Int 2))) (Str ")")) (Str " ")) (SubStr name (Int 4) (Pos name "Alphanumeric" 2 1))))
