#! /usr/bin/env gsi -:dR

;;; ZAKI YOUSSEF 

;;; Fichier : RPN.scm

;;; Ce programme est une version incomplete du TP2.  Vous devez uniquement
;;; changer et ajouter du code dans la première section.

;;;----------------------------------------------------------------------------

;;; Vous devez modifier cette section.  La fonction "traiter" doit
;;; être définie, et vous pouvez ajouter des définitions de fonction
;;; afin de bien décomposer le traitement à faire en petites
;;; fonctions.  Il faut vous limiter au sous-ensemble *fonctionnel* de
;;; Scheme dans votre codage (donc n'utilisez pas set!, set-car!,
;;; begin, etc).

;;; La fonction traiter reçoit en paramètre une liste de caractères
;;; contenant la requête lue et le dictionnaire des variables sous
;;; forme d'une liste d'association.  La fonction retourne
;;; une paire contenant la liste de caractères qui sera imprimée comme
;;; résultat de l'expression entrée et le nouveau dictionnaire.  Vos
;;; fonctions ne doivent pas faire d'affichage car c'est la fonction
;;; "repl" qui se charge de cela.


(define traiter
  (lambda(lst dict)
  (define (cdr0 lst) (if (null? lst) lst (cdr lst))) ; saute un element si la liste n'est pas encore vide
  (let loop ((lst lst) (token '()) (stack '()) (dict dict))
    (cond
      ; fin-> retourne une paire qui contient une liste de chars qui seront affichees et le dictionnaire
      ((and (null? token) (null? lst)) (append(list(convert stack))dict))
      ; fin du mot ->treater
      ((and (or (null? lst) (eq? (car lst) #\space))
            (not (null? token)))
       (let* ((token-string (list->string (reverse token)))
              (n            (string->number token-string)))  ; convertir a un nombre 
         (cond	;pour quitter
           ((string=? token-string "quit")
            (exit))      
           (n   ; si nombre
            (loop (cdr0 lst) '() (cons n stack) dict))
           ; = var
           ((string=? (substring token-string 0 1) "=")            
            (let* ((x (substring token-string 1 2))    ; prendre la variable               
                  (test (assoc x dict)))  ;tester si on trouve la variable dans dict
             (if test   ; si test = TRUE ( la variable est deja dans dict)
                 (loop (cdr0 lst)'() stack (cons (list x (car stack))(del test dict))) ; on associe le noveau valeur
                 (loop (cdr0 lst)'() stack (cons (list x (car stack)) dict))))) ;sinon, on ajoute la nouvelle liste dans dict
           ; Multiplication
           ((string=? token-string "*")
            (loop (cdr0 lst) '() (cons (* (car stack) (cadr stack)) (cddr stack)) dict)) 
           ; Addition
           ((string=? token-string "+")
            (loop (cdr0 lst) '() (cons (+ (car stack) (cadr stack)) (cddr stack)) dict))
           ; Soustraction
           ((string=? token-string "-")
            (loop (cdr0 lst) '() (cons (- (cadr stack) (car stack)) (cddr stack)) dict))
           ; Division
           ((string=? token-string "/")
            (loop (cdr0 lst) '() (cons (/ (cadr stack) (car stack)) (cddr stack)) dict))
           ; si c'est une variable sans affectation
            (else
            (let((test2 (assoc token-string dict)))
              (if test2 ; si test2 = TRUE 
            (loop (cdr0 lst) '() (append(cdr(assoc token-string dict))stack)  dict); on recupere sa valeur du dict et on le met dans le stack 
 	    (and(display "error")(newline)(repl dict)))))))) ;sinon , on affiche erreur et on continue.
      (else
       (loop (cdr lst)
             (if (char=? (car lst) #\space) token (cons (car lst) token)) ; sauter les espaces
             stack
             dict))))))
          
(define convert ; Pour convetrir le stack en liste des cars, sert pour l'affichage du resultat.
  (lambda(l)
    (if (null? l)l
   (string->list(number->string (car l))))))

(define del  ; Pour suprimier une liste dans le dict.
  (lambda(item list) 
  (cond 
    ((null? list) '())
    ((equal? item (car list)) (cdr list))
    (else (cons (car list) (del item (cdr list)))))))

;;;----------------------------------------------------------------------------

;;; Ne pas modifier

(define repl
  (lambda (dict)
    (print "?")
    (let ((ligne (read-line)))  
          (let ((r (traiter-ligne ligne dict)))
            (for-each write-char (car r))
            (newline)
            (repl (cdr r))))))

(define traiter-ligne
  (lambda (ligne dict)
    (traiter (string->list ligne) dict)))

(define main
  (lambda ()
    (repl '()))) 
    
