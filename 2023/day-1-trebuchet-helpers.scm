;; Files labeled helpers are intended to only be used by targeted audience
;;   it's named after and unit test runners
;;(module day-1-trebuchet-helpers
;;
;;  (find-first-char-digit-or-word-digit
;;   find-last-char-digit-or-word-digit
;;   substring-indices
;;)

  (import
    scheme
    (chicken base)
    srfi-1
    srfi-13
    srfi-69)

  (define digit-word-to-digit-char-map
    (alist->hash-table
      '(("1" . #\1)
        ("2" . #\2)
        ("3" . #\3)
        ("4" . #\4)
        ("5" . #\5)
        ("6" . #\6)
        ("7" . #\7)
        ("8" . #\8)
        ("9" . #\9)
        ;; Commenting below will give result for aoc 2023 day 1 part 1
        ("one" . #\1)
        ("two" . #\2)
        ("three" . #\3)
        ("four" . #\4)
        ("five" . #\5)
        ("six" . #\6)
        ("seven" . #\7)
        ("eight" . #\8)
        ("nine" . #\9)
        ;; Commenting above will give result for aoc 2023 day 1 part 1
        )))

  (define (digit-word->digit-char word) 
    (hash-table-ref digit-word-to-digit-char-map word))

  (define (substring-indices str1 str2 #!optional (cursor 0))
    (let [(substring-index (string-contains str1 str2))
          (substring-length (string-length str2))
          ]
      (if (eq? #f substring-index)
        '()
        (cons
          (+ substring-index cursor)
          (substring-indices
            (string-drop str1 (+ substring-length substring-index))
            str2
            (+ cursor (+ substring-length substring-index)))))))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; (define substring-index (string-contains "six92onesix" "six"))
  ; (0 8)
  ; (substring-indices "six92onesix" "six")
  ; (3)
  ; (substring-indices "8six1ninezjsix" "six")
  ; (1 11)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  (define ()
    ())

  (define word-digits
    '("1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
      "one"
      "two"
      "three"
      "four"
      "five"
      "six"
      "seven"
      "eight"
      "nine"))

  (define (find-first-char-numeric-from-head line)
    (let [(chars (string->list line))]
      (list (find char-numeric? chars) (list-index char-numeric? chars))))

  (define (find-last-char-numeric-from-end line)
    (let [(rev-chars (reverse (string->list line)))]
      (list (find char-numeric? rev-chars) (list-index char-numeric? rev-chars))))

  (define (valid-position position)
    (not (eq? #f (cadr position))))


  (define (find-first-word-digit-from-head line)
    (fold
      (lambda
        (word-position closest)
        (if (eq? #f (cadr word-position))
          closest
          (if (or (eq? #f (cadr closest)) (< (cadr word-position) (cadr closest)))
            word-position
            closest)))
      (list "" #f)
      (map (lambda
          (word-digit)
          (list word-digit (string-contains line word-digit)))
           word-digits)))

  (define (find-last-word-digit-from-end line)
    (fold
      (lambda
        (word-position furthest)
        (if (eq? #f (cadr word-position))
          furthest
          (if (or (eq? #f (cadr furthest)) (> (cadr word-position) (cadr furthest)))
            word-position
            furthest)))
      (list "" #f)
      (map (lambda
          (word-digit)
          (list word-digit (string-contains line word-digit)))
           word-digits)))

  (define (find-first-char-digit-or-word-digit line)
    (let [(find-first-char-numeric-result (find-first-char-numeric-from-head line))
          (find-first-word-digit-result (find-first-word-digit-from-head line))]
      (fold
        (lambda
          (digit-position closest)
          (if (eq? #f (cadr digit-position))
            closest
            (if (or (eq? #f (cadr closest)) (< (cadr digit-position) (cadr closest)))
              digit-position
              closest)))
        (list "" #f)
        (map (lambda
             (digit-or-word-position)
             (if (eq? #t (string? (car digit-or-word-position)))
               (list (digit-word->digit-char (car digit-or-word-position))
                 (cadr digit-or-word-position))
               digit-or-word-position))
             (filter 
               valid-position
              (list find-first-char-numeric-result find-first-word-digit-result))))))

  (define (find-last-char-digit-or-word-digit line)
    (let [(find-last-char-numeric-result (find-last-char-numeric-from-end line))
          (find-last-word-digit-result (find-last-word-digit-from-end line))]
      (fold
        (lambda
          (digit-position closest)
          (if (eq? #f (cadr digit-position))
            closest
            (if (or (eq? #f (cadr closest)) (< (cadr digit-position) (cadr closest)))
              digit-position
              closest)))
        (list "" #f)
        (map (lambda
               (digit-or-word-position)
               (if (eq? #t (string? (car digit-or-word-position)))
                 (list (digit-word->digit-char (car digit-or-word-position))
                   (- (- (string-length line) (cadr digit-or-word-position)) 1))
                 digit-or-word-position))
               (filter
                 valid-position
                 (list find-last-char-numeric-result find-last-word-digit-result))))))

;;) ;; End of module


;(define x (list ("one" #f)  ("two" 0)  ("three" #f)  ("four" #f)  ("five" #f)  ("six" #f)  ("seven" #f)  ("eight" #f)  ("nine" 4))) 
; "two1nine""
; #47: ((#\1 3) ("two" 0))
; (list (list #\1 3) (list "two" 0))

;#;53> (find-first-char-digit-or-word-digit "two1nine")
;(#\2 0)
;#;54> (find-first-char-digit-or-word-digit "eightwothree")
;(#\8 0)
;#;55> (find-first-char-digit-or-word-digit "abcone2threexyz")
;(#\1 3)
;#;56> (find-first-char-digit-or-word-digit "xtwone3four")
;(#\2 1)
;#;57> (find-first-char-digit-or-word-digit "4nineeightseven2")
;(#\4 0)
;#;58> (find-first-char-digit-or-word-digit "zoneight234")
;(#\1 1)
;#;59> (find-first-char-digit-or-word-digit "7pqrstsixteen")

;#;68> (find-last-char-digit-or-word-digit "two1nine")
;(#\9 3)
;#;69> (find-last-char-digit-or-word-digit "eightwothree")
;(#\3 4)
;#;70> (find-last-char-digit-or-word-digit "abcone2threexyz")
;(#\3 7)
;#;71> (find-last-char-digit-or-word-digit "xtwone3four")
;(#\4 3)
;#;72> (find-last-char-digit-or-word-digit "4nineeightseven2")
;(#\2 0)
;#;73> (find-last-char-digit-or-word-digit "zoneight234")
;(#\4 0)
;#;74> (find-last-char-digit-or-word-digit "7pqrstsixteen")
; (find-last-char-digit-or-word-digit "8six1ninezjsix")
; (find-last-char-digit-or-word-digit "six92onesix")

;(#\6 6)
; (list (list #\1 4) (list "nine" 4)))
