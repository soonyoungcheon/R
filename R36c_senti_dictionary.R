# 감성분석
Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_181')

library(rJava)
library(KoNLP)
library(stringr)
library(dplyr)
library(rvest)

# 감성사전 초기화
# 감성사전 초기화
pos <- readLines('positive.csv', encoding = 'UTF-8')
neg <- readLines('negative.csv', encoding = 'UTF-8')
head(pos)


# 감정분석 테스트
str1 <- '10점 내 생애 최고의 영화 심금을 울리네요'
str2 <- '도대체 뭐가 충격적이라는 거지..'
str3 <- '와.. 드디어 AMD가 자기네 그래픽 드라이버에 문제 있다는 걸 인정했네요..'





# 전처리 작업
docs <- as.character(str2)
docs <- gsub('[[:punct:]]','', docs)
docs <- gsub('[[:cntrl:]]','', docs)
docs <- gsub('\\d+','', docs)
head(docs)


# 형태소 분석
doc <- paste(SimplePos22(docs))
doc
doc.nc <- str_match(doc, '[가-힣]+/NC')   # 명사
doc.nc <- unique(doc.nc[!is.na(doc.nc)])
head(doc.nc)

doc.pv <- str_match(doc, '[가-힣]+/PV')   #  동사
doc.pv <- doc.pv[!is.na(doc.pv)]
doc.pv <-unique(doc.pv)

doc.pa <- str_match(doc, '[가-힣]+/PA')   # 형용사
doc.pa <- doc.pa[!is.na(doc.pa)]
doc.pa <- unique(doc.pa)


# 감성 분석 실시

pos.nc.matches <- match(doc.nc, pos)
neg.nc.matches <- match(doc.nc, neg)
pos.nc.matches <- !is.na(pos.nc.matches)
neg.nc.matches <- !is.na(neg.nc.matches)

pos.pv.matches <- match(doc.pv, pos)
neg.pv.matches <- match(doc.pv, neg)
pos.pv.matches <- !is.na(pos.pv.matches)
neg.pv.matches <- !is.na(neg.pv.matches)


pos.pa.matches <- match(doc.pa, pos)
neg.pa.matches <- match(doc.pa, neg)
pos.pa.matches <- !is.na(pos.pa.matches)
neg.pa.matches <- !is.na(neg.pa.matches)

pos.sum <- sum(pos.nc.matches , pos.pv.matches ,pos.pa.matches)
neg.sum <- sum(neg.nc.matches , neg.pv.matches,neg.pa.matches)
score <- pos.sum -  neg.sum
score



steve <- readLines('steve_ko.txt', encoding = 'UTF-8')
head(steve)
docs <- as.character(steve)
docs <- gsub('[[:punct:]]','', docs)
docs <- gsub('[[:cntrl:]]','', docs)
docs <- gsub('\\d+','', docs)
head(docs)


thrump <- readLines('thrump_ko.txt')
head(thrump)
docs <- as.character(thrump)
docs <- gsub('[[:punct:]]','', docs)
docs <- gsub('[[:cntrl:]]','', docs)
docs <- gsub('\\d+','', docs)
head(docs)



# 형태소 분석
doc <- paste(SimplePos22(docs))
doc
doc.nc <- str_match(doc, '[가-힣]+/NC')   # 명사
doc.nc <- unique(doc.nc[!is.na(doc.nc)])
head(doc.nc)

doc.pv <- str_match(doc, '[가-힣]+/PV')   #  동사
doc.pv <- doc.pv[!is.na(doc.pv)]
doc.pv <-unique(doc.pv)

doc.pa <- str_match(doc, '[가-힣]+/PA')   # 형용사
doc.pa <- doc.pa[!is.na(doc.pa)]
doc.pa <- unique(doc.pa)


# 감성 분석 실시

pos.nc.matches <- match(doc.nc, pos)
neg.nc.matches <- match(doc.nc, neg)
pos.nc.matches <- !is.na(pos.nc.matches)
neg.nc.matches <- !is.na(neg.nc.matches)

pos.pv.matches <- match(doc.pv, pos)
neg.pv.matches <- match(doc.pv, neg)
pos.pv.matches <- !is.na(pos.pv.matches)
neg.pv.matches <- !is.na(neg.pv.matches)


pos.pa.matches <- match(doc.pa, pos)
neg.pa.matches <- match(doc.pa, neg)
pos.pa.matches <- !is.na(pos.pa.matches)
neg.pa.matches <- !is.na(neg.pa.matches)

pos.sum <- sum(pos.nc.matches , pos.pv.matches ,pos.pa.matches)
neg.sum <- sum(neg.nc.matches , neg.pv.matches,neg.pa.matches)
score <- pos.sum -  neg.sum
score



