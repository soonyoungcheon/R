# 파이그래프
# 도수분포표를 원 모양으로 시각화 한 것
# 자료의 범주별 빈도 비율을 요약해서 나타낸 그래프

val =c(10,20,30,40,50)
pie(val)  # 기본 작성법 

pie(val, init.angle = 90)  # 시작위치
pie(val, init.angle=90, col=rainbow(length(val)), label=c('가','나','다','라','마'))
# 색상과 값 제목 표시

pie(val, init.angle=90, col=rainbow(length(val)), label=paste(val,'%'))
legend('bottomleft', c('가','나','다','라','마'),fill=rainbow(length(val)))
legend('bottomright', c('가','나','다','라','마'),fill=rainbow(length(val)))

# 각 수치간 임의 비율로 그래프 작성


# 각 항목별 비율 계산
# 10/150, 20/150, 30/150, 40/150, 50/150
pct <- round(val/sum(val)*100)
pval <- paste(pct,'%')
pie(val,init.angle =90, label=pval, col=rainbow(length(val)))
legend('topright', c('10','20','30','40','50'), fill=rainbow(length(val)))


# 매니저별 국적 비율을 파이 그래프로 작성
# 매니저별 성별 비율을 파이 그래프로 작성
Manger <- 1:5
Date <- c('10/24/14','10/28/14','10/01/14','10/12/14','05/01/14')
Country <- c('US','US','UK','UK','UK')
Gender <- c('M','F','F','M','F')
Ages <- c(32,45,25,39,99)
q1 <-c(5,3,3,3,2)
q2 <-c(4,5,5,3,2)
q3 <-c(5,2,5,4,1)
q4 <-c(5,5,5,NA,2)
q5 <-c(5,5,2,NA,1)

leadership <- data.frame(Manger,Date,Country,Gender,Ages,q1,q2,q3,q4,q5)
from <- sort(table(leadership$Country))
from
pct <- paste(from/5*100,'%')
pie(from, init.angle=90, label= pct , col=rainbow(length(from)),clockwise = T)
legend('bottomleft',c('US','UK'),fill=rainbow(length(from)))
text(0,-0.5,3)


gender <- sort(table(leadership$Gender))
gender
pct <- paste(gender/5*100,'%')
pie(from, init.angle=90, label= pct , col=rainbow(length(gender)))
legend('bottomleft',c('male','female'),fill=rainbow(length(gender)))
text(0.5,0, 3)



# 핫도그 대회 최다 우승국 비율을 파이그래프로
# 벡터로 바꿀 필요없이 바로 테이블에서 파이테이블 만들 수 있다 연산ㄷ
str(hotdog)
wincon <- sort(table(hotdog$Country))
wincon2 <- as.vector(wincon)
wincon
pct <- paste(round(wincon2/sum(wincon2)*100),'%') 
pct
pie(wincon,init.angle=90, label=pct, col=rainbow(length(wincon2)))
legend('bottomleft',c('Germany','Mexico','Japan','United States'),fill=rainbow(length(wincon2)))


# 핫도그 대회 최다 우승자 비율을 파이그래프로
win <- sort(table(hotdog$Winner),decreasing = T)
pct <-paste(round(win/sum(win)*100),'%')
pct
lab <-names(win)
pie(win, init.angle=90,  label=pct, col=rainbow(length(win)),cex=0.5, clockwise = T)
legend(0.05,0.05,lab,fill=rainbow(length(lab)))

# 지역별 자동차 판매대수 비율을 파이그래프로 
str(applewood)
loc <- sort(table(applewood$Location),,decreasing = T)
loc
locname <-names(loc)
locname
pct <- paste(round(loc/sum(loc)*100),'%')

pie(loc, init.angle = 90,label=pct, col=rainbow(length(loc)), clockwise = T)
legend("topright", locname ,fill=rainbow(length(loc)))



# 차종별 자동차 판매대수 비율을 파이그래프로 <- sort(table(applewood$Location))
cartype <- sort(table(applewood$Vehicle.Type),decreasing = T)
cartypeN <-names(cartype)
cartype 
pct <- paste(round(cartype/sum(cartype)*100),'%')
pct
pie(cartype, init.angle = 90,label=pct, col=rainbow(length(cartype)), clockwise = T)
legend("topright", cartypeN  ,fill=rainbow(5))


# 타이타닉 데이터 셋
# 생존/사망 비율
str(Titanic)
survived<-table(Titanic$Survived)
pct <- round(survived/sum(survived)*100)
pie(survived, init.angle = 90, label=paste(pct,'%'), clockwise = T)

survived =table(Titanic$Survived)
#pct <- round(survived/sum(survived)*100)
pct <- round(prop.table(Titanic$Survived)*100)
pct
pie(survived, init.angle = 90, label=paste(pct,'%'), clockwise = T)

# 승선권 유형별 비율을 파이그래프로
tclass<-table(Titanic$Pclass)
pct <- round(tclass/sum(tclass)*100)
pct <- round(prop.table(tclass)*100)
pie(tclass, init.angle = 90, label=paste(pct,'%'), clockwise = T)

# 승선위치별 비율을 파이그래프로

# ok <- !is.na(Titanic$Embarked)
ok<-Titanic$Embarked !=''
ok
place<-table(Titanic$Embarked[ok])
place
#pct <- round(place/sum(place)*100)
pct <- round(prop.table(place)*100)
pie(place, init.angle = 90, label=paste(pct,'%'), clockwise = T)


# 성별 생존 비율을 파이그래프로 작성
str(Titanic)
SS<-table(Titanic$Sex,Titanic$Survived)
SS
#pct <- round(SS/sum(SS)*100)
pct <- round(prop.table(SS)*100)
pct
pie(SS, init.angle = 90, label=paste(pct,'%'), clockwise = T,col=rainbow(4))
legend('topleft', c('여/사망','남/사망','여/생존','남/생존'),fill=rainbow(4))
# 남/여 생존/사망이 함께 그려져서
# 그래프의 의도를 한눈에 파악하기 어려움
# 따라서, 각각의 그래프로 다시 작성
pctf <-round(prop.table(SS[1,])*100)
pctm <-round(prop.table(SS[2,])*100)
pctf
pctm
pie(pctf,label=paste(pctf,'%'), col=rainbow(2), clockwise=T, main='여자 사망/생존 비율')
legend('topleft',c('사망','생존'), fill=rainbow(2))자
pie(pctm,label=paste(pctf,'%'), col=rainbow(2), clockwise=T, main='남ㅈ 사망/생존 비율')
legend('topleft',c('사망','생존'), fill=rainbow(2))

# 승선권 유형별 생존비율을 파이그래프로 작성
str(Titanic)
CS<-table(Titanic$Pclass,Titanic$Survived)
CS
pct1 <- round(prop.table(CS[1,])*100)
pct2 <- round(prop.table(CS[2,])*100)
pct3 <- round(prop.table(CS[3,])*100)

pie(pct1, init.angle = 90, label=paste(pct1,'%'), clockwise = T, col=rainbow(2),main='1st승선권 사망/생존 비욜')
legend('topleft', c('사망','생존'),fill=rainbow(2))
pie(pct2, init.angle = 90, label=paste(pct2,'%'), clockwise = T, col=rainbow(2),main='2st승선권 사망/생존 비욜')
legend('topleft', c('사망','생존'),fill=rainbow(2))
pie(pct3, init.angle = 90, label=paste(pct3,'%'), clockwise = T, col=rainbow(2),main='3st승선권 사망/생존 비욜')
legend('topleft', c('사망','생존'),fill=rainbow(2))

# 승선 위치별 생존비율을 파이그래프로
str(Titanic)
ES<-table(Titanic$Embarked[ok],Titanic$Survived[ok])
ES
pctc <- round(prop.table(ES[1,])*100)
pctq <- round(prop.table(ES[2,])*100)
pcts <- round(prop.table(ES[3,])*100)
pctc
pie(pctc, init.angle = 90, label=paste(pctc,'%'), clockwise = T, col=rainbow(2), main='courugh 탑승자 사망현황')
legend('topleft',c('사망','생존'),fill=rainbow(2))
pie(pctq, init.angle = 90, label=paste(pctq,'%'), clockwise = T, col=rainbow(2), main='queens 탑승자 사망현황')
legend('topleft',c('사망','생존'),fill=rainbow(2))
pie(pcts, init.angle = 90, label=paste(pcts,'%'), clockwise = T, col=rainbow(2), main='southampton 탑승자 사망현황')
legend('topleft',c('사망','생존'),fill=rainbow(2))



