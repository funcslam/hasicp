-- 1.2 프로시저와 프로세스 Procedures and Processes
-- 프로시저 = 컴퓨터 프로세스가 해야 할 일을 밝힌 것.


if' True  c _ = c
if' False _ a = a
-- 1.2.1 재귀 recursion 반복 iteration 프로세스
-- 계승의 정의는 다음과 같다.
-- n! = n (n-1) (n-2) ... 3 * 2 * 1
factorial n = if' (n == 1) 1 (n * (factorial (n - 1)))
-- 이는 선형 재귀 프로세스로 계산된다.

-- 재귀 말고 다른 방법을 생각해보자.
-- 지금까지 곱한 값을 product, 1부터 n까지 헤아리는 변수를 counter라 하자.
-- product <- counter * product
-- counter <- counter + 1
-- counter 값이 1에서 시작해 n에 이르렀을 때, product 값은 n!이 된다.
factorial' n = factiter 1 1 n
    where
        factiter product counter maxcnt =
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
(+.) a b = if' (a == 0) b (succ $ (pred a) +. b)
(.+) a b = if' (a == 0) b ((pred a) .+ (succ b))
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


-- 1.1.2 여러 갈래로 되도는 프로세스 tree recursion
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
fib n = fibiter 1 0 n
    where fibiter a b cnt = if' (cnt == 0) b (fibiter (a + b) a (cnt - 1))


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
  | otherwise = (cc amount (kindsOfCoins - 1)) +
                (cc (amount - (firstDenomination kindsOfCoins)) kindsOfCoins)
firstDenomination kindsOfCoins
  | kindsOfCoins == 1 = 1
  | kindsOfCoins == 2 = 5
  | kindsOfCoins == 3 = 10
  | kindsOfCoins == 4 = 25
  | kindsOfCoins == 5 = 50

cc' :: Int -> [Int] -> Int
cc' amount coins
  | amount == 0 = 1
  | amount < 0 || coins == [] = 0
  | otherwise = cc' (amount - (head coins)) coins + cc' amount (tail coins)

