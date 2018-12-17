# 데이터 조작
# 실제 데이터 분석 업무에서 모델링이나 시각화에 적합한 형태의 데이터를 얻기 위해서는
# 데이터 변환/조작/필터링등의 전처리 작업이 필요
# plyr, dlyr, sqlf, reshape2 등의 패키지를 이용하면 데이터 전처리 작업이 수월해짐

getMode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v,uniqv)))]
}


# plyr : 데이터를 쪼개고, 일부를 취해서 특정함수를 적용해서 집계 결과를 제공
install.packages('plyr')
library(plyr)

# 두개의 데이터 프레임을 하나로 합치기
a <- c(1,2,3,4,5)  # 번호 @1
b <- c(160,171,173,162,165) # 키
c <- c(5,4,1,3,2) # 번호 @2
d <- c(55,73,60,57,80)  # 몸무게

x<-data.frame(id=a,height=b)
x
y<-data.frame(id=c,weight=d)
y

# sql join 역ㅎ
z<-join(x,y,by='id')

z




# 만일, 일치하지 않는 id가 존재한다면?
# left 조인으로 작ㄷ
a <- c(1,2,3,4,6)  # 번호 @1
b <- c(160,171,173,162,180) # 키
c <- c(5,4,1,3,2) # 번호 @2
d <- c(55,73,60,57,80)  # 몸무게

x<-data.frame(id=a,height=b)
x
y<-data.frame(id=c,weight=d)
y

z<-join(x,y,by='id')


# 그럼, 서로 일치하는 id만으로 결합한다면?
# inner 인자를 넣어준다

z<-join(x,y,by='id', type='inner')
z


# 그럼, 서로 일치하는 id만으로 결합하고, 일치하지 않는 id도 포함시킨다면?
# full join
z<-join(x,y,by='id', type='full')
z


# 만일, 일치하지 않는 id가 존재한다면?
# right 조인으로 작ㄷ
a <- c(1,2,3,4,6)  # 번호 @1
b <- c(160,171,173,162,180) # 키
c <- c(5,4,1,3,2) # 번호 @2
d <- c(55,73,60,57,80)  # 몸무게

x<-data.frame(id=a,height=b)
x
y<-data.frame(id=c,weight=d)
y

z<-join(x,y,by='id', type='right')
z


# 만일, 서로 일치하는 key가 2개 존재한다면?
join(x,y, by=c('id', 'name'))


# 그룹별 기술통계량 구하기
# 집단변수를 기준으로 그룹단위로 기술통계함수를 적용
# apply, tapply, ddply

# apply - iris 데이터 셋 적용
head(iris[-5])
# apply (데이터, 행 또는 열, 함수)
apply(iris[-5],1,mean)   # 행기준
apply(iris[-5],2,mean)   # 열기준
apply(iris[-5],2,mean, na.rm=T) 


# tapply : 그룹별 통계 계산 함수
# 하나의 통계함수만 적용가능
unique(iris$Species) #  붓꽃 품종 확인

tapply(iris$Sepal.Length,iris$Species,mean)
tapply(iris$Sepal.Length,iris$Species,sd)
tapply(iris$Sepal.Length,iris$Species,sum)
tapply(iris$Sepal.Length,iris$Species,var)
# 붓꽃 품종별 꽃받침 길이 평균 구하기


tapply(mtcars$mpg,mtcars$cyl,mean)
# 실린더별 평균 연비 구하기




# ddply
# 여러개의 통계 함수 적용 가능
# ddply(데이터셋, .(그룹변수), 요약집계, 변수명 = 통계함수(변수))

ddply(iris, .(Species),summarise,avg=mean(Sepal.Length))
# 붓꽃 품종별 꽃받침 길이 평균 구하기

ddply(mtcars, .(mpg),summarise, avg=mean(cyl))
#실린더별 평균 연비 구하기


#붓꽃 품종별 꽃받침 길이에 대해 평균/최대/최소/중위/최빈 구하기
ddply(iris,.(Species),summarise,avg=mean(Sepal.Length), max=max(Sepal.Length),
      meadn=mean(Sepal.Length), median=median(Sepal.Length), mode=getMode(Sepal.Length))



# 집계요약 함수 : summerise 
# 주어진 함수의 결과를 새로운 DF에 생성 후 반ㅎ
summarise(iris, means=mean(Sepal.Length))

# 1871 ~ 2007
head(baseball)
tail(baseball)

# 선수별 첫 데뷔 년도 계산 :summarise
baseball$year[baseball$id=='herzobu01']
ddply(baseball,.(id),summarise,데뷔연도=min(year))

ddply(baseball,.(id),transform, 데뷔연도=min(year))
# 선수별 첫 출전년도 계산


# dplyr :
# plyr의 느린 속도를 개선
# 주로 데이터 프레임을 처리하는 함수군으로 구성
# 다루는 방법은 RDBM와 유사 - 배우기 쉬움
# select, filter, mutate, group_by, summarize, arrange

install.packages("dplyr")
library(dplyr)
data(diamonds, package = 'ggplot2')
head(diamonds)
diamonds
# dplyr 설치 후 데이터셋을 호출하면 자동으로 10행까지 출력해 ㅈ


# select - 모두 조회
# ex) carat, price 변수 출력
diamonds[,1]
diamonds[,'carat']
diamonds[,7] 
diamonds[,'price']
diamonds[,c(1,7)]

select(diamonds,carat)
select(diamonds,1)
select(diamonds,1,7)
select(diamonds,carat,price)


# pipe 를 이용한 연산 : %>%
# 이전 명령을 실행한 결과를 다음 명령의 입력으로 처리
diamonds %>% select(carat,price)
diamonds %>% select(starts_with('c'))
select(diamonds,starts_with('c'))
# 변수명이 c로 시작하는 것만 출ㄹ
diamonds %>% select(ends_with('e'))

# 변수명이 e로  끝나는 것만 출력
diamonds %>% select(contains('l'))
# 변수명이 e로  끝나는 것만 출력
diamonds %>% select(matches('r.+t'))
# 변수명이  r과 t를 포함하는 것만 출력


# 특정 변수 제외
# ex) carat과 price를 제외
diamonds[,c(-1,-7)]
diamonds %>% select(-'carat',-'price')


# filter - 조건 검색
diamonds %>%  filter(cut=='Ideal')


# price가 1000이상인 데이터 조회
diamonds %>%  filter(price>=1000)
# carat이 2 이상, price가 14000이하인 데이터 조회
diamonds %>%  filter(carat>=2,price<=14000)
# carat이 1 초과, 5 미만인 데이터 조회
diamonds %>%  filter(carat<1,carat<5)
# cartar이 1 미만이거나, 5 초과인 데이터 조호l
diamonds %>%  filter(carat>1|carat<5)


# group_by : 집계조회
diamonds %>% group_by(cut) %>% summarise(mean=mean(price))
# ex) color 별 최대, 최소 가격 조회
diamonds %>% group_by(color) %>% summarise(min=min(price),max=max(price))
# ex) clarity 별 개수 조회
diamonds %>% group_by(clarity) %>% tally()
# ex) color 별 개수 조회
diamonds %>% group_by(color) %>% tally()
str(diamonds)

diamonds



# arrange : 조회 후 데이터 정렬하기
diamonds %>% select(carat, price) %>% arrange(price)  # 오름 차순
diamonds %>% select(carat, price) %>% arrange(desc(price))  # 내림 차순
diamonds %>% select(carat, color, price) %>% arrange(desc(carat,color))  # 내림 차순



# mutate - 결과를 기존 DF/새로운 DF에 부착
diamonds %>% mutate(price/carat)
# 새로운 DF에 price/carat 칼럼 추가

diamonds %>% select(carat,price) %>%  mutate(ratio=price/carat, doubles=ratio*2)
# 새로운 DF에 ratio 칼럼 추가
