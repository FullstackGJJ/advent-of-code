(module file-input-loader
  (file->list)

  (import scheme (chicken io))

  (define (get-file-lines file-handler)
    (let ([line (read-line file-handler)])
      (if (eof-object? line)
        (begin
          (close-input-port file-handler)
          '())
        (cons line (get-file-lines file-handler)))))

  (define (file->list file)
    (let ([file-handler (open-input-file file)])
      (get-file-lines file-handler)))
);; end module
