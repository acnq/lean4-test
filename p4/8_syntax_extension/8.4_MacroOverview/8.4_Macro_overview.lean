/- Declares a parser -/
syntax (priority := high) "{" term,+ "}" : term 

/- Declares two expansions/syntax transformers -/
macro_rules
  | `({$x}) => `(Set.singleton $x)
  | `({$x, $xs:term,*}) => `(Set.insert $x {$xs,*})
/- Provided `Set` has been imported (from Mathlib4), these are all we need for `{1, 2, 3}` to be valid notation to create a literal set -/

open Lean
inductive Syntax where
  | missing : Syntax
  | node (kind : SyntaxNodeKind) (args : Array Syntax) : Syntax
  | atom : String -> Syntax
  | ident : Name -> Syntax
abbrev MacroM := ReaderT Macro.Context (EStateM Macro.Exception Macro.State)
structure Context where
  methods       : MethodsRef
  mainModule    : Name
  currMacroScope: MacroScope
  currRecDepth  : Nat := 0
  maxRecDepth   : Nat := defaultMaxRecDepth
  ref           : Lean.Syntax

inductive Exception where
  | error             : Lean.Syntax → String → Exception
  | unsupportedSyntax : Exception

structure State where
  macroScope : MacroScope
  traceMsgs  : List (Prod Name String) := List.nil
  deriving Inhabited

/- test whether the git is OK?-/
