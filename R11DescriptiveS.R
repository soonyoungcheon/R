# 통계학의 종류
# 기술 통계학 - 자료를 중심으로 통계 수치, 표, 그래프 등을 이용해서 집단의 특성 파악
#  (위치-평균/분포-흩어짐 경향)

# 추론 통계학 - 표본 자료를 이용해서 모집단 특성 파악 기본적으로 확률 이론을 바탕
     # 모수 통계 - 모집단의 분포를 자정하고 분석
        #빈도분석 - 변수의 분포와 중심치 파악
        #연속형 두 변수간의 관계 파악, 상관계수로 표현
        #표본평균분석 - 두 집단의 평균값 비교
        #3집단 이상 평균분석 - 세 집단간의 평균값 비교
        #회귀분석 - 변수간의 인과관계 분석 및 예측



    # 비모수 통계 - 모집단 가정없이 분석(확률계산)
       #적합도 검증 - 카이스케어, 케이검증, 이항분포, 스피어만 순위 상관분석, 켄달 상관분석, 카이제곱

# 기술통계 
# 우치 척도를 이용한 기술통계
# 평균
weight <- c(72,67,60,78,82)
mean(weight)


# 표본 추출 방법
# 표본조사 : 더조은 수강생 500명 대상 사용중인 핸드폰 제조사 조사, 단 이 중 10명을 뽑아서 시행
# 모집단 : 수강생 500명
# 표본 : 10명

# 1. 단순랜덤 : 모집단 개체에 1-500 번호표 부여하고 추첨식/SRS 방식으로 10을 뽑음
# 2. 개통추출 : 단, '개체수/표본수'로 계산되는 k값을 계산 1~k의 숫자 중 하나를 선택하고 그 숫자에 k를 더해서
#                개체를 선택 예)500/10 => 50 : k
#           
# 3. 층화추출 : 모집단을 몇 개의 계층(특성)으로 나누어 표본 추출
#        예 ) 수강생 500명 => 남/여 수 파악
#     각 계층별로 번호 부여 : 남 = 300, 여 = 2000
# 계층별 비율 계산 => 남 : 여 = 0.4 : 0.6
# 따라서, 남자는 6, 여자는 4명을 단순 추출로 뽑음
# 4. 군집추출 : 모집단을 몇 개의 군집(임의특성)으로 나누어 표본을 뽑음
#  예) 모집단을 학력수준/지역으로 나눔(고졸, 대졸, 대학원, 서울, 경기, 부산)
# 각 군집별로 번호 부여 후 랜덤하게 추출

#  표본 추출 : sample
#  복원 추출 : 뽑았던 표본을 다시 추출에 사용, 중복허용
sample(1:100,5,replace = T)   # 1~100 사이에 5개 표본 추출

# 비복원 추출 : 뽑았던 표본은 다음 추출에서 제외

# strata : 층화 추출
# sampleBy : 계통 추출

# 1~100 사이의 7개의 표본을 복원 추출하고 평균계산
mean(sample(1:100,7, replace=T))

# 1~100 사이의 7개의 표본을 비복원 추출하고 평균계산
mean(sample(1:100,7, replace=F))


# 산술평균 : 모든 개체값 총합/ 개체수 
# 모집단이 정규분포를 띄고 있을 때 가장 이상적인 중심화 경향 통계값

# 가중평균: weighted.mean
# 관측값에 가중치(도수)를 더해서 평균을 구함
sales <- c(95,72,87,65)
weights <- c(0.5,0.25,0.125,0.125)  # 가중치

mean(sales)  # 산술평균
weighted.mean(sales, weights) # 가중평균

# 도수를 이용한 가중평균
kor.A <-c(4.0,3.0)
kor.B <-c(4.0,3.0)
counts <- c(3,2)  # 도수

weight <- counts/sum(counts)
weighted.mean(kor.A,weight)
weighted.mean(kor.B,weight)


# 도수를 이용한 가중평균
score <- c(90,80,75,60)
counts <- c(3,12,15,5)
weighted.mean(score,counts)

# 건설회사는 시간제 근로자에게 시간당 $16.50, $19.00, $25.00의 임금을 지급한다
# 총 26명의 근로자 중 14명은 16.50를, 10명은 19.00, 나머지 2명은 25.00을 받는다
# 26명의 근로자의 시간당 편균 임금은 얼마인가?
wage <- c(16.50, 19.00, 25.00)
counts <- c(14,10,2)
weight <- counts/sum(counts) 
weighted.mean(wage, weight)


# 중앙값 : 관측값 정렬시킨 후 가운데 값
# 중위수 
# 데이터에 한, 두개의 매우 크거나 작은 값이 존재하는 경우 산술 평균 만으로는 데이터의
data <- 1:10
mean(data)
sort(data)
median(data)  # (7+8)/2
# 관측값 수가 짝수인 경우
# 중앙의 2개 값에 대한 평균 계산

# 최빈값 
# 가장 빈번하게 출현하는 값
# 명목 척도 데이터를 요약하는데 유용
num <- c(1,2,2,3,4,3,5,5,7,2,2,0)
freq <- table(num)  #  빈도표 작성
max(freq)
freq(num)
idx<-which.max(freq)
idx
names(freq)[idx]


# 산포 중심 척도
# 평균, 중앙값, 최빈값은 데이터의 중심만 기술
# 데이터의 흩어짐 정도를 파악하는 것도 중요
# 예) 어떤 공원 호수의 수심이 평균 3미터
# 만약, 수심이 2.8미터에서 3.2 미터 사이 : 뛰어들만 함
# 1미터에서 5미터 사이

# 범위 : 데이터 내 최소/ 최대 차이
data <- c(7,7,2,3,7,6,9,10,8,9,10)
range(data)
data <- c(1,2,2,3,4,3,5,5,7,2,2,0)
range(data)


# 분산 : 평균을 기준으로 얼마나 떨어져 있나?
# 범위는 최소/최대값만을 기준으로 산출
# 반면, 분산은 모든 값을 고려해서 산출
# 평균을 기준으로 각 관측값의 거리 평균 계산
weight <- c(72,67,60,78,82)
mean(weight)
median(weight)
range(weight)
var(weight)

# 어떤 두 지점의 5일동안 오후 4~5 사이의 카푸치노 판매량 데이터
a<- c(20,40,50,60,80)
b<- c(20,45,50,55,80)

# 평균, 중위, 범위
mean(a)
median(a)
range(a)
var(a)
mean(b)
median(b)
range(b)
var(b)
# 위치 척도로 비교
# 따라서, B집단의 판매량 분포가 460
# A집단의 판매량 분포 500보다 밀집됨
# B 집단의 카푸치노가 균일/일정하게 팔리고 있음



# 서울/경기 지역 거주 성인 10명에세
# 신제품을 시식하게 하고 1~50점을 평가하게 함
# 과연 어느 지역이 가능성이 있는지 알아보자
s<-c(34,39,40,46,33,31,34,15,15,45)
k<-c(28,25,35,16,25,29,24,26,17,20)

# 분산 구하는 방법
x<- c(1,2,3,4,5)
mean(x)
var <- {(3-1) + (3-2) + (3-3) + (3-4)+ (3-5)}/5 # 결과는 0
var <- {(3-1)^2 + (3-2)^2 + (3-3)^2 + (3-4)^2+ (3-5)^2}/5 # 따라서, 각 차에 제곱 계산
# 모분산 : 모집단에 대한 분산 계산

# var(x): 표본분산에 의한 결과값
# 표본개수가  n이라 할때 표본분산에서는 분산 공식에서 표본 개수를 n-1로 계산
mean(s)
mean(k)
median(s)
median(k)
var(s)
var(k)

library(dplyr)
library(reshape2)
# 타이타닉 데이터 셋
setwd('c:/Java/data')
titanic <- read.csv('train.csv', header = T, stringsAsFactors = F)
summary(titanic)

# 탑승객의 나이에 대한 기술통계량 조사
summary(titanic$Age)
var(titanic$Age, na.rm= T)


# 생존 탑승객의 평균 나이는?
head(titanic)
newdata <- melt(titanic, id= c('Survived','Pclass','Sex','Embarked'))
head(newdata)

newone <- titanic %>% select(Survived,Age) %>% filter(titanic$Survived=='1') 
tail(newone) 
is.na(newone)
newone <-newone %>% filter(Age>=1)

titanic$Survived == 1
survived <- titanic$Age[titanic$Survived==1]
mean(survived, na.rm=1)


# 평균나이
mean(newone$Age,na.rm= T)

# 생존 탑승객의 가중 평균 나이는?
weight <- count/sum()
temp<- data.frame(table(newone$Age))
head(temp)
str(temp)
temp$Var1 <- as.numeric(temp$Var1)

weighted.mean(temp$Var1,temp$Freq)

# 승선권 등급 중 가장 많은 수를 차지하는 것은?
nrow(titanic[titanic$Pclass==1,])
nrow(titanic[titanic$Pclass==2,])
nrow(titanic[titanic$Pclass==3,])

newtwo <- titanic %>% select(Pclass)
head(newtwo)
newtwo<-table(newtwo)  # max값 index
idx <- which.max(idx)
names(newtwo)[idx]


# 비생존 탑승객의 최소/최대 나이는?

newthree <- titanic %>% select(Survived,Age) %>% filter(titanic$Survived=='0')
newthree <- newthree %>% filter(Age>=1)
head(newthree)
idx<- which.max(newthree$Age)
newthree$Age[idx]


idx<-which.min(newthree$Age)
newthree$Age[idx]



# 운임의 범위는?
newfour <- titanic %>% select(Fare) 
range(newfour)


# 표준 편차
# 1년동안 발부된 모든 벌칙금 통지서 조사
# 19 17 22 18 28 34 45 39 38 44 34 10
# 이 것에 대한 (표본) 분산은?
temp<- c(19, 17, 22, 18, 28, 34, 45, 39, 38, 44, 34, 10)
var(temp)
sd(temp)

# 분산은 보통 두 개 이상의 데이터 집합의 산포도를 비교해서 알아볼 수 잇음 - 조밀 vs 흩어짐
# 그런데, 어떤 데이터군의 분산을 알아보기 위헤 편차의 제곱을 비교하기
# 편차의 제곱값을 측정의 단위를 사용하는 것은 꽤나 번잡한 일 - 수치가 너무 큼
# 분산값에 제곱근을 씌어 같은 측정단위로 변환할 수 있음

# 회계 수습사원들의 월급 3536, 3173,3448,3121,3622 이라고 할때
# 사무 수습 사원들의 평균 월급은 3550
# 표준 편차는 250 이다
# 이 둘 수습 사원 그룹을 비교한다면
accounting <- c(3536, 3173,3448,3121,3622)
mean(accounting)
sd(accounting)

# 데이터의 통계적 치우침을 표현하는 대표적 기호
# 분산을 알아보려면 먼저, 평균을 계산해야함
# 그래야 평균으로부터 얼마나 멀어져 있는지 알 수 있음
# 평균으로 부터 멀어진 정도 : 편차로 계산
# 편차는 개별자료와 전체자료 평균간의 차이(오차)
# 분산 : 이러한 차이를 제곱하고 모두 더한 후 평균낸 값

# 표준편차를 이용한 경험적 법칙 = 
# 평균과 가깝게 위치한다는 의미

# 러시아 수학자 체비셰프는 평균에서
# 특정크기의 표준편차 거리 내에 존재하는 관측치의 최소 비율을 계산해냄
# 관측치의 75%는 2 표준편차 거리내에 존재
# 관측치의 88.9%  3 표준편차 거리내에 존재
# 관측치의 96%는 5 표준편차 거리내에 존재
# 1-1/k^2

# 어떤 회사의 직원들은 평균 51.54 달러,
# 표준편차 7.51달러를 이익분배사업에 재투자한다
# 평균으로부터 3.5 표준편차내에슨
# 즉, 25.26달러와 77.83 달러안에 적어도 %의 투자가 포함되는가?
# 평균 51.54, 표준편차 7.51 에 대해 3.5 표준 편차
# 51.54-(7.51*3.5)=25.26   : -3.5 표준편차
# 51.54+(7.51*3.5)=77.83   : 3.5 표준편차
# 1-1 /k^2 
# 1-1/(3.5^2) = 0.918 => 약 92% 범위에 해당



# 데이터의 위치
# 사분위수 : 자료를 정렬한 후 누적 백분율을 기준으로 4등분한 각 지점의 수를 의미
# 10분위수, 100분위수
x<- c(136,182,166,132,130,186,140,155)
quantile(x, 0.25)  # 25%에 해당하는 ㅅ
quantile(x, 0.30)
summary(x)  # 사분위수는 summary로도 계산 가능

# 어떤 사무실의 수수료 내역이다
# 2038, 1758,1721,1637,2097,2047,2205,1787,2287,1940,2311,2054,2406,1471,1460
# 중위수, 1사분위수, 3사분위수는?
temp <- c(2038, 1758,1721,1637,2097,2047,2205,1787,2287,1940,2311,2054,2406,1471,1460)
temp <- sort(temp)
quantile(temp)
median(temp)
summary(temp)
boxplot(temp)

# 타이타닉 데이터셋
# 탑승객의 나이에 대한 기술통계량 조사
summary(titanic$Age,na.rm = T)
# 탑승객 나이의 사분위수를 구하세요
quantile(titanic$Age,na.rm = T)
# 운임의 사분위수를 구하세요
quantile(titanic$Fare,na.rm = T)


# 어떤 IT회사의 주당 이익 자료이다
0.09, 0.13, 0.41, 0.51,1.12,1.20,1.49,3.18,3.50,6.36,7.83,8.92,10.13,12.99,16.40
# 평균, 사분위값, 표준편차, 왜도와 첨도는?
it <- c(0.09, 0.13, 0.41, 0.51,1.12,1.20,1.49,3.18,3.50,6.36,7.83,8.92,10.13,12.99,16.40)
summary(it)
sd(it)

install.packages("fBasics")
library(fBasics)
plot(it)

skewness(it)
kurtosis(it)
