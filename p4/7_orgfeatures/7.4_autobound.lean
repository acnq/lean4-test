-- Auto Bound Implict Argument

universe u v w 
def compose {α : Type u} {β : Type v} {γ : Type w}
            (g : β → γ) (f : α → β) (x : α) : γ := 
  g (f x)

def compose'.{u', v', w'}
              {α : Type u'} {β : Type v'} {γ : Type w'}
              (g : β → γ) (f : α → β) (x : α) : γ := 
  g (f x)

def compose'' (g : β → γ) (f : α → β) (x : α) : γ := 
  g (f x)

#check @compose''

set_option autoImplicit false 
