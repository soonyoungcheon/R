
# R의 자료 구조

# 스칼라 : 변수에 한개의 값만을 저장
age <- 35
name <- '홍길동'

# 벡터 : 변수에 동일한 유형의 여8러개 값들을 저장
# c(), seq(), rep() 함수를 사용해서 벡터 생성
# 일반적으로 하나의 변수(속성)를 저장하는 최소 단위

num10 <- c(1,2,3,4,5,6,7,8,9,10)
num10

sj.name <- c('혜교','지현','수지')
sj.name


twotype1 <- c(1,2,"3")  # 벡터 안에 서로 다른 유형 자료 정의

twotype1
twovec <-c(9,8,7,c(1,2,3),c(4,5,6)) # 벡터안 벡터를 정의
twovec

num10 <- c(1:10)   # 시작:끝 형태로 벡터 정의
numeeven <- c(0,2,4,6,10)
numoeven <seq(0,10,2)
numodd <-seq(1,10,2)
numeeven
numodd

rep1 <- rep(1:3,3)   # 특정 숫자를 반복 출력
rep2 <- rep(1:3, each = 3)

# 33, -5, 20, 21,22,23,12,-2,-1,0,1,2,3

ex = c(33, -5, 20, 21,22,23,12,-2,-1,0,1,2,3)
ex1 = c(33, -5, seq(20,23,1),12, seq(-2,3,1))
# ex1 = c(33, -5, 20:23, 12, -2:3)

# 벡터 값 참조하기
# 벡터의 각 요소는 []를 사용해서 위치를 지정하고 참조할 수 있음
num10[5]
num10[-3]       # 특정요소를 제외시킴


# 벡터에는 이름을 부여할 수 있음
# names() 에 원하는 이름을 벡터로 넘겨줌
kor <- c(99, 98, 100)
names(kor) <- c('정해인', '송중기', '정윤호')
kor[1:2]
kor[c(1,3)]
kor['정윤호']


seq_len(100)

# 결측치 처리
# 만약 변수에 값이 존재하지 않으면 NA로 지정
one <- c(1,3,5,7,NA)
is.na(one)

# 변수만 선언하고 값을 초기화하기 않은 경우 NULL 로 지정
one <-c(2,4,6,8,NULL)
is.null(one)

one
length(one)
NROW(one)
2 %in% one

two <- NULL
is.null(two)

# NA vs NULL
# NA 는 결측치로 인식 - 요소는 존재, 데어터만 없음
# NULL은 객체가 없음 - 요소 없음, 데이터도 없음

#리스트
 # 성격이 다른 자료구조(백터, 행렬, 리스트, 데이터프레임)을 객체로 생성
# 메모지 영역에는 키와 값을 형태로 저장 - python의 dictionary 와 유사
# list 처리 함수는 list() unlist(), lapplay()
sj <- c('혜교', 99,98,99) # 모두 문자로 변환

sj <- list('혜교',99,98,99)  # 키없이 리스트 생성

sj # 전체
sj[[1]]  # 혜교에 대한 키 확인
sj[[1]][1] # 값
sj[[2]][1]
sj[1]  # 값과 키를 같이 출력
sj[2]

class(sj)    #자료구조 유형 출력

# 리스트 구조를 벡터 구조로 변경
vsj <- unlist(sj)
vsj   # 벡터구조로 변경


#하나 의상의 값을 리스트 객체 생성

num <- list(c(1:5), c(6:10))
num

num[1]
num[2]
num[[2]][3]

# 키와 값의 형식으로 리스트 지정
# list(키=값, .....)
sj<-list(name='혜교', kor=99, eng=98, mat=99)
sj$name      #sj[[name]]
sj$kor
sj$mat

num <- list(num1=c(1:5), num2=c(6:10))
num$num1
num$num2[3]

# 값 수정
sj$kor <-55     # 원소 수정

sj
sj$mat <- NULL  # 원소 제거제

sj




# 팩터

# 데이터프레임
# R에서 가장 많이 사용하는 자료구조
# 데이터베이스의 테이블 구조와 유사
# 칼럼 단위로 서로 다른 데이터 저장 가능
# 리스트와 벡터의 혼합형 - 컬럼은 벡터/리스트, 데이터는 벡터
# data.frame(), read.table(), read.csv() 로 객체 생성
# 기타 처리함수는 str(), ncol(), nrow(), summary(), subset() 등이 있음
# 벡터나 행렬로 데이터프레임 객체 생성 가능
# txt, csv, excel 파일 등으로 데이터 프레임 객체 생성 가능

# 먼저, 벡터로 각 변수들을 정의
names <- c('해인','윤호','재용')
kor <- c(99,98,99)
eng <- c(55,35,96)
mat <- c(32,94,24)
# sj <- data.frame(names, kor, eng, mat)
sj <- data.frame(이름=names, 국어=kor, 영어=eng, 수학=mat)

sj


# 행렬로 데이터프레임 객체 생성


# txt 데이터프레임 객체 생성
customers <- read.table('C:/Java/data/test/customers.csv',header=F, sep=',')
# 제목 없음, 쉼표 구부
emp <- read.table('C:/Java/data/hr/EMPLOYEES.csv',header=T, sep=',')
# 제목 있음, 쉼표 구부


customers
emp

# csv 데이터프레임 객체 생성
getwd()     # 현재 작업 디렉토리 확인
setwd('c:/Java/data')

books <- read.csv('test/books.csv', header = T) 
books

# 변수 이름 직접 지정
name <-c('고객번호','이름', '주소', '연락처')
customers <- read.csv('test/customers.csv',header = T, col.names = name, stringsAsFactors = F)

#stringsAsFactors = F  문자열이 factor 로 바뀌는 것을 방ㅈ
customers


# 데이터프레임 구조 확인
str(customers)
str(books)
str(emp)

# 데이터프레임 다루기
sj
sj$국어       # 특정 열 하나만 출력
sj$이름

sj$이름 <-as.character(sj$이름)   # 범주형 변수를 문자형으로 

# sj['국어', '영어', '수학']
# sj[2], sj[3], sj[4]
sj[c(2:4)]  # 국, 영, 수
sj[c(2,4)]  # 국, 수

sj[c(2),]   # 2행만 출력, 윤호 성적
sj[c(1,3),]

#
names(sj) # 컬럼명 출력
ncol(sj)  # 컬럼(열)수
nrow(sj)  # 행수

a <- c('hello','age','혜교')
nchar(a)


# 기술 통계량 확인
# 최대, 최소, 중위수, 평균, 사분위수를 요약

summary(sj)

# 많은 행으로 구성된 데이터 프레임 조회
numbers <- data.frame(x=1:10000)
numbers     # 최대 1000행 까지만 출력 - 나머지는 생략
head(numbers)  # 앞에 6행까지만 출력 
tail(numbers)  # 뒤에서 6행까지만 출력

head(numbers,n=10)
tail(numbers, n=10)


# 변수출력시 데이터프레임이름 생략
# attach, detach / with 사용하면 이름 생략 가능
sj$이름



books

attach(books)
 bookid
 bookname
 publisher
 price
detach(books) 
 

# 범주형 factor
# facror 는 범주형 데이터를 표현하기 위해 사용
# 범쥬형 데이터의 값이 정해진 범위 특정 값으로만 분류되는 유형
# level : 범주형 변수가 가질 수 있는 값의 목록
 
# 성별 : 남, 여 / M,F / male, female
# factor() 를 이용해서 범주형 변수 생성

gender <- factor('남',c('남','여'))
gender
levels(gender)    # gender 변수가 가질 수 있는 값의 범
gender <- '여'
# gender <- '동물'  # 범주형 변수가 문자형으로 바뀜
# levels(gender)
as.numeric(gender)
gender <- factor('여', c('남','여'))
as.numeric(gender)

gender <- factor('남',c('남','여'))
as.numeric(gender)

# 범주형 변수를 숫자형으로 바꾸면 정의된 순서대로 서수가 부여됨

hobby <- c('게임', '여행','운동', '독서', '운동', '여행')

fhobby <- as.factor(hobby)
# 문자형 벡터를 범주형 벡터로 변환
fhobby
as.numeric(fhobby)     #  알파벳, 가나다 순



# 행렬
# 벡터의 2차원 배열
# 동일한 유형의 요소들로 구성
# 1행은 문자, 2행은 숫자와 같은 구성은 불가
# matrix 함수로 행렬 객체 생성
# rbind(), cbind() 를 이용해서 행렬을 다룸

# 단순 행렬 생성
a <- matrix(1:10)  # 열 우선으로 행렬 생성
a

# 5X2 행렬 생성
a <- matrix(1:10, nrow=2)  
a
a <- matrix(1:10, ncol=2)
a

# 2x5 행렬 생성
a <- matrix(1:10, nrow=5)  
a


# 3x3 행혈
b <- matrix(1:9, nrow=3, byrow = T )  # 행우선
b
b <- matrix(1:9, nrow=3)  
b
b <- matrix(1:9, ncol=3)     # 열우선
b


# 행과 열의 수가 일치하지 않는 경우
b <- matrix(1:10, ncol=3)  
b # 모자라는 데이터는 기존 데이터 활용

# 행렬을 테이블 형대로 생성 : 행 기준
x1 <- c(5,40,50:52)
x2 <- c(30, 5, 6:8)
x1
x2
x<-rbind(x1,x2)
xx <-cbind(x1,x2)
xx

y1 <- c('a',10)
y2 <- c('b', 20)
y <- rbind(y1,y2)
y    # 벡터 형태처럼 문자열로 바꾸뀜

# 행렬을 테이블 형태로 생성 : 열 기준
x <-cbind(x1,x2)
x

# 10~ 19 사이의 값을 2행 행렬로 표시
z <- matrix(10:19, nrow = 2)
z

# 1행 전체 출력
z[1,]

# 5 열 전체 출력
z[,5]

# 2행 3열 값 출력
z[2,3]

# 1행 2열/3열/4열/5 열 출력
z[1,c(2:5)]

# 행렬의 크기
nrow(x)
ncol(x)
length(x)

# 행렬간 연산
a <- matrix(1:12, nrow = 3)
b <- matrix(13:24, nrow = 3)

a
b

a + b
a * b
a == b


# 행렬의 행/열에 이름 부여
colnames(a)
rownames(b)

colnames(a) <- c('첫번째','두번째','세번째','네번째')
rownames(a) <- c('one', 'two', 'three')
a

# 행령 생성시 행/열 이름 지정
matrix(1:4, nrow=2, dimnames = list(c('a','b'), c('x','y')))

#배열
# n - 차원의 행렬과 유사
# 배열의 차원은 dim 으로 확인
# array 함수로 배열 객체 생성
# 다른 자료 구조에 비해 활용빈도 낮음

# 3x2x3
d <- array(c(1:18), c(3,2,3))
d

# 배열요소에 접근
d[,,2]  # 2번째 면에 접근
d[1,,2] # 1행만 모두 출 
d[,2,2] # 2열만 모두 출
d[3,,3] # 3번째 면의 3행만 출력

# 데이터 프레임에서 부분집합 subset 추출
person <- c('peter','louis', 'meg', 'chris','stewie')
age <- c(43,40,17,41,1)
gender <- c('M', 'F', 'F', 'M', 'M')
profiles <- data.frame(person,age, gender, stringsAsFactors = F)
profiles

# person 과 gender 만 표시 (단, gender가 먼저)

y <- subset(profiles, select = c(gender, person))
y

str(profiles)


# "Brian, 7,M " 등의 데이터를 profiles 에 추가
newOne <- data.frame( person='Brian', age= 7, gender='M', stringsAsFactors = F)
newOne
profiles <- rbind(profiles,newOne)
profiles

# 새로운 열을 추가
funny <- c('high', 'high', 'low', 'med', 'high', 'med')

profiles <- cbind(profiles, funny)

# age를 이용한 개월 수 계산
# df이름$추가할열이름 <- 계산ㅅ
profiles$age
profiles$age*12
profiles$month <- profiles$age*12


# 성별이 남자인 행만 추출
# 데이터프레임의 각 항목에서 특정 요소를 가리키려면 인덱스나 열이름 사용
# 조건식을 DF 의 인덱스로 사용가능
profiles$gender == 'M'
profiles[profiles$gender == 'M',]
# 새로운 열을 추가 : 계산식 이용

# 성별이 여자인 행만 추출, 단, 성별열은 제외하고 출력
profiles[profiles$gender == 'F',-3]

# 나이가 10이상인 사람은?
profiles[profiles$age >= 10,]

# 유머감각이 높으 사람은?
profiles[profiles$funny == 'high',]

# 나이가 10이상이거나 유머감각이 높은 사람은?
profiles[profiles$funny == 'high' | profiles$age >= 10,]

# 나이가 10 이상이고 유머 감각이 높은 사람은?
profiles[profiles$funny == 'high' & profiles$age >= 10,]

# 매니저에 대해 리더쉽 설문조사 결과
# 표를 참조해서 데이터 프레임으로 작성
Manger <- 1:5
Date <- c('10/24/14','10/28/14','10/01/14','10/12/14','05/01/14')
Country <- c('US','US','UK','UK','UK')
Gender <- c('M','F','F','M','F')
Ages <- c(32,45,25,39,99)
q1 <-c(5,3,3,3,2)
q2 <-c(4,5,5,3,2)
q3 <-c(5,2,5,4,1)
q4 <-c(5,5,5,NA,2)
q5 <-c(5,5,2,NA,1)

# 설문 문항에 대해 sumq, meanq 변수 추가
# 새로운 변수를 추가하려면 'DF이름 $ 새로운 변수 명'
leadership = data.frame(Manger,Date,Country, Gender, Ages,q1,q2,q3,q4,q5)
leadership$sumq <-leadership$q1 +leadership$q2 + leadership$q3 +leadership$q4 + leadership$q5



attach(leadership)
leadership$sumq <- q1 +q2+q3+q4+q5
leadership$meanq <- sumq/5
detach(leadership)

leadership



# within 문으로 변수명을 줄여보자
leadership<-within(leadership,{
  sumq <- q1+q2+q3+q4+q5
  meanq <- sumq/5
})

profiles

attach(profiles)
person
gender
age
funny
sumq
meanq
detach(profiles)

# 나이를 대상으로 새로운 범주형 변수 agegGroup 생성
# 나이가 30 미만 : 초년
# 나이가 30 이상 75미만 : 중년
# 나이가 75 이상 : 노년


leadership$ageGroup[leadership$Ages < 30]<-'초년'
leadership$ageGroup[leadership$Ages  >=75]<-'노년'
leadership$ageGroup[leadership$Ages  >=30&leadership$Age  < 75] <- '중년'

# within 문으로 변수명을 줄여보자
leadership$ageGroup <- c('','','','','')

leadership<-within(leadership,{
ageGroup[Ages < 30]<-'초년'
ageGroup[Ages >=75]<-'노년'
ageGroup[Ages >= 30&Ages< 75 ]<-'중년'
})

leadership

