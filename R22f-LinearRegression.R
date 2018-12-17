# 로지스틱 회귀
logit 함수를 사용한 회귀분석이라는 의미

범주형 값(0,1:1,2,3)들을 이용해서 무언가를 예측하거나 분류할 때 사용

# 기존 회귀 vs 로짓 회귀
setwd('c:/Java/data')
data <- read.csv('logit.txt',sep = '\t', header = F)
str(data)
# 나이, 혈압관계 회귀분석
m<-lm(V2~V1, data=data)

plot(data$V1,data$V2)
abline(m,col='red',lty=2)

y= a + bx 
x : +- 무한대, y : +- 무한대

# 나이, 혈압은 연속형 값이므로 선형회귀 분석 가능
선형 회귀 분석 가능

# 나이, 암발생여부 회귀분석
plot(data$V1,data$V3)
abline(lm(V3~V1, data=data),col='red',lty=2)
lm(V3~V1, data=data)


# 암발생여부는 범주형 값이므로 선형회귀 분석 불가능
y= a + bx 
x : +- 무한대, y : 0 ~ 1

따라서, 선형회귀에서는 좌변/우변에서 계산된 값은 모두 연속형 값으로 가정함
하지만, 로지스틱 회귀에서는 우변은 연속형값이고 좌변은 이산형값이 출력
우변의 계산값이 좌변의 계산값과 맞지 않으므로 등호는 불일치함
좌변값을 어떤 처리를 통해 범위를 맞춰주는 작업이 필요
=> logit 변환log(odds)

# odds => probability => chance => 확률

일반 회귀식으로는 (y=a+bx)로는 0/1를 예측할 수 없으므로 y값의 확률(0이 나올/1일 나올 확률)을
이용해서 odds ratio로 변환하여 로그를 취하면 좌/우변 값을 등호로 표현할 수 있음

# 로지스틱 함수 그래프 = 시그노이드 그래프
library(e1071)
plot(sigmoid, -5,5)
abline(h=0, lty=2, col='red')
abline(h=1, lty=2, col='red')


# 대학교지원자들의 고등학교 성적으로 합격/불합격 여부 분류
(합격여부, 성적, 학점, 출신학교 등급)
admit(0불합격, 1합격),gre,gpa,rank
# 0. 탐색적분석
uni <- read.csv('admits.csv', header = T, stringsAsFactors = F)
str(uni)

admit,rank레이블 변수는 범주형으로 변환
uni[,1] <- as.factor(uni[,1])
uni[,4] <- as.factor(uni[,4])

summary(uni)

library(caret)
set.seed(2018112316)
idx <- createDataPartition(uni[,1],p=0.7,list=F)
train <- uni[idx,]
test <- uni[-idx,]

table(train$admit)
table(test$admit)

# 2.
R에서의 로지스틱 회귀 함수
glm : 레이블이 이항변수 일 때
multinom : 레이블이 다항변수일 때

library(e1071)
lr_uni <- glm(formula=admit~.,data = train, family = binomial(link='logit'))

# family : 레이블변수의 분포유형

summary(lr_uni)

pred_uni <- predict(lr_uni, test)

예측한 레이블들은 목표변수의 확률값으로 출력됨
cut-off을 설정해야함
pred_uni <- predict(lr_uni, test, type = 'response')
모델 예측 시 레이블이 이산형변수로 출력
자동 cut- off 예측값 조사
pred_uni
round(pred_uni) # 반올림 처리 후 출력
 
table(round(pred_uni), test$admit)
confusionMatrix(as.factor(round(pred_uni)), test$admit)


# 4 로지스틱 회귀 모형 분석
summary(lr_uni)

# Pr(>|z|)
p-value 가 0.05보다 작은 변수는 gre,rank2,rank3, rank4이며, 통계적으로 유의미함

rank2, rank3, rank4 순으로 측정값이 마이너스 방향으로 움직임 -> rank가 낮을수록
합격률이 낮아짐

Deviance residuals : 모형의 목표변수 실제값과 추정값간의 차이인 오차의 4분위수
중앙값이 0에 가까울수록 정규분포에 따름

coefficientsdml 갯수 : 5개 (왜)?
  실제 독립변수 갯수는 3개임
=> rank 변수는 범주형 변수임
따라서, rank2,rank3, rank4 라는 더미변수를 생성하고 분석에 활용함

# Null deviance dhk Residual devidence
먼저 모형의 유의성 검정을 실시해야함
유의성 검정을 2가지 방식으로 실시한 결과값이 deviance에 표시
Null deviance : 입력변수가 사용되지 않을때 (NULL)
검정실시 시 로그를 적용한 확률값으로 계산
Residual deviance : 입력변수가 사용되고 각 변수로 인한 오차값
검정실시 시 카이제곱 통계량으로 계산

# Residual deviance를 이용한 카이제곱 통계량
gap <- lr_uni$null.deviance - lr_uni$deviance
두 편차의 차를 계산함

dfgap <- lr_uni$df.null-lr_uni$df.residual
두 편차의 자유도 차를 계산함

카이제곱 검정 실시 (pchisq 함수 사용)
범주형 데이터 간 동일성/연관성 여부 검ㅈ
options(scipen = 100)
pchisq(gap,dfgap, lower.tail = F)
