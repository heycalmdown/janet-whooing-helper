(import util)

(def SOURCE ``
[전통부산어묵 by.고래사] 모둠 어묵 270g
판매가9,000원 2개 구매
배송완료	
후기쓰기
장바구니 담기

[남도우애] 무항생제 1++ 한우 정육 국거리용 200g(냉장)
판매가15,000원 1개 구매
배송완료	
후기쓰기
장바구니 담기
``)

(defn price-only [line] (util/price (0 (string/split " " line))))

(defn paren->square [s] (string/replace-all ")" "]" (string/replace-all "(" "[" s)))

(defn kurly->whooing [x date]
  (let [lines (string/split "\n" x)
        subj (paren->square (0 lines))
        price (price-only (lines 1))]
    (string/join [date " 식재료(" subj ") " price " -식비 -네이버페이포인트"])))

(defn kurly-split-items [x]
  (string/split "\n\n" x))

(defn main [_ & args]
  (let [date (if (empty? args) "오늘" (args 0))]
    (each i (kurly-split-items SOURCE) (print (kurly->whooing i date)))))
