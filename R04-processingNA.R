q3 <-c(5,2,5,4,1)
q4 <-c(5,5,5,NA,2)
q5 <-c(5,5,2,NA,1)

q3 + q4 +q5

na.omit(q4)


sum(q3,q4,q5, na.rm= T)



# 결측지, 이상치 처리
# 실제 데이터들 중 오류를 포함할 가능성은 언제나 존재재
# 따라서, 분석전 이러한 오류들은 바로 수정해야 함

# 결측치 missing value - NA
# 누락된 값, 비어 있는 값
# 함수/수식 적용 불가 - 분석 결과 왜곡
# 제거 또는 적절한 값으로 대체한 후 분석 실시


leadership = data.frame(Manger,Date,Country, Gender, Ages,q1,q2,q3,q4,q5)

is.na(leadership)  # 결측치 확인

table(is.na(leadership)) # 빈도표 작성

is.na(leadership$q4)    # 결측치 확인 
sum(is.na(leadership$q4))   # 결측치 총 개수


# 결측지 채우기
# 중심경향 값 넣기 : 평균, 최빈갓, 중앙값 -> (분석결과는 비교적 양호)
# 난수값 넣기 : 정규분포를 따름
# 회귀 분석을 이용한 값 넣기 : 관측치의 특성을 고려
# 상황에 따라 결측치를 제외할 수도 있음
# 결측지 제거


leadership$q4[4] <- 3
leadership$q5[4] <- 3


leadership<-within(leadership,{
  sumq <- q1+q2+q3+q4+q5
  meanq <- sumq/5
})

x<- c(1,2,3,NA,5)
y<- sum(x)    # 결측치가 포함된 벡터에 sum함수를 적용 -> 결과는 NA!

y

y <- sum(x,na.rm=T)   # 결측치는 제외하고 sum 적ㅇ
y

x <- na.omit(x)   # 결측치를 자료구조에서 아예 제외
x

na.exclude(x)
y<- sum(na.exclude(x)) 
y

# leadership 예제에서는 na.rm=T 를 이용해서 계산
leadership<-within(leadership,{
  sumq[1] <- sum(q1[1],q2[1],q3[1],q4[1],q5[1],na.rm = T)
  sumq[2] <- sum(q1[2],q2[2],q3[2],q4[2],q5[2],na.rm = T)
  sumq[3] <- sum(q1[3],q2[3],q3[3],q4[3],q5[3],na.rm = T)
  sumq[4] <- sum(q1[4],q2[4],q3[4],q4[4],q5[4],na.rm = T)
  sumq[5] <- sum(q1[5],q2[5],q3[5],q4[5],q5[5],na.rm = T)
})

leadership

# na.omit  이용해서 계산(행 자체가 살아짐)
leadership
leadership <- na.omit(leadership)
leadership


# 결측치 예제 - titanic (kaggle.com)
# 타이타닉 생존 요인 예측
# 승객번호, 생존여부(1:생존), 승선권등급(1:특석)
# 이름,성별,나이,형제수,자식수,승선권번호, 요금, 객실번호, 승선항ㄱ

setwd('c:/Java/data')
titanic <- read.csv('titanic.csv', header = T, sep=',', stringsAsFactors = F,na.strings = c("NA",""))

head(titanic,10)

tail(titanic,10)

str(titanic)

# 결측치 조사 빈도표로 나타냄
is.na(titanic)
table(is.na(titanic))

head(titanic$Cabin)
sum(is.na(titanic$Age))     # 177 
sum(is.na(titanic$Cabin))   # 0

# 하지만, excel 에서 필터기능으로 확인시 다름
# 문자열을 factor 형으로 변환하지 말것!
# 빈값 "" 은 반드시 NA로 설정

sum(is.na(titanic$Age))    # 177
sum(is.na(titanic$Cabin))  # 687

# Age 의 결측치는 177이므로 적정한 값으로 대체
# cabin 의 결측치는 687이므로 제거하는 것이 좋음

# 살아남은 승객 수는 얼마나 되나?
nrow(titanic[titanic$Survived==1,]) # 342명

# 승객 중 남자는 얼마나 되나?
nrow(titanic[titanic$Sex=='male',]) # 131명 

# 승선권 클래스가 2이고 남자인 승객수는?
nrow(titanic[titanic$Pclass==2&titanic$Sex=='male',]) #108

# 살아 남은 승객 중 남자수와 여자수는?
nrow(titanic[titanic$Survived==1&titanic$Sex=='male',])
nrow(titanic[titanic$Survived==1&titanic$Sex=='female',])

# 서울시 우편번호 파일 읽어서
setwd('c:/Java/data')
zipcode <- read.csv('Seoul-2017.10.csv', header = T, sep=',', stringsAsFactors = F,na.strings = c("NA",""))

str(zipcode)

sum(is.na(zipcode))   # 1595039
sum(is.na(zipcode$읍면))  # 569443
sum(is.na(zipcode$시군구용건물명))   # 456153

zipcode

# 도로명 주소 '약수암길 9-13'를 조회
zipcode[zipcode$도로명=='약수암길'&zipcode$건물번호본번==9&zipcode$건물번호부번==13,]

# NA 값을 ''로 변경
# zipcode$읍면[] <- ''
zipcode$읍면[is.na(zipcode$읍면)] <- ''
zipcode$리명[is.na(zipcode$리명)] <- ''
sum(is.na(zipcode$읍면))
zipcode[zipcode$도로명=='약수암길'&zipcode$건물번호본번==9&zipcode$건물번호부번==13,]


# 단, 결측치는 NA로 설정

# 경기도 우편번호 파일 읽어서
setwd('c:/Java/data')
getwd()
Gzipcode <- read.csv('경기도.csv', header = T, sep=',', stringsAsFactors = F,na.strings = c("NA",""))

str(Gzipcode)

Gzipcode[Gzipcode$도로명=='회덕길'&Gzipcode$건물번호본번==53&Gzipcode$건물번호부번==55,]

# 각자의 주소를 조회
