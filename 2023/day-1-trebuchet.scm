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
(import day-1-trebuchet-helpers file-input-loader)


;; csc -o day-1-trebuchet.exe day-1-trebuchet.scm
;;   ./day-1-trebuchet.exe day-1-input.txt
(let ((filePath (car (command-line-arguments)))) 
  (let [(lines (file->list filePath))]
    (printf
      "~A~%"
      (fold 
        +
        0
        (map
          (lambda (line)
            (string->number 
              (list->string
                (append 
                  (list (car (find-first-char-digit-or-word-digit line)))
                  (list (car (find-last-char-digit-or-word-digit line)))))))
          lines)))))

;;

    ;;(map
    ;;  (lambda (line)
    ;;    (string->number 
    ;;      (list->string
    ;;        (append 
    ;;          (list (car (find-first-char-digit-or-word-digit line)))
    ;;          (list (car (find-last-char-digit-or-word-digit line)))))))
    ;;  #1)
