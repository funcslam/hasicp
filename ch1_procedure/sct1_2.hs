-- 1.2 프로시저와 프로세스
-- 프로시저 = 컴퓨n터 프로세스가 해야 할 일을 밝힌 것.
import Control.Monad
import System.Random

if' True  c _ = c
if' False _ a = a

main = putStrLn "1.2 Procedures and the Processes They Generate"
-- 1.2.1 재귀 recursion 반복 iteration 프로세스
-- 계승의 정의는 다음과 같다.
-- n! = n (n-1) (n-2) ... 3 * 2 * 1
factorial n = if' (n == 1) 1 (n * factorial (n - 1))
-- 이는 선형 재귀 프로세스로 계산된다.

-- 재귀 말고 다른 방법을 생각해보자.
-- 지금까지 곱한 값을 product, 1부터 n까지 헤아리는 변수를 counter라 하자.
-- product <- counter * product
-- counter <- counter + 1
-- counter 값이 1에서 시작해 n에 이르렀을 때, product 값은 n!이 된다.
factorial' n = factiter 1 1 n
  where factiter product counter maxcnt =
          if' (counter > maxcnt)
              product
              (factiter (counter * product) (counter + 1) maxcnt)
-- 이것은 선형 반복 프로세스로 계산된다.

-- 재귀 프로세스와 재귀 프로시저를 헛갈리지 말자.
--      재귀 프로시저 = 프로시저를 정의하는 식 속에서 자신을 불러 쓴다.
--      재귀 프로세스 = 실제 계산이 재귀적으로 펼쳐진다.
--          위의 재귀 factorial 처럼, 연산이 계속 지연되어 메모리를 소모한다.
-- 프로그램 실행기가 꼬리 재귀 최적화 기법으로 재귀 효율을 높일 수 있다.

-- 연습문제 1.9 
(+.) a b = if' (a == 0) b (succ $ pred a +. b)
(.+) a b = if' (a == 0) b (pred a .+ succ b)
-- 재귀 프로세스로 계산된다.

-- 연습문제 1.10
-- 애커만 함수 Ackermann function
akmnfunc x y 
  | y == 0    = 0
  | x == 0    = 2 * y
  | y == 1    = 2
  | otherwise = akmnfunc (x - 1) (akmnfunc x (y - 1))
-- akmnfunc 1 10
-- 1024
-- akmnfunc 2 4
-- 65536
-- akmnfunc 3 3
-- 65536

f n = akmnfunc 0 n
g n = akmnfunc 1 n
h n = akmnfunc 2 n
k n = 5 * n * n
-- f, g, h 프로시저의 기능을 수학으로 정의하라.
-- f(x) = 2x
-- g(x) = 2^x
-- h(x) = 2^^x (크누스 화살표 표기법)


-- 1.2.2 여러 갈래로 되도는 프로세스 Tree Recursion
-- 피보나치 수열은 0, 1, 1, 2, 3, 5, 8, 13, 21, ... 와 같이 전개된다.
-- 피보나치 수열을 수학적 정의대로 쓰면 다음과 같다.
fibslow n
  | n == 0    = 0
  | n == 1    = 1
  | otherwise = fibslow (n - 1) + fibslow (n - 2)
-- 이는 지수 비례로 계산 복잡도가 증가하기 때문에 비효율적이다.

-- 피보나치 수열을 반복 프로세스로 구할 수 있다.
-- Fib(1) = 1, Fib(0) = 0 이고, 상태 변수 a, b를 다음과 같다고 하자.
-- a <- a + b, b <- a 를 n번 반복하면 a = Fib(n + 1), b = Fib(n) 이 된다.
fib n = fib_iter 1 0 n
  where fib_iter a b cnt = if' (cnt == 0) b (fib_iter (a + b) a (cnt - 1))


-- 연습 : 돈 바꾸는 방법
-- 1달러를 50센트, 25센트, 10센트, 5센트, 1센트 동전으로 바꾸는 방법의 수는?
-- 재귀 프로시저를 사용하면 쉽다.
-- a만큼 동전이 있을 때, n가지 동전으로 바꾸는 가짓수 =
--      처음 나오는 동전을 아예 쓰지 않는 방법의 수 + 다 쓰는 방법의 수
-- 아예 쓰지 않는 방법의 수 =
--      맨 처음 나오는 한 가지 동전을 빼고 남은 동전으로 바꾸는 가짓수.
-- 다 쓰는 방법의 수 =
--      처음 동전이 d일 때, a - d한 돈을 n가지 동전으로 바꾸는 가짓수.
-- 이런 식으로 동전을 하나씩 줄여가다 보면 정답에 도달한다.

-- 
countChange amount = cc amount 5
cc amount kindsOfCoins
  | amount == 0 = 1
  | amount < 0 || kindsOfCoins == 0 = 0
  | otherwise = cc amount (kindsOfCoins - 1) +
                cc (amount - firstDenomination kindsOfCoins) kindsOfCoins
firstDenomination kindsOfCoins
  | kindsOfCoins == 1 = 1
  | kindsOfCoins == 2 = 5
  | kindsOfCoins == 3 = 10
  | kindsOfCoins == 4 = 25
  | kindsOfCoins == 5 = 50

cc' :: Int -> [Int] -> Int
cc' amount coins
  | amount == 0 = 1
  | amount < 0 || null coins = 0
  | otherwise = cc' (amount - head coins) coins + cc' amount (tail coins)

-- 연습문제 1.11
-- 함수 정의 그대로 쓰면 재귀 프로세스 프로시저가 된다.
f' n = if' (n < 3) n (f (n-1) + 2 * f (n-2) + 3 * f (n-3))
-- 반복 프로세스는 n을 루프 카운터로 쓴다.
f'' n = fiter 2 1 0 n
  where fiter _ _ c 0 = c
        fiter a b c n = fiter (a + 2 * b + 3 * c) a b (n-1)

-- 연습문제 1.12
-- 파스칼의 삼각형 정의 그대로 쓰면 재귀 프로세스가 된다.
pascal r c = if' (c==1 || c==r) 1 (pascal (r-1) (c-1) + pascal r (c-1))


-- 1.2.3 프로세스가 자라나는 정도 Order of Growth
-- 자람 차수 = Order of Growth. 입력의 크기에 따라 프로세스가 쓰는 자원의 증가 정도.
--      n 만큼 큰 문제를 푸는 데 드는 자원의 양을 R(n)이라고 할 때,
--      n과 무관한 상수 a, b에 대해 다음을 만족할 경우,
--      a f(n) <= R(n) <= b f(n)
--      R(n)은 theta of f(n)으로 자라난다고 한다.
-- Big-Theta, Big-O, Big-Omega의 관계 =
--      Big-O = asymptotically upper bound. 자람 차수의 상한.
--      Big-Omega = asymptotically lower bound. 자람 차수의 하한.
--      Big-Theta는 Big-O와 Big-Omega의 교집합이다. tight bound.

-- 연습문제 1.14
-- count-change 프로시저는 동전 개수의 지수 비례로 증가한다.

-- 연습문제 1.15
-- x가 충분히 작으면 sin x = x 이다.
-- 그 외의 경우 sin x = 3 * sin (x/3) - 4 * (sin (x/3)) ** 3 이다.
-- 이를 프로시저로 쓰면 다음과 같다.
cube x = x * x * x
p x = 3 * x - 4 * cube x
sine angle = if' (abs angle <= 0.1) angle (p (sine (angle/3.0)))
-- a. sine 12.15의 값을 구할 때 p 프로시저를 몇 번이나 불러 쓰는가?
-- sine 12.15
-- -> p $ sine 4.05
-- -> p $ p $ sine 1.35
-- -> p $ p $ p $ sine 0.45
-- -> p $ p $ p $ p $ sine 0.15
-- -> p $ p $ p $ p $ p $ sine 0.05
-- -> p $ p $ p $ p $ p $ 0.05
-- 다섯 번 호출한다.
-- b. sine a 의 기억 공간과 계산 단계의 자람 차수를 a의 함수로 나타내어라.
--


-- 1.2.4 거듭제곱 exponentiation
-- 밑수 b, 지수 n인 거듭제곱을 재귀 프로세스 프로시저로 쓰면 다음과 같다.
expt b n = if' (n==0) 1 (b * expt b (n-1))
-- 선형 반복 프로세스는 factorial때와 같은 방식으로 고쳐 쓸 수 있다.
expt' b n = exptiter b n 1
  where exptiter b c p = if' (c==0) p (exptiter b (c-1) (b*p))

-- 지수가 짝수일 경우 계산 단계를 더 줄일 수 있다.
fastexpt b n
  | n == 0    = 1
  | even n    = square (fastexpt b (n `div` 2))
  | otherwise = b * fastexpt b (n-1)

square x = x * x
-- 자람 차수는 log n이다.
-- n이 매우 클 경우, n과 log n의 차이는 매우 크다.

-- 연습문제 1.16
-- 반복 프로세스가 나오게끔 구현.
fastexpt' b n = exptiter b n 1
  where exptiter b c p
          | c == 0    = p
          | even c    = exptiter (square b) (c `div` 2) p
          | otherwise = exptiter b (c-1) (b*p)

-- 연습문제 1.17
-- 덧셈으로 곱셈 프로시저 구현.
(*.) a b = if' (b==0) 0 (a + (a *. (b-1)))
-- 정수 값을 두 배로 하는 함수 double, 짝수를 반으로 나누는 함수 halve를 이용.
-- 계산 프로세스가 로그 비례로 자라나도록 구현.
(.*.) a b
  | b == 0     = 0
  | otherwise  = if' (even b) (double (a .*. halve b)) (a + (a .*. (b-1)))
  where double = (* 2)
        halve  = (`div` 2)

-- 연습문제 1.18
-- (+), double, halve를 사용하여 반복 프로세스로 계산하는 곱셈 프로시저를 짜라.
-- Russian peasant method of multiplication
mult a b = rpm a b 0
  where rpm a b v
          | b == 0    = v
          | otherwise = if' (even b)
                            (rpm (double a) (halve b) v)
                            (rpm (double a) (halve b) (a+v))
        double = (* 2)
        halve  = (`div` 2)

-- 연습문제 1.19
-- 피보나치 수열의 계산 프로세스가 로그 차수로 자라나게 짜라.
-- 1.2.2의 fibiter에서 a <- a + b, b <- a인 규칙을 일반화하면 다음과 같다.
-- T(p,q): (a, b) -> (bq+aq+ap, bp+aq)
-- 피보나치 수열은 위 규칙 T(p,q)에서 a=1, b=0, p=0, q=1인 특수 경우와 같다.
fib' n = fibiter 1 0 0 1 n
  where fibiter a b p q cnt
          | cnt == 0  = b
          | even cnt  = fibiter a
                                b
                                (p^2 + q^2)
                                (2*p*q + q^2)
                                (cnt `div` 2)
          | otherwise = fibiter (b*q + a*q + a*p)
                                (b*p + a*q)
                                p
                                q
                                (cnt - 1)


-- 1.2.5 최대 공약수 Greatest Common Divisor
-- 유클리드 알고리즘: gcd(a, b) = gcd(b, r) where r = a `mod` b
gcd' a b = if' (b==0) a (gcd' b (mod a b))
-- 라메의 정리: 유클리드 알고리즘으로 gcd를 구하는 데 k단계를 거치는 경우,
--       두 수 가운데 작은 수는 k번째 피보나치 수보다 크거나 같아야 한다.

-- 연습문제 1.20
-- gcd(206, 40)를 구할 때 normal order = lazy evaluation으로 할 경우
-- mod 연산을 얼마나 하는지 보여라.

-- gcd 206 40
-- if' (40 == 0) ...
-- gcd 40 (206`mod`40)
-- if' (206`mod`40 == 0) ...
-- if' (6 == 0) ...
-- gcd (206`mod`40) (40`mod`(206`mod`40))
-- if' (40`mod`(206`mod`40) == 0) ...
-- if' (4 == 0) ...
-- gcd ((40`mod`(206`mod`40)) ((206`mod`40)`mod`(40`mod`(206`mod`40)))
-- if' ((206`mod`40)`mod`(40`mod`(206`mod`40)) == 0) ...
-- if' (2 == 0) ...
-- gcd ((206`mod`40)`mod`(40`mod`(206`mod`40)))
--     ((40`mod`(206`mod`40))`mod`((206`mod`40)`mod`(40`mod`(206`mod`40))))
-- if' ((40`mod`(206`mod`40))`mod`((206`mod`40)`mod`(40`mod`(206`mod`40))) == 0)
--     ...
-- if' (0 == 0) ...
-- ((206`mod`40)`mod`(40`mod`(206`mod`40)))
-- 2
-- mod 연산은 총 18회 수행한다.

-- applicative order = strict evaluation일 때도 보여라.
-- gcd 206 40
-- gcd 40 (206`mod`40)
-- gcd 40 6
-- gcd 6 (40`mod`6)
-- gcd 6 4
-- gcd 4 (6`mod`4)
-- gcd 4 2
-- gcd 2 (4`mod`2)
-- gcd 2 0
-- 2
-- mod 연산은 총 4회 수행한다.


-- 1.2.6 연습 : 소수 찾기 Testing for Primality
-- 약수 divisor 찾기
smallestdiv n = finddiv n 2
finddiv n t
  | t^2 > n      = n
  | n`mod`t == 0 = t
  | otherwise    = finddiv n (t+1)
-- 이 함수를 이용해, 가장 작은 약수가 자신과 같다면 소수라고 할 수 있다.
isprime n = n == smallestdiv n
-- 이는 입력 n에 대해 theta root n의 자람 차수를 갖는다.

-- 페르마 검사
-- 계산 복잡도가 log n인 소수 검사는 페르마의 작은 정리를 이용한다.
-- 페르마의 작은 정리 = 
-- n이 소수이고 a는 a < n인 양의 정수일 때, a^n과 a는 법 n에 대해 합동이다.
-- a^n 과 a는 congruent modulo n이다.
-- 이 정리를 역으로 이용해서, 주어진 n에 대해 a<n인 임의의 a를 골라 합동인지 검사한다.
-- 이를 만족하면 또 다른 a를 골라 검사를 반복한다.
-- 검사를 통과할 수록 n은 소수일 확률이 높아진다.
expmod base exp m
  | exp == 0  = 1
  | even exp  = mod (square (expmod base (exp`div`2) m)) m
  | otherwise = mod (base * expmod base (exp-1) m) m

fermattest n = do
  pick <- rndm $ n-1
  let a = 1 + pick
  return $ expmod a n n == a

rndm x = do
  gen <- newStdGen
  return $ fst $ randomR (1, x-1) gen

fastprime n times = do
  lst <- replicateM times $ fermattest n
  return $ and lst

-- 확률을 바탕으로 하는 알고리즘
-- 페르마 검사를 통과했다 해도 소수일 확률이 높을 뿐, 확정적인 결과를 내지 못한다.
-- 카마이클 수 = 페르마 검사를 쓸모없게 만드는 수. 합성수임에도 페르마 검사를 통과한다.
-- 페르마 검사의 조건을 약간 수정하여 예외가 없게 만든 밀러-라빈 검사가 있다.
-- 카마이클 수의 개수는 매우 적기 때문에, 소수일 확률이 높은 것은 공학적으로 의미가 있다.

-- 연습문제 1.21
-- smallest-divisor로 199, 1999, 19999의 약수를 찾아라.
-- smallestdiv 199 = 199
-- smallestdiv 1999 = 1999
-- smallestdiv 19999 = 7

-- 연습문제 1.22
