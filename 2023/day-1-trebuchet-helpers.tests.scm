;; Egg imports
(import scheme srfi-64)

;; Project imports
(import day-1-trebuchet-helpers)

;; Testing section
(test-begin "day-1-trebuchet-helpers")
(test-equal "substring-indices case 1" '(0 8) (substring-indices "six92onesix" "six"))
(test-equal "substring-indices case 2" '(1 11) (substring-indices "8six1ninezjsix" "six"))
(test-equal "substring-indices case 3" '(0 1 2) (substring-indices "111" "1"))
(test-equal "calculate-indices-for-word-digits case 1"
            (list (cons "2" 4) (cons "9" 3) (cons "one" 5) (cons "six" 0) (cons "six" 8))
            (calculate-indices-for-word-digits "six92onesix"))

(test-equal "replace-all-word-digits-to-char-digits case 1"
            (list (cons #\6 0) (cons #\9 3) (cons #\2 4) (cons #\1 5) (cons #\6 8))
            (replace-all-word-digits-to-char-digits
              (list
                (cons "six" 0)
                (cons "9" 3)
                (cons "2" 4)
                (cons "one" 5)
                (cons "six" 8))))
(test-end "day-1-trebuchet-helpers")
