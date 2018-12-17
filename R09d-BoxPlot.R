# 박스 그래프 (box and whiskers plot)
# 연속형 변수에 대해
# 최소/1사분위/중위/3사분위/최대/이상치등을
# 시각적으로 확인할 수 있도록 해주는 그래프

# mtcars데이터 셋 - 자동차 연비
str(mtcars)
summary(mtcars)
mtcars$cyl
boxplot(mtcars$mpg,ylim=c(10,35),col=rainbow(1),names=c('mpg'))

# cyl 별 연비 현황
mtcars$cyl
boxplot(mpg~cyl,data = mtcars,col=rainbow(3),ylim=c(10,35))

# gear 별 차량 연비 현황
mtcars$gear
boxplot(mpg~gear,data=mtcars,ylim=c(10,35))

# 평균을 계산해서 그래프에 점으로 표시
# 연비를 기어별로 구분한 후 평균 내기
means<-tapply(mtcars$mpg,mtcars$gear,mean)
points(means,col='red',pch=18)

# 핫도그 우승자의 핫도그 먹은 개수 현황을 박스그래프로 작성
summary(hg)
boxplot(hg,ylim=c(5,70))

# 탑승자의 나이 현황을 박스그래프로 작성
summary(ag)
boxplot(ag,ylim=c(20,75))

# 사원들의 급여 현황을 박스그래프로 작성
sal <- emp$SALARY
summary(sal)
boxplot(sal,ylim=c(2000, 25000))
means <- mean(emp$SALARY)
points(means,col='red',pch=18)

# 이상치 24000 제외하고
# 다시 박스그래프 작성
sal <- emp$SALARY[emp$SALARY!=24000]
sal
summary(sal)
boxplot(sal,ylim=c(2000, 25000))
means <- mean(emp$SALARY)
points(means,col='red',pch=18)
