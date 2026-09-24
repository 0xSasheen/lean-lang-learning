import Mathlib

-- add a main function so the project builds.
def main : IO Unit :=
  IO.println "Hello, world!"

------------------------------------------------

-- FORALL a,b: Odd(a) -> Odd(b) -> Even(a + b)

-- we need to define what "odd" and "even" actually are.
-- in this case, we say that:
/-

  A number n ∈ ℕ is odd if there exists a number r ∈ ℕ such that n = r + r + 1.
  A number n ∈ ℕ is even if there exists a number r ∈ ℕ such that n = r + r.

-/
-- this makes sense. the definition we are used to is n = 2k, but instead of k we use r
-- for odd it's 2k + 1, or k + k + 1, but since we use r it's r + r + 1.

------------------------------------------------
def Odd1 (a : Nat) : Prop :=
∃ r : Nat, a = r + r + 1

def Even1 (b : Nat) : Prop :=
∃ r : Nat, b = r + r

theorem OddPlusOddIsEven (a : Nat) (b : Nat) (ha : Odd1 a) (hb : Odd1 b) : Even1 (a + b) := by
  obtain ⟨r1, hr1⟩ := ha
  obtain ⟨r2, hr2⟩ := hb
  rw [hr1, hr2]
  use (r1 + r2 + 1)
  ring

------------------------------------------------
-- practice!
-- prove even + even = even
/-

  2k1 + 2k2
  = 2(k1 + k2)
  k1 + k2 ∈ ℕ, = k3
  2(k3) is odd.

-/

theorem EvenPlusEvenIsEven (a : Nat) (b : Nat) (ha : Even1 a) (hb : Even1 b) : Even1 (a + b) := by
  obtain ⟨r1, hr1⟩ := ha
  obtain ⟨r2, hr2⟩ := hb
  rw [hr1, hr2]
  use (r1 + r2)
  ring

------------------------------------------------
-- combining our parameters now. fancy
-- prove odd + even = odd
/-

  2k1 + (2k2 + 1)
  =  2k1 + 2k2 + 1
  = 2(k1 + k2) + 1
  k1 + k2 ∈ ℕ, = k3
  = 2(k3) + 1 is odd.

-/

theorem OddPlusEvenIsOdd (a b : Nat) (ha : Odd1 a) (hb : Even1 b) : Odd1 (a + b) := by
  obtain ⟨k1, hk1⟩ := ha
  obtain ⟨k2, hk2⟩ := hb
  rw [hk1, hk2]
  use (k1 + k2)
  ring
