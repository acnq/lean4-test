def isGreaterThan0 (x : Nat) : IO Bool := do 
  IO.println s!"x : {x}"
  return x > 0 

def f (x : Nat) : IO Unit := do 
  if (<- isGreaterThan0 x) then 
    IO.println s!"{x} is greater than 0"
  else 
    pure ()

#print f 