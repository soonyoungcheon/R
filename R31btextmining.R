# 형태소 분석 2
# 영어 텍스트 분석 - tm 패키지

install.packages('tm')
library(tm)

# 데이터 파일 일거옹기
setwd('c:/Java/data')
docs <- readLines('english.txt')


# tm 패기지가 처리하기 용이하도록 문장들을 벡터처리
# 말뭉치로 저장
# 벡터형으로 저장하기
txt <- VectorSource(docs)
# corpus로 변환하여 저장하기
corp <- Corpus(txt)

inspect(corp)  # documents내용 확인
# 텍스트 분석을 위한 전처리 작업 수행
# 문장 부호를 제거하기
corp <- tm_map(corp, removePunctuation)


# 특정 문자를 제거하기(여기서는 숫자 0~9를 제거)
corp <- tm_map(corp, removeWords,c('0', '1', '2', '3', '4', '5'))
corp <- tm_map(corp, removeWords,c('and','but'))

# 입력 텍스트가 영문인 경우, 대문자를 소문자로 변환하기
corp <- tm_map(corp, tolower)

#전처리 결과 확인
strwrap(corp)
strwrap(corp[[1]])


# cor <- tm_map(corp, PlainTextDocument)
# 일반 문서형태로 변환
tdm <- TermDocumentMatrix(corp)

  tdm
  <<TermDocumentMatrix (terms: 14, documents: 4)>>   # 문장들 중에서 추출한 단어는 14개
    Non-/sparse entries: 20/36 ㅡ  # 무의미/ 유의미 단어 비유
  Sparsity           : 64%
  Maximal term length: 6     # banana
  Weighting          : term frequency (tf)
  
  
  

  
  
tdmm <- as.matrix(tdm)
# TermDocumentMatrix 은 tm 패키지가 사용하는 결과물이므로 일반적인 
# 용도를 위해 행렬로 변환

tdmm

freq <- sort(rowSums(tdmm), decreasing = T)

# 단어별 집계 시행

freq

barplot(freq[1:10], main='단어빈도', las=2, ylim=c(0,2))

# 막대그래프로 시각화





# 스탠포드 대학 : 스티브잡스 연설문을 이용해서 단어별 빈도수 분석후 시각화하세요





docs <- readLines('steve.txt')

docs <- VectorSource(docs)

corp <- Corpus(docs)

inspect(corp)

corp <- tm_map(corp, removePunctuation)

corp <- tm_map(corp, removeWords,c('0', '1', '2', '3', '4', '5'))

corp <- tm_map(corp, tolower)

corp <- tm_map(corp, removeWords,c('had','what','for','with','this','your','from',
                                   'just','very','out','and','but','the', 'that','you', 'was','have',
                                   'are','than', 'has', 'not', 'their', 'will'))
#전처리 결과 확인
strwrap(corp)
strwrap(corp[[1]])

tdm <- TermDocumentMatrix(corp)

findFreqTerms(tdm)
findFreqTerms(tdm, 2)
findFreqTerms(tdm, lowfreq = 2)    # 2회 이상 
findFreqTerms(tdm, highfreq = 2)   # 2회 이하


findAssocs(tdm, 'apple', 0.5)

findAssocs(tdm, 'hate', corlimit= 0.3)

tdmm <- as.matrix(tdm)

tdmm

freq <- sort(rowSums(tdmm), decreasing = T)

# 단어별 집계 시행

freq

barplot(freq[1:20], main='단어빈도', las=2, ylim=c(0,50))

# 막대그래프로 시각화




# 트럼프 연설문

docs <- readLines('thrump.txt')

docs <- VectorSource(docs)

corp <- Corpus(docs)

inspect(corp)

corp <- tm_map(corp, removePunctuation)

corp <- tm_map(corp, removeWords,c('0', '1', '2', '3', '4', '5'))

corp <- tm_map(corp, stripWhitespace)
# 공백 제거




corp <- tm_map(corp, tolower)
corp <- tm_map(corp, removeNumbers)
corp <- tm_map(corp, removeWords,stopwords('english'))
# and but not 제거거
corp <- tm_map(corp, removeWords,c('had','what','for','with','this','your','from',
                                   'just','very','out','and','but','the', 'that','you', 'was','have',
                                   'are','than', 'has', 'not', 'their', 'will'))

#전처리 결과 확인
strwrap(corp)
strwrap(corp[[1]])

tdm <- TermDocumentMatrix(corp)

tdmm <- as.matrix(tdm)

tdmm

freq <- sort(rowSums(tdmm), decreasing = T)

# 단어별 집계 시행

freq




barplot(freq[1:20], main='단어빈도', las=2, ylim=c(0,50))

# 막대그래프로 시각화

wc <- freq[1:30]

library(wordcloud2)
dfword <- data.frame(word=names(wc), freq=wc)

wordcloud2(dfword, size= 1, shape= 'pentagon')
# 워드 클라우드 시각화

