;; Egg imports
(import
  scheme
  (chicken base)
  (chicken format)
  (chicken io)
  (chicken process-context)
  (chicken string)
  srfi-1
  srfi-13
  srfi-69)

;; Project imports
(import file-input-loader)

(define word-digits
  '("one" "two" "three" "four" "five" "six" "seven" "eight" "nine"))

(define (find-first-char-digit-or-word-digit line)
  '())

(define (find-last-char-digit-or-word-digit line)
  '())

(let ((filePath (car (command-line-arguments)))) 
  (let [(lines (file->list filePath))]
    (printf
      "~A~%"
      (fold 
        +
        0
        (map
          (lambda (line)
            (let
              [(chars (string->list line))]
              (string->number 
                (list->string
                  (append 
                    (list (find char-numeric? chars))
                    (list (find char-numeric? (reverse chars))))))))
          lines)))))


