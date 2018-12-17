# aggregate - 집계 관련 함수
# dplyr의 group by 보다 비교적 단순하게 코드 작성
library(dplyr)
data('diamonds',package = "ggplot2")
diamonds
# aggreate(집계대상, 데이터,적용함수)
# cut 별 평균 price 집계
aggregate(price~cut, diamonds, mean)
# cut 별 평균 carat
aggregate(carat~cut, diamonds, mean)
# cut/color 별 평균 price 집계
aggregate(price~cut + color, diamonds, mean)


# fruits 데이터셋
install.packages('googleVis')
data(Fruits,package = "googleVis")
Fruits

# 년도별 총 판매액
aggregate(Sales ~Year, Fruits, sum)
# 과일별 총 판매액
aggregate(Sales ~Fruit, Fruits, sum)
# 과일별 최대 판매액
aggregate(Sales ~Fruit, Fruits, max)
# 과일/년도별 최대 판매액
aggregate(Sales ~Fruit+Year, Fruits, max)

# 연도별 이익합계
aggregate(Profit ~Year, Fruits, sum)
# 연도별,  과일별 이익합계
aggregate(Profit ~Year+Fruit, Fruits, sum)



# sqldf   RMySQL 와 연동될 수 있기 때문에 workspace 에 있는 변수들 다 지우고 다시 설ㅊ
install.packages('sqldf')
library(sqldf)
data(Fruits,package = "googleVis")
data(diamonds,package = "ggplot2")

# Fruits 데이터 전체 조회
sqldf('select*from Fruits')
치
# 과일, 년도, 매출, 이익 조회]
sqldf('select Fruit, Year, Sales, Profit from Fruits')

# Apple에 대한 모든 정보 조회
sqldf('select*from Fruits where Fruit="Apples"')

# 매출액 순으로 오름차순 정렬 출력
sqldf('select*from Fruits order by Sales')
# 매출액 순으로 내림차순 정렬 출력
sqldf('select*from Fruits order by Sales desc')

# 과일별 총 판매액
sqldf('select sum(Sales) as sales from Fruits order by Fruit')
# 과일별 최대 판매액
sqldf('select max(Sales) from Fruits order by Fruit')
# 과일/년도별 최대 판매액
sqldf('select max(Sales) from Fruits order by Fruit, year')
# 연도별 이익합계
sqldf('select sum(Profit) from Fruits order by year')
# 연도별,  과일별 이익합계
sqldf('select sum(Profit) from Fruits order by Fruit, year')

# HR 데이터셋에서 employees, department 등을 
setwd('c:/Java/data/hr')
emp <- read.csv('EMPLOYEES.csv', header=T, stringsAsFactors = F)
dept <- read.csv('DEPARTMENTS.csv', header=T, stringsAsFactors = F)

sqldf('select*from emp')
sqldf('select*from dept')
str(emp)
str(dept)
# join 해서 사원이름과 부서명 조회
sqldf('select FIRST_NAME, DEPARTMENT_NAME from emp inner join dept on emp.DEPARTMENT_ID=dept.DEPARTMENT_ID')
sqldf('select e.FIRST_NAME, d.DEPARTMENT_NAME from emp e join dept d using(DEPARTMENT_ID)')


# data.seoul.go.kr
# 16품목 농수산 생필품 시장가격 조사 데이터
setwd('c:/Java/data')
market_price <- read.csv('서울시 생필품 농수축산물 가격 정보2.csv',header=F, stringsAsFactor=T,skip=1, fileEncoding='UTF-8')
summary(market_price)
names(market_price)
# dplyr 조회 테스트
library(dplyr)
market_price %>% select(V5, V7)

# 데이터셋의 헤더가 한글 -> sqldf에서는 깨져 보임
# 따라서, 헤더는 포함시키지 않음
# sqldf  한글 컬럼명이 깨지는 현상 발생!!  
# market_price 컬럼명을 적절히 변경함(한글/영어)
names(market_price) <-c("id","tnnum","tnname","goodnum","goodname","scale","price","yearmon","comment","date","tdcode","tord","distcode","distname")
names(market_price)

sqldf('select [일련번호] from market_price')
sqldf('select V5,V12,V7 from market_price where V8="2018-10" group by V5,V12')



