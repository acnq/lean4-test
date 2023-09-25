def f (b1 b2 : Bool) : IO Unit := do 
  let xs := #[]
  let xs := if b1 then xs.push 0 else xs
  let xs := if b2 then xs.push 1 else xs
  IO.println xs 

#eval f true true
#eval f false true 
#eval f true false 
#eval f false false 

def f2 (b1 b2 : Bool) : IO Unit := do 
  let xs := #[]
  let ys := #[]
  let (xs, ys) := if b1 then (xs.push 0, ys) else (xs, ys.push 0)
  let (xs, ys) := if b2 then (xs.push 1, ys) else (xs, ys.push 1)
  IO.println s!"xs: {xs}, ys: {ys}"

#eval f2 true false

