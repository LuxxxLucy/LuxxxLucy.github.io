#lang racket/base
(require pollen/core
         pollen/decode
         pollen/setup
         racket/date
         pollen/tag
         racket/list
         racket/match
         racket/path
         racket/string
         (only-in srfi/13
                  string-contains)
         txexpr)

(provide root)
(define (root . elements)
   (txexpr 'root empty (decode-elements elements
     #:txexpr-elements-proc decode-paragraphs
    #:exclude-tags '(raw-html)
    #:exclude-attrs '((class "mermaid" ) (class "raw-html")) 
     )))

(provide (all-defined-out))
(define h1 (default-tag-function 'h1))
(define headline (default-tag-function 'h1))
(define h2 (default-tag-function 'h2))
(define section (default-tag-function 'h2))
(define h3 (default-tag-function 'h3))
(define subsection (default-tag-function 'h3))
(define items (default-tag-function 'ul))
(define numbered-items (default-tag-function 'ol))
(define item (default-tag-function 'li 'p))
(define p (default-tag-function 'p))
(define div (default-tag-function 'div))
(define (link url text) `(a ((href ,url)) ,text))

(define (raw . text)
        ; `(@ 
        ;     (div [(class "mermaid")] ,@text))
        ; `(div [[class "raw-html"]] ,(ltx-escape-str text))
        ; `(txt ,@text)
        `(div [[class "raw-html"]] ,@text)
            )

(define (hover_summary caption . text)
    (case (current-poly-target)
      [else
        `(@ 
            ; (div [(class "show_control")] "test control")
            (div [(class "show_control")] ,caption)
            (div [(class "show_item")] ,@text)
            ) 
            ]))

(define (point_entry  caption . text)
    (case (current-poly-target)
      [else
        `(@ 
            (p
              (code [(class "language-plaintext highlighter-rouge")] ,caption)
              "     "
              ,@text
              ) 

          )
      ]))

(define (summary caption . text)
    (case (current-poly-target)
      [else
        `(@ 
            (details
              (summary [(class "language-plaintext highlighter-rouge")] ,caption)
              (p ,@text)
              ) 
          )
      ]))
; some are inspired from https://github.com/otherjoel/try-pollen

; Escape $,%,# and & for LaTeX
; The approach here is rather indiscriminate; I’ll probably have to change
; it once I get around to handline inline math, etc.
(define (ltx-escape-str str)
  (regexp-replace* #px"([$#%&])" str "\\\\\\1"))

(define ($ . xs)
  `(mathjax ,(apply string-append `("$" ,@xs "$"))))

(define ($$ . xs)
  `(mathjax ,(apply string-append `("$$" ,@xs "$$"))))

(define horizontal
    (case (current-poly-target)
      [(ltx pdf)
       `(txt "\\marginnote{" ,@(latex-no-hyperlinks-in-margin "horizontal line not implemented") "}")]
      [else
        `(hr)
            ]))

(define (mermaid . text)
        ; `(@ 
        ;     (div [(class "mermaid")] ,@text))
        `(span [[class "mermaid"]] ,@text)
            )

;  (define mermaid (default-tag-function 'div #:class "mermaid"))

(define (margin-note . text)
    (define refid (number->string (equal-hash-code (car text))))
    (case (current-poly-target)
      [(ltx pdf)
       `(txt "\\marginnote{" ,@(latex-no-hyperlinks-in-margin text) "}")]
      [else
        `(@ 
            (span [[class "marginnote"]] text))]))
#|
  This function is called from within the margin/sidenote functions when
  targeting Latex/PDF, to filter out hyperlinks from within those tags.
  (See notes above)
|#
(define (latex-no-hyperlinks-in-margin txpr)
  ; First define a local function that will transform each ◊hyperlink
  (define (cleanlinks inline-tx)
      (if (eq? 'hyperlink (get-tag inline-tx))
        `(txt ,@(cdr (get-elements inline-tx))
              ; Return the text with the URI in parentheses
              " (\\url{" ,(ltx-escape-str (car (get-elements inline-tx))) "})")
        inline-tx)) ; otherwise pass through unchanged
  ; Run txpr through the decode-elements wringer using the above function to
  ; flatten out any ◊hyperlink tags
  (decode-elements txpr #:inline-txexpr-proc cleanlinks))

; (define (numbered-note . text)
;     (define refid (number->string (equal-hash-code (car text))))
;     (case (current-poly-target)
;       [(ltx pdf)
;        `(txt "\\footnote{" ,@(latex-no-hyperlinks-in-margin text) "}")]
;       [else
;         `(@ 
;             (label [[for ,refid] [class "margin-toggle sidenote-number"]])
;             (input [[id ,refid] [class "margin-toggle"]])
;             (span [(class "sidenote")] ,@text))]))
(define (note . text)
    (define refid (number->string (equal-hash-code (car text))))
    (case (current-poly-target)
      [(ltx pdf)
       `(txt "\\footnote{" ,@(latex-no-hyperlinks-in-margin text) "}")]
      [else
        `(@ (label [[for ,refid] [class "margin-toggle sidenote-number"]])
            (input [[type "checkbox"] [id ,refid] [class "margin-toggle"]])
            (span [(class "sidenote")] ,@text))]))

(define (figure source . caption)
    (define refid (number->string (equal-hash-code source)))
    (case (current-poly-target)
      [(ltx pdf)
       `(txt "\\begin{figure}"
             "\\includegraphics{" ,source "}"
             "\\caption{" ,@(latex-no-hyperlinks-in-margin caption) "}"
             "\\end{figure}")]
      [else
        `(@ 
            (figure [[class "fullwidth"]]
              (label [[for ,refid] [class "margin-toggle"]] 8853)
              (input [[type "checkbox"] [id ,refid] [class "margin-toggle"]])
              (span [[class "marginnote"]] ,@caption)
              (img [[src ,source]])
            ))]))

(define (margin-figure source . caption)
    (define refid (number->string (equal-hash-code source)))
    (case (current-poly-target)
      [(ltx pdf)
       `(txt "\\begin{marginfigure}"
             "\\includegraphics{" ,source "}"
             "\\caption{" ,@(latex-no-hyperlinks-in-margin caption) "}"
             "\\end{marginfigure}")]
      [else
        `(@ (label [[for ,refid] [class "margin-toggle"]] 8853)
            (input [[type "checkbox"] [id ,refid] [class "margin-toggle"]])
            (span [[class "marginnote"]] (img [[src ,source]]) ,@caption))]))

(define (margin . content)
  `(span [[class "marginnote"]] ,@content)
)

(define (newthought . words)
  (case (current-poly-target)
    [(ltx pdf) `(txt "\\newthought{" ,@words "}")]
    [else `(span [[class "newthought"]] ,@words)]))