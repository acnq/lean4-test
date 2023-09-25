def isGreaterThan0 (x : Nat) : IO Bool := do 
  IO.println s!"x : {x}"
  return x > 0 

def f1 (x y : Nat) : IO Unit := do 
  if (<- isGreaterThan0 x <&&> isGreaterThan0 y) then 
    IO.println s!"{x} and {y} are greater than 0"
  else 
    pure ()

-- `<&&>` is the effectful version of `&&`
-- Given `x y : IO Bool`, `x <&&> y` : m Bool`
-- It only executes `y` if `x` returns `true`.

#eval f1 0 10 
#eval f1 1 10 

def f2 (x y : Nat) : IO Unit := do 
  if (<- isGreaterThan0 x) then 
    if (<- isGreaterThan0 y) then 
      IO.println s!"{x} and {y} are greater than 0"
    else
      pure ()
  else 
    pure ()

    