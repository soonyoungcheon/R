# 2018.11.02
# reshape2 : 데이터 구조를 wide/long 형식 변형
# 데이터 분석시 DF/matrix를 wide 형식인 상태에서
# 실행하는 경우가 잇고, 상황(집계)에 따라 long 형식인 상태에서 실행하는 경우도 존재
# 엑셀의 피벗테이블과 유사한 형태로 분석 실시
library(reshape2)
library(dplyr)
airquality  # 공기질 측정 데이터

# 기준(id) 없이 melt 실행
head(melt(airquality))
tail(melt(airquality))

#월별 각 평균 측정값 조사
# wide 형식 -> long형식
newOne <- melt(airquality, id=c("Month", "Day"))
head(newOne)

# melt 한 결과의 열이름 변경
melt(airquality, id=c("Month", "Day"),variable.name = 'climate_var',value.name = 'climate_val')

# ChickWeight 데이터셋
# id는 time, chick, diet로 melt 하세요
head(ChickWeight)
chick <- melt(ChickWeight, id=c("Time", "Chick", "Diet")) 
head(chick)

# melt한 결과를 원래대로 되돌리거나 집계계산을 위한 구조로 변형하려면
# cast/dcast(DF)/acast 를 실행
dcast(newOne,Month+Day~...)
#dcast(newOne,Month+day~variable)


# chickweight 데이터셋
# melt 한 데이터 원래대로 만드세요
head(chick)
head(dcast(chick,Time+Chick+Diet~...))
head(ChickWeight)

# dcast를 단순히 데이터 구조를 재구성하는 것만으로 그칠것이 아니고 
# 집계함수를 적용시킬 수 있음
dcast(newOne, Month~...)
# 일 컬럼과 나머지 측정값 컬럼이 합쳐져서 보임

dcast(newOne, Month~variable,mean,na.rm=T)

# chickweight 데이터셋
# Time 별 평균 weight
dcast(chick, Time~variable, mean,na.rm=T)
# Diet 별 평균 Weight
dcast(chick, Diet~variable, mean,na.rm=T)
head(chick)
# mtcars 데이터셋
head(mtcars) # wide형식
# 행번호 자리에 차종이 표시됨
# 차종 칼럼을 따로 생성해야함
rownames(mtcars)  # 행번호(이름) 모두 표시
mtcars$car <- rownames(mtcars) # 차종 컬럼 생성
head(mtcars)

# 차종, 실린더수, 기어수, 수동여부로 melt 실행
newOne <- melt(mtcars, id=c('car','cyl', 'gear', 'am'))
head(newOne)

# 실린더수 별 평균 연비
dcast(newOne, cyl~variable, mean)[,1:2]
dcast(newOne, cyl~variable=='mpg', mean)
# 실린더수 별 기어별 평균 연비
dcast(newOne, cyl+gear~variable, mean)[,1:3]
dcast(newOne, cyl+gear~variable=='mpg', mean)
# 실린더수 별 기어별 수동여부 별 평균 연ㅂ
dcast(newOne, cyl+gear+am~variable, mean)[,1:4]
dcast(newOne, cyl+gear+am~variable=='mpg', mean)



# applewood 데이터셋
setwd('c:/Java/data')
ap <- read.table('applewood.txt', header = T, stringsAsFactors = F) 
head(ap)
summary(ap)
library(stringr)
ap$Profit<-str_replace_all(ap$Profit,'\\$','')
ap$Profit<-str_replace_all(ap$Profit,',','')
ap$Profit<-str_remove_all(ap$Profit,',')
ap$Profit<-as.integer(ap$Profit)

# 지역별 평균 이익
newOne <- melt(ap, id=c('Location','Vehicle.Type'))
head(newOne)
str(newOne)
dcast(newOne, Location~variable, mean)[,c(1,3)]

# 차종별 평균 이익
dcast(newOne, Vehicle.Type~variable, mean)[,c(1,3)]



# HR의 EMPLOYEES 데이터셋
setwd('c:/Java/data/hr')
emp <- read.csv('EMPLOYEES.csv', header = T, stringsAsFactors = F) 
head(emp)
str(emp)
emp$HIRE_DATE <- substr(emp$HIRE_DATE,1,4)


library(dplyr)
# 직급별 평균 연봉
newemp <- melt(emp, id=c('DEPARTMENT_ID','HIRE_DATE','JOB_ID'))
newemp %>% filter(variable=="SALARY")
summary(olnysalary) 
olnysalary <-newemp %>% filter(variable=="SALARY")
olnysalary$value <- as.numeric(olnysalary$value)
str(olnysalary)
봉
# 부서별 평균 연봉
dcast(olnysalary, DEPARTMENT_ID~variable, mean)

# 연도별 평균 연ㅂ
dcast(olnysalary, HIRE_DATE~variable, mean)

# 직급별 평균 연봉
dcast(olnysalary, JOB_ID~variable, mean)
