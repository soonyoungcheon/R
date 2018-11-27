# 셀러니엄 
# 1 selenium 설치
# 2 chromedrive 설치
# 3 geckodrive 설치

# 셀레니엄 서버 구동
cd /Java
cd RSelenium
java -Dwebdrive.gecko.drive='geckodriver.exe' -jar selenium-server-standalone-3.141.59.jar -port 1320

# 셀레니엄 패키지 설치
# http://github.com/ropensci/RSelenium
# http://ropensci.github.io/RSelenium/reference/index.html
# install.packages('RSelenium')
install.packages('devtools')
devtools::install_github('ropensci/RSelenium')

library(RSelenium)
library(rvest)

# 셀레니엄 구동 테스트
chrome <- remoteDriver('localhost', 1320, 'chrome')
# 크롬 브라우저를 원격제어 하기 위해 셀러니엄 서버에 접속
chrome$open()
# 크롬 브라우저 구동

chrome$getStatus()
# 셀레니엄 서버 접속 상황 확인

chrome$close()
# 크롬 브라우저 종료


# naver 크로링 테스트 (로그인)
chrome$open()

chrome$maxWindowSize()
# 브라우저를 전체 화면크기로 키움

chrome$navigate('http://naver.com')
# 브라우저 주소창에 'naver.com' 입력

chrome$getCurrentUrl()
# 브라우저의 현재 url 출력

html<-chrome$getPageSource()[[1]] 
# 결과값은 리스트로 반환 인덱스 써줘야함

html
# 현재 페이지의 html 소스 읽어오기

html <-read_html(html)
findWords <-html %>% html_nodes('span.ah_k') %>% html_text()

findWords
# 네이버 검색어 순위 (1-20) 추출 후 출력
lgbtn <- chrome$findElement('class name', 'lg_local_btn')

lgbtn$clickElement()
# 로그인 버튼 클릭

chrome$getCurrentUrl()
# 현재페이지 위치 출력 - 로그인 페이지

uid <- chrome$findElement('id', 'id')
pwd <- chrome$findElement('id', 'pw')

uid$setElementAttribute('value','아이디')
pwd$setElementAttribute('value', '비밀번호')

# 아이디, 비밀번호 입력창에 로그인 정보 입력

lgbtn <- chrome$findElement('css selector', 'input.btn_global')
lgbtn$clickElement()
# 로그인 버튼 클릭



lgbtn <- chrome$findElement('css selector', 'span.btn_inr')
lgbtn$clickElement()
# 로그아웃을 하기 위해 로그아웃 버튼 추출 후 클릭
# 하지만, iframe 프레임으로 구성되었기 때문에 로그아웃 버튼 작동 실패!


myframe <- chrome$findElement('id', 'minime')
chrome$switchToFrame(myframe)
chrome$getPageSource()[[1]]
# 현재 웹페이지 소스 확인


lgbtn <- chrome$findElement('css selector', 'span.btn_inr')
lgbtn$clickElement()
# iframe 으로 전환 후 다시 로그아웃 버튼 실행


# k-apt.go.kr 크롤링 예제
# 팝업창 자동 닫기, 단지정보 자동 입력
# hello_selenium_06.py 소스 참고



chrome$open()
chrome$maxWindowSize()
chrome$navigate('http://k-apt.go.kr/')

popups <- chrome$findElements('class','layerPopup')
popups
popups[[1]]
# 클래스명이 layerPopup 인 요소들을 추출
popups[[1]]$getElementAttribute('id')
popups[[2]]$getElementAttribute('id')
popups[[3]]$getElementAttribute('id')


for(i in 1:3){
  id <- popups[[i]]$getElementAttribute('id')
  #js <- paste('closeLyserPopup(\'',id,'\')')
  js <- paste0('closeLyserPopup(\'',id,'\')')
  chrome$executeScript(js)
  Sys.sleep(1)
  }


navi<- chrome$findElement('class','navi2')
navi$clickElement()
# 단지정보 버튼 추출 후 클릭

# 단지정보 입력


month<- chrome$findElement('css selector','select.combo_MM > option:nth-child(11)')
month$clickElement()

sido<- chrome$findElement('css selector','select.combo_SIDO > option:nth-child(10)')
sido$clickElement()

gu<- chrome$findElement('xpath','//*[@class="combo_SGG"]/option[text()="강남구"]')
gu$clickElement()

dong<- chrome$findElement('xpath','//*[@class="combo_EMD"]/option[text()="삼성동"]')
dong$clickElement()

apt <- chrome$findElement('xpath','//*[@id="15"]/td[2]')
apt$clickElement()

chrome$close()

