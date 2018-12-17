# 의사결정 나무
의사결정 규칙을 계층적 나무구조로 도표화하여 분류 및 예측을 할 수 있는 분석 방법
데이터 유형 - 연속형 수치, 범주형 값

데이터를 분석하여 이들 
그 모양이 나무처럼 보인다해서 DT라 부름 
마치 스무고개를 통해 문제를 해결한느 것과 유사

ex) 대출시 대상자의 신용평가
독버섯과 신용버섯을 분류
다음 달에 연체할 가능성이 있는 고객 판별
약정이 끝나면 다른 통신사로 이동할 고객 판별
타이타닉에서 살아남을 사람 분류


# 의사결정나무 알고리즘 분류
c4.5, c5.0 : 엔트로피
CART : 지니지수
CHAID : 카이제곱통계량 p값, F-검정값

#의사결정 나무의 가지 생성 방법
어떤 입력변수를 이용하여 어떻게 분리하는 것이 목표변수의 분포를 잘 구분할 수 있는지
파악하는 정도를 순수도/불순도로 정의

순수도 또는 불순도를 기준으로 나무를 성장시킴
즉, 부모마디에서 자식마디로 분리될 때 자식마디는 부모마디보다 순수도가 높거나
불순도가 낮아야 함

순수도가 증가/불순도가 감소하는 상황을 정보이론에서 정보이득 information gain이라 함
따라서, 순수도를 걔산하는 방식에 따라의사결정나무 알고리즘이 나뉨()

entropy
확률변수의 값이 0,1 을 가지는 어떤 확률분포 Y가 있을 때
1) P(Y=0): 0.5, P(Y=1) : 0.5
Y의 확률이 0인지 1인지 구분이 안됨
(엔트로피 낮음 - 무질서상태)

2) P(Y=0): 1.0, P(Y=1) :0.0
Y의 확률이 0인 것이 잘구분됨
(엔트로피 높음 - 질서 상태)

3) P(Y=0) : 0.7, P(Y=1) : 0.3
Y의 확률이 0이라고 어느 정도 구분됨

확률분포가 가지는 확신의 정도를 수치상으로 표현한 것을 엔트로피라 함
확률변수가 각각의 특정값이 나올 확률이 비슷한 경우
->엔트로피가 높다고 함

어떤 특정값이 나올 확률이 높고, 나머지 값의 확률이 낮은 경우
->엔트로피가 낮다고 함

즉, 데이터의 무질서도를 정량화해서 표현한 값 어떤 집합의 엔트로피가 높다는 것은
그 집단의 특징을 찾는 것이 어렵다는 의미

물리학에서는 상태가 분산되어 있는 정도를 엔트로피로 정의 
여러가지로 고루 분산되어 있으면 e가 높음
특정한 하나의 상태로 몰려있으면 e가 낮음

한편, 각 메세지에 포함된 정보의 기대값을 정보 엔트로피라고 함
일반적으로 엔트로피는 무질서도 또는 불확실성을 가리키며 0~1 사이 값을 가짐


지니지수
엔트로피처럼 확률분포가 어느 쪽에 더 치우쳐있는가를 재는 척도
단, 수식에 로그를 사용하지 않으므로 계산량이 적어 엔트로피 대신 많이 사용하기도 함


# R에서의 의사결정나무 관련 패키지
rpart : CART 알고리즘 사용(지니지수)
party : CART 알고리즘 개선버전
C50 : 엔트로피 지수를 사용


# 의사결정나무를 이용해서 개인대출을 받은 고객을 분류
고객번호, 나이, 경력, 소득, 우편번호, 가족수, 신카사용금액,교육수준,주택대출여부, 
개인대출여부, 증권계좌보유, 펀드계좌보유, 신용카드보유

# 0 전처리, 탐색적 분석

setwd('c:/Java/data')
banks <- read.csv('creditbanks.txt',header = T, stringsAsFactors = F)
str(banks)
head(banks)
summary(banks)
range(banks$Income)

분석에 관련없는 고객번호, 우편번호는 제외
banks <- banks[,-c(1,5)]
head(banks)

8 : 중졸, 고졸, 대졸(1,2,3)
10~14 : yes,no(1,0)

banks 에서 personalLoan 이 레이블(목표변수)임 
목표변수를 범주형 변수로 변환함
banks$PersonalLoan <- as.factor(banks$PersonalLoan)

대출여부를 빈도로 확인
table(banks$PersonalLoan)

대출거부가 대출승인보다 많음 -> 결과왜곡 유력
0 거부 1 승인
대출거부 level 값이 0으로 지정 -> 혼돈행렬에서는 0은 긍정의 의미 -> 변경해야 함
따라서, 의미에 맞게 level 값을 변경

banks$PersonalLoan <- relevel(banks$PersonalLoan,ref='1')
levels(banks$PersonalLoan)

# 1. train/test
set.seed(2018112216)
idx<-createDataPartition(banks$PersonalLoan, p=0.7, list=F)
train <- banks[idx,]
test <- banks[-idx,]

table(train$PersonalLoan)
table(test$PersonalLoan)


# 2. 의사결정나무 알고리즘 적용(지니지수 이용)
install.packages('rpart')
library(rpart)

dt_banks <- rpart(formula = PersonalLoan~., data=train, parms = list(split='gini'), method='class',
                  control = rpart.control(minsplit = 20, cp=0.01, maxdepth = 10))
# parms : 나무 가지 생성 기준 설정
# method : 데이터의 유형 설정
   class : 분류모델, anova : 회귀모델
# control : 의사결정나무의 가지 생성 정도 설정
   cp : 비용 복잡도 지정
   maxdepth : 가지의 깊이
   minsplit : 가지 생성 기준 관측값의 최소값
   
summary(dt_banks)
생성된 모형 확인하기
  
dt_banks 
모형을 단순하게 출력
plot(dt_banks, compress=T, uniform=T, branch=0.8, margin=0.05)
text(dt_banks, use.n=T, all=T, cex=0.8)

install.packages('rpart.plot')
library(rpart.plot)
rpart.plot(dt_banks)
# 의사결정나무를 보다 세련되게 출력
library(RColorBrewer)
myCol <- brewer.pal(n=3, name='Set2')
색상팔레트 중 3번째 팔레트의 Set2 선택


prp(dt_banks, faclen=0, cex=0.8, extra=101, box.pal=myCol[dt_banks$frame$yval])
faclen : 그래프 맨 끝에 레이블 출력
extra : 그래프 맨끝에 레이블 빈도 출력
box.pal : 그래프 맨끝 박스 색상 지정

나무 각 가지 끝에는 레이블과 그 레이블로 결과를 도출한 정보가 표시

맨 왼쪽 가지의 레이블은 1로 결정했는데 실제 데이터의 1과 0의 비율이 232/1 이기 때문임
아래 7%라는 의미는 특정 케이스로 대출거부될 확률을 나타냄


의사결정나무의 가지 수에 따라 성능이 좌우
따라서 maxdepth 값을 얼마로 지정하는 것이 좋을지 판단하는 것도 중요
plotcp(dt_banks)



dt_banks20 <- rpart(formula = PersonalLoan~., data=train, parms = list(split='gini'), method='class',
                  control = rpart.control(minsplit = 20, cp=0.01, maxdepth = 20))

dt_banks6 <- rpart(formula = PersonalLoan~., data=train, parms = list(split='gini'), method='class',
                    control = rpart.control(minsplit = 20, cp=0.01, maxdepth = 6))
plotcp(dt_banks)
plotcp(dt_banks20)
plotcp(dt_banks6)

# 3. 성능 평가
pred_banks <- predict(object=dt_banks, newdata=test, type='class')
library(caret)
confusionMatrix(data=pred_banks, reference = test$PersonalLoan)
