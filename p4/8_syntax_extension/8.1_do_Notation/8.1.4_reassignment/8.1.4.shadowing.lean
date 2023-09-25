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

-- joint-points 
def f3 (b1 b2 : Bool) : IO Unit := do 
  let jp1 xs ys := IO.println s!"xs: {xs}, ys: {ys}"
  let jp2 xs ys := if b2 then jp1 (xs.push 1) ys else jp1 xs (ys.push 1)
  let xs := #[]
  let ys := #[]
  if b1 then jp2 (xs.push 0) ys else jp2 xs (ys.push 0)

#eval f3 true false 


def f4 (b1 b2: Bool) : IO Unit := do 
  let mut xs := #[]
  if b1 then xs := xs.push 0
  if b2 then xs := xs.push 1 
  IO.println xs 

#eval f4 true true




