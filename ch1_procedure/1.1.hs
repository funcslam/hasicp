-- 1 Building Abstractions with Procedures

-- 프로세스 process = 데이터를 조작하면서 수행하는 일련의 행동. 마법.
-- 프로그램 program = 프로세스가 작동하는 방법을 기술한 규칙. 마법서.
-- 프로그래밍 언어 programming language = 마법서를 적는 데 필요한 말.
-- 프로그래머 programmer = 마법서를 적는 사람. 마법사.
-- 프로그래머의 소양 =
--      깊은 지식, 경험, 조심성.
--      프로그램의 구조를 제대로 짤 줄 안다.
--      오류를 찾아서 제대로 고칠 줄 안다.
-- 좋은 프로그램의 조건 = 부품 단위로 만들고, 고치고, 갈아 끼울 수 있다.

-- Lisp로 프로그램을 짠다는 것 = Lisp이 할 수 있는 것은 Haskell도 할 수 있다.
-- Haskell = 
--      함수형 언어의 표준을 목표로 하여 만들어진 언어.
--      순수 함수형, 지연 평가, 타입 추론.
--      오랜 기간동안 최적화된 컴파일러 GHC, 간단하고 유용한 REPL GHCi.
--      환경, 빌드, 패키지 관리 등 통합 도구 stack.


-- 1.1 프로그래밍의 기본 요소 The Elements of Programming
-- 좋은 프로그래밍 언어의 세 가지 표현 방식 =
--      기본 식 primitive expression = 언어에서 가장 간단한 것.
--      엮어내는 수단 means of combination = 식을 모아 복잡한 것으로 만든다.
--      요약하는 수단 means of abstraction = 복잡한 것에 이름붙여 간단히 쓴다.
-- 프로그래밍의 두 가지 요소 = 프로시저, 데이터.
--      데이터 data = 프로시저에서 사용하는 것. 자료.
--      프로시저 procedure = 데이터를 처리하는 규칙. 함수.
-- 좋은 프로그래밍 언어에는 기본 데이터, 기본 프로시저, 요약하는 수단이 있다.


-- 1.1.1 식 expression
-- 스킴에 실행기가 있는 것처럼, 하스켈에도 실행기가 있다.
-- 실행기는 식을 넣으면, 식을 계산하여, 결과를 보여준다. 이를 반복한다.
-- 이를 REPL이라고 한다. Read-Eval-Print Loop.
 
-- 486을 입력하면 486이 출력된다.
-- (+) 137 349
-- 486

-- 이건 그냥 이렇게 써도 된다.
-- 137 + 349
-- 486

-- 하스켈에서 기호로만 이루어진 함수는 기본적으로 중위 연산자이다.
-- 중위 연산자를 전위로 쓰고 싶으면 괄호로 감싼다.
-- (*) 5 99
-- 495

-- 식의 구조 = (f a1 a2 ...)
--      첫째는 함수(연산자 operator)가 온다.
--      둘째 이후에는 인자(피연산자 operand)가 온다.

-- (+ 21 35 12 7) 은 하스켈에서 이렇게 쓴다.
-- 27 + 35 + 12 + 7
-- 75

-- 아니면 이렇게...
-- foldr1 (+) [21, 35, 12, 7]
-- 75
-- 하스켈에서 (+)는 인자 두 개만 받을 수 있는 binary function이기 때문이다.

-- 복잡한 식도 문제 없다.
expr1 = (+) ((*) 3 ((+) ((*) 2 4) ((+) 3 5))) ((+) ((-) 10 7) 6)


-- 1.1.2 이름과 환경 naming and environment
-- 스킴에서는 define을 쓰지만, 하스켈에서는 =를 쓴다.
-- (define size 2)는 이렇게 쓴다.
size = 2
circumference r = 2 * pi * r

-- 정의 =는 식을 요약하는 수단이다.
-- 환경 environment = 정의한 (이름, 식) 쌍은 실행기 메모리상에 저장된다.


-- 1.1.3 엮은식을 계산하는 방법 evaluating combinations
-- 식의 구조 = (f a1 a2 ...)를 기억하는가?
-- 식이 여러 개로 엮일 수 있는 것도 알고 있다.
-- 엮은식의 내부는 여러 개의 부분 식으로 이루어져 있다.
-- 실행기는 엮은식을 여러 개의 부분 식으로 해석한다.
-- 각각의 부분 식들 역시 더 작은 부분 식으로 분해하여 해석한다.
-- 더 이상 분해할 수 없을 때 까지 분해한다. 분해한 식의 구성은 트리 모양이다.

-- 분해할 수 없는 기본 식 =
--      수식 = 리터럴.
--      붙박이 연산자 = built-in operator. 언어가 미리 정의해 둔 계산.
--      이름 = 다른 환경에서 정의한 식.

-- x = 3과 같은 =를 통한 식의 정의는 언어가 특별히 정의한 문법이다.
--      x = 3을 일반적인 식처럼 해석하면 답이 안 나온다.
--      x를 함수, =와 3을 인자라고 생각하면 계산이 될까?
--      이러한 것을 특별형태 special form 라고 한다.


-- 1.1.4 묶음 프로시저 compound procedure
-- 좋은 프로그래밍 언어의 요건을 다시 생각해보자 =
--      수와 산술 연산 등 기본 데이터와 기본 프로시저가 제공된다.
--      식을 엮어 쓸 수 있다.
--      이름을 붙여 정의할 수 있다.
-- (define (square x) (* x x))
square x = x * x
-- 이를 묶음 프로시저 compound procedure 라고 한다.

-- 프로시저를 정의하는 방법 =
--      <name> <formal parameters> = <body>
--      <name> = 프로시저의 이름. 환경에 저장된다.
--      <formal parameters> = 프로시저가 받는 인자 이름. <body>에서 사용된다.
--      <body> = 프로시저가 계산할 식.
-- 이름붙은 프로시저는 다음과 같이 다른 식에서 끌어다 쓸 수 있다.
sumofsquares x y = square x + square y
expr2 a = sumofsquares (a + 1) (a * 2)


-- 1.1.5 치환으로 프로시저를 실행하는 방법
-- 프로시저가 적용되는 규칙 =
--      프로시저 body 속의 모든 인자를 모두 전달된 값으로 치환한다.
--      이렇게 얻은 식의 값을 계산한다.

-- 식의 값을 구하는 방법 =
--      인자 먼저 계산법 applicative order = strict evaluation.
--          식을 적용하는 순서대로 바로 계산하는 방식이다.
--      정의대로 계산법 normal order = lazy evaluation.
--          식을 가능한 분해해서 필요할 때 까지 미루다가 계산하는 방식이다.
-- 스킴은 strict지만, 하스켈은 lazy이다.


-- 1.1.6 조건 식과 술어 conditional expressions and predicates
-- 조건에 따른 분기별로 값을 정할 수 있다.
abs x
  | x > 0   = x
  | x == 0  = 0
  | x < 0   = -x
abs' x = if' (x < 0) (-x) x
-- x > 0 과 같이 참, 거짓을 판별할 수 있는 식을 술어 predicate 라고 한다.

-- if는 p가 하나일 때 유용하다.
-- if <predicate> <consequent> <alternative>
-- 특별형태 if는 다음과 같이 함수로 구현할 수 있다.
if' :: Bool -> a -> a -> a
if' True  c _ = c
if' False _ a = a
--
-- 술어는 ==, > 이외에도 and, &&, or, || 등을 쓸 수 있다.
isin5to10 x = x > 5 && x < 10
-- 하스켈 표준 라이브러리에 >=, <이 정의되어 있으므로 약간 다르게 쓰자.
x .>=. y = x > y || x == y
x .<. y = not $ x .>=. y

-- 연습문제 1.2
expr3 = (/)((+)((+)5 4)((-)2((-)3((+)6((/)4 5)))))((*)((*)3((-)6 2))((-)2 7))
expr3' = (5+4+(2-(3-(6+4/5))))/(3*(6-2)*(2-7))

-- 연습문제 1.3
-- 세 숫자를 인자로 받아 그 중 큰 숫자 두 개를 제곱한 다음, 그 둘을 더한다.
sumoflargersquares a b c
  | c < a && c < b  = sos a b
  | b < a && b < c  = sos a c
  | otherwise       = sos b c
  where sos = sumofsquares


-- 1.1.7 연습 : 뉴튼 법으로 제곱근 찾기
-- 함수와 프로시저의 차이 =
--      함수 = 무엇이 어떤 성질을 지니는지 밝히는 일. 선언.
--      프로시저 = 그 무엇을 어떻게 만들지 또는 구할지 나타내는 일. 명령.

-- 뉴튼 법 = 제곱근 값을 근사적으로 구하는 방법.
--      x의 제곱근을 구하려고 한다. 제곱근 값에 가까운 값 y가 주어진다.
--      y와 x / y의 평균을 구한다. 이 값은 새로운 y가 된다.
--      이 작업을 반복한다.
--      x와 y의 제곱을 비교해본다.

sqrtiter guess x = if' (isgood guess x) guess (sqrtiter (improve guess x) x)
improve guess x = average guess (x / guess)
average x y = (x + y) / 2
isgood guess x = (abs' ((square guess) - x)) < 0.001
sqrt' x = sqrtiter 1.0 x

-- 연습문제 1.6
-- if를 condition 구문으로 재정의하기.
-- 이것을 뉴튼 법 코드에 적용해서 잘 작동하는지 시험해보자.
newif p c a | p = c | otherwise = a
sqrtiter' guess x = newif (isgood guess x)
                        guess
                        (sqrtiter' (improve guess x) x)
-- 잘 작동한다!

-- 연습문제 1.8
-- 세제곱근을 구하는 뉴튼 법 프로시저를 짜보자.
cubeiter guess x = if' (isgood guess x) guess (cubeiter (improve guess x) x)
    where improve guess x = (x / guess ** 2 + 2 * guess) / 3
          isgood guess x = (abs' ((guess ** 3) - x)) < 0.001
cbrt x = cubeiter 1.0 x


-- 1.1.8 블랙박스처럼 간추린 프로시저
-- 재귀 recursive 프로시저 = 프로시저 정의에서 자기 자신을 불러 쓰는 경우.
-- 프로시저를 쓰면서 큰 문제가 작은 문제로 자연스럽게 나뉜다.
--      추측값이 쓸만한지 따지는 것 = isgood 함수.
--      더 좋은 값을 구하는 것 = improve 함수.
-- 프로시저를 나누는 중요한 기준 = 작업 단위.
-- 프로시저를 끌어다 쓸 때, 해당 프로시저의 자세한 계산을 알 필요는 없다.

-- 갇힌 이름 local name
-- 매개변수 이름은 프로시저가 뜻하는 바에 아무런 영향을 주지 않아야 한다.
--      프로시저에 갇혀야 local 한다.
--      프로시저 본문 body 에서만 쓰는 이름이어야 한다.
-- 종속 변수 bound variable = 프로시저 내부에 매인 bind 변수.
-- 자유 변수 free variable = 프로시저 정의에 매이지 않은 변수.

-- 종속 변수와 자유 변수 구분법 =
--      람다 함수 f = \x y -> if' (x > a) x y 를 예로 들면,
--          x, y는 종속 변수이다.
--              종속 변수는 포인트 point 라고 하며, reduce 할 수 있다.
--              f = (> a) >== if' 과 같이 다시 쓸 수 있다.
--          a는 자유 변수이다.
--              자유 변수를 갖는 함수를 클로저 closure 라고 한다.

-- 안쪽 정의 internal definition 와 블록 구조 block structure
-- 이름 충돌을 막고 구현을 외부로부터 은닉 capsulation 하기 위해.

sqrt'' x = sqrtiter 1.0 x
    where
        isgood guess x   = (abs' ((square guess) - x)) < 0.001
        improve guess x  = average guess (x / guess)
        sqrtiter guess x = if' (isgood guess x)
                            guess
                            (sqrtiter (improve guess x) x)

-- 프로시저 내부 정의에서 x를 자유 변수로 만들어도 된다.
-- 프로시저는 이미 x를 알고 있기 때문에 따로 인자로 전달할 필요가 없다.

sqrt''' x = sqrtiter 1.0
    where
        isgood guess     = (abs' ((square guess) - x)) < 0.001
        improve guess    = average guess (x / guess)
        sqrtiter guess   = if' (isgood guess)
                            guess
                            (sqrtiter (improve guess))

-- 1.1절 끝
