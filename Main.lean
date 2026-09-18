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

-- Structures, like in C!
structure RectangularPrism where
  height : Float
  width : Float
  depth : Float

def volume2 (prism : RectangularPrism) : Float :=
  prism.height * prism.width * prism.depth

-- Defining a structure is very similar to defining regular variables.
-- It is important to use the curly-brace structure to define struct members.
-- To define a structure in-line, eg. #check { height := 1.0, width := 1.0, length := 1.0}, you
-- must include a definition of the type. This can be done easily as shown below:
-- { height := 1.0, width := 1.0, length := 1.0 : RectangularPrism}
def prism : RectangularPrism := { height := 4.0, width := 2.0, depth := 1.0 }

#eval volume2 prism

structure Segment where
  extr1 : Float
  extr2 : Float

def length (lineSegment : Segment) : Float :=
  lineSegment.extr2 - lineSegment.extr1

def lineSeg : Segment := { extr1 := 1.0, extr2 := 5.0 }

#eval length lineSeg
