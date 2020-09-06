(import tester :prefix "" :exit true)
(import "util" :prefix "")

(deftest
  (test "rest-omit-first-elem"
        (is (= [1 2] (rest ;[0 1 2])))))
