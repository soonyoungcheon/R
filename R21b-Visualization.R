ggplot2 는 2005년 Rice 대학 통계학과 교수인 hadley wickam에 의해 개발됨
점, 선, 다각형의 기하학적 객체에 크기, 모양, 색상 등의 미적요소를 지정해서
그래프를 그려줌


set.seed(201811164)  # 난수생성을 위한 seed 설정
tinydia <- diamonds[sample(nrow(diamonds),1000),]

gg<- ggplot(tinydia)
gg+ geom_point(aes(carat, price, color=cut))


gg<- ggplot(mtcars)
gg + geom_point(aes(wt,mpg), color=as.factor(cyl)))

# 선그래프
gg<- ggplot(mtcars)
gg + geom_line(aes(wt,mpg),linetype='twodash')
#linetype : solid, dotted, dashed, longdash, twodash, dotdash

gg<-ggplot(mtcars, aes(wt,mpg))
gg <- gg+geom_line(linetype='twodash')
gg + geom_point()


# 득정변수를 이용해서 그룹형태로 그리기
gg<- ggplot(mtcars)
gg<-ggplot(mtcars, aes(wt,mpg, group=as.factor(cyl),color=as.factor(cyl)))
gg <- gg+geom_line(aes(linetype=as.factor(cyl)))
gg + geom_point()


# 막대그래프
df<-data.frame(A=c('a','b','c'), B=c(4.2,10,29.5))
gg <- ggplot(data=df, aes(A,B))
gg + geom_bar(stat='identity')
# 막대그래프 작성시 stat = 'identity'를 지정
# 그래야 DF의 데이터들을 자동으로 통계데이터로 생성
gg <- ggplot(data= df, aes(A,B))
gg <- gg +geom_bar(stat='identity')
gg + coord_flip()  # x/y축 순서 바꿈

gg <- ggplot(data= df, aes(A,B))
gg +geom_bar(stat='identity', width = 0.5)
# 막대그래프의 막대 두께 ㅈ절

gg <- ggplot(data= df, aes(A,B))
gg +geom_bar(stat='identity', color='blue',fill='white')
# 막대 그래프의 막대색 조절
gg <- ggplot(data= df, aes(A,B))
gg<-gg +geom_bar(stat='identity', color='blue',fill='orange')
gg + geom_text(aes(label=B),hjust=0.5,vjust=1.5, size=5, color='white')



gg <- ggplot(data= df, aes(A,B,color=A))
gg<-gg +geom_bar(stat='identity', fill='white')
gg + scale_color_manual(values =c('#999999','#E69F00','#cc33cc'))
# 막대그래프 사용자 지정 색상 지정하기(테두리)


gg <- ggplot(data= df, aes(A,B,fill=A))
gg<-gg +geom_bar(stat='identity')
gg + scale_fill_manual(values =c('#999999','#E69F00','#cc33cc'))
# 막대그래프 사용자 지정 색상 지정하기(bar 안 채우기)

install.packages('RColorBrewer')
library(RColorBrewer)
display.brewer.all()


# RColorBrewer 패키지를 이용해서 색상 지정
R에서 쓸법한 색상들을 사용하기 편하게 모아둔 패키지

gg <- ggplot(data= df, aes(A,B,fill=A))
gg<-gg +geom_bar(stat='identity')
gg + scale_fill_brewer(palette ='Blues')


gg <- ggplot(data= df, aes(A,B,fill=A))
gg<-gg +geom_bar(stat='identity')
gg + scale_fill_grey()
# 막대그래프 흑백 색상 지정하기


gg <- ggplot(data= df, aes(A,B,fill=A))
gg<-gg +geom_bar(stat='identity')
gg + scale_fill_discrete(limits=c('c','b','a'))
# 막대그래프의 x축 값 순서 변경


df<- data.frame(A=rep(c('x','y'), each=3),
B=rep(c('a','b','c'),2),
C=c(6.8,15,33,4.2,10,29.5))

# 누적 막대 그래프 그리기
gg <- ggplot(data=df, aes(B,C,fill=A))
gg + geom_bar(stat='identity')

gg <- ggplot(data=df, aes(B,C,fill=A))
gg + geom_bar(stat='identity', position=position_dodge())


# 오차 막대 그래프에 레이블 추가
gg <- ggplot(data=df, aes(B,C,fill=A))
gg<-gg + geom_bar(stat='identity', position=position_dodge())
gg + geom_text(aes(label=C),position=position_dodge(0.8),vjust=-0.5, 
               size=4, color='black')


# 오차 막대 그래프 : geom_errorbar
# 표준편차를 미리 계산해 두어야 함
df$sd<- sd(df$C)
df

gg <- ggplot(data=df, aes(B,C,fill=A))
gg <- gg + geom_bar(stat='identity', position=position_dodge())
gg + geom_errorbar(aes(ymin=C-sd+10, ymax=C+sd-10),position= position_dodge(0.8),
                   width=0.3)

# 산점도에 수평선,수직선 그리기
gg<-ggplot(mtcars,aes(wt,mpg))
gg<-gg + geom_point()
gg+ geom_hline(yintercept = 2.5, color='red', linetype='dotted')
gg+ geom_vline(xintercept = 3.5, color='blue', linetype='dashed')

m<-lm(mpg ~ wt, data = mtcars)
37.285       -5.344  
coef(m)[1]
coef(m)[2]


gg<-ggplot(mtcars,aes(wt,mpg))
gg<-gg + geom_point()
gg+ geom_abline(intercept = coef(m)[1], slope=coef(m)[2],color='blue', linetype='dashed')

# 지도공간 시각화
지도공간 기법으로 시각는 ggmap 패키지는 구글맵, 네이버맵 등의 온라인 소스로
부터 가져온 정적 지도위에 특별한 데이터나 모형을 시각화하는 함수를 제공

특정, get_googlemap() 함수를 이용하면 구글에서 지정한 지역의 지도를 내려받아
그래프 형태로 삽입 할 수 있게 해 줌



install.packages('ggmap')
install.packages('maps')
install.packages('mapproj')
library(mapproj)
library(maps)
library(ggmap)
library(ggplot2)

지도 위치정보 가져오기
gc <- geocode('London')
as.numeric(gc)  # deprecated -> google API key 필요
map <- get_googlemap('seoul', language = 'ko-kr')
map

구글API  사용권란을 가진 키 발급함
# 웹브라우져에서 API 작동여부 확인


https://maps.googleapis.com/maps/api/geocode/json?address=seoul&key=AIzaSyAoKsaTSc-fo6IxWKJRJTF10hRpkcLH2UA




install.packages('devtools')
library(devtools)

devtools::install_github('dkahle/ggmap',ref='tidyup')

# R에서 구글맵 API를 등록해서 맵 관련 질의를 가능하게 해주는 라이브러리

# 구글맵 API 사용권한을 가진 키 발급함
Geocoding API
Maps Elevation API
Maps Embed API
Maps Static API
Street View Static API

# 구글맵 API로 지도 정보 받아오기
register_google(key='AIzaSyBBMuUv6FhREid_mTDZ2Fo1lN5ZlV7ewdk')
gc <- geocode('seoul')
gc
seoul <- as.numeric(gc)
map<-get_googlemap(center = seoul, zoom = 11,maptype='roadmap')
ggmap(map, extent = 'device')

# maptype : terrain, roadmap, satellite, hybrid




# 지도에 서울 자치구 좌표를 이용해서 표시하기
setwd('c:/Java') 
gu <- read.csv('seoul_lon_lat.txt',sep = '', header = F, stringsAsFactors = F)
gu
gm <- ggmap(map, extent = 'device')
gm + geom_point(data=gu, aes(x=V3, y=V4), color='blue',size=3, shape=16)


# 서울 자치구별 교통사고 발생건수를 지도 그래프를 이용해서 표시
gc <- geocode('incheon')
gc
incheon <- as.numeric(gc)
map<-get_googlemap(center = incheon, zoom = 11,maptype='roadmap')
ggmap(map, extent = 'device')
