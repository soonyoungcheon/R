# 회귀분석
상관분석은 변수들이 서로 얼마나 밀접한 관계를 가지고 있는지 분석하는 통계적 기번

한편, 회귀분석은 상관분석 + 예측하는 통계적 기법
수량형 값을 예측하는데 주로 사용되는 통계적 모형

즉, 두 변수간의 선형(직선)관계를 식으로 표현하고 독립변수가 주어지면 종속변수의 값이 
얼마인지 추정

y = a + bx

a 절편 : mean() - 기울기*mean()
b 기울기 : cor()*(sd()/sd())

독립변수와 종속변수사이의 관계를 선형방정식으로 나타낸 것을 회귀방정식이라 함
회귀직선을 그릴 때는 최소제곱법이라는 수학적 기법을 이용하는데, 이는 두 변수의
선형관계를 계량화한 것임

ex) 판촉전화횟수와 판매량사이의 관계를 최소제곱법을 이용해서 선형방정식으로 표현하세요
그리고, 판촉전화를 100회 한다면 판매량은 얼마인가?
a 절편 : mean(s) - b*mean(p) 19.98

b<-cor(p,s)*(sd(s)/sd(p)) 0.261

따라서, y = 19.98 + 0.261*x

판촉전화 100회 시도 시 판매량은 46 대
19.98 + 0.261*100 = 46.08


0.261*x 의 의미 : 판촉 전화 1회 시도시 제품은 0.261대를 팔수 있음

19.98 의 의미 : 판촉전화를 한번도 하지 앟아도 제품을 19.98대 팔 수 있다???
                판촉전화의 횟수의 범위 : range(p)
                판촉전화의 시도횟수의 최소값은 30이므로
                판촉전화를 한번도 하지 않는 다는 말은 옳지않음

model<-lm(s ~p) 
model
plot(p,s)
abline(lm(s ~p), col='red')  # 회귀직선
abline(v=mean(p))
abline(h=mean(s))

그래프를 유심히 살펴보면 최소제곱법에 의한 회귀선은 각 데이터의 평균을 지나고 있는
것을 알 수 있음


(Intercept)            p  
19.9800       0.2606  
판매량 실제값s 와 회귀방적식을 통해 추정값 사이에 오차 존재  -> 잔차
이 회귀선을 통해 더 이상 편차제곱합을 줄일 수 있는 직선은 없음

잔차 : s-predict(lm(s~p))
편차제곱합 : sum((종속변수 - 예측값)^2)

예측값 : predict(lm(s~p))
잔차 : s-predict(lm(s~p))
편차제곱합 : sum((s-predict(lm(s~p)))^2) = 587.11

# lm 함수 자세히 살펴보기
model<- lm(s~p)
summary(model)
options('scipen'=100)

ex) applewood 자동차 판매 데이터를 기초로 해서 구매자의 연령과 판매이익간의
관계를 최소제곱법을 이용해서 선형방정식으로 표현하세요
유의성 검정실시 (유의수준 0.05)
model <- lm(profit ~ age)
model
y = 1110.53 + 15.97x 
summary(model)
range(age)  # 21 ~ 73
cor.test(profit,age) # t = 3.6151, df = 178, p-value = 0.0003907



ex) 최고의 중소기업 중 12개를 임의로 추출하여 매출액과 이익을 조사하였음
산점도를 그리고, 상관계수와 회귀방정식을 구해서 매출액이 5000일때 
이익금액을 추정하세요
bs <- read.table('smallbs.txt', header = T,stringsAsFactors = F)
head(bs)
plot(bs$Sales,bs$Earnings)
cor(bs$Earnings,bs$Sales)
lm(bs$Earnings~bs$Sales)
model y =  1.85174  +    0.08357x  
1.85174  +    0.08357*50  = 6.03024




ex) 자산가치와 수익율을 토대로 산점도를 그리고 상관계수와 회귀방정식ㅇ
펀드 투자액이 4억일때 5년 수익률은 얼마인가?을
funds <- read.table('funds.txt', header = T, stringsAsFactors = F)
head(funds)
plot(funds$Assets,funds$Return)
abline(v=mean(funds$Assets), col='red')
abline(h=mean(funds$Return), col='blue')
cor(funds$Assets,funds$Return)  -0.0460508
lm(funds$Return ~ funds$Assets)
y = 9.9198271    -0.0003933*x 
9.9198271    -0.0003933*400 = 9.762507


ex) 시의회에서 범죄발생율을 낮추기 위해 경찰관을 늘리고자 함.
다른 시의 경찰관 수와 범죄율을 토대로 산점도를 그리고
상관계수와 회귀방정식을 구해서 경찰관수가 20일 때 범죄발생 건수는 얼마인가?
crime <- read.table('citycrime.txt', header = T, stringsAsFactors = F) 
head(crime)
plot(crime$Police, crime$Crimes)
abline(v=mean(crime$Police), col='red')
abline(h=mean(crime$Crimes), col='blue')
cor(crime$Police, crime$Crimes)=  -0.8743956
lm(crime$Crimes ~ crime$Police)
y = 29.3882       -0.9596x  
29.3882       -0.9596*20 = 10.1962
cor.test(crime$Police, crime$Crimes)


ex) 중고차의 연령과 가격 사이의 관계를 알고자 함
작년에 판매된 중고차량 12대를 기반으로 산점도를 그리고 상관계수와 회귀방정식을 
떄구해서 중고차 연령이 12일 떄 중고차 가격은 얼마인가?
cars <- read.table('oldcars.txt', header = T, stringsAsFactors = F)  
head(cars)
plot(cars$Age,cars$Price)
abline(v=mean(cars$Age), col='red')
abline(h=mean(cars$Price), col='blue')
cor(cars$Age,cars$Price) = -0.5436463
lm(cars$Price ~ cars$Age)
y = 11.1772      -0.4788x  
11.1772      -0.4788*9  = 5.4316
cor.test(cars$Age,cars$Price) 귀무가설 0 둘은 상관관계 없다


# 회귀분석의 시초
영국 유전학자 골턴은 부모의 키와 자녀들의 키 사이의 연관관계를 조사
- 선형적 관계가 있을음 파악 후에 칼 피어슨이 이 것을 수학적으로 증명
-> 회귀분석이론 정립
즉, 앞으로 발생할 일은 지난 과거에 일어난 일의 [평균수준]으로 돌아가는 성질이 있음

# 예측값 알아보기 : predict
predict(a, b) 함수는 b 변수값을 방정식에 넣어 출력된 값을 실제 a값과 비교해 봄
어느정도 오차는 감안 - 잔차, 잡음 때문에 발생

# 회귀식의 예측력 평가
예측력 - 추정치 표준 오차를 의미

전화 횟수 대비 판매량에 대한 회귀식
y = 19.9632 + 0.2608 x
전화 횟수가 84일 때 판매량은?
  19.9632+0.2608*84 =  41.8704
전화 횟수가 84일 떄 판매량은 41.8704로 예측
하지만, 실제값은 43, 30으로 나옴 -> 방정식은 과연 믿을만 할까?
정확한 예측이란? - 정확한 결과값을 도출하는 것을 의미
경제학과 경영학을 포함한 모든 분야에서는 불가능한 것으로 알려져 있음

추정에 있어서 추정치 x에 근거해서 얼마나 정확하게 예측/부정확하게 예측했나 등의
척도가 필요 -> 추정치의 표준오차

sqrt(편차제곱합/n-2)

추정치의 표준오차가 작음 - 추정치가 잘 맞음
추정치의 표준오차가 작음 - 추정치가 잘 안 맞음


# 전화횟수 대비 판매량에 대한 추정치의 표준오차
error <- sum((s-predict(lm(s~p)))^2)
sqrt(error/(length(p)-2))   # 6.720291

model <- lm(s ~  p)
summary(model)
Residual standard error: 6.72 on 13 degrees of freedom


# 결정계수 - R^2
결정계수를 통해 회귀식이 얼마나 정확한지 알 수 있음
보통 0 이상 1이하 내 실수로 표현 
0에 가까우면 - 회귀식의 정확도(설명력) 낮음
1에 가까우면 - 회귀식의 정확도(설명력) 높음

즉, 결정계수는 종속변수 y의 변동이 독립변수 x의 변동에 의해 설명될 수 있는 비율

결정계수를 구하는 방법은 2가지
1) 상관계수 제곱
2) 분산분석ANOVA의 데이터를 이용(회귀변동/총변동)

R2<-cor(p,s)^2
R2   0.7475881

Multiple R-squared:  0.7476

조정된 결정계수
Adjusted R-squared:  0.7282


# 예측구간 추정
추정치의 표준오차와 결정계수를 통해 회귀식의 존속변수 예측력에 대한
전반적인 평가를 내렸었음

회귀식의 예측력을 표현하는 또 다른 방식은 독립변수의 특정값을 신뢰구간을 
계산하여 제시
신뢰구간 계산을 위한 선형회귀의 가정
1) x값은 y값에 각각 대응 - y값은 정규분포
2) x값, y값의 평균은 회귀직선 위에 놓임
3) 정규분포의 표준오차는 동일
4) y값은 확률적으로 독립적 - 각각 x에 의해 y가 변함

신뢰구간

ex) 전화횟수 대비 판매량에 대한 회귀식을 토대로 50회를 건 모든 판촉사원의
95% 신뢰구간과 예측구간을 계산하세요

먼저, 전화 횟수는 50회 대비 판매량 추정
19.9632+0.2608*50=  33.0032
신뢰구간 : t*s*sqrt((1/DF)+편차제곱/편차제곱합)
s는 추정치에 대한 표준오차
6.72
t:2.160, 95% 신뢰구간, DF: 13

((1/표본수)+편차제곱/편차제곱합)=
  e2<-((50-mean(p))^2/sum((p-mean(p))^2)) 
p
s
신뢰구간 
2.160*6.72*sqrt(1/length(p)+ e2)  = 5.609011
15.56191


예측구간
따라서, 예측구간은 
33.0032 +- 15.56191

# 신뢰구간/ 예측구간 그래프
phone <- seq(min(p), max(p),1)
csales <- predict(model, interval = 'confidence', newdata = data.frame(p=phone))
csales
plot(p,s)
abline(lm(s~p),col='blue')
lines(phone, csales[,2],col='red',lty=2)
lines(phone, csales[,3],col='black',lty=2)


fitplot(model)









# r에서 제공하는 함수를 이용해서
신뢰/예측구간 계산
model<- lm(s ~ p)
coef(model)           #  회귀계수(기울기, 절편)
fitted(model)[1:15]  # 추정값
residuals(model)    # 추정치의 표준오차 : 잔차
deviance(model)    # 잔차제곱합
confint(model)    # 회귀계수의 신뢰구간

ps <- data.frame(p,s)
predict(model, interval = 'confidence', newdata = data.frame(p=20)) # 신뢰구간
predict(model, interval = 'prediction', newdata = data.frame(p=20)) # 예측구간




ex) 식이요법을 적용한 닭에 대한 데이터 1번 닭을 대상으로 시간 대비 
몸무게에 대한 회귀분석을 실시하세요(MASS, ChickWeight)
weight : 닭몸무게
time : 몸무게 측정 시 병아리 나이(일수)
chick : 닭 번호
diet : 닭 모이 종류

head(ChickWeight)
ChickWeight

chick<-ChickWeight[ChickWeight$Chick==1,]
chick
with(chick, plot(Time,weight))


회귀방정식
m<- with(chick, lm(weight ~ Time))
summary(m)

회귀선
abline(m, col='red')

회귀계수
coef(m)
(Intercept)        Time 
24.465436    7.987899 
y = 24.465436 + 7.987899*x



신뢰구간 조사
conf<- predict(m, interval = 'confidence')
pred <-predict(m, interval = 'prediction')
pred
lines(chick$Time, conf[,2], lty=3)
lines(chick$Time, conf[,3], lty=2)
lines(chick$Time, pred[,2], lty=2, col='blue')
lines(chick$Time, pred[,3], lty=2, col='blue')

fitted(model)  # 추정값
residuals(model)    # 추정치의 표준오차 : 잔차
deviance(model)    # 잔차제곱합
confint(model)    # 회귀계수의 신뢰구간








ex) cars 데이터셋을 이용해서 자동차 속도와 제동거리의 상관분석과
회귀분석을 실시하세요
자동차 속도가 3일 때와 21일 때 제동거리는?

산점도
with(cars, plot(speed, dist))
상관계수
with(cars, cor(speed, dist))
0.8068949
회귀식
m<-with(cars,lm(dist ~ speed))
summary(m)

abline(m, col='red')
conf<- predict(m, interval = 'confidence')
pred <-predict(m, interval = 'prediction')
pred
lines(cars$speed, conf[,2], lty=3)
lines(cars$speed, conf[,3], lty=2)
lines(cars$speed, pred[,2], lty=2, col='blue')
lines(cars$speed, pred[,3], lty=2, col='blue')
-5.781869 65.001489 

tail(cars)

# speed가 3, 21일 때 dist?
predict(m, newdata= data.frame(speed=c(3,21)),interval = 'confidence')
65.001489  58.59738 71.405594

# applewood age 대비 profit에 대한 추정치의 표준오차
head(aw)
model<-lm(profit ~ age)
summary(model)   
Residual standard error: 623 on 178 degrees of freedom



