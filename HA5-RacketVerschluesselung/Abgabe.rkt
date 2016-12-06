;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Abgabe) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; Authors:
;; Alexander Siegler
;; Paul Konstantin Wagner
;; Yoshua Hitzel
;; Marcel Lackovic

;; ====== Secret message ======

(define turtle-code
  (list
      0     87      0   2559      0
      0      0   1148      0      0
   2987      0      0      0   2675
      0    649      0      0      0
   2675      0    649      0   2675
      0      0      0   1148      0
      0      0   2855      0    649
      0     57      0      0      0
    649      0   2855      0      0
      0   2987      0      0      0
   2675      0   2987      0      0
      0   2855      0   2987      0
      0      0   2675      0   2987
      0      0      0   2855      0
   2987      0   3249      0      0
      0   2987      0      0      0
   2855      0    649      0      0
      0   2675      0    649      0
      0      0   2855      0   2987
      0     57      0      0      0
      0   2675      0   2987      0
      0      0   2675      0   2987
      0      0      0   2675      0
    649      0      0      0   2675
      0    649      0   2675      0
      0      0     87      0      0
      0   2834      0    340      0
      0      0   2675      0   2987
      0   3249      0      0      0
   2987      0   2675      0      0
      0    649      0      0      0
   2675      0   2987      0   2675
      0      0      0   2987      0
      0      0   2675      0   2987
      0      0      0   2855      0
   2987      0      0      0   2675
     57      0      0   3249      0
      0      0      0   2675      0
   2987      0      0      0   2675
      0   2987      0      0      0
   2675      0    649      0      0
      0   2675      0    649      0
   2675      0      0      0     87
      0   2834      0      0      0
    340      0      0      0   2675
      0   2987      0   3249      0
      0      0      0   2675      0
   2987      0      0      0   2675
      0   2987      0      0      0
   2675      0    649      0      0
      0   2675      0    649      0
   2675      0      0      0     87
      0      0      0   2834      0
    340      0      0      0   2675
      0   2987      0   3249      0
      0      0   2987      0   2675
      0      0      0    649      0
      0      0   2675      0   2987
      0   2675      0      0      0
   2987      0      0      0   2675
      0   2987      0      0      0
   2855      0   2987      0      0
      0   2675     57      0      0
      0      0   2675      0   1148
      0   1957      0      0      0
    649      0      0      0   2855
      0   1148      0   2855      0
      0      0   2987      0   1957
      0      0     57      0      0
      0      0   2675      0   1148
      0   1957      0      0      0
    649      0      0      0   2855
      0   1148      0   2855      0
      0      0   2987      0   1957
      0      0     57      0      0
      0   2987      0      0      0
   2675      0    649      0      0
      0   2675      0    649      0
   2675      0      0      0   1148
      0      0      0   2855      0
    649      0     57      0      0
      0    649      0   2855      0
      0      0   2987      0   3249
      0      0      0   2987      0
      0      0   2855      0    649
      0      0      0   2675      0
    649      0      0      0   2675
      0    649      0      0      0
   1957   1957      0      0      0
   2987      0   2675      0      0
      0   2987      0      0      0
   2675     57      0      0      0
      0   2675      0   2987      0
      0      0   2855      0   2987
      0      0      0   2675      0
   2987      0      0      0   2855
      0   2987      0   3249      0
      0      0      0   2675      0
   2987      0      0      0   2855
      0   2987      0      0      0
   2675      0   2987      0      0
      0   2855      0   2987      0
   3249      0      0      0   2987
      0      0      0   2855      0
     87      0      0      0   2834
      0    649      0      0      0
   2834      0   2726      0   3249))

;; ====== Problem 1 ======

;; generate-sequence: nat nat -> (listof nat)
;; Generates a list of all numbers from i to e
;; Example: (generate-sequence 1 5) returns (list 1 2 3 4 5)
(define (generate-sequence i e)
  (if (> i e)
      empty
      (cons i (generate-sequence (+ i 1) e))))

;; prime-sieve: nat -> (listof nat)
;;
;; Returns an ordered list of numbers from 1 to n. This list contains 1 if n > 0 and
;; then only prime numbers up to n.
;;
;; This procedur uses the sieve of Eratosthenes. This means it creates a list of all numbers
;; from 2 to n and then filters all non-prime numbers.
;;
;; Example: (prime-sieve 11) = (list 1 2 3 5 7 11)
(define (prime-sieve n)
  (local
    ;; prime?: nat (listof nat) -> (listof nat)
    ;;
    ;; Checks if the given number is a prime number by testing the previous calculated prime numbers
    ;; against it. If it's not a prime number, the unmodified list will be returned.
    ;;
    ;; Example: (prime? 5 (list 1 2 3)) = (list 1 2 3 5)
    [(define (prime? check lst)
       ;; nat -> boolean
       ;;
       ;; Check if the given number can divide the check number and return after the first entry
       ;; was found.
       (if (ormap (lambda (against) (= (remainder check against) 0))
                  ;; nat -> boolean
                  ;;
                  ;; According to the definitions of the sieve of eratosthenes, you only
                  ;; have to check all previous prime numbers up to square root of check.
                  ;;
                  ;; All other combinations between the square root and check are already checked
                  ;; using the previous prime numbers.
                  (filter (lambda (x) (and (<= x (integer-sqrt check))
                                           ; Ignore the 1, because it can divide every number
                                           (> x 1))) lst))
           ; It's not a prime number return the old list
           lst
           (append lst (list check))))]
    (foldl prime? empty (generate-sequence 1 n))))

;; Tests
(check-expect (prime-sieve 0) empty)
(check-expect (prime-sieve 1) '(1))
; Last number included
(check-expect (prime-sieve 11) (list 1 2 3 5 7 11))
; Last number not included
(check-expect (prime-sieve 12) (list 1 2 3 5 7 11))



;; ====== Problem 2 ======

;; prime-factors: nat -> (listof nat)
;;
;; Returns a pair of two prime numbers how the given number can be created with multiplication.
;; 
;; Example: (prime-factors 22) = (list 2 11) 
(define (prime-factors n)
  (local
    [(define primes (prime-sieve n))]
    
    ;; : nat (listof nat) -> (listof nat)
    ;; If 'previous' is empty this function checks if n (given by the parent function) has a prime pair containing 'prime1'
    ;; In this case it returns the prime pair, otherwise an empty list
    (foldl (lambda (prime1 previous)
            ; Meaning of the AND conditions:
            ; 1) To reduce work, this function checks first of all if a prime pair was already found -> skip this loop execution
            ; 2) If  not, check if 'n' is dividable by 'prime1'
            ; 3) Last of all it will be checked if the second factor of the pair is a prime number too
            ;    -> Checking all prime numbers by member needs much power, for this reason we check the two conditions above first
            (if (and (empty? previous) (= (remainder n prime1) 0) (member? (/ n prime1) primes))
                ; 'prime1' is always lower than the second element because 'foldl' starts with the lowest prime number
                (list prime1 (/ n prime1))
                previous
                )) empty primes)))

;; Tests
; cannot be created only with two prime numbers
(check-expect (prime-factors 12) empty)
(check-expect (prime-factors 22) (list 2 11))
(check-expect (prime-factors 9) (list 3 3))
(check-expect (prime-factors 10) (list 2 5))
; prime-number
(check-expect (prime-factors 7) (list 1 7))
(check-expect (prime-factors 3) (list 1 3))



;; ====== Problem 3 ======

;; find-second-key: nat nat nat -> nat
;;
;; Finds a valid private key for a given public key and
;; the prime numbers.
;;
;; Example: (find-second-key 11 7 3) = 11
(define (find-second-key public-key p q)
  (local
    [(define phi (* (- p 1) (- q 1)))
     ;; calc-private: nat -> nat
     ;; Finds the first private key which is greater than the given number
     ;; Example: (calc-private 1) = 3
     ;; if public = 3, p = 3 and q = 5
     (define (calc-private private)
       (if (= (remainder (* private public-key) phi) 1)
           private
           (calc-private (add1 private))))]
    (calc-private 1)))

;; Tests
(check-expect (find-second-key 11 7 3) 11)
(check-expect (find-second-key 3 3 5) 3)



;; ====== Problem 4 ======

;; break-code: nat nat -> (listof nat)
;; Given an RSA public key, determines the prime factors p,q and private key d
;; by factorization and returns them as (list p q d)
(define (break-code n e)
  (local
    ((define pq (prime-factors n))
     (define p (first pq))
     (define q (first (rest pq)))
     (define d (find-second-key e p q)))
    (list p q d)))

;; power-mod: nat nat nat -> nat
;; Solves (base^exponent) mod modulus efficiently by Fermat's algorithm
(define (power-mod base exponent modulus)
  (if
   (= modulus 1)
   0
   (foldl
    (lambda (e-prime c) (modulo (* c base) modulus))
    1
    (generate-sequence 1 exponent))))

;; decrypt: (listof nat) nat nat -> (listof nat)
;; Decrypts an RSA-encrypted message (given a private key and the modulus)
(define (decrypt lst n d)
  (map
   (lambda (c) (power-mod c d n))
   lst))

;; Turtle command list format: Move Turn Draw, all concatenated in a flat list

;(require graphics/turtles)
;;; execute-turtle-sequence: (listof number) -> void
;;;
;;; Interprets a list of turtle commands (format: see above) and executes them sequentially
;;; 
;;; Example: (execute-turtle-sequence (decrypt turtle-code 3337 (third (break-code 3337 2089))))
;(define (execute-turtle-sequence seq)
;  (begin
;    [turtles true]
;    [local
;      ;; execute: (listof number) nat -> void
;      ;;
;      ;; Executes sequentially the turtle commands. If the list is smaller than
;      ;; three commands it will fail safetly.
;      ;;
;      ;; Where type is a number 1, 2 or 3 which stands for move, turn, draw on the first
;      ;; element and then rotating for the following elements
;      ;;
;      ;; Example: (execute (list 20 90 5 15) 2)
;      [(define (execute lst type)
;         (if (empty? lst)
;             void
;             (begin
;               (cond
;                 [(= type 0) (move (first lst))]
;                 [(= type 1) (turn (first lst))]
;                 [(= type 2) (draw (first lst))])
;               (execute (rest lst) (remainder (add1 type) 3)))))]
;      (execute seq 0)]))
;
;;; Given n = 3337 and eb = public key = 2089
;;;
;;; p = 47
;;; q = 71
;;; db = secret key = 1489
;(execute-turtle-sequence (decrypt turtle-code 3337 (third (break-code 3337 2089))))