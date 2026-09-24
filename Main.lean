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

------------------------------------------------
-- prove even * 2 = even
/-

  2 * 2k1
  (2 * k1) ∈ ℤ, = k2
  2(k2) is even.

-/

theorem TwoTimesEvenIsEven (a : Nat) (ha : Even1 a) : Even1 (2 * a) := by
  obtain ⟨k1, hk1⟩ := ha
  rw [hk1]
  use (k1 + k1)
  ring

------------------------------------------------
-- using already-written theorems to prove other theorems
-- prove odd + 2 = odd
/-

  2 + (2k + 1)
  2 + 2k + 1
  2k + 3
  even + odd = odd

-/

theorem OddPlusTwoIsOdd (a : Nat) (ha : Odd1 a) : Odd1 (a + 2) := by
  obtain ⟨k1, hk1⟩ := ha
  rw [hk1]

  -- we will use the lemma OddPlusEvenIsOdd. We have to rearrange to match the form
  rw [add_assoc]
  simp
  rw [add_comm]


  -- we have to prove that 3 is odd and k1 + k1 is even
  -- these are known as 'local propositions' - small inline proofs for whatever you want

  have Oddh3 : ∃ r : Nat, 3 = r + r + 1 := ⟨1, rfl⟩
  have Even2k1 : ∃ r : Nat, k1 + k1 = r + r := ⟨k1, rfl⟩

  -- use the previously defined OddPlusEvenIsOdd theorem to prove our statement
  exact OddPlusEvenIsOdd 3 (k1 + k1) Oddh3 Even2k1

------------------------------------------------
-- practice!
-- prove odd + 2 = odd
/-

2 + 2k
2(1 + k)

-/

theorem EvenPlusTwoIsEven (a : Nat) (ha : Even1 a) : Even1 (a + 2) := by
  obtain ⟨k, hk⟩ := ha
  rw [hk]

  -- prove that 2 is even and k + k is even
  have Evenh2 : ∃ r : Nat, 2 = r + r := ⟨1, rfl⟩
  have Evenh2k : ∃ r : Nat, k + k = r + r := ⟨k, rfl⟩

  -- use the previously defined EvenPlusEvenIsEven theorem to prove our statement
  exact EvenPlusEvenIsEven (k + k) 2 Evenh2k Evenh2
