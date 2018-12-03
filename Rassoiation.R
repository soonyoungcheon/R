# 연관성 분석
데이터 내부네 존재하는 
상호관계 혹은 종속 관계를 찾아내는 분석
대표적인 예) 마케딩에서의 장바구니 분석

젊은 기혼 남성들은 기저귀와 맥주를 동시에 구매함
=> 어린 자녀의 기저귀를 사러 마트에 가면 자신 혹은 아내와 같이
마실 맥주를 동시에 구매한다는 규칙을 알아냄
=> 따라서, 상품 진열시 기저귀와 맥주를 가까이 진열하고 매출 증가를 기대

고객이 구매한 장바구니를 살펴봄으로써 상품들의 연관성(규칙을) 
발견하고 분석함으로써 상품을 사기 위해 움직이는 동선에 관한 상품을
진열하거나 관련 상품끼리의 묶음 상품을 개발

한편, 연관성을 일반화하거나 어느 정도까지 신회할 수 있을까? 등의
판단 기준이 필요 => 지지도 support, 신뢰도 confidence, 향상도 lift

# 지지도 
구매기록 데이터
1)맥주, 오징어, 치즈
2)소주, 맥주, 라면
3)맥주, 오징어, 사이다, 콜라
4)사이다, 오징어, 라면
5)치즈, 라면, 계란

# 신뢰도
ex) 맥주를 구해할때, 어떤 상품을 추천할까?
품목 A를 구매했을때, 품목 B를 함께 구매한 거래 수

상품 A에 대한 상품 B의 신뢰도 =>
  맥주 - 오징어 : 2/3
  맥주 - 라면 : 1/3
  맥주 - 소주 : 1/3
  맥주 - 치즈 : 1/3

오징어와 어울리는 상품은?
  오징어 - 맥주 : 2/3
  오징어 - 사이다 : 2/3
  오징어 - 콜라 : 1/3
  오징어 - 라면 : 1/3


지지도 
상품 A,상품 B를 동시 구입횟수/전체 구매횟수

맥주 - 오징어 구입 신뢰도 : 2/3 => 66%
맥주 - 오징어 구입 지지도 : 2/5 => 40%

=> 지지도는 신뢰도보다 높을 수 없음!
  단지, 같거나 작을뿐임

향상도
상품 A, B의 신뢰도 / (B상품 등장횟수/전체 거래횟수)
=1: 두 상품이 서로 독립적인 관계
>1 : 두 상품이 서로 양의 상관관계
<1 : 두 상품이 서로 음의 상관관계

오징어 - 맥주  향상도 : (2/3) / (3/5) = 1.1
오징어 - 사이다 향상도 : (2/3) / (2/5) =1.65

=> 맥주의 출현횟수가 사이다의 출현횟수 보다 크르모 맥주가 인기상품이라는 것을 
알 수 있음, 하지만, 향상도를 구해보면 오히려 오징어 - 사이다 항목이 더 높음
따라서, 오징어 구매시 추천 추천상품은 사이다임 



# 상관성 분석 알고리즘
아프리오리 알고리즘
데이터들의 발생빈도를 기반으로 각 데이터간의 연관관계를 밝히는 방법
install.packages('arules')
library(arules)

setwd('c:/Java/data')
carts <- read.csv('carts2.txt', sep='/',header=T, stringsAsFactor=F)
carts

# 연관규칙분석을 위해 먼저 데이터들을 매출이력 trasnsaction 형식으로 일거온 데이터들을
희소행렬 형대로 확인
맥주/오징어/치즈/소주/라면/사이다/콜라/계란
1    1      1    0    0     0     0    0 
1                1    1
이하 생략

carts <- as.matrix(carts)  # 행렬로 변환
carts

carts <- as(carts,'transactions')
carts
# 연관규칙 분석 위해 먼저 데이터를 테이블로 읽어봐야함


inspect(carts)

summary(carts)
# density of 0.4 : 총 거래 중 1의 비율을 표시
# most frequent items: 높은 빈도순 항목 표시
# length distribution: 거래당 상품 수
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 거래건수 기술통계 : 거래당 평균 3개의 상품 판매
희소행렬의 크기 : 5 X 8 = 40
총 판매된 물품 수 : 40*0.4 =16
0.4는 density
=> 총 16개의 상품이 판매됨
평균 판매갯수 : 16/5=3.2
=> 매 거래당 평균 3.2개의 상품이 팔림

# 상품의 거래비율을 출력
# 전체 상품에 대한 지지도 수준으로 출력
# 맥주, 오징어, 라면 : 거래 60%에 


itemFrequency(carts)
# 상품의 거래비율을 출력
# 전체 상품에 대한 지지도 수준으로 출력

itemFrequencyPlot(carts, support=0.4, cex.names=0.8)
# 상관성을 막대그래프로 표시


# 상관성을 그래프로 표시
install.packages("arulesViz")
library(arulesViz)
plot(ar, method='graph')
plot(ar, method='paracoord')
plot(ar, method='grouped')

ar <- apriori(carts, parameter=list(supp=0.4, conf=0.6, target='rules'))
# 상관성 그래프를 그리기 위한 규칙 생성


#ar <- apriori(carts)

inspect(sort(ar))


install.packages('igraph')
library(igraph)



rules <- labels(ar, ruleSep=' ')
rules <- sapply(rules, strsplit,' ', USE.NAMES = F)
rm <- do.call('rbind', rules)
rm

redg <- graph.edgelist(rm[,1:2], directed = F)
redg <- graph.edgelist(rm[-c(1:3),1:2], directed = F)

plot.igraph(redg, vertex.label=V(redg)$name, vertex.label.cex=1.2,
            vertex.label.color='black', vertex.label.size=20, vertex.color='gray',
            vertex.fream.color='blue')



# -------------------------------
ex) 장바구니분석 2


x <- data.frame(
  
  beer=c(0,1,1,1,0),
  
  bread=c(1,1,0,1,1),
  
  cola=c(0,0,1,0,1),
  
  diapers=c(0,1,1,1,1),
  
  eggs=c(0,1,0,0,0),
  milk=c(1,0,1,1,1) )


x <- as.matrix(x)

x<- as(x,'transactions')
x

inspect(x)

summary(x)

itemFrequency(x)
# 상품의 거래비율을 출력
# 전체 상품에 대한 지지도 수준으로 출력

x



ar <- apriori(x, parameter=list(supp=0.4, conf=0.5, target='rules'))
# 상관성 그래프를 그리기 위한 규칙 생성


#ar <- apriori(carts)

inspect(sort(ar))

rules <- labels(ar, ruleSep=' ')
rules
rules <- sapply(rules, strsplit, ' ', USE.NAMES = F)
rm <- do.call('rbind', rules)
rm

redg <- graph.edgelist(rm[,1:2], directed = F)
redg <- graph.edgelist(rm[-c(1:3),1:2], directed = F)

plot.igraph(redg, vertex.label=V(redg)$name, vertex.label.cex=1.2,
            vertex.label.color='black', vertex.label.size=20, vertex.color='gray',
            vertex.fream.color='blue')



y <- data.frame(
  병원 = c(1,0,0,0,1, 0,0,1,0,0, 0,0,1,0,0, 0,0,1,0,1),
  약국 = c(1,0,0,0,0, 0,0,1,0,0, 0,0,1,0,0, 0,0,1,0,1),
  카페 = c(0,0,1,1,0, 1,0,0,0,0, 1,0,0,0,0, 1,0,0,0,0),
  휴대폰매장 = c(1,0,0,0,0, 1,0,1,0,0, 0,0,1,0,0, 0,0,1,0,1),
  음식점 = c(0,1,0,0,1, 0,0,0,0,1, 0,1,0,1,1, 0,1,0,1,0),
  레스토랑 = c(0,1,0,0,1, 0,1,0,0,1, 0,1,0,1,1, 0,1,0,1,0),
  당구장 = c(0,1,0,0,0, 0,0,0,1,0, 0,1,0,0,0, 0,1,0,1,0),
  학원 = c(0,0,1,1,0, 0,0,0,0,0, 1,0,0,0,0, 1,0,0,0,0),
  슈퍼마켓 = c(0,0,0,0,0, 0,0,0,1,0, 0,0,0,0,0, 0,0,0,0,0),
  은행 = c(0,0,1,1,0, 0,0,0,0,0, 1,0,0,0,0, 1,0,0,0,0),
  편의점 = c(0,1,0,0,1, 0,0,0,0,1, 0,0,0,1,1, 0,0,0,0,0),
  화장품 = c(1,0,0,0,1, 0,1,0,0,1, 0,0,0,1,1, 0,0,0,0,0))
y

y <- as.matrix(y)
y <- as(y, 'transactions' )

inspect(y)
summary(y)
itemFrequencyPlot(y)

ar <- apriori(y, parameter=list(supp=0.25, conf=0.4, target='rules'))
# 상관성 그래프를 그리기 위한 규칙 생성



inspect(sort(ar))

rules <- labels(ar, ruleSep=' ')
rules
rules <- sapply(rules, strsplit, ' ', USE.NAMES = F)
rm <- do.call('rbind', rules)
rm


redg <- graph.edgelist(rm[-c(1:3),1:2], directed = F)

plot.igraph(redg, vertex.label=V(redg)$name)

plot(ar, method='graph')
plot(ar, method='paracoord')
plot(ar, method='grouped')

