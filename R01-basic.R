# R 은 수많은 패키지로 구성
# 패키지 : 활용가능한 함수의 재현 가능한 예제 데이터 셋,
# 사용방법 및 설명서 , 도움말 등으로 구성
#  설치시 7개의 패키지 자동설치ㄷ
# R 기본 설치 가능 패키지수 보기
available.packages()

dim(available.packages()) # 12825개의 패키지 표시

sessionInfo()  # 현재 R 실행 환경, 언어집합, 설치된 패키지

# 새로운 패키지 설치
# install.packages(설치할패키지명)
install.packages('stringr')

#설치한 패키지 확인
installed.packages

#패키지 제거
remove.packages('stringr')

# 패키지를 설치하고 난 후, 사용하려는 패키지는 메모리에 적재해야 함
#패키기 사용/적재
library('stringr')  # 오류 표시 (추천!)
require('stringr')  # 경고 표시

library() # 설치된 패키지 확인


# r 이 제공하는 기본예제
demo()      # 데모 목록 표시
demo('graphics')  # 그래프 예제


# R의 도움말
help('Nile') # 도움말 함
?Nile

example(Nile)     # 함수, 데이터셋 사용예

#그래프 그리기 예제
Nile   # 나일강 범람 수위 조사 데이터 됨

help.start()     # R 에서 제공하는 기본도움말
# https://homepage.usask.ca/~chl948/doc/manual/R-intro-ko.html


# 실습
# RSADBE 패키지를 설치하고 이 패키지의 도움말을 확인
# 데이터셋을 사용해본다

install.packages("RSADBE")

library('RSADBE')

?RSADBE

data(GC)

?GC

data(Severity_Counts)
?Severity_Counts


# vcd 패기지를 설치하세요
# 이 패기지에서 사용가능한 함수와 데이터셋을 확인합니다
install.packages('vcd')
library('vcd')
?vcd
help('vcd')
data()
