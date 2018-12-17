# 데이터베이스로부터 읽어오기
# 다양한 RDBMS에서 데이터를 읽어올 수 있음
# MySQL, MariaDB - RMySQL

install.packages('RMySQL')
library(RMySQL)
?RMySQL


mysqlconn<-dbConnect(MySQL(),
                    user='', password = '', dbname= '',
                    host= '아이피')

# 질의 생성 후 결과 집합 계정

# 결과 집합 모두를 book 객체에 저장

result <- dbSendQuery(mysqlconn,'select*from Books')

book <- fetch(result,n=5)
# book 에서 5 행 결과 보여주기

book

str(book)제

# 출력시 한글 깨짐 현상 발생하면 UTF-8로 문자변환을 해줌
book[[2]] <- iconv(book[[2]], from = 'UTF-8')
book[[3]] <- iconv(book[[3]], from = 'UTF-8')

book

dbDisconnect(mysqlconn) 접속해제


# Oracle
install.packages('rJava')
install.packages('RJDBC')
install.packages('DBI')

library(rJava)
library(DBI)
library(RJDBC)

OJDBC <- JDBC(driverClass = 'oracle.jdbc.driver.OracleDriver', classPath = 'C:/Java/jdbc/ojdbc7.jar')
# 오라클 JDBC 드라이버 등록

oracleconn <- dbConnect(OJDBC,'jdbc:oracle:thin:@//아이피:1521/XE', 'db명', '비밀번호')

sql <- 'select*from employees'

emp <- dbGetQuery(oracleconn,sql)

head(emp)
str(emp)


# 서울시/경기도 우편번호를
# 오라클/마리아디디베 import 해서 저장한 후 
# (seoulzip, kyunggizip)
# 각자의 거주지를 조회하는 R 코드 작성

