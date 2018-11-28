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


