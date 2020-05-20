(def INT->CHAR @[
  "" "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" "" ""
  "" "" "" "+" "" "-" "." "" "0" "1"
  "2" "3" "4" "5" "6" "7" "8" "9" "" ""
])
(defn int->char [int] (INT->CHAR int))
(defn digit? [char] (<= 43 char 57))
(defn atoi [str] (scan-number (string/join (map int->char (filter digit? str)))))
