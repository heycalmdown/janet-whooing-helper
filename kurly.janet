(import util)

(def SOURCE ``
[맛있게 한끼] 국산콩 두부 (찌개용)
1,900원 1개 구매
배송준비중	장바구니 담기
	
참타리버섯 100g
950원 1개 구매
배송준비중	장바구니 담기
	
[KF365] 깐마늘 200g
1,980원 1개 구매
배송준비중	장바구니 담기
	
게르마늄 무농약 컬러 방울토마토 500g
15,800원 2개 구매
``)

(defn price-only [line]  (util/price (0 (string/split " " line))))

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