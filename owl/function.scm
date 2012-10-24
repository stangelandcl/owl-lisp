
(define-library (owl function)

   (export function? procedure? bytecode?)

   (import
      (owl defmac)
      (only (owl ff) ff?)
      (only (owl syscall) interact))

   (begin

      ;; raw bytecode vector, 1-level (proc) or 2-level (clos) function
      (define (function? x)
         (or
            ;(and 
            ;   (raw? x) ;; temporary clash
            ;   (eq? (fxband 31 (type x)) 0)) ;; OLD CODE
            (eq? (fxband 31 (type x)) type-bytecode) ;; FIXME, drop 31 after changing types
            (eq? (type x) type-proc)
            (eq? (type x) type-clos)
            (eq? #b010 (fxband (type-old x) #b11111010))))

      ;; something executable? being a function or a finite function
      (define (procedure? obj)
         (or (function? obj)
             (ff? obj)))

      (define (bytecode? x) 
         (or 
            ;(and (raw? x) ;; clash @ 0 atm
            ;   (eq? 0 (fxband 31 (type x))))  ;; new good, though drop 31 after moving bits
            (eq? type-bytecode (fxband 31 (type x)))  ;; new good, though drop 31 after moving bits
            (eq? #b100000000010 (fxband (type-old x) #b100011111010)))))) ;; old bad


