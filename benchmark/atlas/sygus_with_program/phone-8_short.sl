(set-logic SLIA)
(constraint (= (f "+106 769-858-438") "438"))
(constraint (= (f "+83 973-757-831") "831"))
(constraint (= (f "+62 647-787-775") "775"))
(constraint (= (f "+172 027-507-632") "632"))
(constraint (= (f "+72 001-050-856") "856"))
(constraint (= (f "+95 310-537-401") "401"))
(constraint (= (f "+6 775-969-238") "238"))
(check-synth)
(synth-fun f ((name String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (name)) (ConstString String (name " " "+" "-" ".")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((name String)) String (Str (SubStr name (Pos name "Alphanumeric" 3 0) (Pos name "Alphanumeric" 3 1))))
