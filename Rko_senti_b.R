# 감성사전 만들기1
# 네이버 영화리뷰파일 ratings.txt을 기초로 하여
# 긍정/부정 사전 생성

# 어휘분석

Sys.setenv(JAVA_HOME='c:/Java/jdk1.8.0.181')
library(rJava)
library(KoNLP)
library(stringr)
library(dplyr)
library(rvest)

useNIADic()

# 어휘분석
# 명사 추출, 기본품사 추출, 상세품사 추출
# SimplePos09 : N, P
str1 <- '10점 내 생애 최고의 영화 심금을 울리네요'
str2 <- '도대체 뭐가 충격적이라는 거지..'
str3 <- '와.. 드디어 AMD가 자기네 그래픽 드라이버에 문제 있다는 걸 인정했네요..'


word1a <- extractNoun(str1)
word1a
word1b <- SimplePos09(str1) 
word1b
word1c <- SimplePos22(str1) 
word1c

# 명사 추출
doc <- as.character(str1)  # 문자형 변환
doc <- paste(SimplePos09(doc))  # 상세품사로 추출
doc <- str_match(doc,'[가-힣]+/N')
doc.nc <- doc[!is.na(doc)]
doc.nc


# 추출된 데이터 파일로 저장
setwd('c:/Java/data')
doc.nc <- as.data.frame(doc.nc)
write.csv(doc.nc,'doc.nc.csv', fileEncoding='UTF-8', row.names = F)


# 형용사 (PA)추출
doc.pa

# 동사(PV) 추출
doc.pv

#  추출된 데이터를 csv 파일로 저장



# steve jobs 연설문에서 명사, 형용사, 동사를 추출해서 steve.nc,steve.pa,steve.pv 파일 생성
######명사 추출
steve <- readLines('steve_ko.txt', encoding = 'UTF-8')
class(steve)
steve<- paste(SimplePos09(steve))
steve <- str_match(steve,'([A-Z가-힣]+)/[NC]')
steve.nc <- steve[!is.na(steve)]
steve.nc


# 추출된 데이터 파일로 저장
setwd('c:/Java/data')
steve.nc <- as.data.frame(steve.nc)
write.csv(steve.nc,'steve.nc.csv', fileEncoding='UTF-8', row.names = F)




##### 형용사 
steve <- readLines('steve_ko.txt', encoding = 'UTF-8')
class(steve)
steve<- paste(SimplePos09(steve))
steve <- str_match(steve,'([A-Z가-힣]+)/[PA]')
steve.pa <- steve[!is.na(steve)]
steve.pa



# 추출된 데이터 파일로 저장
setwd('c:/Java/data')
steve.pa <- as.data.frame(steve.pa)
write.csv(steve.pa,'steve.pa.csv', fileEncoding='UTF-8', row.names = F)




##### 동사
steve <- readLines('steve_ko.txt', encoding = 'UTF-8')
class(steve)
steve<- paste(SimplePos09(steve))
steve
steve <- str_match(steve,'([가-힣]+)/[PV]')
steve.pv <- steve[!is.na(steve)]
steve.pv



# 추출된 데이터 파일로 저장
setwd('c:/Java/data')
steve.pv <- as.data.frame(steve.pv)
write.csv(steve.pv,'steve.pv.csv', fileEncoding='UTF-8', row.names = F)




