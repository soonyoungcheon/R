# 2015년 중구 지역의 월별 교통사고 발생건수

# 산점도 : 점
# 산점도 : 선
# 산점도 : 둘다


# 2015년 관악구지역의 월별 교통사고 발생건수

# 산점도 : 점

# 데이터 읽어오기
setwd('c:/Java/data')
seoulcar <- read.table('seoul_car_2015.txt',sep=',',header = T, stringsAsFactors = F)
head(seoulcar)

tail(seoulcar,100)
summary(seoulcar)

j <- seoulcar[seoulcar$자치구명=='중구',]
str(j)

junggu <- seoulcar[13:24,]
junggu

str(junggu)
junggu$월 <- as.factor(junggu$월)
junggu

# 발생건수 산점도
plot(junggu$발생건수,type='p',col='red',xlim=c(0,13), ylim =c(0,150), xlab='월',ylab='발생건수', main='월별발생건수')
grid()
plot(junggu$발생건수,type='l',col='red',ylim =c(0,150))
grid()




plot(junggu$월,junggu$발생건수,type='p', xlab='월',col='red',ylim =c(0,150))

plot(junggu$월,junggu$발생건수,type='l',col='red',xlim=c(0,13), ylim =c(0,150), xlab='월',ylab='발생건수', main='월별발생건수')
plot(junggu$월,junggu$발생건수, type='b',col='red',xlim=c(0,13), ylim =c(0,150), xlab='월',ylab='발생건수', main='월별발생건수')


# 중구 교통 사고 데이터 ㅊㅊ
guanak <- seoulcar[241:252,]
guanak

plot(guanak$월,guanak$발생건수,type='p',xlab='월', ylab='발생건수')
plot(guanak$월,guanak$발생건수,type='l',xlab='월', ylab='발생건수')
plot(guanak$월,guanak$발생건수, type='b',xlab='월', ylab='발생건수')


# 중구/관안구 발생건수 함께 보기
plot(junggu$발생건수,type='l',col='red',xlim=c(0,13), ylim =c(0,150), xlab='월',ylab='발생건수', main='월별발생건수')
lines(guanak$발생건수,type='l',col='blue',xlim=c(0,13), ylim =c(0,150), xlab='월',ylab='발생건수', main='월별발생건수')


# 자동차 연비 데이터셋
mtcars
str(mtcars)






# 병아리 사육 데이터셋
# ChckWeight
str(ChickWeight)
head(ChickWeight$Chick)

ChickWeight$Chick


#  고속도로/시내 자동차 연비 데이터셋
install.packages('ggplot2')
library(ggplot2)
mpg
summary(mpg)
?mpg
str(mpg)

mpg1<-mpg
mpg1$manufacturer<-as.factor(mpg$manufacturer)
str(mpg1)

plot(mpg1$cty, mpg$displ,type='p',pch=as.integer(mpg1$manufacturer), col=as.integer(mpg1$manufacturer))



length(mpg1$manufacturer)
