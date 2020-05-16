(set-logic SLIA)
(constraint (= (f "USD.EUR<IDEALPRO,CASH,EUR>") "EUR"))
(constraint (= (f "USD.EUR<IDEALPRO,CASH,USD>") "USD"))
(constraint (= (f "KOR.JPN<IDEALPRO,CASH,WON>") "WON"))
(constraint (= (f "KOR.JPN<IDEALPRO,CASH,YEN>") "YEN"))
(check-synth)
(synth-fun f ((_arg_0 String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (_arg_0)) (ConstString String (_arg_0 "" " " ">")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((_arg_0 String)) String (Str (SubStr _arg_0 (Pos _arg_0 "Alphabets" 4 0) (Pos _arg_0 "Alphabets" 4 1))))