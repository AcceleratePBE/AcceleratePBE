(set-logic SLIA)
(constraint (= (f "University of Pennsylvania" "Phialdelphia, PA, USA") "University of Pennsylvania, Phialdelphia, PA, USA"))
(constraint (= (f "UCLA" "Los Angeles, CA") "UCLA, Los Angeles, CA, USA"))
(constraint (= (f "Cornell University" "Ithaca, New York, USA") "Cornell University, Ithaca, New York, USA"))
(constraint (= (f "Penn" "Philadelphia, PA, USA") "Penn, Philadelphia, PA, USA"))
(constraint (= (f "University of Maryland College Park" "College Park, MD") "University of Maryland College Park, College Park, MD, USA"))
(constraint (= (f "University of Michigan" "Ann Arbor, MI, USA") "University of Michigan, Ann Arbor, MI, USA"))
(constraint (= (f "UC Berkeley" "Berkeley, CA") "UC Berkeley, Berkeley, CA, USA"))
(constraint (= (f "MIT" "Cambridge, MA") "MIT, Cambridge, MA, USA"))
(constraint (= (f "Rice University" "Houston, TX") "Rice University, Houston, TX, USA"))
(constraint (= (f "Yale University" "New Haven, CT, USA") "Yale University, New Haven, CT, USA"))
(constraint (= (f "Columbia University" "New York, NY, USA") "Columbia University, New York, NY, USA"))
(constraint (= (f "NYU" "New York, New York, USA") "NYU, New York, New York, USA"))
(constraint (= (f "UC Berkeley" "Berkeley, CA") "UC Berkeley, Berkeley, CA, USA"))
(constraint (= (f "UIUC" "Urbana, IL") "UIUC, Urbana, IL, USA"))
(constraint (= (f "Temple University" "Philadelphia, PA") "Temple University, Philadelphia, PA, USA"))
(constraint (= (f "Harvard University" "Cambridge, MA, USA") "Harvard University, Cambridge, MA, USA"))
(constraint (= (f "University of Connecticut" "Storrs, CT, USA") "University of Connecticut, Storrs, CT, USA"))
(constraint (= (f "Drexel University" "Philadelphia, PA") "Drexel University, Philadelphia, PA, USA"))
(constraint (= (f "New Haven University" "New Haven, CT, USA") "New Haven University, New Haven, CT, USA"))
(constraint (= (f "University of California, Santa Barbara" "Santa Barbara, CA, USA") "University of California, Santa Barbara, Santa Barbara, CA, USA"))
(check-synth)
(synth-fun f ((col1 String) (col2 String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (col1 col2)) (ConstString String (col1 col2 " " "," "USA" "PA" "CT" "CA" "MD" "NY")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
(define-fun ResFun ((col1 String) (col2 String)) String (str.++ (str.++ (str.++ (str.++ (str.++ (str.++ (Str (Str col1)) (Str ",")) (Str " ")) (SubStr col2 (Int 0) (Pos col2 "AlphabetsWSpaces" 1 1))) (Str ",")) (Str " ")) (Str "USA")))
