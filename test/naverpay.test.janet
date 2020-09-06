(import tester :prefix "" :exit true)
(import "naverpay" :prefix "")

(def DIRTY-ITEMS ``
2020.09.06
이벤트 적립
충전포인트 결제(네이버통장)
+369원
내역삭제
사용
2020.09.05
결제 시 사용
배달의민족
-18,400원
내역삭제
적립
``)

(def SANITIZED-ITEMS ``
사용
2020.09.05
결제 시 사용
배달의민족
-18,400원
내역삭제
적립
``)

(deftest
  (test "find-start-line"
        (is (deep= (split "적립") (sanitize (split "2020.09\n적립")))))
  (test "handle-broken-items"
        (is (deep= (split SANITIZED-ITEMS) (sanitize (split DIRTY-ITEMS)))))
  (test "slice-items"
        (is (= 1 (length (slice-items (split SANITIZED-ITEMS))))))
  (test "convert-an-item"
        (is (= "2020-09-05 18400 기타+ 네이버페이포인트- ? ;사용 2020-09-05 -18400 결제 시 사용 배달의민족" (convert (split "사용\n2020.09.05\n결제 시 사용\n배달의민족\n-18,400원\n내역삭제"))))))
