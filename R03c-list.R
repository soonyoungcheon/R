# 인구주택총조사 표를 참조
# 각 변수들을 리스트로 선언
id <- list(1:9)
sex <- list('여자','여자','여자','여자','남자','여자','여자','여자','여자','남자')
age <- list(68,29,7,3,26,52,62,10,58)
relation<-list('가구주의 배우자','가구주의 배우자','자녀','자녀','자녀','자녀','가구주의 배우자','가구주의 배우자','가구주')
edu<-list('초등학교','초등학교','초등학교','안받았음','중학교','초등학교','고등학교','초등학교','중학교')
nkid <-list(3, 0, '결측','결측','결측',2,1,'결측','결측')


# applewood auto group 표를 참조
# 각 변수들을 리스트로 선언
Age <- list(21:27, 27, 28, 28, 29, 29, 30, 30, 30)
Profit <-list('$1387','$1754','$1817','$1040','$1273','$1529','$3082','$1951','$2692','$1206','$1342','$443','$754','$1621')
Location<-list('Tionesta','Sheffield','Sheffield','Sheffield','Kane','Sheffield','Kane','Kane','Tionesta','Sheffield','Kane','Kane','Olean','Sheffield')
Vehicle_Type<-list('Sedan','SUV','Hybrid','Compact','Sedan','Sedan','Truck','SUV','Compact','Sedan','Sedan','Sedan','Sedan','Truck')
Previous<- list(0,1,1,0,1,1,0,1,0,0,2,3,2,1)


# 나이에 따른 신생아 몸무게 추이에 대한 표
# 각 변수들을 리스트로 선언 (이변량 분석)
bage <- list(01, 03, 05, 02, 11, 09, 03, 09, 12, 03 )
Weight <- list(4.4, 5.3, 7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1)
plot(bage,Weight)

mean(bage)        # 산술평균
sd(Weight)        # 표준편차
cor(bage,Weight)  # 상관계수

abline(lm(Weight~bage)) # 상관계수에 따른 선형 회귀직서

# 환자 투약 효과에 대한 표
# 각  변수 리스트로 선언

parentid <- list(1:4) 
admdate <- list('10/15/2014','11/01/2014','10/21/2014','10/28/2014')
page <- list(25, 34, 28, 52)
diabetes <- list('Type1','Type2','Type1','Type1')
status <- list('Poor', 'Improved', 'Excellent', 'Poor')



# 메니저에 대해 리더쉽 설문조사 결과표
# 각 변수들을 리스트로 선언

Manger <- list(1:5)
Date <- list('10/24/14','10/28/14','10/01/14','10/12/14','05/01/14')
Country <- list('US','US','UK','UK','UK')
Gender <- list('M','F','F','M','F')
Ages <- list(32,45,25,39,99)
q1 <-list(5,3,3,3,2)
q2 <-list(4,5,5,3,2)
q3 <-list(5,2,5,4,1)
q4 <-list(5,5,5,NA,2)
q5 <-list(5,5,2,NA,1)


help(package='vcd')

data()
