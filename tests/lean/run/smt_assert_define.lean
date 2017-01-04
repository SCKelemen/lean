open smt_tactic

example (a b c : nat) : a = b + 0 → a + c = b + c :=
by using_smt $ do
  pr ← tactic.to_expr `(add_zero b),
  note `h pr,
  trace_state, return ()

constant p : nat → nat → Prop
constant f : nat → nat
axiom pf (a : nat) : p (f a) (f a) → p a a

example (a b c : nat) : a = b → p (f a) (f b) → p a b :=
by using_smt $ do
  t ← tactic.to_expr `(p (f a) (f a)),
  assert `h t,  -- assert automatically closed the new goal
  trace_state,
  tactic.trace "-----",
  pr ← tactic.to_expr `(pf _ h),
  note `h2 pr,
  trace_state,
  return ()
