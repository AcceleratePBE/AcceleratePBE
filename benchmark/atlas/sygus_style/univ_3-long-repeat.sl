(set-logic SLIA)
(constraint (= (f "UC Berkeley" "Berkeley, CA") "Berkeley, CA, USA"))
(constraint (= (f "University of Pennsylvania" "Phialdelphia, PA, USA") "Phialdelphia, PA, USA"))
(constraint (= (f "Cornell University" "Ithaca, New York, USA") "Ithaca, New York, USA"))
(constraint (= (f "Penn" "Philadelphia, PA, USA") "Philadelphia, PA, USA"))
(constraint (= (f "University of Michigan" "Ann Arbor, MI, USA") "Ann Arbor, MI, USA"))
(constraint (= (f "UC Berkeley" "Berkeley, CA") "Berkeley, CA, USA"))
(constraint (= (f "MIT" "Cambridge, MA") "Cambridge, MA, USA"))
(constraint (= (f "University of Pennsylvania" "Phialdelphia, PA, USA") "Phialdelphia, PA, USA"))
(constraint (= (f "UCLA" "Los Angeles, CA") "Los Angeles, CA, USA"))
(constraint (= (f "University of Maryland College Park" "College Park, MD") "College Park, MD, USA"))
(constraint (= (f "University of Michigan" "Ann Arbor, MI, USA") "Ann Arbor, MI, USA"))
(constraint (= (f "UC Berkeley" "Berkeley, CA") "Berkeley, CA, USA"))
(constraint (= (f "MIT" "Cambridge, MA") "Cambridge, MA, USA"))
(constraint (= (f "Rice University" "Houston, TX") "Houston, TX, USA"))
(constraint (= (f "Yale University" "New Haven, CT, USA") "New Haven, CT, USA"))
(constraint (= (f "Columbia University" "New York, NY, USA") "New York, NY, USA"))
(constraint (= (f "NYU" "New York, New York, USA") "New York, New York, USA"))
(constraint (= (f "Drexel University" "Philadelphia, PA") "Philadelphia, PA, USA"))
(constraint (= (f "UC Berkeley" "Berkeley, CA") "Berkeley, CA, USA"))
(constraint (= (f "UIUC" "Urbana, IL") "Urbana, IL, USA"))
(constraint (= (f "Temple University" "Philadelphia, PA") "Philadelphia, PA, USA"))
(constraint (= (f "Harvard University" "Cambridge, MA, USA") "Cambridge, MA, USA"))
(constraint (= (f "University of Connecticut" "Storrs, CT, USA") "Storrs, CT, USA"))
(constraint (= (f "Drexel University" "Philadelphia, PA") "Philadelphia, PA, USA"))
(constraint (= (f "NYU" "New York, New York, USA") "New York, New York, USA"))
(constraint (= (f "UIUC" "Urbana, IL") "Urbana, IL, USA"))
(constraint (= (f "New Haven University" "New Haven, CT, USA") "New Haven, CT, USA"))
(constraint (= (f "University of California, Santa Barbara" "Santa Barbara, CA, USA") "Santa Barbara, CA, USA"))
(constraint (= (f "University of Connecticut" "Storrs, CT, USA") "Storrs, CT, USA"))
(check-synth)
(synth-fun f ((col1 String) (col2 String)) String ((Start String (ntString)) (ntString String ((Str A) (str.++ ntString A))) (A String ((Str ConstString) (SubStr X P P))) (P Int ((Int ntInt) (Pos X Pattern ntInt Direction))) (Pattern String ((Str ConstString) "ProperCase" "CAPS" "lowercase" "Digits" "Alphabets" "Alphanumeric" "WhiteSpace" "ProperCaseWSpaces" "CAPSWSpaces" "lowercaseSpaces" "AlphabetsWSpaces")) (X String (col1 col2)) (ConstString String (col1 col2 " " "," "USA" "PA" "CT" "CA" "MD" "NY")) (Direction Int (0 1)) (ntInt Int (-5 -4 -3 -2 -1 0 1 2 3 4 5))))
