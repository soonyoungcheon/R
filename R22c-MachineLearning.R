# KNN(K-Nearest Neighbor)
k - 최근접 이웃 알고리즘
머시러닝 분류에 자주 사용되는 대표 알고리즘 
얼굴인식, 개인영화추천, 질병 유전자 패턴 식별에 활용
분류 문제란 새로운 데이터가 들어왔을 때 기존 데이터의 그룹 중 어떤 그룹에 속하는지를
분류하는 문제를 말한다.


KNN의 K는 가장 가까운 이웃 '하나'가 아니고  
훈련데이터 중 새로운 데이터와 가장 가까운 k개의 이웃을 찾는다는 의미

즉, 하나의 관측값은 거리가 가까운 k개의 이웃 관측값들과 비슷한 특성을 갖는다고 가정함
따라서, k개 이웃의 목표변수 중 다수결로 가장 많은 범주에 속한 값을 결과로 반환

KNN 알고리즘에서 k를 얼마로 설정하느냔에 따라 결과와 성능이 달라짐
k가 작으면 데이터 범위가 작아짐 - 이상치에 민감
k가 크면 데이터의 범위가 넓어짐 - 결과가 일반화 경향띔

일반적으로 데이터 건수의 제곱을 k로 설정

# 머신러닝 관련 데이터셋
캘리포니아 어바인시 대학교 머신러닝 연구소
http://archive.ics.uci.edu/ml



# iris 데이터를 이용한 KNN분류
# 0. 데이터 수집/ 전처리/ 탐색적 분석(기술통계) 
str(iris) # 데이터 구조 확인

head(iris, n=5)  # 데이터 앞부분 확인
tail(iris, n=5)  # 데이터 뒷부분 확인

table(iris$Species)  # 품종 빈도 확인
plot(iris)          # 데이터 분포 확인
plot(iris$Sepal.Length,iris$Sepal.Width)
plot(iris$Petal.Length, iris$Petal.Width)

summary(iris)  # 최대/최소/사분위

# 레이블을 제외한 표준화


# 1. 전체 데이터셋을 train/test로 분리
set.seed(2018112016)
library(caret)
idx <- createDataPartition(iris[,5], p=0.7, list=F)
train <- iris[idx,]
test <- iris[-idx,]

# KNN 알고리즘을 이용한 모델 생성
install.packages('class')
library(class)

knn_iris <- knn(train=train[,1:4], test=test[,1:4], cl=train[,5], k =3, prob=T)
knn_iris

# KNN : train - 훈련 데이터셋 지정
# KNN : test - 검증 데이터셋 지정
# KNN : cl - 훈련 데이터셋의 레이블 지정
# KNN : k - 참고할 이웃 수 지정
# KNN : prob - 레이블 추측 확률 표시 여부 지정

# 예측값과 실제값을 비교하기 위해 빈도표 작성
test[,5]   #  실제가
knn_iris[1:45]  # 예측값 
table(test[,5], knn_iris[1:45])

            setosa versicolor virginica
setosa         15          0         0
versicolor      0         13         2
virginica       0          0        15

versicolor로 판정해야할 것을 virginica로 오판정한 것이 1건 발생


# 혼동행렬
e1071 패키지의 confusionMatrix 함수 사용

install.packages('e1071')
library(e1071)
confusionMatrix(data=knn_iris[1:45], reference=test[,5])


# confusionMatrix  data= 예측값 할당
# confusionMatrix  reference= 실제값 할당

# Accuracy  정확도
# Sensitivity 민감도 a값을 a이라고 제대로 측정한 정도
# Specificity 특이도


# Pos pred Value : 올바르게 예측
# Neg pred value : 부정확하게 예측


# ROC 곡선
거짓 긍정비율과 참 긍정비율 관계를 그래프로 표시
참 긍정 : 참인 값에 대해 참으로 예측(예. 암환자를 암환자로 예측)
거짓 긍정 : 거짓인 값에 대해 참으로 예측(예. 암환자가 아닌데 암환자로 예측)
install.packages('ROCR')
library(ROCR)
roc_data<-knn_iris[1:45]
roc_data<-roc_data[roc_data !='setosa']
roc_data <- as.factor(as.character(roc_data))
length(roc_data)
roc_data
roc_label<- test[,5]
roc_label<- roc_label[roc_label!='setosa']
roc_label <- as.factor(as.character(roc_label))
length(roc_label)

iris_roc <- prediction(labels=roc_label,predictions=as.numeric(roc_data))
iris_roc_perf <- performance(prediction.obj = iris_roc, measure = 'tpr', x.measure = 'fpr')

plot(x= iris_roc_perf)
lines(x=c(0,1), y=c(0,1), col='red', lty=2)


# AUC
ROC 곡선을 이용한 평가는 직관적이지만, 여러 모델을 비교하기 위해서는 수치로 계량화하는
것이 좀 더 편리함
범위는 대체로 0.7 이상이면 양호한 모델, 
0.8 이상일 경우 뛰어난 모델로 평가함

install.packages('pROC')
library(pROC)

# auc(실제값, 예측값)
auc(roc_label, as.numeric(roc_data))
Area under the curve: 0.9333

# wine 데이터를 이용한 KNN 분류

library(MASS)
archive.ics.uci.edu/ml => winequality 데이터 셋
winequlity-white.csv 파일을 다운로드한 후
wine_w.csv 파일 변경함

# 0 데이터 수집/전처리/탐색적 분석(기술통계)
setwd('c:/Java/data')
wine <- read.csv('wine_w.csv', sep=';', stringsAsFactors = F, header = T)
str(wine)  # 변수 : 12, 관측치
# acidity 산도 
# sugar 당도
# chlorides 염화물
# dioxide 이산화황
# density 밀도
# pH 수소이온농도
# suphates  황산염
# alcohol 알콜 함유량
# quality 와인 품질 (레이블)


head(wine, 5)
tail(wine, 5)
plot(wine)

table(wine[,12])   # quality 빈도표
plot(wine[,c(1:5,12)])  # 데이터 분포 확인 
plot(wine[,c(6:11,12)])


# 도수 분포표로 quality 빈도 확인
p<-barplot(table(wine[,12]), ylim = c(0,2400))
text(x=p, y=table(wine[,12]), labels = table(wine[,12]), pos = 3)
p

# quality 변수의 범위는 3~9
# 도수분포표로 확인해보니
# 3~6이 전체의 약 78% 정도임
# 따라서, 3~6은 good으로 7~9는 best로 정하는 새로운 레이블 변수 grade를 생성


wine$grade[wine$quality<=6] <- 'good'
wine$grade[wine$quality>6] <- 'best'

table(wine$grade)

# 1. KNN을 위한 전처리 - 표준화
변수간 척도(단위)가 다를 때 단위가 큰 변수가 전체 결과에 지배적인 영향을 미칠 수 있음
표준화를 거치면 모든 변수가 평균이 0, 표준편차가 1인 정규분포를 따르게 됨
scale 함수를 사용해서 각 변수를 표준화함

summary(iris) # max,min  확인
summary(wine) # max,min  확인
-> 변수간 단위가 다름, 표준화 필요

std_wine <- scale(wine[,1:11], center = T, scale=T)
=> 결과는 행렬 matrix로 출ㄹ
std_wine <- as.data.frame(std_wine)
std_wine <- cbind(std_wine,grade=wine[,13])
std_wine
summary(std_wine)

# 2. train/test 데이터셋으로 분리
library(caret)
idx <- createDataPartition(std_wine[,12], p=0.7, list=F)
idx
train <- std_wine[idx,]
test <- std_wine[-idx,]
nrow(train)
nrow(test)
table(train[,12])
table(test[,12])



# 3. KNN 알고리즘으로 분류모델 생성
library(class)
knn_wine <- knn(train=train[,1:11], test=test[,1:11], cl=train[,12], k=3, prob =T)

knn_wine

test[,12]
knn_wine[1:1469]   # 1469는 test 데이터 총 개수
table(test[,12],knn_wine[1:1469])



knn_wine5<-knn_wine <- knn(train=train[,1:11], test=test[,1:11], cl=train[,12], k=5, prob =T)


table(test[,12],knn_wine[1:1469])


# 4. 성능평가 confusionMatrix
library(e1071)
confusionMatrix(data=knn_wine[1:1469], reference = test[,12])
confusionMatrix(data=knn_wine5[1:1469], reference = test[,12])


# ROC

library(ROCR)

wine_roc <- prediction(labels=test[,12], predictions=as.numeric(knn_wine3))
wine_roc_perf <- performance(wine_roc,'tpr','fpr')
plot(wine_roc_perf)
lines(x=c(0,1), y=c(0,1), col='red', lty=2)

library(pROC)
auc(test[,12], as.numeric(knn_wine3))
auc(test[,12], as.numeric(knn_wine5))


