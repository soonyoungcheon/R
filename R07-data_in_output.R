# 키보드로부터 입력받기
x <- 3  # 입력값이 고정
y <- 5
z<-x+y

x<-scan()  # 입력 종료시 엔터 2번 입력
y<-scan() 
z <- x+y 
z

# 문자 입력 받기
name <- scan(what = character())
name


# 데이터프레임 생성시 편집기 이용
df <- data.frame()
df <- edit(df)
df

# 기존에 만든 DF를 편집기로 수정
edit(leadership)


# 외부 파일 불러오기 #2  - 탐색기 이용
summermedia<-read.table(file.choose(),header=T,sep=',')
head(summermedia) 

# 엑셀 파일 다루기
install.packages('xlsx')
install.packages('rJava')
Sys.setenv(JAVA_HOME='c:/Java/jdk1.8.0_181')
# 이미 설치되있는 경우 설치하지 말것

library(rJava)
library(xlsx)

titanic <-read.xlsx(file.choose(),sheetIndex = 1 )

head(titanic)


# 인터넷에서 바로 데이터 가져오기
# 세계 GDP 순위 데이터 가져오기
# data.worldbank.org
#http://databank.worldbank.org/data/download/GDP.csv
#http://databank.worldbank.org/data/download/GDP.xls
url<- 'http://databank.worldbank.org/data/download/GDP.csv'
gdp_rank <- read.csv(url)
head(gdp_rank,20)

# 전처리
# 1행부터 4행까지 삭제, 1,2,3,6,7열 제거

# 내가 한 방법
gdp_rank<- gdp_rank[-1:-4,]
head(gdp_rank)

gdp_rank<- gdp_rank[,-1:-3]
head(gdp_rank)
gdp_rank<- gdp_rank[,-3:-4]
head(gdp_rank)

# 행제거 with a instructor
gdp_rank<- gdp_rank[-c(1,2,3,4),]
# 열제거 with a instructor
gdp_rank<- gdp_rank[,-c(1,2,3,6,7)]

# 상위 25개국 선별 -> GDP_rank_25
colnames(gdp_rank)<-c('Nation','GDP')
gdp_rank_25<-head(gdp_rank,25)
gdp_rank_25

# 열이름 변경with a instructor
names(gdp_rank_25)<-c('Nation','GDP')
gdp_rank_25

names(gdp_rank_25)

# 행번호 변경 
rownames(gdp_rank_25)<-1:nrow(gdp_rank_25)
gdp_rank_25

rownames(gdp_rank_25)<-NULL
gdp_rank_25



# 2010~2015 까지 미국의 주별 1인당 소득자료
# ssti.org -> search : Per Capital personal income
# https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015

url <-'https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015'

install.packages('XML')    # html 소스 처리 패키지
install.packages('httr')   # http 프로토콜 처리 패키지
library(XML)
library(httr)

rawdata <- GET(url)      # raw data로 넘어옴
head(rawdata$content)    # 본문만 출력
head(rawToChar(rawdata$content))   # 16진수를 문자로 바꿔서 출력

html <- readHTMLTable(rawToChar(rawdata$content),stringsAsFactors=F)
html

?readHTMLTable
str(html)

# html 소스 중 table 태그 부분만 추출
incomes <- as.data.frame(html)   # DF로 변환
head(incomes)

# 변수명 바꿈(state, 2010,2011,2012,2014, 2015)
colnames(incomes)<- c('state','2010':'2015')
head(incomes,5)
tail(incomes,5)
names(incomes)
rownames(incomes)

# $와 , 삭제해야 그래프 그릴 수 있다

# 결과물 화면 저장하기
# cat() - 문자열과 변수를 결합
x <- 10
y <- 20
z <- x*y
cat('x*y =', z, '입니다')



# 파일에 데이터 저장
# sink() 함수 사용
setwd('c:/Java/data')
library(RSADBE)
data(Severity_Counts)
Severity <-Severity_Counts
Severity

setwd('c:/Java/data')
library(RSADBE)
data(Severity_Counts)  # Severity_Counts 데이터셋
sink("Severity_Counts.txt")  # 저장할 파일 지정 다음부터 출력한 명령은 다음 파일에 저장해!
Severity_Counts<- Severity_Counts  # 데이터셋을 변수에 저자
Severity_Counts      # 화면에 출력되지 않고 파일에 저장
sink()    # 저장할 파일 닫기



# psych 패키지의 galton 데이터 셋을 galton.txt 로 저장하세요

setwd('c:/Java/data')
library(psych)
data(galton)
sink("galton.txt")
galton <- galton
galton
sink()


# titanic, gdp_rank_25, incomes DF 를 각각 titanic.txt, gdp_rank_25.txt, incomes.txt로 저장
setwd('c:/Java/data')
sink("titanic.txt")
titanic <- titanic  # 변수 설정 이미 되있기 때문에 이 과정 생략 가느
titanic
sink()

setwd('c:/Java/data')
sink("gdp_rank_25.txt")
gdp_rank_25 <- gdp_rank_25
gdp_rank_25
sink()

setwd('c:/Java/data')
sink("incomes.txt")
incomes <- incomes
incomes
sink()


# 파일에 데이터 저장
# write.table() 함수 사용
setwd('c:/Java/data')
write.table(Severity,'Severity1.txt')
write.table(Severity,'severity2.txt', row.names = F)
write.table(Severity,'severity3.txt',quote = F)

# write.xlsx() 함수 사용
library(xlsx)
write.xlsx(Severity,'Severity1.xlsx')

# write.csv() 함수 사용
write.csv(Severity,'severity.csv', row.names = F,quote = F)


# titanic, gdp_rank_25, incomes DF를 각각 txt,xlsx, csv 로 저장하시오
write.table(titanic,'titanic1.txt', row.names = F,quote = F)
write.table(gdp_rank_25,'gdp_rank_25_1.txt', row.names = F,quote = F)
write.table(Severity,'Severity_1.txt', row.names = F,quote = F)
write.xlsx(titanic,'titanic.xlsx')
write.xlsx(gdp_rank_25,'gdp_rank_25.xlsx')
write.xlsx(incomes,'incomes.xlsx')
write.csv(titanic,'titanic.csv', row.names = F,quote = F)
write.csv(gdp_rank_25,'gdp_rank_25.csv', row.names = F)
write.csv(incomes,'incomes.csv', row.names = F,quote = F)


