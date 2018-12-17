# ggplot2
다양하고 세련된 그래프를 그리기 위한 패키지
별도로 ggplot2 하는 패키지를 설치해야 사용가능
데이터를 이용해서 색, 형태, 크기 등으로 달리 표시하거나 
범례를 추가할 수 있고, 그래프 그리는 속도로 빠름
기본적으로 ggplot 함수를 이용해서 그래프의 기본적인 형태를 만들고
+ 연산자를 이용해서 레이어를 추가하는 방식으로 나머지 부분을 그림

레이어 : 점, 선, 히스토그램 등의 기하학적 그래프를 그려주는 요소 
일반적으로 geom_접두사로 시작함 
ex)geom_point(점), geom_line(선), geom_histogram(히스토그램)

install.packages('ggplot2')
library(ggplot2)

head(diamonds)  # 데이터셋 확인
ggplot(diamonds)  # 그래프를 그리기 위한 프레임 생성

?diamonds

ggplot(diamonds, aes(x=carat, y=price))
# aesthetic으로 그래프의 외관(x,y축) 지정

ggplot(diamonds, aes(x=carat, y=price, color='red'))
# aesthetic으로 그래프의 외관(x,y축, 색) 지정

gg <- ggplot(diamonds, aes(x=carat, y=price, color='red')) 

gg + geom_point()
# 점 그래프 그리기 

gg <- ggplot(diamonds)
gg + geom_point(aes(x=carat, y=price, color=cut))

# 색상을 cut 변수로 지정해서 점 그래프 그림
gg <- ggplot(diamonds)
gg + geom_line(aes(x=carat, y=price, color=cut))
# 색상을 cut 변수로 지정해서 선 그래프 그림


gg <- ggplot(diamonds)
gg + geom_histogram(aes(x=carat,color=cut))
# 색상을 cut 변수로 지정해서 히스토그램 그림


gg <- ggplot(diamonds)
gg <- gg + geom_point(aes(x=carat, y=price))
gg + geom_line(aes(x=carat, y=price))
# 점 + 선 그래프


ggplot(diamonds) + geom_density(aes(x=carat),fill ='red')
# 밀도 곡선 그래프1
ggplot(diamonds) + geom_density(aes(x=carat),fill ='grey')

ggplot(diamonds) + geom_boxplot(aes(x=cut, y=price))
# 상자그래프

ex) mtcars데이터셋을 이용해서 차량중량 대비 연비를 점 그래프로 그리세요
library(ggplot2)
mtcars

gg <-ggplot(data=mtcars)
gg + geom_point(aes(x=wt, y=mpg, color=cyl))

ex) economics데이터셋을 이용해서 년도별 실업률 현황, 년도별 인구수 현황을
점 그래프로 그리세요
head(economics)

# 점그래프
gg<-ggplot(data=economics)
gg + geom_point(aes(x=date, y=uempmed))

gg<-ggplot(data=economics)
gg + geom_point(aes(x=date, y=pop))


# 선그래프
gg<-ggplot(data=economics)
gg + geom_line(aes(x=date, y=uempmed))

gg<-ggplot(geom_line()a=economics)
gg + geom_line(aes(x=date, y=pop))

# ggplot의 경향화 버전 -qplot
R의 기본 그래프 패키지와 비슷한 사용법 제공

nrow(diamonds)  # 53940행
set.seed(20181116)  # 난수생성을 위한 seed 설정
tinydia <- diamonds[sample(nrow(diamonds),1000),]
# 53940행을 가진 diamonds 데이터셋에서 무작위로 500개만 추출해 냄
# SRS simple random sampling


# 기본사용법
qplot(carat, price, data=tinydia)
qplot(carat, price, data=tinydia, color=color)
# shape 그래프로 표시점 색상 지정
qplot(carat, price, data=tinydia, shape=cut)
# shape 그래프로 표시점 모양 지정


# 그래프에 회귀선을 추가하고 신뢰구간 표시하기(smooth 기나)
library(splines)
qplot(carat, price, data=tinydia, geom=c('point', 'smooth'), method='lm')


# 상자그래프 
qplot(color, price/carat, data=tinydia,geom='boxplot')
str(diamonds) 범주형 데이터 사용

# 히스토그램
qplot(carat, data=tinydia, geom='histogram', fill=color) # 막대색 지정
막대 그래프 색깔 채우기 파마미터는 fill 

# 막대그래프
qplot(color, data = tinydia, geom='bar', fill=color)


# 선그래프
qplot(date, pop, data=economics, geom='line', color='red')

# 그래프 미적 요소 세부 지정
qplot(carat, price, data=tinydia, xlab = '캐럿', ylab = '가격', main= '캐럿당 가격')

# 부분 데이터facet 를 이용한 그래프 출력
qplot(carat, data= tinydia, geom='histogram', facets = color~.) # 행단위
qplot(carat, data= tinydia, geom='histogram', facets = .~color) # 열단위

# iris 데이터 셋을 이용해서 꽃잎길이 대비 꽃받침길이에 대한 산점도를 qplot함수를 이용해서 그리세요
head(iris)
?iris
qplot(Sepal.Length,Sepal.Width,data=iris, color=Species)
qplot(Petal.Length,Petal.Width,data=iris, color=Species)


# Cars93 데이터 셋을 이용해서 고속도로 연비를 막대그래프로 그리시오
막대그래프로 그리세요(열단위 출력)
qplot(MPG.highway, data= Cars93, geom='bar')
qplot(MPG.highway, data= Cars93, fill=Cylinders)
head(Cars93)



#
library(MASS)
data("Cars93")
head(Cars93)
qplot(MPG.highway,data=Cars93, facets=Origin~.)
qplot(MPG.highway,data=Cars93, facets=.~Origin)


# 시내 연비 대리 중량을 이용해서 산점도를 그리세요
qplot(Weight,MPG.city,data=Cars93)

# mtcars데이터셋을 이용해서 자체 중량 연비 대비 산점도를 그리세요
단, 색상은 carb 변수로, 모양은 cyl변수로 크기는  qsec 변수로 지정한다

mtcars2<-mtcars
mtcars2$cyl<- as.factor(mtcars$cyl)
mtcars2$carb<- as.factor(mtcars$carb)
str(mtcars2)
qplot(wt, mpg, data= mtcars2, shape= cyl, color=carb, size=qsec)
?qplot
qplot(wt, mpg, data= mtcars2, shape= cyl, color=carb, size=mpg)

단,각 점에 자동차 이름을 레이블로
qplot(wt, mpg, data= mtcars2,label=row.names(mtcars2),geom=c('point','text'), hjust=-0.1,vjust=0.3)


# mtcars데이터 셋을 이용해서 차제 중량 연비 대비 그래프를 그리세요
단, 점과 선을 같이 표시한다
qplot(wt, mpg, data=mtcars)
qplot(wt, mpg, data=mtcars, geom=c('point', 'line'))
qplot(wt, mpg, data=mtcars, geom=c('point', 'line'),color=cyl)  # 연속형 
qplot(wt, mpg, data=mtcars, geom=c('point', 'line'),color=as.factor(cyl))  # factor형
qplot(wt, mpg, data=mtcars, geom=c('point', 'line'),color=as.factor(cyl),linetype=as.factor(cyl)) #선모양지정


# diamond 데이터 셋을 이용해서
다이아몬드의 선명도에 대한 막대그래프를 그리세요
단, 색상은 컷품질을 이용한다
qplot(clarity,data = tinydia, fill=cut)
