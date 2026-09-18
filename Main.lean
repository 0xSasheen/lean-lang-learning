import LEANLEARNING

-- variables are declared using def. def [name] : [type] := [value]
def test : String := "Hello world!"

-- variables may be used as values in expressions
#eval test

-- functions are declared using def. def [name] [param : type] : [return type] := [func]
def max (a : Nat) (b : Nat) : Nat :=
  if a > b then a
  else b

-- Lean defaults to unsigned Natural numbers. Use int for negative calculations
#eval (1 - 2 : Int)

def joinStringsWith (joiner : String) (b : String) (c : String) : String :=
  String.append b (String.append joiner c)

#eval joinStringsWith ", " "one" "and another"

def volume (height : Nat) (width : Nat) (depth : Nat) : Nat :=
  height * width * depth

#eval volume 10 20 30

structure RectangularPrism where
  height : Float
  width : Float
  depth : Float

def volume2 (prism : RectangularPrism) : Float :=
  prism.height * prism.width * prism.depth

def prism : RectangularPrism := { height := 4.0, width := 2.0, depth := 1.0 }

#eval volume2 prism
