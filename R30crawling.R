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



title<-html_nodes(html,'p.book_tit')
# 도서 제목 추출

html_text(title)
# 태그 저거 후 텍스트만 출력


url <- 'http://www.hanbit.co.kr/store/books/full_book_list.html'
html <- read_html(url)
# 책 제목, 가격 추출
title <- html_nodes(html,'td.left')
title <- html_text(title)
title[seq(1,100,2)]  # 책 제목 저자 같이 나오기 때문에 
title

price <- html_nodes(html, 'td.right')
price <- html_text(price)
price
mode(price)

# httr 패키지
# http 해더 취급, POST, GET, REST API 지원
read_html(url) 를 간단하게 GET/POST 함수로 처리 가능
부수적으로 http header를 추가해서 서버에 요청 가능
웹 문서를 가져올 때는 content 함수를 이용

install.packages('httr')
library(httr)

url <- 'http://www.hanbit.co.kr/store/store_submain.html'
html <- GET(url, add_headers(.headers=c('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36')))
content(html)
content(html, 'text')
