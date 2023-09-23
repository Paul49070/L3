(*a-EX1:*)

(*

let prixTTC prixHT = 
    let tauxTVA = 1.2 
    in prixHT *. tauxTVA ;;

prixTTC 10.;;

*)

(*a-EX2*)

(*

let isBissextile annee =
    if(annee mod 4 = 0) then 
        if(annee mod 100 = 0) then 
            if(annee mod 400 = 0) then true
            else false
        else true
    else false;;

isBissextile 1700;;

*)

(*a-EX3*)

(*

let isUpper character = 
if(c >= 'a' && <= 'z') then true 
else false;;

isUpper 'A';;

*)

(*b-EX1*)

(*

let moyenne x y =(x+.y)/.2. ;;

moyenne 0. 15. ;;

*)

(*b-EX2*)

(*

let qANDr a b = 
    ((a/b), a mod b);;

qANDr 184 9 ;;

*)

(*c-EX1*)

(*

let puissance_4 x =
    let carre y = y*y in
    carre (carre x)
;;

puissance_4 2;;

*)

(*c-EX2*)

(*

let minTOmaj c = Char.uppercase_ascii c ;;

minTOmaj 'a' ;;

*)

(*ALGO FONCTIONS RECURSIVES*)

(*a*)

(*

let rec nFibo n = 
    if(n = 0) then 0
    else if (n = 1) then 1
    else nFibo(n-1)+nFibo(n-2);;

nFibo 6;;

*)

(*b*)

(*

let rec sumfirstSquare n =
    if(n=0) then 0
    else n*n + sumfirstSquare (n-1);;

sumfirstSquare 5;;

*)

(*ALGO FONCTIONS ORDRE SUPERIEUR*)

(*a*)

(*

let rec sigma n f =
    if(n=0) then f n
    else f n + sigma (n-1) f;;

let carre x = x*x ;; 

sigma 5 carre;;

*)

(*b*)

(*

let rond x f g = g (f x) ;;

*)

(*CALCUL RACINE CARRE NEWTON*)

(*a*)

(*

let absol x = if (x >= 0.) then x else -.x ;;

let rec newton x y eps = 
    if absol(y*.y-.x) <= eps then y
    else newton x ((y+.x/.y)/.2.) eps 
;;

let racine x = newton x x 0.00001 ;;

racine 4. ;;

*)

(*b*)

let absol x = if (x >= 0.) then x else -.x ;;

let racine x =
    let eps = 0.00001 
        in let correct y = absol(y*.y-.x) <= eps
            and suivant y = ((y+.x/.y)/.2.)
                in let rec newton y =
                    if correct y then y
                    else newton (suivant y)
    in newton x 
;;

racine 4. ;;












