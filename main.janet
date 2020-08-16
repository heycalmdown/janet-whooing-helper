(import coupang)
(import naverpay)
(import kurly)

(defn do-coupang [source args]
  (each i (coupang/split source) (print (coupang/convert i))))

(defn do-naverpay [source args]
  (each i (naverpay/split source) (print (naverpay/convert i))))

(defn do-kurly [source args]
  (let [date (if (empty? args) "오늘" (args 0))]
    (each i (kurly/kurly-split-items source) (print (kurly/kurly->whooing i date)))))

(defn help-then-exit! []
  (print ``
이렇게 하시오
$ pbpaste | janet main.janet [coupang|naverpay|kurly]
``)
  (os/exit))

(defn rest [head & _] _)

(defn main [_ & args]
  (let [target (if (empty? args) "coupang" (args 0))
        handler (case target "coupang" do-coupang "naverpay" do-naverpay "kurly" do-kurly)]
    (if (nil? handler) (help-then-exit!))
    (let [source (file/read stdin :all)]
      (handler source (rest ;args)))))
