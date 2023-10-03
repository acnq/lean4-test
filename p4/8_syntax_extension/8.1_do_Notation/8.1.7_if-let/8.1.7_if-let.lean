def tryIncrement (getInput : IO (Option Nat)) : IO (Except String Nat) := do 
  if let some n ← getInput
  then return Except.ok n.succ
  else return Except.error "argument was `none`"

-- Except.ok 2
#eval tryIncrement (pure <| some 1)

-- Except.error "argument was `none`"
#eval tryIncrement (pure <| none)
