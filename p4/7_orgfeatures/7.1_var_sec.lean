-- variables and sections
def compose (α β γ : Type) (g : β → γ) (f : α → β) (x : α) : γ := 
  g (f x)

def doTwice (α : Type) (h : α → α) (x : α) : α := 
  h (h x)

def doThrice (a : Type) (h : α → α) (x : α) : α := 
  h (h (h x))


variable (α β γ : Type)

def compose' (g : β → γ) (f : α → β) (x : α) : γ := 
  g (f x)

def doTwice' (h : α → α) (x : α) : α := 
  h (h x)

def doThrice' (h : α → α) (x : α) : α := 
  h (h (h x))

variable (α β γ : Type)
variable (g : β → γ) (f : α → β) (h : α → α)
variable (x : α)

def compose'' := g (f x)
def doTwice'' := h (h x)
def doThrice'':= h (h (h x))

#print compose''
#print doTwice''
#print doThrice''

section useful 
  variable (α β γ : Type)
  variable (g : β → γ) (f : α → β) (h : α → α)
  variable (x : α)

  def compose2 := g (f x)
  def doTwice2 := h (h x)
  def doThrice2:= h (h (h x))
end useful 