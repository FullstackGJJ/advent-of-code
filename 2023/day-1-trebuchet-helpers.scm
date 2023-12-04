;; Files labeled helpers are intended to only be used by targeted audience
;;   it's named after and unit test runners
(module day-1-trebuchet-helpers

  ;; Exported for caller to use
  (sorted-indices-for-digits
   ;; Exported for testing purposes only
   substring-indices
   replace-all-word-digits-to-char-digits
   calculate-indices-for-word-digits)

  (import
    scheme
    (chicken base)
    (chicken sort)
    srfi-1
    srfi-13
    srfi-69)

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
      ;; Commenting below will give result for aoc 2023 day 1 part 1
      "one"
      "two"
      "three"
      "four"
      "five"
      "six"
      "seven"
      "eight"
      "nine"
      ;; Commenting above will give result for aoc 2023 day 1 part 1
      ))


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
          (substring-length (string-length str2))]
      (if (eq? #f substring-index)
        '()
        (cons
          (+ substring-index cursor)
          (substring-indices
            (string-drop str1 (+ substring-length substring-index))
            str2
            (+ cursor (+ substring-length substring-index)))))))

  (define (multiply-element-with-list element li)
    (map (lambda (index) (cons element index)) li))

  (define (not-null? x) 
    (not (null? x)))

  (define (flatten-matrix pairs-matrix)
    (fold
      (lambda
        (row-pairs acc-pairs)
        (append acc-pairs row-pairs))
      '()
      pairs-matrix))

  (define (calculate-indices-for-word-digits line)
    (flatten-matrix
      (filter
        not-null?
        (map (lambda
               (word-digit)
               (multiply-element-with-list
                 word-digit
                 (substring-indices line word-digit)))
             word-digits))))

  (define (replace-all-word-digits-to-char-digits word-infos)
    (map
      (lambda
        (word-info)
        (cons (digit-word->digit-char (car word-info)) (cdr word-info)))
      word-infos))

  (define (sorted-indices-for-digits line)
    (sort
      (replace-all-word-digits-to-char-digits (calculate-indices-for-word-digits line)) 
      (lambda
        (first second)
        (< (cdr first) (cdr second)))))
) ;; End of module

;; Create importable module and compiled definition
;; csc -s day-1-trebuchet-helpers.scm -J
