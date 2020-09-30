(import char)

(defn split-col [line] (string/split " " line))
(defn join-col [cols] (string/join cols " "))
(defn rest [f & r] r)
(defn price [str] (string (char/atoi str)))
(defn date [str] (string/replace-all "." "-" str))
(def string-abs (comp string math/abs scan-number))
(defn tap-print [str] (print str) str)
