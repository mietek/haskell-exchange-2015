-- Minimal implicational logic, PHOAS approach, initial encoding

module STLC where


-- Types

infixr 0 _=>_

data Ty : Set where
  UNIT :             Ty
  _=>_ : Ty -> Ty -> Ty


-- Context

Cx : Set1
Cx = Ty -> Set


-- Terms

infixl 1 _$_

data Tm (tc : Cx) : Ty -> Set
  where
    var : forall {a}   ->  tc a
                       ----------
                       -> Tm tc a

    lam : forall {a b} ->  (tc a -> Tm tc b)
                       ---------------------
                         -> Tm tc (a => b)

    _$_ : forall {a b} -> Tm tc (a => b) -> Tm tc a
                       ----------------------------
                               -> Tm tc b

T : Ty -> Set1
T a = forall {tc} -> Tm tc a


-- Example theorems

I : forall {a} -> T (a => a)
I = lam \x ->
      var x

K : forall {a b} -> T (a => b => a)
K = lam \x ->
      lam \_ ->
        var x

S : forall {a b c} -> T ((a => b => c) => (a => b) => a => c)
S = lam \f ->
      lam \g ->
        lam \x ->
          (var f $ var x) $ (var g $ var x)

SKK : forall {a} -> T (a => a)
SKK {a = a} = S {b = a => a} $ K $ K
