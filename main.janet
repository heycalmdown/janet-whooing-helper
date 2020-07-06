(import coupang)

(defn f [lines]
  (filter length lines))

(defn main [_ & args]
  (let [source (file/read stdin :all)
        lines (filter (comp not empty?) (string/split "\n" source))]
    (each i lines (print (coupang/convert i)))))

