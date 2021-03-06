(import tester :prefix "" :exit true)
(import "coupang" :prefix "")

(def ITEMS ``
-66,000원인출
0원 (잔액)
2020.09.19 (토) 16:05
KEB하나은행 **********4507
-34,000원결제
66,000원 (잔액)
2020.09.19 (토) 16:01
[결제] 내추럴발란스 드라이 캣 포뮬라 LID 완두&닭고기, 완두, 2.04kg, 10000081311576
100,000원충전
100,000원 (잔액)
2020.09.19 (토) 16:01
[잔액충전] 내추럴발란스 드라이 캣 포뮬라 LID 완두&닭고기, 완두, 2.04kg, 10000081311576
-90,810원인출
0원 (잔액)
2020.09.18 (금) 21:44
KEB하나은행 **********4507
-109,190원결제
90,810원 (잔액)
2020.09.18 (금) 21:43
[결제] 켈로그 크랜베리 아몬드 그래놀라, 550g, 1개 포함 총 3건, 10000081262247
200,000원충전
200,000원 (잔액)
2020.09.18 (금) 21:43
[잔액충전] 켈로그 크랜베리 아몬드 그래놀라, 550g, 1개 포함 총 3건, 10000081262247
-90,601원인출
0원 (잔액)
2020.09.15 (화) 22:12
KEB하나은행 **********4507
-27,087원결제
90,601원 (잔액)
2020.09.15 (화) 22:11
[결제] 곰곰 하남식쭈꾸미 보통매운맛 (냉동), 450g, 1개 포함 총 4건, 10000081017617
100,000원충전
117,688원 (잔액)
2020.09.15 (화) 22:11
[잔액충전] 곰곰 하남식쭈꾸미 보통매운맛 (냉동), 450g, 1개 포함 총 4건, 10000081017617
``)

(deftest
  (def SLICED (slice-items (split ITEMS)))
  (test "네 줄씩 쪼개야 한다"
        (is (= 9 (length SLICED))))
  (test "인출 타입을 얻을 수 있어야 한다"
        (is (= "인출" (parse-type (0 (0 SLICED))))))
  (test "결제 타입을 얻을 수 있어야 한다"
        (is (= "결제" (parse-type (0 (1 SLICED))))))
  (test "충전 타입을 얻을 수 있어야 한다"
        (is (= "충전" (parse-type (0 (2 SLICED))))))
  (test "충전은 소하나에서 빠지고 소쿠페이머니로 들어와야 한다"
        (is (=
              "소쿠페이머니+ 소하나- 쿠페이 충전"
              (type->whooing (0 (reformat (2 SLICED)))))))
  (test "인출은 소쿠페이머니에서 빠지고 소하나로 들어와야 한다"
        (is (=
              "소하나+ 소쿠페이머니- 쿠페이 인출"
              (type->whooing (0 (reformat (0 SLICED)))))))
  (test "결제는 소쿠페이머니에서 빠지고 기타로 들어와야 한다"
        (is (=
              "기타+ 소쿠페이머니- ?"
              (type->whooing (0 (reformat (1 SLICED)))))))
  (test "원본 그대로 주석이 되어야 한다"
        (is (=
              "-66,000원인출 0원 (잔액) 2020.09.19 (토) 16:05 KEB하나은행 **********4507"
              (5 (reformat (0 SLICED))))))
  (test "최종 모습"
        (is (=
              "2020-09-19 66000 소하나+ 소쿠페이머니- 쿠페이 인출 ;-66,000원인출 0원 (잔액) 2020.09.19 (토) 16:05 KEB하나은행 **********4507"
              (convert (0 SLICED))))))
