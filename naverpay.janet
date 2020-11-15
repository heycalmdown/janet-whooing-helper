(import char)
(import util)

(defn escape-by-cancel [] (error "취소건 발생") (os/exit 1))

(defn merchant->whooing [merchant] (if (string/find "nanaharu" merchant) "콩빈두+ 네이버페이포인트- ?"
                                     (case merchant
                                       "배달의민족" "식비+ 네이버페이포인트- ?"
                                       "네이버플러스 멤버십" "기타비용+ 네이버페이포인트- 네이버플러스"
                                       "프로젝트21" "콩빈두+ 네이버페이포인트- 콩빈두 건강"
                                       "PETHROOM" "콩빈두+ 네이버페이포인트- 콩빈두 모래"
                                       "THESUJATA" "미용+ 네이버페이포인트- 염색약"
                                       "기타+ 네이버페이포인트- ?")))

(defn type->whooing [t merchant] (case t
                                   "사용" (merchant->whooing merchant)
                                   "충전" "네이버통장- 네이버페이포인트+ 네이버페이포인트 충전"
                                   "적립" "네이버페이포인트+ 페이백포인트기타+ 네이버페이포인트 적립"
                                   "취소" (escape-by-cancel)))

(defn reformat [cols]
  (let [t (cols 0)
        d (util/date (cols 1))
        cmt (cols 2)
        merchant (cols 3)
        p (util/price (cols 4))]
    @[t d p cmt merchant]))

(defn reorder [cols]
  (let [t (cols 0) date (cols 1) price (cols 2) merchant (cols 4)]
    @[date
      (util/string-abs price)
      (type->whooing t merchant)
      (string ";" (string/join cols " "))]))

(defn split [source] (filter (comp not empty?) (string/split "\n" source)))

(defn first-n [items n] [(array/slice items 0 n) (array/slice items n)])

(defn convert [item]
  (util/join-col (reorder (reformat item))))

(defn one-of [line] (or (= line "사용") (= line "적립") (= line "충전") (= line "취소")))

(defn sanitize [source]
  (if (= 0 (length source))
    []
    (if-not
      (one-of (0 source)) (sanitize (array/concat @[] (util/rest ;source)))
      source)))

(defn slice-items [lines]
  (def sanitized (sanitize lines))
  (if (> 6 (length lines))
    []
    [(array/slice sanitized 0 6) ;(slice-items (array/slice sanitized 6))]))

(defn convert! [source args]
  (each i (slice-items (split source)) (print (convert i))))
