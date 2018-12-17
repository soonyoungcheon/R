# aggregate - 집계 관련 함수
# dplyr의 group by 보다 비교적 단순하게 코드 작성
library(dplyr)
data('diamonds',package = "ggplot2")
diamonds
# aggreate(집계대상, 데이터,적용함수)
# cut 별 평균 price 집계
aggregate(price~cut, diamonds, mean)
# cut/color 별 평균 price 집계
aggregate(price~cut + color, diamonds, mean)
