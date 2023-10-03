-- String Interpolation
def name := "John"
def age := 28

#eval IO.println s!"Hello, {name}! Are you {age} years old?"
#eval IO.println ("Hello, " ++ name ++ "! Are you " ++ toString age ++ " years old?")

-- `println! <interpolated-string>` is a macro for `IO.println s!<interpolated-string>`
#eval println! "Hello, {name}! Are you {age} years old?"


-- Structure of an interpolated string 
def vals := [1, 2, 3]
#eval IO.println s! "\{ vals := {vals} }"
#eval IO.println s! "varialbels: {vals.map (fun i => s! "x_{i}")}"

-- `ToString` instances
structure Person where 
  name : String 
  age : Nat 

instance : ToString Person where 
  toString : Person -> String 
    | {name := n, age := v } => s! "\{ name := {n}, age := {v}}"

def person1 : Person := {
  name := "John"
  age := 28
}

#eval println! "person1: {person1}"