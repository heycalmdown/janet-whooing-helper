(import tester :prefix "" :exit true)
(import "kurly" :prefix "")

(def kurly-item ``
당도선별 고당도 수박 6kg
20,900원 1개 구매
배송완료	
후기쓰기
장바구니 담기
``)

(def kurly-items ``
당도선별 고당도 수박 6kg
20,900원 1개 구매
배송완료	
후기쓰기
장바구니 담기
	
[KF365] 애호박 1개
990원 1개 구매
배송완료	
후기쓰기
장바구니 담기``)

(def item-with-garbage ``
[크레이브푸드] 콥 샐러드 240g
할인가5,865 원 판매가 6,900 원 1개 구매
배송완료	
후기쓰기
장바구니 담기
[오팡두] 데니쉬 식빵 2종

[오팡두] 데니쉬 식빵 플레인
할인가5,865 원 판매가 6,900 원 1개 구매
배송완료	
후기쓰기
장바구니 담기
``)

(deftest
  (test "kurly->whooing"
        (is (= "오늘 식재료(당도선별 고당도 수박 6kg) 20900 -식비 -네이버페이포인트" (kurly->whooing kurly-item "오늘"))))
  (test "grouping"
        (is (= 2 (length (kurly-split-items kurly-items)))))
  (test "간헐적 6줄 등장해도 처리할 수 있어야 함"
        (is (= "오늘 식재료([크레이브푸드] 콥 샐러드 240g) 5865 -식비 -네이버페이포인트" (kurly->whooing item-with-garbage "오늘"))))
  (test "not allowed parenthesis"
        (is (= "무항생제 1등급 암퇘지 삼겹 찌개용 200g[냉장]" (paren->square "무항생제 1등급 암퇘지 삼겹 찌개용 200g(냉장)")))))
