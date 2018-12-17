# 초콜렛 봉지에 든 초콜렛 색깔 비율 조사
# 초콜렛 색상을 범주형 변수로 선언하고, level 과 각 범주에 할당된 서수를 확인하세요

color <- factor(c('blue', 'green', 'orange', 'yellow', 'red', 'brown'))
levels(color)
as.numeric(color)
# as.factor(color)

percent<- c('24%','20%','16%','14%', '13%', '13%')

data.frame(color, percent)


# 고객 평가 빈도표를 참고하여 평가 지표를 범주형 변수로 선언하세요
# level 과 각 범주에 할당된 서수를 확인하세요

rating <- factor(c('superior', 'good', 'average', 'poor', 'inferior'))
freqen <- c(6,26,16,9,3)
percentage <-c('10.0%', '43.3%', '26.7%', '15.0%', '5.0%')

data.frame(rating,freqen,percentage)
rating


# 메니저에 대해 리더쉽 설문조사 결과표
Gender <- c('M','F','F','M','F')
q4 <-c(5,5,5,NA,2)
q5 <-c(5,5,2,NA,1)