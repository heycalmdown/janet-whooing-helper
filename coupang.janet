(import char)
(import util)

(defn price->subject [price] (if (< (scan-number price) 0)
                               "기타+ 소쿠페이머니- ?"
                               "소쿠페이머니+ 소하나- 쿠페이 충전"))

(defn type->whooing [t] (case t
                          "결제" "기타+ 소쿠페이머니- ?"
                          "충전" "소쿠페이머니+ 소하나- 쿠페이 충전"
                          "인출" "소하나+ 소쿠페이머니- 쿠페이 인출"))

(defn sanitize [cols]
  (put cols 0 (util/price (cols 0)))
  (put cols 3 (util/date (cols 3))))

(defn parse-type [line]
  (if (string/find "인출" line) "인출"
    (if (string/find "충전" line) "충전"
      (if (string/find "결제" line) "결제"))))

(defn reformat [cols]
  (def t (parse-type (0 cols)))
  (def p (util/price (0 cols)))
  (def remains (1 cols))
  (def d (util/date (0 (string/split " " (2 cols)))))
  (def subject (3 cols))
  (def cmt (util/join-col cols))
  @[t p remains d subject cmt])

(defn reorder [cols]
  (let [price (cols 0) date (cols 3)]
    @[(3 cols)
      (util/string-abs (1 cols))
      (type->whooing (0 cols))
      (string ";" (5 cols))]))

(defn convert-line [line] (-> line
                              util/split-col
                              sanitize
                              reorder
                              util/join-col))

(defn convert [item]
  (util/join-col (reorder (reformat item))))

(defn split [source] (filter (comp not empty?) (string/split "\n" source)))

(defn slice-items [lines]
  (if (> 4 (length lines))
    []
    [(array/slice lines 0 4) ;(slice-items (array/slice lines 4))]))

(defn convert! [source args]
  (each i (slice-items (split source)) (print (convert i))))
