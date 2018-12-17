# 나이브베이즈 알고리즘
조건부 확률을 이용힌 분류 알고리즘

조건부 확률 : 어떤 사건 A가 일어났을 때 사건 B가 일어날 확률
              사건 B확률은 사건 A확률에 영향을 받음

베이즈 정리 : 두 확률변수의 사전 확률과 사후 확률 사이의 관계를 나타내는 정리

P(A∩B) = P(A)P(B|A)
P(A∩B) = P(B)P(A|B)

따라서, P(A)P(B|A)=P(B)P(A|B) 이므로
P(A|B)=P(A)P(B|A)/P(B)이 도출됨

# P(A|B) : B 일때 A의 사후 확률
# P(A) : A의 사전확률
# P(B|A) : A 일 때 B 의 가능도(likehood)
# P(B) : 정규화 상수

# 영화 마케팅 문제를 베이즈 정리로 해결함
# 영화 관객의 성향을 설문조사로 정리
# 관객의 속성으로 영화 취향을 파악해보자

조건부확률 : P(A|B)
주변확률 : P(B|A) - 두 사건이 동시에 일어날 때 하나의 특정사건에 주목하여 그것이 일어날 확률

사전 확률

P(A) : 공포영화를 선택할 확률
P(B) : 20대, 여, IT, 미혼, 애인없음
P(B|A) = P(20대, 여, IT, 미혼, 애인없음 | 공포)=
       = P(20대|공포)*P(여|공포)*P(IT|공포)*P(애인없음|공포)

P(A) : 로멘틱영화를 선택할 확률
P(B|A)= P(20대, 여, IT, 미혼, 애인없음 | 로멘틱)
P(A) : 액션영화를 선택할 확률
P(B|A)= P(20대, 여, IT, 미혼, 애인없음 | 액션)
P(A) : 무협영화를 선택할 확률
]P(B|A)= P(20대, 여, IT, 미혼, 애인없음 | 무협)
P(A) : 스릴러영화를 선택할 확률
P(B|A)= P(20대, 여, IT, 미혼, 애인없음 | 스릴러)


# 입사지원시 조건에 따라 합격여부 판별
# 나이, 장래희망유무,인터뷰태도, 고교성적, 합격여부
사전확률
P(B) = 나이, 장래희망유무, 인터뷰태도, 고교성적
P(A) = 합격여부 확률

수집한 데이터 : 총 20건 이라고 가정
테스트 변수값 : 적음/없음/좋음/보통 -> ????
  
P(합격여부=합격)   =  13/20 = 0.65
P(합격여부=불합격) = 7/20 = 0.35

P(나이=적음|합격) = 4/13
P(나이=적음|불합격) = 3/7

P(장래희망=없음|합격) = 1/13
P(장래희망=없음|불합격) =7/7

P(태도=좋음|합격) = 3/13
P(태도=좋음|불합격) = 1/7

P(성적=보통|합격) = 2/13
P(성적=보통|불합격) = 3/7

조건부확률
P(합격|적음/없음/좋음/보통)= 13/20*4/13*3/13*2/13 = 0.0005 가정
P(불합격|적음/없음/좋음/보통) = 7/20*3/7*7/7*1/7*3/7 = 0.0092

불합격인 것이라 예측

# 나이브 베이즈에서 '나이브'는 단순한/순진한 뜻으로
모든 변수가 서로 독립이라고 가정하고 확률을 계산함
사후 확률값 자체를 아는 것이 중요한 것이 아니고
각각의 사후확률의 크기를 비교하는 것만으로도 충분하기 때문에 수식의 분모는 상수처럼 취급함

각 변수의 상호작용을 고려해서 확률을 구하려면 수식이 상당히 복잡해지기 때문에 각 변수를
독립사건처럼 단순화함으로써 수식이 단순해지는 효과를 얻을 수 있다


# 0. 데이터 전처리/ 탐색적 분석
mlbench 패키지 내장 데이터셋 - HouseVotes84
1984년에 실시된 중안건에 대한 미의회 투표기록 데이터 - 민주당/공화당 추정 판별
install.packages('mlbench')
library(mlbench)
data(HouseVotes84, package ='mlbench') # 데이터 로딩 안될때
vote84<- HouseVotes84
str(vote84)
?HouseVotes84
head

# 투표안건 : 장애아동, 물프로젝트비용, 예산안 체택, 의료수가 동결, 특정국가 원조,
학교내 종교단체 허용여부, 방위성 조사, 반군 원조, MX 미사일, 이민정책, 합성연료 감축,
교육비 추출, 수퍼펀드, 범죄, 면제수출, 수출행정법

table(vote84$Class)

set.seed(2018112117)
library(caret)
idx <- createDataPartition(vote84[,1], p=0.7, list=F)
train <- vote84[idx,]
test <- vote84[-idx,]

table(train[,1])
table(test[,1])

# 2. navie bayes 알고리즘 적용해서 분류 모델 생성
e1071 패키지의navieBayes  함수 이용
library(e1071)
nb_vote84 <- naiveBayes(formula=Class~., data=train, laplace = 0)

nb_vote84$tables[1:2]
각 투표안건에 대한 민주당/공화당 대비 y/n 확률
# 즉, 주변 확률에 대한 likehood를 측정한 것

predict_vote84<-predict(object=nb_vote84,newdata = test)
head(predict_vote84)

생성된 모델에 테스트 데이터셋을 이용해서 예측값 데이터 생성

# 간단한 성능평가
library(caret)
confusionMatrix(data=predict_vote84,reference = test$Class)

# ROC 곡선, AUC 값 조사
library(ROCR)
vote_roc <- prediction(labels=test[,1], predictions = as.numeric(predict_vote84))
vote_roc_perf <- performance(vote_roc,'tpr','fpr')
plot(vote_roc_perf)

library(qROC)
auc(test[,1], as.numeric(predict_vote84))



# movie 데이터 셋 - 나이브베이즈 실시
setwd('c:/Java/data')
movie <- read.csv('movies.csv', header = T, stringsAsFactors = T)
str(movie)
head(movie)
set.seed(2018112117)
idx <- createDataPartition(movie[,6], p=0.7, list=F)
train <- movie[idx,]
test <- movie[-idx,]

table(train$장르)
table(test$장르)

# 모델 생성
nb_movie<- naiveBayes(formula=장르~., data=train, laplace=0)

table()

# 모델 test 실시
predic_movie <- predict(object=nb_movie, newdata = test )
head(predic_movie)

# 간단한 성능평가
table(predic_movie,test$장르)
confusionMatrix(data = predic_movie, reference = test$장르)

# ROC 곡선, AUC 값 조사


# titanic 데이터 셋 - 나이브베이즈 실시
titanic <- read.csv('train.csv', header=T)



# iris 데이터 셋
# 1. 데이터 전처리
library(caret)
idx <- createDataPartition(iris$Species,p=0.7, list=F)
idx

train <- iris[idx,]
test <- iris[-idx,]

table(train$Species)
table(test$Species)

# 2. 나이브베이즈 알고리즘 적용 - 모델 생성
library(e1071)
nb_iris <- naiveBayes(formula=Species~., data=train, laplace=0)
# 라플라스 : 특정 변수의 발생확률이 0에 가까우면 전체 추정결과가 왜곡될 가능성이 존재
# 따라서, 0에 가까운 발생확률에 소량의 값을 추가함으로써 왜곡되는 것을 방지할 수 있음
# laplace = 1


nb_iris

pred_iris <- predict(object = nb_iris, newdata = test)

# 3. 성능 평가
confusionMatrix(data=pred_iris, reference = test$Species)
