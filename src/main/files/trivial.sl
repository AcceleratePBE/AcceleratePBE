
(set-logic BV)


(define-fun origCir ( (LN8 Bool) (k4 Bool) (LN17 Bool) (LN100 Bool)  )  Bool
          (xor LN8 k4)
)


(synth-fun skel ( (LN8 Bool) (k4 Bool) (LN17 Bool) (LN100 Bool)  )  Bool
          ((Start Bool (
		                                  (and depth1 depth1)
		                                  (not depth1)
		                                  (or depth1 depth1)
		                                  (xor depth1 depth1)
          ))
          (depth1 Bool (LN8 k4 LN17 LN100
          ))
          )
)


(declare-var LN8 Bool)
(declare-var k4 Bool)
(declare-var LN17 Bool)
(declare-var LN100 Bool)

(constraint (= (origCir LN8 k4 LN17 LN100 ) (skel LN8 k4 LN17 LN100 )))


(check-synth)
