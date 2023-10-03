-- Binary Search Trees [BST]

inductive Tree (β : Type v) where
  | leaf 
  | node (left : Tree β) (key : Nat) (value : β) (right : Tree β)
deriving Repr 

def Tree.contains (t : Tree β) (k : Nat) : Bool := 
  match t with 
  | leaf => false 
  | node left key value right =>
    if k < key then 
      left.contains k 
    else if key < k then 
      right.contains k 
    else 
      true 

def Tree.find? (t : Tree β) (k : Nat) : Option β := 
  match t with 
  | leaf => none 
  | node left key value right =>
    if k < key then 
      left.find? k 
    else if key < k then 
      right.find? k 
    else 
      some value 

def Tree.insert (t : Tree β) (k : Nat) (v : β) : Tree β := 
  match t with 
  | leaf => node leaf k v leaf 
  | node left key value right =>
    if k < key then 
      node (left.insert k v) key value right 
    else if key < k then 
      node left key value (right.insert k v)
    else 
      node left k v right 


def Tree.toList (t : Tree β) : List (Nat × β) := 
  match t with 
  | leaf => []
  | node l k v r => l.toList ++ [(k, v)] ++ r.toList

#eval Tree.leaf.insert 2 "two"
  |>.insert 3 "three"
  |>.insert 1 "one"

#eval Tree.leaf.insert 2 "two"
  |>.insert 3 "three"
  |>.insert 1 "one"
  |>.toList
  
def Tree.toListTR (t : Tree β) : List (Nat × β) := -- tail recursion version 
  go t []
where 
  go (t : Tree β) (acc : List (Nat × β)) : List (Nat × β) := 
    match t with 
    | leaf => acc 
    | node l k v r => go l ((k, v) :: go r acc)

theorem Tree.toList_eq_toListTR (t : Tree β)
        : t.toList = t.toListTR := by 
  simp [toListTR, go t []]
where 
  go (t : Tree β) (acc : List (Nat × β))
      : toListTR.go t acc = t.toList ++ acc := by 
    induction t generalizing acc <;> 
      simp [toListTR.go, toList, *, List.append_assoc]

@[csimp] theorem Tree.toList_eq_toListTR_csimp 
                  : @Tree.toList = @Tree.toListTR := by 
  funext β t 
  apply toList_eq_toListTR

-- ForallTree express that a predicate holdst at every node of a tree
inductive ForallTree (p : Nat → β → Prop) : Tree β → Prop 
  | leaf : ForallTree p .leaf 
  | node : 
    ForallTree p left → 
    p key value → 
    ForallTree p right → 
    ForallTree p (.node left key value right)

-- the BST invariant: An empty tree is a BST. 
-- A non-empty tree is a BST if all its left nodes have a lesser key, 
-- its right nodes have a greater key,
inductive BST : Tree β → Prop 
  | leaf : BST .leaf 
  | node : 
    ForallTree (fun k v  => k < key) left → 
    ForallTree (fun k v  => key < k) right →
    BST left → BST right → 
    BST (.node left key value right)

/-- The `have_eq lhs rhs` tactic (tries to) prove that `lhs = rhs`,
    and then replaces `lhs` with `rhs`. -/
local macro "have_eq " lhs:term:max rhs:term:max : tactic =>
  `(tactic|
    ( have h : $lhs = $rhs :=
        -- TODO: replace with linarith
        by simp_arith at *; apply Nat.le_antisymm <;> assumption
      try subst $lhs))

/-- `by_cases' e` is a shorthand form `by_case e <;> simp[*]` -/
local macro "by_cases' " e:term : tactic =>
  `(tactic | by_cases $e <;> simp [*])

attribute [local simp] Tree.insert 

theorem Tree.forall_insert_of_forall 
        (h₁ : ForallTree p t) (h₂ : p key value )
        : ForallTree p (t.insert key value) := by 
  induction h₁ with 
  | leaf => exact .node .leaf h₂ .leaf 
  | node hl hp hr ihl ihr => 
    rename Nat => k 
    by_cases' key < k 
    . exact .node ihl hp hr 
    . by_cases' k < key 
      . exact .node hl hp ihr 
      . have_eq key k 
        exact .node hl h₂ hr 

theorem Tree.bst_insert_of_bst 
        {t : Tree β} (h : BST t) (key : Nat) (value : β)
        : BST (t.insert key value) := by 
  induction h with 
  | leaf => exact .node .leaf .leaf .leaf .leaf 
  | node h₁ h₂ b₁ b₂ ih₁ ih₂ =>
    rename Nat => k 
    simp
    by_cases' key < k
    . exact .node (forall_insert_of_forall h₁ ‹key < k›) h₂ ih₁ b₂
    . by_cases' k < key
      . exact .node h₁ (forall_insert_of_forall h₂ ‹k < key›) b₁ ih₂
      . have_eq key k
        exact .node h₁ h₂ b₁ b₂

def BinTree (β : Type u) := {t : Tree β // BST t}

def BinTree.mk : BinTree β := 
  ⟨.leaf, .leaf⟩

def BinTree.contains (b : BinTree β) (k : Nat) : Bool := 
  b.val.contains k 

def BinTree.find? (b : BinTree β) (k : Nat) : Option β := 
  b.val.find? k 

def BinTree.insert (b : BinTree β) (k : Nat) (v : β) : BinTree β := 
  ⟨b.val.insert k v, b.val.bst_insert_of_bst b.property k v⟩

attribute [local simp]
  BinTree.mk BinTree.contains BinTree.find?
  BinTree.insert Tree.find? Tree.contains Tree.insert 

theorem BinTree.find_mk (k : Nat)
        : BinTree.mk.find? k = (none : Option β) := by 
  simp 

theorem BinTree.find_insert (b : BinTree β) (k : Nat) (v : β)
        : (b.insert k v).find? k = some v := by 
  let ⟨t, h⟩ := b; simp 
  induction t with simp 
  | node left key value right ihl ihr =>
    by_cases' k < key 
    . cases h; apply ihl; assumption 
    . by_cases' key < k 
      cases h; apply ihr; assumption 

theorem BinTree.find_insert_of_ne (b : BinTree β) (h : k ≠ k') (v : β)
        : (b.insert k v).find? k' = b.find? k' := by 
  let ⟨t, h⟩ := b; simp 
  induction t with simp 
  | leaf =>
    split <;> simp <;> split <;> simp 
    have_eq k k'
    contradiction 
  | node left key value right ihl ihr =>
    let .node hl hr bl br := h 
    specialize ihl bl 
    specialize ihr br 
    by_cases' k < key; by_cases' key < k 
    have_eq key k 
    by_cases' k' < k; by_cases' k < k'
    have_eq k k' 
    contradiction 
