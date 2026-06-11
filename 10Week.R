setwd("C:/r_data")
Sys.setlocale("LC_ALL", "Korean_Korea.UTF-8")

library(lubridate)
library(dplyr)
library(plyr)
library(ggplot2)
library(googleVis)
library(stringr)

# 그래프 기초
# plot() : 분포도나 꺽은 선
# plot(y축 데이터, 옵션)
# plot(x축 데이터, 옵션)
# plot(x축, y축, 옵션)

# x축, y축

v1 = c(2,2,2)
plot(v1)    # y축의 수가 다 2로 설정이 됨

# x축, y축
x = 1:3
y = 3:1
plot(x,y)   # 위처럼 각각의 축을 정의된 상태라고 하면 (1,3)과, (3,1)에 점이 찍힘


# x축, y축의 한계값 지정
plot(x, y, xlim = c(1, 10), ylim = C(1,5))    # ?lim = c(a:b)를 사용해 ?에 x나 y를 넣어서 (a,b)의 위치로 한계값 지정 가능함

# 축제목 : xlab, ylab, main : 그래프 제목
plot(x, y, xlim=c(1,10), ylim=c(1,5), xlab='축값', ylab='y축값',
     main='PLOT TEST')

# 해당 식으로 그래프를 그린다면 기존 그래프에 덧씌워져 그려짐
# 그렇기 때문에 창을 지우고 새로게 그리는 방법(plot.new())과 새창을 꺼내서 그리는 방법(dev.new())이 존재함

plot.new()    # 창을 지우고 다시 그린다
dev.new()     # 새로운 창에서 다시 그린다

v1 = c(100,130,120,160,150)
plot(v1, type='o', col='red', ylim = c(0,200), axes= F, ann= F)   # 코드에서 col은 2가지고 나뉜다. 시각 함수에서 사용되었다면 color이고, 데이터함수에서 사용되었다면 column이다 

axis(1, at = 1:5, lab= c('MON', 'TUE', 'WED', 'THU', 'FRI'))
axis(2,, ylim= c(0, 200))
title(main = "FRUITS", col.name= 'red', font.main= 4)
title(xlab = 'DAY', col.lab = 'black')
title(ylab = 'PRICE', col.lab = 'blue')


# 그래프의 배치 조정 : mfow
# par(mfrow= c(nr, nc))       # 어떤 함수 안에 n이 붙어있다면 개수를 의미하기 떄문에 해당 코드는 몇행 몇열인지 알려주는 코드임
v1

par(mfrow= c(3,3))
plot(v1, type = 'b')    # 점과 선으로 이뤄진 타입
plot(v1, type = 's')    # 왼쪽부터 시작해 그리는 계단형 그래프
plot(v1, type = 'S')    # 오른쪽 시작 계단형 그래프    
plot(v1, type = 'l')    # 선으로 그려진 그래프
plot(v1, type = 'p')    # 점
plot(v1, type = 'c')    # 'b'에서 점이 생략됨
plot(v1, type = 'o')    # 점과 선이 중첩된 그래프
plot(v1, type = 'h')    # 각 점에서 x축까지 수직선으로 나타내는 그래프_히스토그램
plot(v1, type = 'n')    # 축만 표현

par(mfrow=c(1,3))     # 3개 띄우는 것 같음
pie(v1)
plot(v1, type = 'o')
barplot(v1)

par(mfrow=c(1,1))     # 1개만 띄우는 것 같음
a= c(1,2,3)
plot(a, xlab='aaa')


# 그래프의 여백 조정
# mgp = c(제목위치, 지표값위치, 지표선위치)
par(mgp= c(2,1,0))
plot(a, xlab = 'aaa')
# 위에서 2를 1로 바꾸면 축 제목이 바뀜
par(mgp= c(1,1,0))
# 지표값도 지표선도 매한가지


# oma(outside margine) : 그래프의 전체 여백 조정,
# oma(bottom, left, top, right)
par(oma=c(3,2,2,2))   # 각각 정확한 위치는 기억이 안나긴 하지만 각각 상하좌우 위치의 여백 조정 가능함
plot(a, xlab='aaa')


# 여러개의 그래프를 중첩으로 그리기
# par(new= T) 혹은 add= T
v1=c(1,2,3,4,5)
v2=c(5,4,3,2,1)
v3=c(3,4,5,6,7)

plot(v1, type = 's', col='red', ylim = c(1,5))
par(new= T)
plot(v2, type = 'o', col='blue', ylim = c(1,5))
par(new= T)
plot(v3, type = 'l', col='green')   # lim(limit를 안 주게 되면 겹쳐서 들어옴..?)
# 일단 plots쪽 칸의 빗자루 버튼으로 그래프를 지울수도 있어서 그걸로 지움...

plot(v1, type = 's', col='red', ylim=c(1,10))
lines(v2, type = 'o', col='blue', ylim=c(1,5))  # 얘는 ylim를 적어줘도 되지만 적용은 안된다고 함 >> 쓰나마나임
lines(v3, type = 'l', col='green')

# 범례추가
# legend(x축, y축, 내용, cex=글자크키, col=색상, pch=크기, lty=선모양)

legend(4,9, c('v1', 'v2', 'v3'), cex=0.9, col = c('red', 'blue', 'green'),
       lty=1)     # lty : 0~6



# 그래프 중에서 막대 그래프를 많이 사용한다고 함, 그래프가 화려하지 않고 투박하다 함
# batplot() : 막대그래프

# 기본 형태인 세로 막대 그래프형
x=c(1,2,3,4,5)
barplot(x)

# 가로 막대형
barplot(x, horiz = T)


# 그룹으로 묶어서 출력 : beside=T >> 반드시 matrix로 데이터 생성 _ 중요
x = matrix(c(5,4,3,2), 2, by=T)     # 참고로 열 우선 :  by=T를 안 붙인다면 그럼
x

# 그룹으로 묶어서 가로 출력
barplot(x, beside = T, names=c(5,3), col = c('green', 'yellow'), horiz = T)
# 세로 출력
barplot(x, beside = T, names=c(5,3), col = c('green', 'yellow'))


# 여러개의 막대그래프를 하나의 막대그래프로 출력_기본값으로 세로로 출력
barplot(x, names=c(5,3), col = c('green', 'yellow'), ylim = c(0, 10))
# 위의 형식의 막대그래프 가로로 출력
barplot(x, names=c(5,3), col = c('green', 'yellow'), horiz = T, xlim = c(0, 10))


# 조건을 주고 그래프 그리기
# peach 값이 200이상 red, 180~199 yellow, 그 이하는 green
peach = c(180, 200, 250, 198, 170)

colors = c()

for (i in 1:length(peach)) {
  if (peach[i] >= 200) {
    colors = c(colors, 'red')
  } else if (peach[i] >= 180) {
    colors = c(colors, 'yellow')
  } else {
    colors= c(colors, 'green')
  }
}
barplot(peach, main = 'PEACH SALES', names.arg = c('MON','TUE','WED','THU','FRI'),
        col=colors)

# 매개변수가 있는 함수 처리
f1 = function(f) {
  colors = NULL
  for (i in 1:length(f)) {
    if (f[i] >= 200) {
      colors[i] = 'blue'
    } else if (f[i] >= 180) {
      colors[i] = 'pink'
    } else {
      colors[i] = 'green'
    }
  }
  return(colors)
}

f1(peach)
barplot(peach, col=f1(peach), names.arg = c('MON','TUE','WED','THU','FRI'))




# 실습
x1=c(100,130,190,160,150,220)

# 1. 한 화면에 6개의 그래프를 나타내어라
barplot(x1)
par(mfrow=c(2,3))   #정답

# 2. 점과 선의 조합으로 이루어진 그래프 출력
plot(x1, type = 'o')
plot(x1, type='o', col='red', ylim = c(0,250))   #정답

# 3. 가로 출력
barplot(x1,  horiz = T)   #맞춤

# 4. 그룹으로 묶어서 출력
v1 = matrix(x1, 2, by=T)  #맞춤_3번째 줄부터 정답 못적음
v1
barplot(v1, beside = T, names= c(1,2,3), col=c('green', 'yellow'))

# 5. 그룹으로 묶어서 가로 출력
barplot(v1,horiz = T, beside = T, names= c(1,2,3),
        col=c('green', 'yellow'))

# 6. 하나의 막대그래프로 가로로 출력
barplot(v1, horiz = T, names= c(1,2,3),
        col=c('green', 'yellow'), xlim = c(0,500))

# 7. 하나의 막대그래프로 세로로 출력 ....? 얘는 못적음
barplot(v1, names=c(1,2,3), col = c('green', 'yellow'), ylim = c(0, 500))

# 8. 조건을 주고 그래프 그리기 : 한 화면에 하나의 그래프로 표현
#     v1값이 200이상 red, 180~199 yellow, 그 이하 green

par(mfrow=c(1,1))
x1
colors = c()

for (i in 1:length(x1)) {
  if (x1[i] >= 200) {
    colors = c(colors, 'red')
  } else if (x1[i] >= 180) {
    colors = c(colors, 'yellow')
  } else {
    colors= c(colors, 'green')
  }
}
barplot(x1, main = 'PREACH SALES',
        names.arg = c('MON','TUE','WED','THU','FRI','SAT'),
        col = colors)














