import Control.Monad.Trans.Writer

data FieldSet a = FieldSet
  { fields :: [a]
  } deriving (Show)

instance Semigroup (FieldSet a) where
  (FieldSet xs) <> (FieldSet ys) = FieldSet (xs <> ys)

instance Monoid (FieldSet a) where
  mempty = FieldSet []

data Root = Root
  { fsA :: FieldSet Int
  , fsB :: FieldSet String
  , fsC :: FieldSet Bool
  } deriving (Show)

instance Semigroup Root where
  (Root as1 bs1 cs1) <> (Root as2 bs2 cs2) =
    Root (as1 <> as2) (bs1 <> bs2) (cs1 <> cs2)

instance Monoid Root where
  mempty = Root mempty mempty mempty

addFieldA :: Int -> Root
addFieldA x = Root (FieldSet [x]) mempty mempty

addFieldB :: String -> Root
addFieldB x = Root mempty (FieldSet [x]) mempty

addFieldC :: Bool -> Root
addFieldC x = Root mempty mempty (FieldSet [x])

type App = Writer Root ()

tellFieldA :: Int -> App
tellFieldA = tell . addFieldA

tellFieldB :: String -> App
tellFieldB = tell . addFieldB

tellFieldC :: Bool -> App
tellFieldC = tell . addFieldC

run :: App
run = do
  tellFieldA 1
  tellFieldA 2
  tellFieldA 3

main :: IO ()
main = do
  print $ mempty
    <> addFieldA 1
    <> addFieldA 2
    <> addFieldA 3
    <> addFieldB "Foo"
    <> addFieldB "Fib"
    <> addFieldB "Bar"
    <> addFieldC True
    <> addFieldC True
    <> addFieldC False

  print $ runWriter run 
