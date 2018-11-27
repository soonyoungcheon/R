# 크롤링 기초
# rvest 패키지를 이용
python의 bs4에서 영감을 받아 만든 패키지

install.packages('rvest')
library(rvest)

url<- 'http://www.hanbit.co.kr/store/store_submain.html'

html <- read_html(url)
# 지정한 url로 부터 웹문서를 다운로드해서 html 변수에 저장

html_nodes(html,'h3')
html_nodes(html,'span')
# 지정한 요소를 탐색함
