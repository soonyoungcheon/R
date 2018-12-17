# 상관분석

두 변수 x, y가 있을때 두 변수가 서로 어떤 관계에 있는지 분석하는 과정

보통 2개의 등간/비율 척도 변수를 분석할때 우선적으로 산점도를 그려
변수간의 관계를 시각화한 후 상관계수를 계산

ex) 키가 클수록 몸무게도 증가하는가?
  교육을 많이 받으면 수입도 증가하는가?
  광고를 많이 하면 판매량이 증가하는가?
  운동을 많이하면 몸무게는 감소하는가?
  담배를 줄이면 심혈관 질병 발생비율은 낮아지는가?
  
  
두 변수 정의 : 독립변수, 종속변수
독립변수 : 종속변수를 추정하거나 예측하는데 토대
종속변수 : 예측되거나 추정되는 변수, 독립변수의 특정값에 대한 결과를 의미

각 변수의 관계를 기울기에 따라 양/음의 상관계수로 분류함

이러한 차이를 명확하게 하기 위해 상관계수를 사용 - 피어슨 상관계수

ex) 판매원 15명의 판촉횟수와 판매량 자료
전화횟수에 따라 판매량 변화가 있는가?
  
전화횟수 : 96,40,104,128,164,76,72,80,36,84,180,132,120,44,84
판매량 : 41,41,51,60,61,29,39,50,28,43,70,56,45,31,30

p <- c(96,40,104,128,164,76,72,80,36,84,180,132,120,44,84)
s <- c( 41,41,51,60,61,29,39,50,28,43,70,56,45,31,30)

plot(독립변수, 종속변수)
plot(p,s)
abline(v=mean(p), col='red')
abline(h=mean(s), col='blue')


# 상관계수 공식
((각 변수 - 평균)들의 곱)합/(변수개수-1)*각 변수 표준편차들의 곱
p 변수 평균편차 : p - mean(p)
s 변수 평균편차 : s - mean(s)
(p 변수 평균편차*s변수 평균편차)의 총합
sum((p-mean(p))*(s-mean(s)))
    
x <- p -mean(p)
y <- s -mean(s)
sum(x*y)

sum(x*y)/((length(p)-1)*sd(p)*sd(s))

ex) applewood 자동차 판매 데이터를 기초로 해서 구매자의 연령과 판매이익간의 상관분석하고 상관계수를 계산하세요
setwd('c:/Java/data')
aw<-read.table('applewood.txt',header = T, stringsAsFactors = F)
age <- aw$Age
profit <- aw$Profit
library(stringr)
profit <- str_replace_all(profit,'\\$','')
profit <- str_replace_all(profit,',','')
profit <- na.omit(profit) 
profit <- as.integer(profit)


plot(age, profit)
abline(v=mean(age), col='red')
abline(h=mean(profit),col='blue')

sum((age-mean(age))*(profit-mean(profit)))

sum((age-mean(age))*(profit-mean(profit)))/((length(age)-1)*sd(age)*sd(profit))
cor(age,profit)  #  0.261529 약한 양의 상관관계

결론은 판매자 연령과 판매이익은 그리 큰 상관관계가 없음


ex) 회사에서 신제품이 출시되었을때 안내메일을 발송하는 횟수와 판매량 사이 관계 조사
안내메일발송 : 1,2,3,4,5
판매량 : 3,5,8,11,13
email <- c(1,2,3,4,5)
sales <- c(3,5,8,11,13)
plot(email, sales)
abline(v=mean(email),col='red')
abline(h=mean(sales),col='blue')
cor(email,sales)

ex) ggplot2에 제공하는 데이터 셋 중 economics을 이용해서 실업자 unemploy수와 개인소비지출 pce,
실업자수와 개인저축률 psavert의 상관관계 분석 실시


# 실업자 대비 저축률
with(economics,plot(unemploy,psavert))
with(economics,cor(unemploy,psavert))

  library(ggplot2)
?ggplot
data()
head(economics)
unemploy<- economics$unemploy
pce <- economics$pce
psavert <- economics$psavert
plot(unemploy, pce)
cor(unemploy, pce)
plot(unemploy, psavert)
abline(v=mean(unemploy),col='red')
abline(h=mean(psavert),col='blue')
cor(unemploy, psavert)


ex) MASS 패키지의 Cars93 데이터 셋을 이용해서 고속도로highway/시내city 연비와 차체중량weight의 상관관계


head(Cars93)

attach(Cars93)
plot(MPG.highway, Weight)
abline(v=mean(MPG.highway), col='red'))
abline(h=mean(Weight), col='blue'))
detach(Cars93)




city<- Cars93$MPG.city
highway<- Cars93$MPG.highway
weight <- Cars93$Weight

plot(city,weight)
cor(city,weight)
plot(highway,weight)
cor(highway,weight)


# 상관행렬
여러 변수(2개이상)의 상관 관계를 한번에 알아보고자 하는 경우 모든 변수에 대한 
상관관계를 한번에 알려주는 상관행렬을 사용한다

# iris 데이터셋을 이용한 상관행렬 표시
plot(iris$Sepal.Width,iris$Sepal.Length)

str(iris)
plot(iris[,1:4])

# 상관관계 정도를 한눈에 보기 쉽게 그래프를 그려줌

# 빨강색 : 음의 상관관계
# 파란색 : 양의 상관관계
cor <- cor(iris[,1:4])

install.packages('corrplot')
library(corrplot)
corrplot(cor)
corrplot(cor, method = 'shade')
corrplot(cor, method = 'eclipse')
corrplot(cor, method = 'number')
corrplot(cor, method = 'pie')
corrplot(cor, method = 'square')


# Cars93
연비와 관련된 변수와의 상관관계를 corrplot 으로 표시하세요
library(MASS)
str(Cars93)
Cars93$MPG.city
Cars93$MPG.highway

Cars93$Cylinders
Cars93$EngineSize
Cars93$Horsepower
Cars93$RPM
Cars93$Weight

plot(Cars93[,c(7,11:14,25)])

library(corrplot)
cors <- cor(Cars93[,c(7,12:14,25)])
corrplot(cors)


cors <- cor(Cars93[,c(8,12:14,25)])
corrplot(cors)



# 놀이만족도에 대한 상관관계 분석
주말이용여부, 동반자녀수, 공원까지거리
기구만족도, 게임만족도, 대기시간 만족도
청결 만족도, 전체 만족도

setwd('c:/Java/data')
parks <- read.csv('parks.csv',header = T,stringsAsFactors = F)
head(parks)
str(parks)
summary(parks)

# 전체만족도overall에 영향을 주는 인자는?
plot(parks[,4:8])

# 참고 : 만족도에 대한 수치는 
# 순서의 개념이 들어있는 비모수 데이터이므로로 상관분석을 하려면 다른 방식으로 접근해야 함

# mtcars 데이터셋을 이용해서 자동차의 각 요소에 대한 연비 상관관계 분석
mtcars
?mtcars
str(mtcars)

plot(mtcars[,])
cor<- cor(mtcars[,c(1,4,5,6)])
corrplot(cors, method = 'number')

# 상관계수 유의성 검정
 판촉전화횟수와 판매량이 서로 관련없는데 상관계수가 양으로 나온것은 아닌지?
유의수준 0.05를 기준으로 가설검정 실시
귀무가설 : 상관계수가 0이다
대립가설 : 상관계수가 0이 아니다
  df 13  임계치 -2.160 2.160
t검정값 : 상관계수*sqrt(n-2)/sqrt(1-상관계수)^2)

cor(p,s)*sqrt((length(p)-2))/sqrt(1-cor(p,s)^2)
= 6.205089
따라서, 귀무가설 기각 : 상관계수는 0이 아니

cor.test(p,s, method = 'pearson')
상관계수는 0이 아니다

ex) applewood 자동차 판매 데이터를 기초로 해서 구매자의 연령과 판매이익간의 상관계수에 대해
유의성 검정실시 (유의수준 0.05)
head(aw)
length(aw$Age)
임계값 DF = 178     -1.973~1.973
cor(age,profit)*sqrt((length(age)-2))/sqrt(1-cor(age,profit)^2)
= 3.615052 귀무가설 기각
따라서, 상관계수는 0 이 아니다

귀무가설 : 상관계수는 0이다
대립가설 : 상관계수는 0보다 크다
임계값 : DF =178 , 1.653 
= 3.615052 귀무가설 기각  : 상관관계는 0보다 큼

어느 대학교 학생회에서는 학생이 마시는 맥주와 혈중알콜 농도 사이 관계를 알고자 한다
18명의 학생을 확률표본추출하여 맥주캔 500ml을 마시게 하고 30분 후 경찰서에서 혈중알콜 농도를
측정하였음
시음량과 혈중알콜농도 사이에는 어떤 상관관계가 있는가? 상관계수 유의성 검정까지 실시하세요
beer(캔수) : 6,7,7,4,5,3,3,6,6,3,3,7,2,4,2,7,2,1
bac : 0.1,0.09,0.09,0.1,0.1,0.07,0.1,0.12,0.09,0.07,0.05,0.08,0.04,0.07,0.06,0.12,0.05,0.02

beer <- c(6,7,7,4,5,3,3,6,6,3,3,7,2,4,2,7,2,1)
bac<- c(0.1,0.09,0.09,0.1,0.1,0.07,0.1,0.12,0.09,0.07,0.05,0.08,0.04,0.07,0.06,0.12,0.05,0.02)

plot(beer, bac)
abline(v=mean(beer),col='red',lty=3)
abline(h=mean(bac),col='blue',lty=3)
cor(beer, bac)

상관계수 검정
임계값  : df = 16  1.746
  cor.test(beer, bac, method = 'pearson')
cor(beer, bac)*sqrt((length(beer)-2))/sqrt(1-cor(beer, bac)^2) =  4.797056
귀무가설 기각 대립가설(0보다 크다)