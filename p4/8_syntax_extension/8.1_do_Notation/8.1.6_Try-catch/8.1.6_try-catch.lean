def showUserInfo (getUsername getFavoriteColor : IO (Option String)) : IO Unit := do 
  let some n ← getUsername | IO.println "no username!"
  IO.println s!"username: {n}"
  let some c ← getFavoriteColor | IO.println "user didn't provide a favorite color !"
  IO.println s!"favorite color: {c}"

-- username: JohnDoe
-- favorite color: red
#eval showUserInfo (pure <| some "JohnDoe") (pure <| some "red")

-- no username 
#eval showUserInfo (pure none) (pure <| some "purple")

-- username: JaneDoe
-- user didn't provide a favorite color
#eval showUserInfo (pure <| some "JaneDoe") (pure none)

