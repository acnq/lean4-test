def main : IO UInt32 := do 
  IO.println "hello"
  IO.println "world"
  return 0 

#check IO.println "hello"
-- IO Unint
#print main 
-- Output contains the infix operator `>>=` and `pure`
-- The following `set_option` disable notation such as `>>=` in the output
set_option pp.notation false in 
#print main 
-- Output contains `bind` and `pure`
#print bind 
-- bind : {m : Type u → Type v} → [self : Bind m] → {α β : Type u} →
--        m α → (α → m β) → m β
#print pure
-- pure : {m : Type u → Type v} → [self : Pure m] → {α : Type u} →
--        α → m α

-- IO implements the type classes `Bind` and `Pure`.
#check (inferInstance: Bind IO)
#check (inferInstance: Pure IO)

