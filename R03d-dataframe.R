# 인구주택총조사 표를 참조
# 각 변수들을 벡터로 선언
id <- 1:9
sex <- c('여자','여자','여자','여자','남자','여자','여자','여자','남자')
age <- c(68,29,7,3,26,52,62,10,58)
relation<-c('가구주의 배우자','가구주의 배우자','자녀','자녀','자녀','자녀','가구주의 배우자','가구주의 배우자','가구주')
edu<-c('초등학교','초등학교','초등학교','안받았음','중학교','초등학교','고등학교','초등학교','중학교')
nkid <-c(3, 0, '결측','결측','결측',2,1,'결측','결측')

a = data.frame(id,sex,age,relation,edu,nkid)


# applewood auto group 표를 참조

Age <- c(21, 23:27, 27, 28, 28, 29, 29, 30, 30, 30)
Profit <-c('$1387','$1754','$1817','$1040','$1273','$1529','$3082','$1951','$2692','$1206','$1342','$443','$754','$1621')
Location<-c('Tionesta','Sheffield','Sheffield','Sheffield','Kane','Sheffield','Kane','Kane','Tionesta','Sheffield','Kane','Kane','Olean','Sheffield')
Vehicle_Type<-c('Sedan','SUV','Hybrid','Compact','Sedan','Sedan','Truck','SUV','Compact','Sedan','Sedan','Sedan','Sedan','Truck')
Previous<- c(0,1,1,0,1,1,0,1,0,0,2,3,2,1)

b = data.frame(Age,Profit,Location,Vehicle_Type,Previous)



# 나이에 따른 신생아 몸무게 추이에 대한 표
# 각 변수들을 벡터로 선언 (이변량 분석)
bage <- c(01, 03, 05, 02, 11, 09, 03, 09, 12, 03 )
Weight <- c(4.4, 5.3, 7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)
plot(bage,Weight)


c = data.frame(bage, Weight)

mean(bage)        # 산술평균
sd(Weight)        # 표준편차
cor(bage,Weight)  # 상관계수

abline(lm(Weight~bage)) # 상관계수에 따른 선형 회귀직서

# 환자 투약 효과에 대한 표
# 각  변수 벡터로 선언

parentid <- 1:4 
admdate <- c('10/15/2014','11/01/2014','10/21/2014','10/28/2014')
page <- c(25, 34, 28, 52)
diabetes <- c('Type1','Type2','Type1','Type1')
status <- c('Poor', 'Improved', 'Excellent', 'Poor')

d = data.frame(parentid,admdate,page,diabetes,status)
str(d)


d[c(3,5)]
d[c('page','status')]

d$page
d[3]
d[c('page')]

# 메니저에 대해 리더쉽 설문조사 결과표

Manger <- 1:5
Date <- c('10/24/14','10/28/14','10/01/14','10/12/14','05/01/14')
Country <- c('US','US','UK','UK','UK')
Gender <- c('M','F','F','M','F')
Ages <- c(32,45,25,39,99)
q1 <-c(5,3,3,3,2)
q2 <-c(4,5,5,3,2)
q3 <-c(5,2,5,4,1)
q4 <-c(5,5,5,NA,2)
q5 <-c(5,5,2,NA,1)




help(package='vcd')

data()


# applewood auto group 의 csv 파일을 이용해서 데이터프레임으로 작성
getwd()
applewood <- read.table('applewood.txt', header=T, sep=" " ) 

str(applewood)

# applewood 데이터셋에서 '판매이익profit'을 문자형으로 변경
applewood$Profit <- as.character(applewood$Profit)
str(applewood)

# 기술통계량 확인
summary(applewood)


# psych 패키지의 galton 데이터셋을 조사하세요
install.packages('psych')
library('psych')
?psych  # 유전학, 의학, 통계학을 기초로 우성 유전학 증대 목적
data(galton)  # 부모/자식 키 조사, 관계 조사
str(galton)
summary(galton)
