def sum (xs : Array Nat) : IO Nat := do 
  let mut s := 0 
  for x in xs do 
    IO.println s!"x: {x}"
    s := s + x 
  return s 

#eval sum #[1, 2, 3]

-- We can write pure code using the `Id.run <| do` DSL too.
def sum' (xs : Array Nat) : Nat := Id.run <| do 
  let mut s := 0 
  for x in xs do 
    s := s + x
  return s 

#eval sum' #[1, 2, 3]

def sumEven (xs : Array Nat) : IO Nat := do 
  let mut s := 0
  for x in xs do 
    if x % 2 == 0 then 
      IO.println s!"x: {x}"
      s := s + x 
  return s 

#eval sumEven #[1, 2, 3, 6]

def splitEvenOdd (xs : List Nat) : IO Unit := do 
  let mut evens := #[]
  let mut odds := #[]
  for x in xs do 
    if x % 2 == 0 then 
      evens := evens.push x 
    else 
      odds := odds.push x 
  IO.println s!"evens: {evens}, odds: {odds}"

#eval splitEvenOdd [1, 2, 3, 4]

def findNatLessThan (x : Nat) (p : Nat → Bool) : IO Nat := do 
  -- [:x] is notation for the range [0, x)
  for i in [:x] do 
    if p i then 
      return i -- `return` from the `do` block
  throw (IO.userError "value not found")

#eval findNatLessThan 10 (fun x => x > 5 && x % 4 == 0)

def sumOddUpTo (xs : List Nat) (threshold : Nat) : IO Nat := do 
  let mut s := 0
  for x in xs do 
    if x % 2 == 0 then 
      continue -- it behaves like the `continue` statement in imperative languages
    IO.println s!"x: {x}"
    s := s + x 
    if s > threshold then 
      break -- it behaves like the `break` statement in imperative languages
  IO.println s!"result: {s}"
  return s 

#eval sumOddUpTo [2, 3, 4, 11, 20, 31, 41, 51, 107] 40 



