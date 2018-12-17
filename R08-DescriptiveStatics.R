# 기술통계
# 도수의 분포와 중심화 경향, 퍼짐 정도를 측정해서 집단의 특성을 기술
# 관측한 데이터를 도표로 정리하거나, 통계량을 정리함으로서 관측한 현상의 특징을 기술
# 연구 수행을 위한 데이터 수집이 완료되면 가장 먼저 수행하는 분석 단계
# 주로 자료분포에 대한 평균값, 중앙값, 표준편차등을 분석

# 데이터 확인
setwd('c:/Java/data')
store <- read.csv('productSales.csv',header = T,sep=',', stringsAsFactors = F)


# 1.데이터 구조 확인
str(store)
class(store)

# 2. 데이터 앞/뒤/임의로 확인
install.packages('car')  # some 함수를 이용하고 싶다면 car 패키지를 다운받아야
library(car)
head(store,10)
tail(store,10)
some(store,10)   # 임의 표시


# 3. 데이터 요약
summary(store)  # 기술 통계 요약
length(store)   # 
nrow(store)     # 행수
nchar(store)

min(store$p1sales)   # 최소
max(store$p1sales)   # 최대
mean(store$p1sales)  # 평균
median(store$p1sales) # 중앙값
var(store$p1sales)    # 분산
sd(store$p1sales)     # 표준편차

quantile(store$p1sales)  # 사분위값


# 4. 데이터 범위, 치우침
 range(store$p1sales)
 
 install.packages('fBasics')
 library(fBasics)
skewness(store$p1sales)  # 왜도 중앙값을 알 수있ㄷ
# 왼쪽으로 치우면 0보다 크고 0보다 왼쪽일 경우 0보다 작ㄷ
kurtosis(store$p1sales0) # 첨도큼 첨도: 분포를 알 수 있다
# 3 이면 종모양   3보다 크면 정규분표 곡선에 비해 다소 뽀족한 모양

# 기타 등등
sum(store$p1sales)
rank(store$p1sales)   # 순위 출력
# 해당 값에 대한 위치값이 출력

# 뒤에서 1-10
store$p1sales[rank(store$p1sales)<=10]

# 1위부터 10위
store$p1sales[rank(-store$p1sales)<=10]

 x <- sample(1:50,20)
 # 1~50 사이의 숫자들 중에서
 # 표본 추출방식으로 20개를 추출
x
  rank(x)        # 작은 순으로 순위 매김(위치값출력)
rank(-x)        # 큰 순으로 순위 매김
x[rank(x)<=5]  # 작은 값들 중 5개만 추출
x[rank(-x)<=5]# 큰 값들 중 5개만 추출

sort(store$p1slaes) # 정렬
sort(store$p1sales, decreasing = T) # 내림차순 정렬
head(sort(store$p1sales, decreasing = T))
tail(sort(store$p1sales, decreasing = T))


# gdp_rank_25, incomes 데이터셋을 이용해서
# 기술통계 함수 - 수치적 분석을 실시하세요

# 문자 데이터를 숫자로 변경

gdp_rank_25 <- read.csv('gdp_rank_25.csv',header = T, stringsAsFactors = F)
head(gdp_rank_25)
install.packages('stringr')
library(stringr)    # 문자처리 패키지
gdp_rank_25_1<-str_replace_all(gdp_rank_25$GDP,',','')
head(gdp_rank_25_1)

gdp_rank_25_9 <-as.integer(gdp_rank_25_1)
gdp_rank_25_9 
class(gdp_rank_25_9)
a<-data.frame(gdp_rank_25[1],gdp_rank_25_9)
a
str(a)
colnames(a) <- c('Nation','GDP')

gdp_rank_25_2 <-cbind(gdp_rank_25$Nation,gdp_rank_25_1)
colnames(gdp_rank_25_2) <- c('Nation','GDP')
head(gdp_rank_25_2$GDP)
class(gdp_rank_25_2)
gdp_rank_25_2<-as.data.frame(gdp_rank_25_2)
class(gdp_rank_25_2)
gdp_rank_25_2$GDP <- as.integer(gdp_rank_25_2$GDP)
gdp_rank_25_2


b<-a
c<- d

##### gdp_rank_25 df를 a 변수에 넣었ㅇ
summary(a)
min(a$GDP)
max(a$GDP)
var(a$GDP)
sd(a$GDP)


head(incomes)
cpincomes<-incomes

z <-str_replace_all(cpincomes,',','')
z
x <-as.vector(str_replace_all(z,'\\$',''))
y <-as.vector(x)

str(y[100])
class(y)

y <- data.frame(x[1],x[1],x[1])
