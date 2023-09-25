def isGreaterThan0 (x : Nat) : IO Bool := do
  IO.println s!"x: {x}"
  return x > 0

def f2 (x y : Nat) : IO Unit := do 
  if (<- isGreaterThan0 x) then 
    if (<- isGreaterThan0 y) then 
      IO.println s!"{x} and {y} are greater than 0"

