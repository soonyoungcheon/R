# 기본연산
2

# 수식
3*7+10

# 변수(할당자 : =)
a =3
b = 3+75
b  # 변수 b의 값을 화면에 표시
   # print(b)

# 변수 ( 할당 연산자 : <-)
c <- 3
d <- c*75
d

# 5 = e  # 사용불가
5 -> e  # 할당연산자를 반대로 사용  
e

?rm

rm(a)    # 변수제거
rm(b)
rm(c)
rm(d)
rm(e)

# '변수.멤버' 형대로 변수 선언 가능
kor <- 99
eng <- 98
mat <- 99

sj.name <- '지현'
sj.kor <- 99
sj.eng <- 98
sj.mat <- 99

sj.name

# 변수의 자료형
x <- 10
class(x)        # 변수의 자료형 조사
is.numeric(x)   # 변수가 실수인지 조사
is.integer(x)   # 변수가 정수인지 조사

y <- 10L 
class(y)
is.numeric(y)
is.integer(y)
is.double(y)


z <-  'abc'   # 문자
class(z)
is.character(z)
nchar(z)     # 문자수 출력

today <- '2018-10-22'
a <- as.Date(today)  # 날짜형으로 변환환
class(a)
as.numeric(a)        # 날짜를 숫자로 변환 
                     # 1970-01-01 기준 몇 일 후 인지

b <- TRUE            # 논리형(소문자 불가)
class(b)
is.logical(b)

TRUE*5              # T : 1
FALSE*5             # F : 0

# 변수 목록 확인
ls()

# 관계 연산자(>,<,==, !=)
x<-10
y<-100
x>y
x==y
x!=y

