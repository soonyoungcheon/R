Manager <- 1:5
Date <- c('10/24/14','10/28/14','10/01/14','10/12/14','05/01/14')
Country <- c('US','US','UK','UK','UK')
Gender <- c('M','F','F','M','F')
Ages <- c(32,45,25,39,99)
q1 <-c(5,3,3,3,2)
q2 <-c(4,5,5,3,2)
q3 <-c(5,2,5,4,1)
q4 <-c(5,5,5,NA,2)
q5 <-c(5,5,2,NA,1)

leadership <- data.frame(Manager,Date,Country,Gender,Ages,q1,q2,q3,q4,q5)

str(leadership)


# 날짜가 문자형으로 작성됨 stringsfactors =f

# 문자형식을 날짜로 변환 - as.Date()
# 기본 형식은 시스템의 locale  에 따라 다름 (yyyy-mm-dd)
dates <- c('2018-01-01', '2018-12-31')

newdates <- as.Date(dates)
class(newdates)
dates

# 만일, 다른 형식의 날짜를 사용한다면
# 적절한 형식 지정자를 사용
strDates <- c('01/01/2018','12/31/2018')
newdates <- as.Date(strDates,'%m/%d/%Y')
newdates     # 시스템 locale 에 맞게 출력


#leadership의 date 변수를 적절한 날짜형식으로 변환
# fmt <- '%m/%d/%Y'    # %Y : 4자리 년도
# fmt <- '%m/%d/%y'    # %Y : 2자리 년도


leadership$Date <- as.Date(leadership$Date,'%m/%d/%y')  

# within 을 이용하는 두번째 방ㅂ
fmt <- '%m/%d/%y'
leadership <- within(leadership,{date <- as.Date(leadership$Date,fmt)})

str(leadership)
법

# 오늘 날짜/시간 출력
Sys.Date()
Sys.time()

# 날짜 출력 형식
today <- Sys.Date()
format(today, format='%B %d %Y')
format(today, format='%A')
format(today, format='%d %a %m %b %y' )

# 날짜 계산
startdate <- as.Date('2004-02-01')
enddate <- as.Date('2014-05-01')
enddate - startdate

# 생년월일을 기준으로 지금까지 몇일이 지났는지 계산산
DOB <- as.Date('1990-03-20')
today <- Sys.Date()
today - DOB

# 그녀와 사귄지 몇 일이 지났는지 계산
withher <- as.Date('2016-09-09')
today - withher

# 결혼한지 몇일이 지났는지 계산
weddingD <- as.Date('2017-05-25')
today - weddingD

# 헤어진지 몇일이 지났는지 계사
breakup <- as.Date('2017-11-08')
today-breakup 

# 요일 검색
format(DOB,format='%A')

# 고급 날짜 계산 : difftime
difftime(today, DOB, units='weeks') # 주로 계산
difftime(today, DOB, units='hours') # 시간으로 계산
difftime(today, DOB, units='days') # 일로 계산


# 키보드로부터 입력받기
x <- 3  # 입력값이 고정
y <- 5
z<-x+y

x<-scan()  # 입력 종료시 엔터 2번 입력
y<-scan() 
z <- x+y 
z

# 문자 입력 받기
name <- scan(what = character())
name


# 데이터프레임 생성시 편집기 이용
df <- data.frame()
df <- edit(df)
df
