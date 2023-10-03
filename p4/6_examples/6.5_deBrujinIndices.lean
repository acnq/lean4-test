inductive HList {α : Type v} (β : α → Type u) : List α → Type (max u v)
  | nil : HList β []
  | cons : β i → HList β is → HList β (i :: is)

infix:67 " :: " => HList.cons
notation "[" "]" => HList.nil 

inductive Member : α → List α → Type
  | head : Member a (a :: as)
  | tail : Member a bs → Member a (b::bs)  

def HList.get : HList β is → Member i is → β i 
  | a::as, .head => a 
  | a :: as, .tail h => as.get h 

inductive Ty where 
  | nat 
  | fn : Ty → Ty → Ty 

@[reducible] def Ty.denote : Ty → Type
  | nat => Nat 
  | fn a b => a.denote → b.denote

inductive Term: List Ty → Ty → Type
  | var : Member ty ctx → Term ctx ty 
  | const : Nat → Term ctx .nat 
  | plus : Term ctx .nat → Term ctx .nat → Term ctx .nat 
  | app  : Term ctx (.fn dom ran) → Term ctx dom → Term ctx ran 
  | lam  : Term (dom :: ctx) ran → Term ctx (.fn dom ran)
  | «let» : Term ctx ty₁ → Term (ty₁ :: ctx) ty₂ → Term ctx ty₂  

open Ty Term Member
def add : Term [] (fn nat (fn nat nat)) := 
  lam (lam (plus (var (tail head)) (var head)))

def three_the_hard_way : Term [] nat := 
  app (app add (const 1)) (const 2)

@[simp] def Term.denote : Term ctx ty → HList Ty.denote ctx → ty.denote
  | var h,      env => env.get h 
  | const n,    _   => n 
  | plus a b,   env => a.denote env + b.denote env 
  | app f a,    env => f.denote env (a.denote env)
  | lam b,      env => fun x => b.denote (x :: env)
  | «let» a b,  env => b.denote (a.denote env :: env)

example : three_the_hard_way.denote [] = 3 := 
  rfl 

@[simp] def Term.constFold : Term ctx ty → Term ctx ty
  | const n   => const n 
  | var h     => var h 
  | app f a   => app f.constFold a.constFold
  | lam b     => lam b.constFold
  | «let» a b => «let» a.constFold b.constFold
  | plus a b  => 
    match  a.constFold, b.constFold with 
      | const n, const m  => const (n + m)
      | a',      b'       => plus a' b' 

theorem Term.constFold_sound (e : Term ctx ty) : e.constFold.denote env = e.denote env :=   
by 
  induction e with simp [*]
    | plus a b iha ihb => 
      split 
      next he₁ he₂ => simp [← iha, ← ihb, he₁, he₂]
      next => simp [iha, ihb]


