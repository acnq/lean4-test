-- Namespace 
namespace Foo
  def a : Nat := 5
  def f (x : Nat) : Nat := x  + 7 

  def fa : Nat := f a 
  def ffa : Nat := f (f a)

  #check a 
  #check f 
  #check fa 
  #check ffa 
  #check Foo.fa
end Foo 

-- #check a -- error
-- #check f -- error 
#check Foo.a 
#check Foo.f
#check Foo.fa
#check Foo.ffa 

open Foo 

#check a 
#check f 
#check fa 
#check Foo.fa 

#check List.nil 
#check List.cons
#check List.map 

open List 

#check nil 
#check cons 
#check map 

namespace Foo_
  def a : Nat := 5
  def f (x : Nat) : Nat := x  + 7 

  def fa : Nat := f a 

  namespace Bar 
    def ffa : Nat := f (f a)

    #check fa 
    #check ffa 
  end Bar 

  #check fa
  #check Bar.ffa 
end Foo_ 

#check Foo_.fa 
#check Foo_.Bar.ffa 

open Foo_

#check fa 
#check Bar.ffa 

namespace Foo_
  def a_ : Nat := 5 
  def f_ (x : Nat) : Nat := x + 7 

  def fa_ : Nat := f_ a_ 
end Foo_ 

#check Foo_.a_
#check Foo_.f_

namespace Foo_
  def ffa_ : Nat := f_ (f_ a_)
end Foo_

