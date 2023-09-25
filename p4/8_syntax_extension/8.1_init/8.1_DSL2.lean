def main: IO UInt32 :=
  bind (IO.println "hello") fun _ => 
  bind (IO.println "world") fun _ => 
  pure 0 

def isGreaterThan0 (x : Nat) : IO Bool := do 
  IO.println s!"value: {x}"
  return x > 0 

def f (x : Nat) : IO Unit := do 
  let c <- isGreaterThan0 x 
  if c then 
    IO.println s!"{x} is greater than 0"
  else 
    pure ()

#eval f 10 