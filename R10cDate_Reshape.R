# reshape : 데이터셋의 구조를 변형하는 함수
# 주로 DF, matrix 모양을 다른 형태로 바꿈
install.packages('reshape')

library(reshape)

# a <- [1,2,3,4,5,6,7,8,9,10]
# b <- reshape(a,[5,2])
# b => 12
#      3 4
#      5 6
#      7 8
#     9 10


# c <- 1 2 3 4 5 
#      6 7 8 9 10
# d <- reshape(c,[5,2])
# d => 1 2
#      3 4
#      5 6
#      7 8
#      9 10

install.packages('reshape2')
library(reshape2)
?french_fries
?smiths
smiths

# melt, case 함수 : 데이터 구조 변형 함수
str(french_fries)   # 9개 변수로 구성
head(french_fries)  # wide 형식 출력
head(melt(id=1:2, french_fries))  # long 형식 출력

# fruits 데이터셋
install.packages('googleVis')
data(Fruits, package = 'googleVis')
Fruits

mfruits<-melt(id='Year', Fruits)
# 3개의 변수로 재구성된 DF(long)
mfruits[c(1:9),]  # 재구성된 DF에 접근하기

# smiths 데이터셋
# subject, time 변수를 기준으로 DF 재구성
newOne<-melt(id=c('subject','time'), smiths)

smiths
newOne

# airquality  데이터 셋
# month, day 기준으로 melt
str(airquality)
newTwo <- melt(id=c('Month','Day'),airquality)
newTwo

# melt 된 데이터를 원래대로 돌려놓기
ori <- dcast(newOne, subject+time~...)
ori

oritwp <- dcast(newTwo, Month+Day~...)
oritwp

# 부분 복구 
# 서브젝트 남겨놓고 복귀
orip <- dcast(newOne, subject~...)


# 총정리 
no <- c(1,1,2,2)
day <- c(1,2,1,2)
kor <- c(40,30,50,25)
mat <- c(70,55,80,45)
ex <- data.frame(no,day,kor,mat)
ex
meltOne <- melt(id=1:2, ex)
meltOne
dcast(meltOne, no+day~...)


# cars93 : 차종별 시내/고속도로 연비 데이터
library(MASS)
Cars93 <- Cars93
str(Cars93)

# Type, Origin, MPG.city, MPG.highway  
# Type은 'Compact', 'Van' 만 선택
library(dplyr)
newCar93 <- Cars93 %>% select(Type, Origin, MPG.city, MPG.highway)%>% filter(Type %in% c('Compact', 'Van'))



meltOne <- melt(id='Type', newCar93)
meltOne


# 자동차 타입별로 시내/고속도로 평균 연비
# + 측정 장소(Origin) : 올바른 DF 작성 실패
# 즉, value 컬럼에 숫자/문자 혼재
dcast(meltOne, Type~..., mean)  # 실행 실패
dcast(meltOne, Type~...)


# 따라서, Type, Origin 을 기준으로 다시 melt
newOne <- melt(id =c('Type','Origin'), newCar93)
newOne

# value 컬럼은 숫자로만 구성
dcast(newOne, Type~..., mean)  # 차종별 평균 연비
dcast(newOne, Type~variable, mean)  # 차종별 평균 연비
dcast(newOne,  Origin~..., mean)  # 측정 지역별 연비
dcast(newOne, Type + Origin~..., mean)  # 자동차종류별, 측정 지역별 연비
