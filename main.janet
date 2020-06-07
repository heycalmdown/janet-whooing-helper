(import char)

(def SOURCE ``
-36,240원결제 87,115원 (잔액) 2020.05.16 (토) 20:18 [결제] 현대메디칼 디스크 팡 4단 목 견인 의료기기, 1개, 10000071049815
100,000원충전 123,355원 (잔액) 2020.05.16 (토) 20:18 [잔액충전] 현대메디칼 디스크 팡 4단 목 견인 의료기기, 1개, 10000071049815
``)

(defn price [str] (string (char/atoi str)))
(defn date [str] (string/replace-all "." "-" str))
(defn price->subject [price cols] (string
  (if (< (scan-number price) 0)
  "기타+ 쿠페이머니- ?" "쿠페이머니+ 하나- 쿠페이 충전") ";"
  (string/join cols " ")))

(defn sanitize [cols]
  (put cols 0 (price (cols 0)))
  (put cols 3 (date (cols 3))))

(defn reorder [cols]
  (let [price (cols 0) date (cols 3)]
    @[date (string (math/abs (scan-number price))) (price->subject price cols)]))

(defn split-col [line] (string/split " " line))
(defn join-col [cols] (string/join cols " "))

(defn convert [line] (-> line
  split-col
  sanitize
  reorder
  join-col))

(each i (string/split "\n" SOURCE) (print (convert i)))
