(import char)
(import util)

(def SOURCE ``
적립 2020.07.12 이벤트 적립 충전포인트 결제(네이버통장) +749원 내역삭제
적립 2020.07.12 이벤트 적립 충전포인트 결제(네이버통장) +2,549원 내역삭제
사용 2020.07.11 결제 시 사용 배달의민족 -56,900원 내역삭제
적립 2020.07.11 구매 적립예정 배달의민족 +284원 내역삭제
``)

(defn type->whooing [t] (case t
                          "사용" "기타+ 네이버페이포인트- ?"
                          "충전" "네이버통장- 네이버페이포인트+ 네이버페이포인트 충전"
                          "적립" "네이버페이포인트+ 페이백포인트기타+ 네이버페이포인트 적립"))

(defn sanitize [cols]
  (let [t (cols 0)
        d (util/date (cols 1))
        rev-cols (reverse (array/slice cols 2))
        p (util/price (rev-cols 1))
        remains (string/join (reverse (array/slice rev-cols 2)) " ")]
    @[t d p remains]))

(defn reorder [cols]
  (let [t (cols 0) price (cols 2) date (cols 1)]
    @[date
      (util/string-abs price)
      (type->whooing t)
      (string ";" (string/join cols " "))]))

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
