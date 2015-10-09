-- Minimal implicational logic, PHOAS approach, initial encoding

module STLC

%default total


-- Types

infixr 0 :=>

data Ty : Type where
  UNIT  :             Ty
  (:=>) : Ty -> Ty -> Ty


-- Context

Cx : Type
Cx = Ty -> Type


-- Terms

infixl 1 :$

data Tm : Cx -> Ty -> Type
  where
    var  :  tc a
         ----------
         -> Tm tc a

    lam  :  (tc a -> Tm tc b)
         --------------------
          -> Tm tc (a :=> b)

    (:$) : Tm tc (a :=> b) -> Tm tc a
         ----------------------------
                 -> Tm tc b

T : Ty -> Type
T a = {tc : Cx} -> Tm tc a


-- Example theorems

I : T (a :=> a)
I = lam $ \x =>
      var x

K : T (a :=> b :=> a)
K = lam $ \x =>
      lam $ \_ =>
        var x

S : T ((a :=> b :=> c) :=> (a :=> b) :=> a :=> c)
S = lam $ \f =>
      lam $ \g =>
        lam $ \x =>
          (var f :$ var x) :$ (var g :$ var x)

SKK : T (a :=> a)
SKK {a} =
  S {b = a :=> a} :$ K :$ K
