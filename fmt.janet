(import spork/fmt)

(fmt/format-file "./fmt.janet")

(defn main [_ & args]
  (let [filename (if (empty? args) "main.janet" (args 0))]
    (fmt/format-file (string "./" filename))))
