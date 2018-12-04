# 감정분석 2 - 한글 데이터 이용
# 군산대학교 한국어 감성 사전을 이용
# http://dilab.kunsan.ac.kr/knusl.html

library(dplyr)
library(stringr)

setwd('c:/Java/data')
# 감성사전 초기화
pos <- readLines('positive_ko.txt')
neg <- readLines('negative_ko.txt')

head(pos,5)
head(neg,5)

# 분석 데이터 초기화
docs <- readLines('steve_ko.txt', encoding = 'UTF-8')
head(docs)


# 전처리 작업
docs <- gsub('[[:punct:]]','', docs)
docs <- gsub('[[:cntrl:]]','', docs)
docs <- gsub('\\d+','', docs)
head(docs)


# 문장들을 공백단위로 잘라서 벡터로 변환
words <- str_split(docs, '\\s+')
words <- unlist(words)
head(words)



# 감성 분석 실시

pos.matches <- match(words, pos)
neg.matches <- match(words, neg)

pos.matches <- !is.na(pos.matches)
neg.matches <- !is.na(neg.matches)


score <- sum(pos.matches) - sum(neg.matches)
sum(pos.matches)
sum(neg.matches)
score

a<-'10점 내 생애 최고의 영화 심금을 울리네요'
# 전처리 작업
a <- gsub('[[:punct:]]','', a)
a <- gsub('[[:cntrl:]]','', a)
a <- gsub('\\d+','', a)
a


# 문장들을 공백단위로 잘라서 벡터로 변환
a <- str_split(a, '\\s+')
a <- unlist(a)
a


# 감성 분석 실시

pos.matches <- match(a, pos)
neg.matches <- match(a, neg)

pos.matches <- !is.na(pos.matches)
neg.matches <- !is.na(neg.matches)


score <- sum(pos.matches) - sum(neg.matches)
score
sum(pos.matches)
sum(neg.matches)



b<-'도대체 뭐가 충격적이라는 거지..'
# 전처리 작업
b <- gsub('[[:punct:]]','', b)
b <- gsub('[[:cntrl:]]','', b)
b <- gsub('\\d+','', b)
b


# 문장들을 공백단위로 잘라서 벡터로 변환
b<- str_split(b, '\\s+')
b <- unlist(b)
b


# 감성 분석 실시

pos.matches <- match(b, pos)
neg.matches <- match(b, neg)

pos.matches <- !is.na(pos.matches)
neg.matches <- !is.na(neg.matches)


score <- sum(pos.matches) - sum(neg.matches)
score
sum(pos.matches)
sum(neg.matches)



c<-'와.. 드디어 AMD가 자기네 그래픽 드라이버에 문제 있다는 걸 인정했네요..'
# 전처리 작업
c <- gsub('[[:punct:]]','', c)
c <- gsub('[[:cntrl:]]','', c)
c <- gsub('\\d+','', c)
c


# 문장들을 공백단위로 잘라서 벡터로 변환
c <- str_split(c, '\\s+')
c <- unlist(c)
c


# 감성 분석 실시

pos.matches <- match(c, pos)
neg.matches <- match(c, neg)

pos.matches <- !is.na(pos.matches)
neg.matches <- !is.na(neg.matches)


score <- sum(pos.matches) - sum(neg.matches)
score
sum(pos.matches)
sum(neg.matches)





setwd('c:/Java/data')
marketing <- readLines('marketing.txt',encoding = 'UTF-8')
# 전처리 작업
docs <- gsub('[[:punct:]]','', marketing )
docs <- gsub('[[:cntrl:]]','', docs )
docs  <- gsub('\\d+','', docs )
head(docs)


# 문장들을 공백단위로 잘라서 벡터로 변환
docs <- str_split(docs, '\\s+')
docs <- unlist(docs)
docs


# 감성 분석 실시

pos.matches <- match(docs, pos)
neg.matches <- match(docs, neg)

pos.matches <- !is.na(pos.matches)
neg.matches <- !is.na(neg.matches)


score <- sum(pos.matches) - sum(neg.matches)
score
sum(pos.matches)
sum(neg.matches)

