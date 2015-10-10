-- Minimal implicational logic, PHOAS approach, initial encoding

{-# LANGUAGE DataKinds, GADTs, KindSignatures, Rank2Types, Safe, TypeOperators #-}

module STLC where


-- Types

infixr 0 :=>

data Ty :: * where
  UNIT  ::             Ty
  (:=>) :: Ty -> Ty -> Ty


-- Context

-- NOTE: Haskell does not support kind synonyms
-- type Cx = Ty -> *


-- Terms

infixl 1 :$

data Tm :: (Ty -> *) -> Ty -> *
  where
    Var  ::  tc a
         ----------
         -> Tm tc a

    Lam  :: (tc a -> Tm tc b)
         --------------------
          -> Tm tc (a :=> b)

    (:$) :: Tm tc (a :=> b) -> Tm tc a
         -----------------------------
                 -> Tm tc b

type T a = forall tc. Tm tc a


-- Example theorems

aI :: T (a :=> a)
aI = Lam $ \x ->
       Var x

aK :: T (a :=> b :=> a)
aK = Lam $ \x ->
       Lam $ \_ ->
         Var x

aS :: T ((a :=> b :=> c) :=> (a :=> b) :=> a :=> c)
aS = Lam $ \f ->
       Lam $ \g ->
         Lam $ \x ->
           (Var f :$ Var x) :$ (Var g :$ Var x)

tSKK :: T (a :=> a)
tSKK = aS :$ aK :$ aK
