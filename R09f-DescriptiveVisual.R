# 여러개의 그래프를 한 화면에 배치하기
# mfrow=c(행,열) : 행 우선 배치
# mfcol=c(행,열) : 열 우선 배치

# 현재 그래프 설정 저장
.opar <- par(no.readonly = T)

par(mfrow=c(2,2))  # 화면 분할 2x2
plot(mtcars$mpg)
plot(mtcars$cyl)
plot(mtcars$gear)
plot(mtcars$hp)

par(.opar)   # 그래픽 설정 초기화

par(mfcol=c(2,2))  # 화면 분할 2x2  
plot(mtcars$mpg)
plot(mtcars$cyl)
plot(mtcars$gear)
plot(mtcars$hp)

par(mfcol=c(3,1))  # 화면 분할 3x1
plot(mtcars$mpg)
plot(mtcars$cyl)
plot(mtcars$gear)
plot(mtcars$hp)

# 좀 더 복잡한 레이아웃을 지정하고 싶다? - layout
# layout(matrix(영역번호, 행수, 열수))
# layout.show() : 분할된 영역 미리보기
par(.opar)
layout(matrix(c(1,1,2,3),2,2))   #2x2
layout.show(3)
plot(mtcars$mpg)
plot(mtcars$cyl)
plot(mtcars$gear)
plot(mtcars$hp)


par(.opar)
layout(matrix(c(1,1,2,3),2,2, byrow=T))   #2x2
layout.show(3)
plot(mtcars$mpg)
plot(mtcars$cyl)
plot(mtcars$gear)
plot(mtcars$hp)


