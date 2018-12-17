# 그래프 기초
# 숫자와 텍스트만으로 작성된 통계 결과는 지루 /따분
# 그래프와 그림형태로 제시(시작적 묘사)
# => 열정적 반응(데이터의 관계 구분 용이)

# 그래프 - plot, hist, bocplot
# 산점도 plot
# 연속형 데이터를 이용해서 작성해보는 기본적인 그래프
# 실제값은 x축에, 예측값은 y축에 배치
# 데이터들의 분포를 시작적으로 나타냄

plot(rnorm(15))
# 정규 분포를 따르는 난수 15개를 생성한 후 산점도 그리기

# 히스토그램
# 관측치의 빈도분포를 시각적으로 나타냄
# 그룹, 계급은 x축, 빈도수는 y축에 배치
hist(rnorm(15))


# 박스 그래프, 상자수염 그래프
# 각종 기술통계수치를 시각적으로 표시
# 최대값, 최소값, 사분위값, 중앙값 등을 이용
boxplot(rnorm(15))

# 사례 : 두 약물에 따른 환자 반응
dose <- c(20,30,40,50,60)
drugA <- c(16,20,27,40,60)
drugB <- c(15,18,25,31,40)
# A약에 대한 반응
plot(drugA)   # x 축은 index로 1부터
plot(dose,drugA)  # x 축은 dose
# B약에 대한 반응
plot(drugB)
plot(dose,drugB)  



# 산점도 시각화 옵션
plot(drugA, type='p')  # 점 point
plot(drugA, type='l')  # 선 line
plot(drugA, type='b')  # 둘다 both
plot(drugA, type='h')  # 수직선
plot(drugA, type='s')  # 계단식

.opar<-par(no.readonly = FALSE)
# 현재 그래프 매개변수 설정 저자
# 그래프 다양한 설정 알아보기
par(pch=17,lty=2,lwd=3, cex =2, bg='light cyan')
#pch : 점 종류 (0-25)
#lty : 선 종류 (1-6)
#cex : 기호크기(1,0.5,1.5)
#lwd : 선 굵기(1)
#bg : 배경색
plot(drugB, type='b')
hist(drugA)

par(.opar)  # 그래프 매개변수 초기화



# 모든 설정을 지정해서 그래푸 작성
plot(drugA,type='b',col='blue', main='메인', sub='서브',fg='orange',xlab='x축', ylab='y축',pch=10, lty=4,cex=1.5, xlim=c(-5,10),ylim=c(0,100))



# 두개의 그래프 그리기
plot(drugA, type='b', col='red', ylab= 'drugs')
lines(drugB, type='b', col= 'blue')
grid()  # 모눈 표


# cars 데이터셋을 이용한 그래프 그리기
# 자동차 제동거리 관련 데이터
cars

# 변수 하나만 사용
plot(cars$speed)
plot(cars$dist)

# 변수 두개를 사용
plot(cars$speed, cars$dist)
grid()
abline(lm(cars$dist~cars$speed),col='red')


manager <- c(1:5)
date <- c('10/24/14','10/28/14','10/01/14','10/12/14','05/01/14')
country <- c('US','US','UK','UK','UK')
gender <- c('M','F','F','M','F')
age <- c(32,45,25,39,99)

leadership<-data.frame(manager,date,country,gender, age)

str(leadership)
plot(leadership$manager,leadership$age)

# 매니저별 나이에 대한 산점도 성별도 함꼐 표시
plot(leadership$manager,leadership$age, pch=as.integer(leadership$gender))
?plot
# gender 는 범주형 변수이므로 level에 따라 점모양을 다르게 출력
# 매니저별 나이에 대한 산점도 작성 국적도 함께 표시
plot(leadership$manager,leadership$age, pch=as.integer(leadership$country))


# iris 데이터 셋
# 붓꽃 꽃잎 길이와 붓꽃 받침 길이에 따라 붓꽇을 분류해놓은 데이터
iris
str(iris)

# 붓꽃 꽃잎 petal 길이/너비도
plot(iris$Petal.Length,iris$Petal.Width)

# 붓꽃 꽃잎받침Sepal 길이/너비 산점도
plot(iris$Sepal.Length,iris$Sepal.Width)

# 붓꽃 꽃잎 petal 길이/너비도
# 붓꽃 종류와 함께 표시
plot(iris$Petal.Length,iris$Petal.Width,pch=as.integer(iris$Species), col=c('red','green','blue'))

# 붓꽃 꽃잎받침Sepal 길이/너비 산점도
# 붓꽃 종류와 함께 표시
plot(iris$Sepal.Length,iris$Sepal.Width,pch=as.integer(iris$Species))


# 범례 추가하기
with(leadership,plot(manager,age, pch=as.integer(gender), col=as.integer(gender)))

#  레드 블루 레드 블루 로 계속 반복되므로 위의 코드를 써야한다 그래야 그룹화가느
with(leadership,plot(manager,age, pch=as.integer(gender), col=c('red','blue')))

#topright,center,bottomleft
legend('topleft', c('Male','Female'), pch=c(1,2), col=c(1,2))

# iris 데이터 산점도에 범례 추가하기
str(iris)
tail(iris$Species,20)

with(iris, plot(Petal.Length,Petal.Width, pch=as.integer(Species),col=as.integer(Species)))
legend('bottomright', c('setosa','versicolor','virginica'),pch = 1:3, col=1:3)
#아래 방법은 복잡 위의 방법을 쓰자
#legend('bottomright', c('setosa','versicolor','virginica'),pch = as.integer(iris$Species[c(1,51,109)]), col=as.integer(iris$Species[c(1,51,109)]))

as.integer(iris$Species)

with(iris, plot(Sepal.Length,Sepal.Width, pch=as.integer(Species),col=as.integer(Species)))
legend('topright', c('setosa','versicolor','virginica'), pch = 1:3, col=1:3)


# 산점도 각 점에 수치 표시 
plot(drugA, type='p', col='red')
grid()
text(drugA, cex=0.7, lab=drugA, adj = c(-0.5,1))
# adj 벡터 안의 값이 - 일경우 x축은 오른쪽, y축은 아래쪽으로 이동


# 그래프 눈금 다루기
plot(drugA, type='p', col='red')
# x축 눈금이 잘 나오는데 y축 눈금이 뜨문뜨문 출력됨
plot(drugA, type='p', col='red', axes=F)
axis(1,at=seq(1:5))
axis(1,at=1:5,lab=c('A','B','C','D','E'))
axis(2, at=seq(0:70))
axis(2, ylim=c(0,70))


# 제목 다루기 ann= F
plot(drugA, type='p', col='red', ann= F)
title(main='환자 투약 효과', col.main='red',front.main=3)
title(xlab='환자', col.lab='blue',front.main=4)
title(ylab='투여량', col.lab='green',front.main=1)


# 이산형 데이터와 연속형 데이터
cars
Nile
plot(cars, type='p')
abline(lm(cars$dist~cars$speed), col='red')
plot(cars, type='l')

plot(Nile, type='p')
plot(Nile, type='l')

plot(AirPassengers, type='p')
plot(AirPassengers, type='l')
