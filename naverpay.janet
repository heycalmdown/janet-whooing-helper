(import char)
(import util)

(def SOURCE ``
사용 2020.05.31 결제 시 사용 배달의민족 -19,500원 내역삭제
적립 2020.05.31 구매 적립예정 배달의민족 +97원 내역삭제
충전 2020.05.31 포인트 충전 (계좌 간편결제) 하나은행 +50,000원 내역삭제
적립 2020.05.31 이벤트 적립 계좌 충전 즉시적립 혜택 +750원 내역삭제
사용 2020.05.29 결제 시 사용 배달의민족 -39,900원 내역삭제
적립 2020.05.29 구매 적립 배달의민족 +199원 내역삭제
사용 2020.05.29 결제 시 사용 루나 랩 -69,000원 내역삭제
적립 2020.05.29 구매 적립예정 루나 랩 +690원 내역삭제
충전 2020.05.29 포인트 충전 (계좌 간편결제) 하나은행 +100,000원 내역삭제
적립 2020.05.29 이벤트 적립 계좌 충전 즉시적립 혜택 +1,500원 내역삭제
``)

(defn type->whooing [t] (case t
                          "사용" "기타+ 네이버페이포인트- ?"
                          "충전" "소하나- 네이버페이포인트+ 네이버페이포인트 충전"
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

(defn convert [line] (-> line
                         util/split-col
                         sanitize
                         reorder
                         util/join-col))

(defn main [_ & args]
  (each i (string/split "\n" SOURCE) (print (convert i))))
