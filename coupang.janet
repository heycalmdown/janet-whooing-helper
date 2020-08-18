(import char)
(import util)

(def SOURCE ``
-36,240원결제 87,115원 (잔액) 2020.05.16 (토) 20:18 [결제] 현대메디칼 디스크 팡 4단 목 견인 의료기기, 1개, 10000071049815
100,000원충전 123,355원 (잔액) 2020.05.16 (토) 20:18 [잔액충전] 현대메디칼 디스크 팡 4단 목 견인 의료기기, 1개, 10000071049815
``)

(defn price->subject [price] (if (< (scan-number price) 0)
                               "기타+ 소쿠페이머니- ?"
                               "소쿠페이머니+ 소하나- 쿠페이 충전"))

(defn sanitize [cols]
  (put cols 0 (util/price (cols 0)))
  (put cols 3 (util/date (cols 3))))

(defn reorder [cols]
  (let [price (cols 0) date (cols 3)]
    @[date (util/string-abs price) (price->subject price) (string ";" (string/join cols " "))]))

(defn convert-line [line] (-> line
                              util/split-col
                              sanitize
                              reorder
                              util/join-col))

(defn split [source] (filter (comp not empty?) (string/split "\n" source)))

(defn convert! [source args]
  (each i (split source) (print (convert-line i))))


(defn main [_ & args]
  (convert! SOURCE args))
