# 텍스트분석 3가지 유형
# 텍스트분류
# 텍스트군집
# 텍스트요약

# 형태로 분석
주어진 단어 또는 어절을 구성하는 각 형태소를 분리한 후 분리된 형태소이 기본형 및 품사정보를 추출

# 형태소
의미가 최소 단위로서 더 이상 분리할 수 없는 가장 작은 의미 요소

  
# KoNLP: Korean natural Language Processing 
# 한글 자연어 처리 분석 패키지
# KoNLP는 rJava, memoise 패키지가 부수적으로 필요
# github.com/haven-jeon/KoNLP
install.packages('devtools')
install.packages('rJava')
install.packages('memoise')
install.packages('KoNLP') 
install.packages('dplyr')

library(devtools)
library(rJava)
library(memoise)
library(KoNLP)
library(dplyr)
library(stringr)

Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_181')

# 형태소 분석을 위한 참고사전이 필요
# 분석할 문장에 포함된 단어들이 사전에 알맞는 형태(품사)로 정의되어 있어야 정확한 분석 가능
# 이를 위해 KoNLP에는 세종 사전이 포함되어 있음


useSejongDic()   # 370957
useNIADic()      # 983012  단어수가 가장 많음!
useSystemDic()   # 283949



# 형태로 분리 예
text <- "롯데마트가 판매하고 있는 흑마늘 양념 치킨이 논란이 되고 있다."
extractNoun(text)     # 명사 위주 분류
# [1] "롯데마트가" "판매"       "흑마늘"     "양념"       "치킨"       "논란"   
SimplePos09(text)     # 품사를 9개 기준으로 분류
SimplePos22(text)     # 품사를 22개 기준으로 분류
MorphAnalyzer(text)   # 품사를 상세한 수준으로 분류




ex) 대통령 연설문을 참고로 자주 언급되느 단어순으로 분석하고 워드클라우드로 시각화하기
setwd('c:/Java/data')

speech <- readLines('speech.txt')
# readLines() - txt 파일의 내용을 읽어서 변수에 저장

head(speech, n=5)

# 1. 전처리 작업 - 불필요한 불용어(공백, 특수문자)를 처리
# gsub : 문자열 치환 함수
# gsub(패턴, 치환문자, 대상)
speech <- gsub('[~?!@%#()_+=<>]','',speech)  # 특수문자제거
speech <- gsub('[0-9]','',speech)            # 0부터 9까지
speech <- gsub('[a-zA-Z]','',speech)         # 영어 제거 
speech <- gsub('[ㄱ-ㅎ]','',speech)          # ㅋㅋㅋ ㅎㅎㅎ 제거
speech <- gsub('[ㅜㅠ]','',speech) 
speech <- gsub('[\\-]','',speech)            # \\ 
# speech <- gsub('[주제와상관없는단어|할인]','',speech) # 특정 단어 제거
speech

# 2. 명사 추출
nouns <- extractNoun(speech)
nouns

wdc <- table(unlist(nouns))
# 추출된 명사의 빈도표 작성
wdc

# 빈도표 데이터프레임으로 변경
df_word<- as.data.frame(wdc, stringsAsFactors = F)
head(df_word)
df_word <- rename(df_word, word=Var1, freq=Freq)
# 데이터프레임의 각 열 이름 변경  word<-Var1, freq<-Freq 변경

df_word$word <- as.character(df_word$word)
df_word <- filter(df_word, nchar(word)>=2)
문자 길이가 2자 이상인 단어를 걸러냄

top20 <- df_word %>% arrange(desc(freq)) %>% head(20)

# df_word의 내용을 빈도수로 정렬한 후 상위 20개만 추려냄
top20


ex) 2018년 7월, '월드컵'이라는 주제로 트위터에서 각종 텍스트를 수집했다
이를 분석하고 워드클라우드로 시각화하세요
wordcup <-read.csv()



