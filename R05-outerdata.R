# 데이터베이스로부터 읽어오기
# 다양한 RDBMS에서 데이터를 읽어올 수 있음
# MySQL, MariaDB - RMySQL

install.packages('RMySQL')
library(RMySQL)
?RMySQL


mysqlconn<-dbConnect(MySQL(),
                    user='', password = '', dbname= '',

result <- dbSendQuery(mysqlconn,'select*from Book')

book <- fetch(result,n=5)
book
str(book)

dbDisconnect(mysqlconn)

