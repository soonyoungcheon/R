# 히스토그램
# 막대그래프
# 연속형 데이터의 도수빈도표를 작성해서 막대 그래프로 나타낸 것
# x축은 변수들의 구간을 의미하는 계급
# y축은 구간의 빈도를 의미하는 도수

# 학생들의 키 데이터를 이용해서 히스토그램 작성
height <- c(168,172,176,163,174,179)
h<-hist(height,ylim = c(0,3)) 
h # 히스토 그램 상세정보 확인 
# 구간, 도수, 밀도등등

hist(height,breaks = 4)
# 변수의 구간을 재설정

# 국가별, 연도별 출생률 데이터
setwd('c:/Java/data')
births<-read.csv('birth-rate.csv',header = T, stringsAsFactors = T)
head(births)
summary(births)
y2008<-births$X2008[!is.na(births$X2008)]

# 기본 계급은 0~5
h<-hist(y2008)
h
hist(y2008, main = '2008년도 출생자 수', xlab='출생자수 구간', ylab='출생률 빈도수')

# 수정된 계급은 0~10
hist(y2008,breaks=5, main = '2008년도 출생자 수', xlab='출생자수 구간', ylab='출생률 빈도수')

# 재수정된 계급은 
#0~2, 2~4,4~6,6~8,8~10,....
hist(y2008,breaks=25, main = '2008년도 출생자 수', xlab='출생자수 구간', ylab='출생률 빈도수', col=rainbow(25))

# 구간의 범위를 벡터로 정ㅇ
hist(y2008,breaks=c(0,10,20,30,40,50,60), main = '2008년도 출생자 수', xlab='출생자수 구간', ylab='출생률 빈도수', col=rainbow(25))
hist(y2008,breaks=seq(0,60,2), main = '2008년도 출생자 수', col=rainbow(25))
hist(y2008,breaks=seq(5,55,5), main = '2008년도 출생자 수', col=rainbow(25))

hist(y2008,breaks=seq(8,54,2), main = '2008년도 출생자 수', col=rainbow(25),freq=F)
lines(density(y2008),lwd=2, col='blue')
# 정규분포 확률밀도 곡선 작성
# 추론 통계학에서 자주 사용
h
hist(y2008,breaks=seq(5,55,5), main = '2008년도 출생자 수', col=rainbow(25),ylim=c(0,70))
text(h$mids,h$counts,labels=h$counts,adj=c(0.5,-0.5))

hist(y2008,breaks=seq(5,55,5), main = '2008년도 출생자 수', col=rainbow(25),xaxt="n",yaxt="n")
axis(1,c(0,2,10,15,20,25,55))
axis(1,seq(5,55,5),pos=-1)
axis(2,seq(0,70,2),pos=-1)
# 그래프 축 구간 설정

# applewood 판매현황 데이터셋 참고

ap <- read.table('applewood.txt', header = T)
str(ap)

# 판매 금액 현황을 히스토그램으로 작성
pro<-ap$Profit
summary(pro)  # 구간을 나누기 위한 탐
# 적당한 구간을 나누기 위한 방법
# 1. 구간 개수 파악 - 2승수 법칙 이용
length(pro)  # 2^7 ~ 180 ~ 2^8 => k(계급의 수) = 8

# 2. 구간의 범위 지정 : max - min / k
# 일반적으로 범위는 10의 배수, 100배수로 지정
(3292 -294)/8  # 374.75 => 400

# 3. 구간의 한계값 지정
# 최소값 : 294 => 200
# 최대값 : 3292 => 3400

seq(200,3400,400)
#library(stringr)
#str_replace_all(prices,'\\$','')
pro<-sub(pattern="\\$", replacement="", x=pro)
pro<-sub(pattern=",", replacement="", x=pro)
pro<-as.integer(pro)

h<-hist(pro,ylim =c(0,50),breaks=seq(200,3400,400),col=rainbow(8),main='판매 금액 현황',xaxt="n",yaxt="n")
h
text(h$mids,h$counts,labels=h$counts,adj=c(0.5,-0.5))
axis(1,seq(200,3400,400),pos=-1)
axis(2,seq(0,50,5),pos=-1)

# 나이별 구매 현황을 히스토그램으로 작성
ag <- ap$Age
ag

h<-hist(ag,main='나이별 구매현황',breaks=seq(20,80,10), ylim=c(0,70),col=rainbow(10),xaxt='n',yaxt='n')
text(h$mids,h$counts,labels=h$counts,adj=c(0.5,-0.5))
axis(1,seq(20,80,10),pos=-1)
axis(2,seq(0,80,20))

# 핫도그 컨데스트 데이터셋 참고
hotdog <-read.csv('hot-dog-winners.csv',header=T)
str(hotdog)

# 핫도그 우승자이 핫도그 먹은 개수 현황을 히스토그램으로 작성
hg<-hotdog$Dogs.eaten
summary(hg)

# 구간수, 범위, 한계값
# 5,15,10~
length(hg)  # 31개
hg
2^5 # 5 구간으로 나누기
(68-9.1)/5 # 11.78
seq(0,75,15)

h<-hist(hg, col=rainbow(5),main='핫도그 먹은 개수 현황',breaks=seq(0,75,15),ylim=c(0,15), xaxt='n',yaxt='n')
text(h$mids,h$counts,labels=h$counts,adj=c(0.5,-0.5))
axis(1,seq(0,75,15))
axis(2,seq(0,15,5),pos=-1)


# 타이타닉 데이텃 셋
# 탑승자의 나이 현황을 히스토그램으로 작성
str(Titanic)
old<-Titanic$Age[!is.na(Titanic$Age)]
h<-hist(old,ylim=c(0,250),col=rainbow(10),main='탑승자의 나이 현황')
h
text(h$mids,h$counts,labels=h$counts,adj=c(0.5,-0.5))
axis(1,seq(20,80,5),pos=-1)
axis(2,seq(0,40,5))




# 나이대별 사망 생존 현황
tita <- !is.na(Titanic$Age)
tita
tita  <- data.frame(Titanic$Age[tita],Titanic$Survived[tita])
names(tita) <-c('age','survived')
head(tita)
d<-xtabs(age ~ survived, data = tita)
get

oldage <- Titanic[,c(2,6)]
head(oldage)
oldage <- oldage[!is.na(oldage$Age)]
head(oldage)
oldage


# 인사정보 HR-employees 데이터셋 참고
emp <- read.csv('hr/EMPLOYEES.csv',header=T)
str(emp)

# 사원들의 급여 현황을 히스토그램으로 작성
sal <- emp$SALARY
h<-hist(sal,ylim = c(0,50),main='급여현황',col=rainbow(20),xaxt='n',yaxt='n')
h
text(h$mids,h$counts,labels=h$counts,adj=c(0.5,-0.5))
axis(1,seq(2000,24000,2000),pos=-1)
axis(2,seq(0,45,5))

# 사원들의 부서 현황을 히스토그램으로 작성
dep <- emp$DEPARTMENT_ID
h<- hist(dep, ylim=c(0,50),main='부서현황',col=rainbow(20),xaxt='n',yaxt='n')
h
text(h$mids,h$counts,labels=h$counts,adj=c(0.5,-0.5))
axis(1,seq(0,150,10),pos=-1)
axis(2,seq(0,45,5))
