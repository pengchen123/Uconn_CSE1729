;Peng Chen
;problem set 9
;4/17/2017

"problem 1"
(define (basic-set)
  (let ((the-set '()))
    (define (empty?) (eq? the-set '()))
    (define (insert x) (set! the-set (cons x the-set)))
    (define (element? n)
      (define (member-iter L)
        (cond ((null? L) #f)
              ((eq? n (car L)) #t)
              (else (member-iter (cdr L)))))
      (member-iter the-set))
    (define (delete m)
      (define (helper L)
        (cond ((eq? m (car L)) (cdr L))
              (else (cons (car L)(helper (cdr L))))))
      (set! the-set (helper the-set)))
    (define (show) the-set)
    (define (dispatch method)
      (cond ((eq? method 'empty?) empty?)
            ((eq? method 'insert) insert)
            ((eq? method 'delete) delete)
            ((eq? method 'element?) element?)
            ((eq? method 'show) show)))
    dispatch))
;test case
(define newset (basic-set))
((newset 'empty?))
((newset 'insert) 2)
((newset 'show))
((newset 'element?) 2)
((newset 'delete) 2)
((newset 'empty?))
;when I run the test case I got:
;#t
;(2)
;#t
;#t


"problem 2"
(define (stat-set)
  (let ((new-list '()) (size 0) (max 0) (min 0) (sum 0))
    (define (empty?) (eq? new-list '()))
    (define (average) (/ sum size))
    (define (insert x)
      (cond ((null? new-list)
             (set! new-list (list x))
             (set! size 1)
             (set! max x)
             (set! min x)
             (set! sum x))
            ((not (element? x))
             (if (> x max) (set! max x))
             (if (< x min) (set! min x))
             (set! sum (+ sum x))
             (set! size (+ size 1))
             (set! new-list (cons x new-list)))))
    (define (element? x)
      (define (member-iter L)
        (cond ((null? L) #f)
              ((eq? x (car L)) #t)
              (else (member-iter (cdr L)))))
      (member-iter new-list))
    (define (show) new-list)
    (define (dispatch method)
      (cond ((eq? method 'empty?) empty?)
            ((eq? method 'element?) element?)
            ((eq? method 'insert) insert)
            ((eq? method 'show) show)
            ((eq? method 'size) (lambda () size))
            ((eq? method 'smallest) (lambda () min))
            ((eq? method 'largest) (lambda () max))
            ((eq? method 'average) average)))
    dispatch))
;test case
(define list (stat-set))
((list 'empty?))
((list 'insert) 1)
((list 'insert) 2)
((list 'insert) 3)
((list 'insert) 4)
((list 'insert) 5)
((list 'empty?))
((list 'show))
((list 'size))
((list 'smallest))
((list 'largest))
((list 'size))
((list 'average))
;when I run the test case I got:
;#t
;#f
;(5 4 3 2 1)
;5
;1
;5
;5
;3


"problem 3"
(define (mulitset)
  (let ((new-set '()))
    (define (empty?) (eq? new-set '()))
    (define (insert n)
      (set! new-set (cons n new-set)))
    (define (multiplicity? m)
      (define (helper L)
        (cond ((null? L) 0)
              ((eq? m (car L)) (+ 1 (helper (cdr L))))
              ((not (eq? m (car L))) (helper (cdr L)))))
      (helper new-set))
    (define (delete m)
      (define (helper L)
        (cond ((eq? m (car L)) (cdr L))
              (else (cons (car L) (helper (cdr L))))))
      (set! new-set (helper new-set)))
    (define (deleteall a)
      (define (helper L)
        (cond ((null? L) L)
              ((eq? a (car L))(helper (cdr L)))
              (else (cons (car L) (helper (cdr L))))))
      (set! new-set (helper new-set)))    
    (define (show)
      (define (remove v L)
        (cond ((null? L) l)
              ((eq? (car v) (car (car L))) (remove v (cdr L)))
              (else (cons (car L) (remove v (cdr L))))))
      (define (remove-all L)
        (if (null? L)
            L
            (cons (car L)
                  (remove (car L) (remove-all (cdr L))))))
      (define (helper l)
        (if (null? l)
            l
            (cons (cons (car l) (multiplicity? (car l))) (helper (cdr l)))))
      (remove-all (helper new-set)))
    (define (dispatch method)
      (cond ((eq? method 'empty?) empty?)
            ((eq? method 'insert) insert)
            ((eq? method 'multiplicity?) multiplicity?)
            ((eq? method 'delete) delete)
            ((eq? method 'deleteall) deleteall)
            ((eq? method 'show) show)))
    dispatch))
;test case
(define list (mulitset))
((list 'empty?))
((list 'insert) 9)
((list 'insert) 8)
((list 'insert) 8)
((list 'insert) 6)
((list 'insert) 6)
((list 'insert) 5)
((list 'insert) 3)
((list 'insert) 3)
((list 'insert) 3)
((list 'insert) 1)
((list 'empty?))
((list 'multiplicity?) 6)
((list 'show))
((list 'deleteall) 1)
((list 'show))
;when I run the test case I got:
;#t
;#f
;2
;((1 . 1) (3 . 3) (5 . 1) (6 . 2) (8 . 2) (9 . 1))
;((3 . 3) (5 . 1) (6 . 2) (8 . 2) (9 . 1))


"problem 3"
(define (muliset)
  (let ((s '()))
    (define (empty) (null? s))
    (define (element? x)
      (define (element-sub l)
        (cond ((null? l) #f)
              ((eq? x (caar l)) #t)
              (else (element-sub (cdr l)))))
      (element-sub s))
    (define (insert x)
      (define (insert-sub l)
        (cond ((null? l) (list (cons x 1)))
              ((eq? x (caar l)) (cons (cons x (+ (cdar l) 1))
                                      (cdr l)))
              (else (cons (car l) (insert-sub (cdr l))))))
      (set! s (insert-sub s)))
    (define (mult x)
      (define (mult-sub l)
        (cond ((null? l) 0)
              ((eq? x (caar l)) (cdar l))
              (else (mult-sub (cdr l)))))
      (mult-sub s))
    (define (delete x)
      (define (delete-sub l)
        (cond ((null? l) '())
              ((eq? x (caar l)) (if (eq? (cdar l) 1)
                                    (cdr l)
                                    (cons (cons x (- (cdar l) 1))
                                          (cdr l))))
              (else (cons (car l) (delete-sub (cdr l))))))
      (set! s (delete-sub s)))
    (define (delete-all x)
      (define (delete-all-sub l)
        (cond ((null? l) '())
              ((eq? x (caar l)) (cdr l))
              (else (cons (car l) (delete-all-sub (cdr l))))))
      (set! s (delete-all-sub s)))
    (define (dispatcher method)
      (cond ((eq? method 'empty) empey)))
    dispatcher))