infixl:65     " + " => HAdd.hadd  -- left-associative
infix:50      " = " => Eq         -- non-associative 
infixr:80     " ^ " => HPow.hPow  -- right-associative
prefix:75     "-"   => Neg.neg 
set_option quotPrecheck false 
postfix:max   "⁻¹"  => Inv.inv

notation:65 lhs:65 " + " rhs:66  => HAdd.hAdd lhs rhs 
notation:50 lhs:51 " = " rhs:51  => Eq lhs rhs 
notation:80 lhs:81 " ^ " rhs:80  => HPow.hPow lhs rhs 
notation:75 "-" arg:75 => Neg.neg arg 
set_option quotPrecheck false 
notation:1024 arg:1024 "⁻¹" => Inv.inv arg -- `max` is a shorthand for precedence 1024

notation:65 lhs:65 " ~ " rhs:65 => wobble lhs rhs 
notation:max "(" e ")" => e 
notation:10 Γ " ⊢ " e " : " τ =>  Typing Γ e τ 