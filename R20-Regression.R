# 다중회귀분석
# 단일 회귀분석에 비해 변수가 2개 이상 증가
기술통계학이나 추론통계학 상의 주요 기법


종속변수 y를 보다 더 잘 설명하고 예측하기 위해 여러 독립변수 x를 사용함

다중회귀방정식
y = a + b*1 + c*2 + d*3 + ...

하지만, 보통 a + bx1 +cx2 정도로만 고려한다
그 이상이 되면(독립변수가 3개 이상) 그래프로 표현하기 어려워짐

ex) 부동산회사에서 소유하고 있는 주택에 대해 
고객들의 많은 문의사항 중 하나는 난방기가 얼마나 드느냐임
난방비 가이드라인 작성을 위해

setwd('c:/Java/data')
getwd()
house <- read.csv('houses.txt',header = T, sep='\t', stringsAsFactors = F)
names(house)
m <- with(house,lm(난방비~평균외부기온+단열재+난방사용연수))
coef(m)
회귀방정식
y = 427.193803    -4.582663평균외부기온   -14.830863단열재     6.101032난방사용연수

1) 외부기온이 1도 증가 => 난방비는  4.58 감소
2) 단열재두께가 1cm 증가 => 난방비는 14.83 감소
3) 난방기년수가 1년 증가 => 난방비는 6.10 증가
4) 주택 자체 난방비 => 427.19

만일, 기본이 30도이고, 단열재두께가 5cm이고 
난방기가 10이 된 주택의 예상 난방비는?
  427.193803-4.582663*30-14.830863*5+6.101032*10 = 276.5699
  
  
ex) 주택가격은 방의 갯수와 거주연수와 관련있음 다음 회귀 방정식을 보고 각 독립변수의 의미를 설명해
보세요
y = 21.2 + 18.7*1 - 0.25*2
1) 방의 갯수 1개 증가 : 주택가격은 18.7 증가
2) 거주년수 1년 증가 : 주택가격은 0.25 감소
3) 주택대지 : 기본 가격 21.2

만일, 방이 7개, 거주년수 30년일 때 주택가격은?
  21.2 + 18.7*7 - 0.25*30 = 144.6
  
  
ex) 놀이동산 만족도 데이터셋을 이용해서 놀이기구, 게임만족도, 청결만족도와 전체만족도에 대한
관계를 분석해보고 회귀방정식을 작성하세요
parks <- read.csv('parks.csv', stringsAsFactors = F, header=T)
names(parks)
m <- with(parks, lm(overall ~ rides+games+clean))
coef(m)
y = -131.6787679 + 0.5779797놀이기구+ 0.2602822+게임만족도+ 1.2838081청결만족도

# 다중회귀식 평가
다중회귀식의 통계적 분석은 회귀모형과 잔차를 이용
m <- with(house,lm(난방비~평균외부기온+단열재+난방사용연수))
options('scipen'=100)
summary(m)

# 다중표준오차 : 추정치의 표준오차와 표준편차 비교
Residual standard error: 51.05 on 16 degrees of freedom
기온 35, 단열재 두깨 3, 난방기연수 6일 때 난방비는?
  427.19 -4.58*35 - 14.83*3 + 6.10*6 => 259 으로 예측
하지만, 실제값은 250 임 
따라서 오차는 9 : 다른 관측치에 대해 오차 계산

=> 추정치의 다중표준오차는 잔차 평균제곱 MSE의 제곱근 = 평균제곱오차

# 다중결정계수
Multiple R-squared:  0.8042
독립변수등이 난방비 변동의 80%를 설명 또는 도출한다고 판단할 수 있음

19.6%의 오차는 다른 원인(오차나 다른 보이지 않는 변수)으로 인한 것이라고 추정 가능

with(house, cor(난방비,평균외부기온+단열재+난방사용연수)^2) => 0.6572343


# 수정된 결정계수
Adjusted R-squared:  0.7675 
독립변수의 수가 증가할수록 예측력이 좋아져서 결정계소의 수치가 증가하는 경향이 있음
이러한 효과를 상쇄시킨 수정된 결과


다중회귀분석에서는 종속변수와 독립변수 n개의 연관을 보여주는 미지의 모회귀식이 있다고 가정
이것을 관계의 모형 model이라고 부름
Y = 알파 + 베타1X1 + 베타2X2 + 베타 3X3 + ...


# 다중선형회귀모형 추론
F-statistic:  21.9 on 3 and 16 DF,  p-value: 0.000006562

만일, 독립변수가 없더라도 종속변수를 추정할 수 있을까?

즉, 다중회귀계수가 모두 0인지 검정하자 - F 분포이용
귀무가설 : 각 계수가 0이다
대립가설 : 각 계수가 모두 0이 아니다

유의수준 0.05 정함

F분포의 특징
자유도에 의해 새로운 F분포가 생성 - 왜도가 변함
연속분포, 양의 방향으로 치우친 분포, 점근적 구조

분자의 자유도 3, 분모의 자유도16를 이용해서 F분포표에서 임계값 조사
F분포표에서 임계값 조사 : 3.24
검정값이 21.06 따라서, 귀무가설 기각
=> 회귀계수는 0이 아니다

분자  :  회귀제곱합을 회귀자유도로 나눈값
분모  :  잔차제곱합을 잔차자유도(n-(k+1)로 나눈값)

      
# 개별 회귀계수에 대한 평가
  Coefficients:
  Estimate Std. Error t value   Pr(>|t|)    
(Intercept)  427.1938    59.6014   7.168 0.00000224 ***
  평균외부기온  -4.5827     0.7723  -5.934 0.00002100 ***
  단열재       -14.8309     4.7544  -3.119    0.00661 ** 
  난방사용연수   6.1010     4.0121   1.521    0.14786    
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

  
특정 독립계수가 개별적으로 검정하여 해당하는 회귀계수가 0인지 아닌지 검정
어떤 계수가 0이라면 독립변수는 종속변수의 변동을 설명하는데 쓸모 없음
기각할 수 없는 변수는 제거하는 것이 나음
각 회귀계수는 유의수준 0.05, 양측검정으로 평가

귀무가설 : 각 회귀계수가 0이다
대립가설 : 각 회귀계수가 0이 아니다

자유도가 16이므로 임계값은 -2.120 2.120 임

  
ex) 놀이동산 만족도 데이터셋을 이용해서 놀이기구, 게임만족도, 청결만족도와 전체만족도에 대한
결정계수와 다중/개별 회귀계수에 대한 평가를 하세요

parks <- read.csv('parks.csv', stringsAsFactors = F, header=T)
names(parks)

다중회귀모형
m <- with(parks, lm(overall ~ rides+games+clean))
coef(m)
summary(m)
Multiple R-squared:  0.4392,	Adjusted R-squared:  0.4358 
F-statistic: 129.5 on 3 and 496 DF


# 의학정보 데이터를 참고해서
심박수 BMP 대비 몸무게에 대한 회귀식과 
심박수 BMP 대비 몸무게, 강제호기량, 잔기량에 대한 회귀식을 작성하고
결정계수와 다중/개별 회귀계수에 대한 평가를 하세요

medical <- read.csv('medical.csv', stringsAsFactors = F, header=T)
tail(medical)

# 단일회귀분석 : 심박수/체충
m<- with(medical, lm(BMP ~ weight))
summary(m)
Coefficients:
  Estimate Std. Error t value         Pr(>|t|)    
(Intercept)  60.9554     4.3699  13.949 0.00000000000104 ***
  weight        0.4511     0.1035   4.358          0.00023 ***
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 9.076 on 23 degrees of freedom
Multiple R-squared:  0.4523,	Adjusted R-squared:  0.4285 
F-statistic:    19 on 1 and 23 DF,  p-value: 0.0002305

# 다중회귀분석 
m <- with(medical,lm(BMP ~ weight+FEV+RV))
coef(m)
다중회귀방정식
y = 60.0872218  + 0.3297987weight +   0.2706874FEV -0.0151688RV 

평가
m<- with(medical, plot())
summary(m)

Adjusted R-squared:  0.4648 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)   
(Intercept) 60.08722   15.84198   3.793  0.00106 **
  weight       0.32980    0.12809   2.575  0.01766 * 
  FEV          0.27069    0.21499   1.259  0.22181   
RV          -0.01517    0.03192  -0.475  0.63957   
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 8.783 on 21 degrees of freedom
Multiple R-squared:  0.5317,	Adjusted R-squared:  0.4648 
F-statistic: 7.948 on 3 and 21 DF,  p-value: 0.0009937


나이 age, 키hight, 몸무게 weight, 강제호기량 FEV
잔기량 RV 기능성잔기량 FRC, 전폐용량 TLC, 호기최대량 PE



# 상호작용항
독립변수 사이의 상호작용이 있는 경우
ex) 다이어트와 운동이 서로 관련있는지 연구
체중변화량 = 종속변수
다이어트, 운동 = 독립변수
따라서, 다이어트를 유지하고 운동을 하면 체중 감소?
즉, 전체 체중감소량이 다이어트 효과량과 운동 효과량의 합보다 크다할 수 있나?

회귀분석에서 상호작용은 별도의 독립변수를 통해 만들어낼 수 있ㅇ
  
ex) 부동산회사에서 소유하고 있는 주택에 대해 

house <- read.csv('houses.txt',header = T, sep='\t', stringsAsFactors = F)

기존 회귀식
y(난방비) = 427.19 -4.58X1 -14.83X2
house$기온x단열재 <- house$평균외부기온*house$단열재
head(house)

m <- with(house, lm(난방비~평균외부기온+단열재+평균외부기온*단열재))
coef(m)
y = 598.070  -7.810a  -30.160b  +  0.385c 
summary(m)


아쉽지만, '평균외부기온:단열' 회귀계수는 귀무가설을 기각할 정도의 수치를 가지고 
있지 않기 때문에 상호작용항으로써의 기능은 못함


# Orange 데이터 셋을 이용해서 
나무의 수령에 따라 나무의 자라는 환경에 영향을 주는 회귀분석을 실시하세요
상호작용항 : 나무종류와 나이
str(Orange)
data(Orange)
head(Orange)
tail(Orange)
Orange$Tree <- factor(Orange$Tree, ordered = F)


with(Orange, plot(Tree, circumference))
Tree 변수가 범주형 변수라서 
적절한 자료형으로 변환한 후 회귀분석 실시


# 개별 독립변수 나이와 둘레 회귀분석
m<-with(Orange, lm(circumference ~ Tree+age))
summary(m)
# 상호작용항 변수 나이*둘레 회귀분석
m<-with(Orange, lm(circumference ~ age*Tree))
summary(m)

Orange$Tree


Orange


# mtcars 데이터셋을 이용해서 
연비 mpg 대비 중량wt과 마력hp에 대한 개별 회귀계수와 상호작용항에 따른
회귀식을 만들고 회귀계수를 평가하세요

head(mtcars)

개별
m<- with(mtcars, lm(mpg ~ wt + hp))
summary(m)
(Intercept) 37.22727    1.59879  23.285 < 0.0000000000000002 ***
  wt          -3.87783    0.63273  -6.129           0.00000112 ***
  hp          -0.03177    0.00903  -3.519              0.00145 ** 
Adjusted R-squared:  0.8148  
  
상호작용항
m<- with(mtcars, lm(mpg ~ wt*hp))
summary(m)  
Adjusted R-squared:  0.8724



# 다중공선성
독립변수들이 서로 상관되었을때 발생

ex) 대학교 합격 여부를 예측하기 위해 고등학교 성적과 석차를 사용하는 경우 
예기치 못하게 독립변수의 하나가 음의 상관을 나타낼 수 있음 - 설명하기 어려움
독립변수 가설 검정시 결과가 잘못 나올 수 있음

두 독립변수간의 상관계수가 -0.7~0.7 사이면 사용해도 좋음
팽창계수 VIF를 사용하기도 함 : 10이상이면
독립변수는 제외시킴 : 1/1 - 결정계수


ex) 다중공선성 문제풀기
시멘트가 굳어지며 발생하는 열의 양을 결정짓는 4가지 성분의 회귀분석

x1 <- c(7, 1, 11, 11, 7, 11, 3, 1, 2, 21, 1, 11, 10)
x2 <- c(26, 29, 56, 31, 52, 55, 71, 31, 54, 47, 40, 66, 68)
x3 <- c(6, 15, 8, 8, 6, 9, 17, 22, 18, 4, 23, 9, 8)
x4 <- c(60, 52, 20, 47, 33, 22, 6, 44, 22, 26, 34, 12, 12)

y <- c(78.5, 74.3, 104.3, 87.6, 95.9, 109.2, 102.7, 
       72.5, 93.1, 115.9, 83.8, 113.3, 109.4)
cm <- data.frame( y,x1, x2, x3,x4)
plot(cm)  # 상관행렬 산점도
m <- with(cm, lm(y ~ x1+ x2+x3+x4))
m <-lm(y ~.,data=cm)  # 독립변수를 .로 줄여씀

summary(m)
Coefficients:
  Estimate Std. Error t value Pr(>|t|)  
(Intercept)  62.4054    70.0710   0.891   0.3991  
x1            1.5511     0.7448   2.083   0.0708 .
x2            0.5102     0.7238   0.705   0.5009  
x3            0.1019     0.7547   0.135   0.8959  
x4           -0.1441     0.7091  -0.203   0.8441  
---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.446 on 8 degrees of freedom
Multiple R-squared:  0.9824,	Adjusted R-squared:  0.9736 
F-statistic: 111.5 on 4 and 8 DF,  p-value: 0.0000004756


결정계수도 높고, 전체 회귀계수에 대한 평가도 나쁘지 않지만, 개별 회귀계수에 대한
평가는 나쁨 - 다중 공선성 때문에 발생

따라서, 팽창계수를 확인해 봄
car 패키지의 vif 함수를 사용하면 다중공선성 검사 가능
library(car)
vif(m)


# x1, x3를 이용한 회귀분석
m13 <- lm(y~ x1+x3,data=cm)
vif(m13)
summary(m13)


# 독립변수 최적화
독립변수가 많을때 유의한 계수를 포함 시키고 유의하지 않은 계수를 제외시켜 주한
회귀방정식은 간단해지고 이해하기 쉬어짐

다중 회귀식에 포함할 수 있는 독립변수들을 효과적으로 선별할 수 있는 분석방법
-> 단계적 회귀법, 단계적 변수선택법
전진소거법 : 중요도(설명력 R^2)가 높은 변수부터 추가
후진소거법 : 모든 변수로 회귀식 생성 후 p값이 높은 변수부터 제거

# 후진소거법 이용
m<- lm(난방비~., data=house)
summary(m)  # Multiple R-squared:  0.8285
=> p값이 높은 회계계수를 제거:난방사용연수 제거
m <- lm(난방비~ 평균외부기온+단열재, data=house)
summary(m) # Multiple R-squared:  0.7759

y = 490.2859 -5.1499X1  -14.7181X2거


# 전진 소거법 이용
# 단계별 소거법 이용
# 이렇게 변수를 하나씩 빼고 추가하며 
유의한 독립변수를 찾는 것은 다소 불편
더구나 변수의 갯수가 많아지면 시간도 많이 걸림 => step 함수를 사용할 것을 권장
 step(lm모델, 변수범위, 소거종류)

# 전진소거법
step(lm(난방비~1,data=house), scope=list(lower=~1, upper=~평균외부기온+단열재+난방사용연수), direction = 'forward')

# 후진소거법
step(lm(난방비 ~ 평균외부기온+단열재+난방사용연수, data=house), direction = 'backward')

# 단계소거법
step(lm(난방비~1, data=house), scope=list(lower=~1, upper=~평균외부기온+단열재+난방사용연수), direction = 'both')
names(house)


AIC  : 종속변수의 실제 분포와 모형에 의해 예측된 분포사이의 불일치 측정값
RSS  : 낮을수록 좋은 모형을 의미함

RSS  : 오차의 분산정도를 나타낸 값




# 보스턴 집값 예측
보스턴 외각지역 집값과 그것들과 관련있는 여러 요소를 변수로 정의
범죄률, 단위면적당 거주주민수, 비상업지구 거주민, 강근처 주택여부, 오염도 비율,
공실 비율, 노후주택 비율, 도로 접근성 비율, 재산세 비율, 학생.교사 비율, 유색인종 비율,
하위계층 비율, 본인소유 주택 가격

최종적으로 집값에 영향을 주는 요인은?
library(MASS)
str(Boston) 
?Boston
tail(Boston)
상관행렬
plot(Boston)
names(Boston)
회귀분석
options('scipen'=100)
후진 소거법
m<- lm(medv~.,data=Boston)
summary(m)
m<- lm(medv~crim+zn+chas+nox+rm+dis+rad+tax+ptratio+black+lstat,data=Boston)
summary(m)
m<- lm(medv~crim+zn+nox+rm+dis+rad+tax+ptratio+black+lstat,data=Boston)
summary(m)
m<- lm(medv~chas+nox+rm+dis+rad+tax+ptratio+black+lstat,data=Boston)
summary(m)
m<- lm(medv~nox+rm+dis+ptratio+lstat,data=Boston)
summary(m)

# 최종적으로 집값에 영향을 주는 요인
공기오염도, 주택당 방수, 구직용이성, 학생/교사비율, 인구비율

# step 함수를 이용한 후진제거
m<-step(lm(medv~crim+zn+chas+nox+rm+dis+rad+tax+ptratio+black+lstat+indus+age,data=Boston), direction='backward')
# indus, age 제외한 결과 출력

# 다중공선성 확인
library(car)
vif(m)  # rad도로접근성 tax재산세 비율 수치가 다소 높은 편

# 독립변수 제거를 위힌 또 다른 방법1
# regsubsets : n개의 변수가 있을때, 각 변수를 더하고 빼거나, 2n개의 모델을 만들어 비교하면서
# 적절한 회귀모델을 생성해 주는 함수

install.packages('leaps')
library(leaps)


?regsubsets
m<- regsubsets(medv~.,data=Boston, method = 'exhaustive')
m
summary(m)
summary(m)$bic     # 회귀모델 측정값
summary(m)$adjr2   # 조정된 R^2값
plot(m, scale = 'bic')
plot(m, scale = 'adjr2')



m<- regsubsets(medv~.,data=Boston, method = 'forward')
m
summary(m)

m<- regsubsets(medv~.,data=Boston, method = 'backward')
m

summary(m)
# 최적변수 소거
m<- regsubsets(medv~.,data=Boston, method = 'seqrep')
m
summary(m)


ex) 어떤 은행에서 담보대출관련 분석을 위해 관련 자료를 분석하고 있음. 
 주택구입가격,세대주 교육수준, 세대주 연령, 월상환액, 세대주 성별등이 가계소득 수준과 어떤 관련이 
  Value           Education         Age          Mortgage   Gender
있는지 회귀분석을 실시하세요
setwd('c:/Java/data')
bank <- read.table('banks.txt', header = T, stringsAsFactors = F)
head(bank)
plot(bank)  # 상관행렬
library(corrplot)
cor_bank <- cor(bank)  
corrplot(cor_bank, method = 'number') # 상관계수 행렬
# 상관계수행렬의 첫번째 열을 기준으로볼 때 가계수입은 주택구입가격과 양의 상관관계임
하지만, 교육수준과 모기지와는 약한 상관관계를 보임

각 상관계수의 값이 -0.7~0.7 사이에 있으므로 다중공선성 문제는 없어보임


# 전체 독립변수를 이용해서 다중회귀식 계산
m <- lm( Income  ~. ,data = bank)
summary(m)
coef(m)
# 회귀방정식 : R^2 = 0.6831
y = 70.648+0.071Value+1.6156 Education -0.122Age -0.0009Mortgage  +1.817Gender 


Coefficients:
  Estimate Std. Error t value     Pr(>|t|)    
(Intercept) 70.6483026  7.5013154   9.418 0.0000000137 ***
  Value        0.0718329  0.0124864   5.753 0.0000152289 ***
  Education    1.6159743  0.6060901   2.666      0.01526 *  
  Age         -0.1221059  0.0785276  -1.555      0.13646    
Mortgage    -0.0009212  0.0031880  -0.289      0.77575    
Gender       1.8167604  0.6259073   2.903      0.00913 ** 
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.485 on 19 degrees of freedom
Multiple R-squared:  0.7491,	Adjusted R-squared:  0.6831 
F-statistic: 11.34 on 5 and 19 DF,  p-value: 0.00003556


# 독립변수 소거(Mortgage) : R^2  0.6976 
m <- lm(Income~.-Mortgage, data=bank)
summary(m)
# 회귀방정식
y = 70.241+0.071Value+ 1.636 Education -0.122Age  +1.852Gender 


# 독립변수 소거(Age) : R^2  0.6755 
m <- lm(Income~.-Mortgage-Age, data=bank)
summary(m)
# 회귀방정식
coef(m)
y = 74.60+0.0637Value+ 1.007Education+1.776Gender 

# 다중공선성
vif(m)
Value Education    Gender 
1.061626  1.029594  1.043704 



# 전진소거법(수동)
m <- lm( Income  ~Value+Education+Age+Gender,data = bank)
summary(m)

Coefficients:
  Estimate Std. Error t value      Pr(>|t|)    
(Intercept) 70.24177    7.19738   9.759 0.00000000476 ***
  Value        0.07058    0.01144   6.171 0.00000498939 ***
  Education    1.63642    0.58799   2.783       0.01148 *  
  Age         -0.12211    0.07671  -1.592       0.12710    
Gender       1.85290    0.59906   3.093       0.00574 ** 
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.451 on 20 degrees of freedom
Multiple R-squared:  0.748,	Adjusted R-squared:  0.6976 
F-statistic: 14.84 on 4 and 20 DF,  p-value: 0.000008762


# 이 모델 채택

m <- lm( Income  ~Value+Education+Gender,data = bank)
summary(m)
Coefficients:
  Estimate Std. Error t value      Pr(>|t|)    
(Intercept) 74.60001    6.89513  10.819 0.00000000048 ***
  Value        0.06366    0.01096   5.809 0.00000912935 ***
  Education    1.00702    0.45082   2.234       0.03651 *  
  Gender       1.77640    0.61856   2.872       0.00913 ** 
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.503 on 21 degrees of freedom
Multiple R-squared:  0.7161,	Adjusted R-squared:  0.6755 
F-statistic: 17.65 on 3 and 21 DF,  p-value: 0.000005913


# step 함수를 써서 자동으로 전진소거법 적용
step(lm(Income~1,data=bank), scope=list(lower=~1, upper=~Value+Education+Age+Gender+Mortgage), direction = 'forward')
step(lm(Income~Value+Education+Age+Gender+Mortgage,data=bank), direction = 'backward')









# 잔차의 정규분포 확인
plot(m)
성
# 1) 잔차그래프 : 정규성
=> 독립변수가 정규분포를 띄면 잔차도 정규분포를 띄는가?
library(lattice)  
hist(rstandard(m))

  
#2) 잔차 확률분포도 : 독립성
누적 정규확률분포표
점선 : 표준누적 정규분포


# 3) 잔차 예측비교도 : 선형성
잔차를 표준화시켜 정규분포를 따르는지 확인

# 4) 잔차 분산비교도 : 등분산성
=> 독립변수의 분산 양상에 따라 잔차도 비슷한 양상을 띄는가?

  
# cook's distance
회귀방정식의 계수 결정에 불균형한 영향을 미치는
독립변수 존재 여부 파악

따라서, 산출된 회귀방정식은 가계소득변수의 변동성을 0.6976 =>70% 정도로 설명하고 있고
선형관계, 잔차의 정규분포, 등분산성, 다중공선성에서 커다란 문제는 없음


ex) 미술품 수집가는 그림의 낙찰가격과 입찰자수, 보존연수와의 관계를 알아보고자 함
독립변수와 종속변수간에 어떤 관련이 있는지 회귀분석을 실시하세요
요
art <- read.table('artsbuyer.txt', header = T, stringsAsFactors = F)
tail(art)
상관행렬(그림번호 제외)
plot(art[,-1])
상관계수행렬 (그림번호 제외)
cor_art<- cor(art[,-1])
corrplot(cor_art, method = 'number')

그림번호와 가격에 다중공선성문제가 살짝 엿보임


arts<- art[,-1]
m <- lm(Price~.,data=arts)
summary(m) 0.6158 

vif(m) # 다중공선성 확인


#선형회귀식
coef(m)
y = 3080.05 + -54.18Bidders  +16.28Age 

# 잔차의 정규분포, 공분산성, 독립성, 선형성 확ㅇ
.opar <- par(no.readonly = F)
par(mfrow=c(2,2))
plot(m)
par(.opar)
library(lattice)
hist(rstandard(m))

따라서, 산출된 회귀방정식은 0.62 =>62% 정도로 설명하고 있고
선형관계, 잔차의 정규분포, 등분산성, 다중공선성에서 커다란 문제는 없음



ex) 자동차부품도매상 관리자는 각 지역의 연매출을 추정하고자 함. 지역내 아웃렛수, 
차량등록수, 개인총소득, 자동차사용년수, 매니저수등이 총매출에 어떤 영향을 주는지
회귀분석을 실시하세요

carpart <- read.table('carparts.txt', header = T, stringsAsFactors = F)
tail(carpart)
plot(carpart)
str(carpart)
library(stringr)
carpart$outlet <- str_remove_all(carpart$outlet,',')
carpart$outlet <- as.integer(carpart$outlet)


plot(m)
cor_car<- cor(carpart)
corrplot(cor_car, method = 'number')

# 전체 독립변수를 사용
m <- lm(sales~.,data=carpart )
summary(m)  # 

m <- lm(sales~.-outlet-manager-year,data=carpart )
summary(m)


coef(m)

# 회귀모형
y = -7.75 + 1.38users +  0.39income 
vif(m)


ex) 공매를 통해 차압된 주택을 전문적으로 판매하는 회사에서 주택대출잔고, 월납입액, 납입회차 대비
최종 경매가에 대해 추정하라고 함. 이에 적절한 회귀분석을 하세요
auction <- read.table('auctions.txt', header = T, stringsAsFactors = F)
tail(auction)
plot(auction)
str(auction)
plot(auction)

m<-lm(Auction~.,data=auction)
summary(m)   #0.8598

m<-lm(Auction~.-Payments,data=auction)
summary(m)  #0.8679
vif(m)

m<-lm(Auction~.-Payments-PaymentsMade,data=auction)
summary(m)  #0.874 

# 정규성, 선형성, 등분산성
.opar <- par(no.readonly =F)
par(mfrow=c(2,2))

plot(m)
coef(m)

# 회귀식
y = -119892.87 + 1.67Loan  



ex) 주택 보수재료를 취급하는 회사에서 광고비, 거래처수, 경쟁브랜드수, 잠재력 등을
토대로 매출액에 대한 추정치를 알고싶어 함
이에 적절한 회귀분석을 하세요

house <- read.table('houseparts.txt', header = T, stringsAsFactors = F)
tail(house)
plot(house)
str(house)
plot(house)
cor_house <- cor(house)
corrplot(cor_house, method = 'number')

par(mfrow=c(1,1))
m <- lm(Sales~.,data=house)
summary(m)
vif(m)

# 독립변수 제거 Ad
m <- lm(Sales~.-Potential,data=house)
summary(m)  #0.9874 

m <- lm(Sales~.-Potential-Ad,data=house)
summary(m)  #0.9866 
plot(m)
y = 186.6940 + 3.4081accounts  -21.1930Competitors
vif(m)
.opar <- par(no.readonly =F)
par(mfrow=c(2,2))
plot(m)
hist(rstandard(m))

산출된 회귀 방정식은 약 98%(0.9866)의
설명력을 가지고 있으며(과적합예상) 선형관계, 잔차의 정규분포,
등분산성, 다중공선성에 커다란 문제는 다소 없음

