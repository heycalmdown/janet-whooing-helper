(import coupang)
(import naverpay)
(import kurly)

(defn help-then-exit! []
  (print ``
이렇게 하시오
$ pbpaste | janet main.janet [coupang|naverpay|kurly]
``)
  (os/exit))

(defn rest [head & _] _)

(defn main [_ & args]
  (let [target (if (empty? args) "coupang" (args 0))
        handler (case target "coupang" coupang/convert! "naverpay" naverpay/convert! "kurly" kurly/convert!)]
    (if (nil? handler) (help-then-exit!))
    (let [source (file/read stdin :all)]
      (handler source (rest ;args)))))
