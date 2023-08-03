-- Implicit Argument
def compose (α β γ : Type) (g : β → γ) (f : α → β) (x : α) : γ := 
  g (f x)

def double (x : Nat) := 2 * x
def triple (x : Nat) := 3 * x 

#check compose Nat Nat Nat double triple 10 
#eval compose Nat Nat Nat double triple 10

def appendWorld (s : String) := s ++ "world"
#check String.length -- String → Nat 

#check compose String String Nat String.length appendWorld "hello" 
#eval compose String String Nat String.length appendWorld "hello"

#check compose _ _ _ double triple 10 -- Nat 
#eval compose Nat Nat Nat double triple 10 
#check compose _ _ _ String.length appendWorld "hello" 
#eval compose _ _ _ String.length appendWorld "hello"

def compose_ {α β γ : Type} (g : β → γ) (f : α → β) (x : α) : γ := 
  g (f x)

#check compose_ double triple 10 
#eval compose_ double triple 10 
#check compose_ String.length appendWorld "hello" 
#eval compose_ String.length appendWorld "hello"

universe u 

section 
  variable {α : Type u}
  variable (x : α)
  def ident := x 
end 

variable (α β : Type u)
variable (a : α) (b : β)

#check ident
#check ident a 
#check ident b 

def ident' {α : Type u} (a : α) : α := a 
#check (ident' : Nat → Nat) 

#check 2 
#check (2 : Nat)
#check (2 : Int)

variable (α β : Type)
#check ident
#check @ident
#check ident α
#check @ident α 
#check @ident β 
#check @ident Nat
#check @ident Bool true 

#check ident (α := Nat) 
#check ident (α := Bool)

