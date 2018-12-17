# 막대 그래프

dose <- c(20,30,40,50,60)
drugA <- c(16,20,27,40,60)
drugB <- c(15,18,25,31,40)

barplot(dose,col='red')
barplot(drugA,col='blue')
barplot(drugB,col='green')

barplot(drugA,xlab = '환자번호', ylab = '양물반응도', main='약물에 대한 환자 반응도',
         col=c('red','orange','yellow', 'green', 'blue'), names.arg=c(1:5), horiz=T)
        
# leadership 데이터에서 매니저별 나이를 막대 그래프로 작성
# 도수 분포표
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

leadership <- data.frame(Manger,Date,Country,Gender,Ages,q1,q2,q3,q4,q5)
barplot(leadership$Ages, ylab= 'age', names.arg=c('A','B', 'C','D','E'))

getwd()
setwd('c:/Java/data')
hotdog <- read.csv('hot-dog-winners.csv', header=T, stringsAsFactors = F)
str(hotdog)
barplot(hotdog$Dogs.eaten, names.arg = hotdog$Year)

# 핫도그 대회 최다 우승국순으로 막대그래프 작성
# table(hotdog$Country)  # 알파벳순
# sort(table(hotdog$Country))  # 오름차순
barplot(sort(table(hotdog$Country),decreasing = T))  # 내림차순


# 핫도그 컨테스트 최다 우승자 순으로 막대그래프 작성
#  barplot(sort(table(hotdog$Winner)))  
barplot(sort(table(hotdog$Winner), decreasing = T )) 

#매니저별 국적 현황을 막대그래프로 작성
table(leadership$Country)
barplot(table(leadership$Country))


#매니저별 성별 현황을 막대그래프로 작성
barplot(table(leadership$Gender), ylim=c(0,4))


# applewood 데이터셋을 참고해서 막대그래프를 작성

getwd()
applewood<- read.table('applewood.txt', header=T)
str(applewood)

# 어느 지점이 가장 판매실적이 좋은가?
barplot(sort(table(applewood$Location),decreasing = T),ylim=c(0,60),main='지역별 판매현황', xlab='판매지역', ylab='판매대수',
        col=c('red','yellow','blue','green'), las=2)
# las=1, 2, 3 x축 변수들의 이름 디스플레이 방식 지정

# 어느 차종이 인기가 많은가?
barplot(sort(table(applewood$Vehicle.Type),decreasing = T), ylim=c(0,80),las=2)

barplot(sort(table(applewood$Vehicle.Type),decreasing = T), xlim=c(0,80),las=2, horiz = T)


# 타이타닉 데이터 셋
setwd('c:/Java/data')
Titanic <- read.csv('train.csv', header=T, stringsAsFactors = F)

Titanic
# 성별 생존수를 막대그래프로 작성
survived <- table(Titanic$Sex,Titanic$Survived)
barplot(survived)
barplot(survived[,2])

# 승선권 유형별(pclass) 생존수를 막대그래프로
survived <- table(Titanic$Pclass,Titanic$Survived)
str(Titanic)
survived
barplot(survived [,2], ylim=c(0,160), main='생존자')
# survived [,1] 사망자

# 누적막대그래프
barplot(survived, xlim=c(0,400), beside = T, horiz=T, names.arg = c( '사망자','생존자'), legend=c('class1','class2','class3'))

# S: southampton, C: cherbourg Q: queens
# 승선 지역별 탑승자 수
# but 실제로는 빈칸처리 되어있음, NA 아니
# csv파일 불러왔을시 stringasfact = F 인자로 쓰지 않았을 
ok<- Titanic$Embarked != ''      # csv파일 불러왔을시 stringasfact = F 인자로 썼을 ㄸ
#ok <- !is.na(Titanic$Embarked)  # csv파일 불러왔을시 stringasfact = F 인자로 쓰지 않았을 
ok
embarked <- Titanic$Embarked[ok]
table(embarked)
embarked
barplot(table(embarked))
Titanic



# 승선 지역별 성별 탑승자수님
loc<-table(Titanic&sex,Titanic$Embarked)
barplot(loc,beside = T)

barplot(embarkgender,beside = T,col=c('red','yellow'))
legend('topleft',c('female','male'), fill=c('red','yellow'))
row.names(embarkgender)

# 승선 지역별 승선권 유형수
embarkclass <- table(Titanic$Embarked,Titanic$Pclass)
rownames(embarkclass) <- c('unknown','cherbourg','queens','southampton' )
barplot(embarkclass,beside = T,col=c('red','yellow','blue','green'),ylim = c(0,400))
barplot(embarkclass,beside = T,col=c('red','yellow','blue','green'),legend('topleft',legend=row.names(embarkclass),
                                      col=c('red','yellow','blue','green'),pch=20))


# 승선 지역별 생존자/사망자 수
embarksur <- table(Titanic$Survived,Titanic$Embarked)
rownames(embarksur) <- c('dead','survived')

barplot(embarksur,beside = T, ylim = c(0,500),col=c('red','yellow'))
legend('topleft',row.names(embarksur),fill=c('red','yellow','blue','green'))

