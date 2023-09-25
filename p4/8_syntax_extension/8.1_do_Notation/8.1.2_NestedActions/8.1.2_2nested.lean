def isGreaterThan0 (x : Nat) : IO Bool := do 
  IO.println s!"x : {x}"
  return x > 0 

def f (x y : Nat) : IO Unit := do 
  if (<- isGreaterThan0 x) && (<- isGreaterThan0 y) then
    IO.println s!"{x} and {y} are greater than 0"
  else
    pure ()

#eval f 0 10 

-- value: 0
-- value: 10

-- The function `f` above is equivalent to
def g (x y : Nat) : IO Unit := do 
  let c1 <- isGreaterThan0 x 
  let c2 <- isGreaterThan0 y 
  if c1 && c2 then 
    IO.println s!"{x} and {y} are greater than 0"
  else 
    pure ()

theorem fgEqual : f = g := 
  rfl   -- proof by reflexivity
