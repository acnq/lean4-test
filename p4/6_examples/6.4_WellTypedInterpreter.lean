-- The Well-Typed Interpreter

-- Vectors 
inductive Vector (α : Type u) : Nat → Type u 
  | nil : Vector α 0 
  | cons : α → Vector α n → Vector α (n + 1)

infix:67 " :: " => Vector.cons 

inductive Ty where 
  | int 
  | bool 
  | fn (a r : Ty)

@[reducible] def Ty.interp : Ty → Type
  | int     => Int 
  | bool    => Bool 
  | fn a r  => a.interp → r.interp 

inductive HasType : Fin n → Vector Ty n → Ty → Type where
  | stop  : HasType 0 (ty :: ctx) ty 
  | pop   : HasType k ctx ty → HasType k.succ (u :: ctx) ty 

inductive Expr : Vector Ty n → Ty → Type where 
  | var     : HasType i ctx ty → Expr ctx ty 
  | val     : Int → Expr ctx Ty.int 
  | lam     : Expr (a :: ctx) ty → Expr ctx (Ty.fn a ty)
  | app     : Expr ctx (Ty.fn a ty) → Expr ctx a → Expr ctx ty 
  | op      : (a.interp → b.interp → c.interp) → Expr ctx a → Expr ctx b → Expr ctx c 
  | ife     : Expr ctx Ty.bool → Expr ctx a → Expr ctx a → Expr ctx a 
  | delay   : (Unit → Expr ctx a) → Expr ctx a 

open HasType (stop pop)

-- HasType i ctx ty, proof that `var` i in context ctx has type ty 
-- `stop` prf that most recently defined var is well-typed 
-- `pop` n as a prf that, if nth most recently defiend var is well-typed, so is the n+1th.
-- `val` concrete representation of an Int
-- `lambda` creates a function, 
-- `app`function application, produces value of type `ty` given a function from `a` to `ty` and a value of type `a` 
-- `op` arbitrary binary operators 
-- `ife` if-then-else 
-- `delay` delay evaluation

-- `Env` environment, indexed over the types in scope 
inductive Env : Vector Ty n → Type where 
  | nil : Env Vector.nil 
  | cons : Ty.interp a → Env ctx → Env (a :: ctx)

infix:67 " :: " => Env.cons 

def Env.lookup : HasType i ctx ty → Env ctx → ty.interp
  | stop, x :: xs => x 
  | pop k, x:: xs => lookup k xs 


def Expr.interp (env : Env ctx) : Expr ctx ty → ty.interp
  | var i     => env.lookup i 
  | val x     => x 
  | lam b     => fun x => b.interp (Env.cons x env)
  | app f a   => f.interp env (a.interp env)
  | op o x y  => o (x.interp env) (y.interp env)
  | ife c t e => if c.interp env then t.interp env else e.interp env 
  | delay a   => (a ()).interp env 

open Expr

def add : Expr ctx (Ty.fn Ty.int (Ty.fn Ty.int Ty.int)) := 
  lam (lam (op (· + ·) (var stop) (var (pop stop))))

#eval add.interp Env.nil 10 20 

def fact : Expr ctx (Ty.fn Ty.int Ty.int) := 
  lam (ife  (op (· == ·) (var stop) (val 0))
            (val 1)
            (op (· * ·) (delay fun _ => app fact (op (· - ·) (var stop) (val 1))) (var stop)))
  decreasing_by sorry 

#eval fact.interp Env.nil 10 



