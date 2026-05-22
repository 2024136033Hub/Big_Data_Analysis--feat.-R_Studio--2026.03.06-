setwd("C:/r_data")
Sys.setlocale("LC_ALL", "Korean_Korea.UTF-8")

library(lubridate)
library(dplyr)
library(plyr)
library(ggplot2)
library(googleVis)
library(stringr)

# 히스토그램(특정데이터의 빈도수를 막대 그래프로 나타낸 것) : hits()
h = c(182, 157, 167, 172, 181, 166, 159, 155, 156)
hist(h, maun='HIST')

# pie() : 전체의 합이 100이 되어야하는 경우, 서로를 비교할 때 사용
p1 = c(11,19,33,37)
pie(p1)

# pie함수의 경우 여러 옵션 추가 가능함
pie(p1, radius = 1, init.angle = 90)

pie(p1, radius = 1, init.angle = 90, col=rainbow(length(p1)), labels = c('w1', 'w2', 'w3', 'w4'))


# 수치값 출력
pct = round(p1/sum(p1)*100)
lab=paste(pct, ' %')
pie(p1, radius = 1, init.angle = 90, col=rainbow(length(p1)), labels = lab)
legend(0.8, 1.1, c('w1','w2','w3','w4'), cex=0.5, fill = rainbow(length(p1)))

pct = round(p1/sum(p1)*100)
lab1 = c('w1','w2','w3','w4')
lab2 = paste(lab1, '\n', pct, ' %')
pie(p1, radius = 1, init.angle = 90, col=rainbow(length(p1)), labels = lab2)


# pie그래프 3D로 표시
install.packages("plotrix")
library(plotrix)

pct = round(p1/sum(p1)*100)
lab1 = c('w1','w2','w3','w4')
lab2 = paste(lab1, '\n', pct, ' %')
pie3D(p1, radius = 1, col=rainbow(length(p1)), labels = lab2, explode = 0.05)




# 상자차트(최대, 최소, 중앙값등을 한눈에 볼 수 있음) : boxplot()  _ 사용시 박스모양으로 그래프가 그려짐
# _ 최대값, 최소값을 각각 윗수염, 아랫수염이라고 부르고 ??을 극단치경계라고 함 극단치 값을 벗어난 걸 극단값이라고 함
v1 = c(10,12,15,11,20)
v2 = c(5,7,15,8,9)
v3 = c(11,20,15,18,13)
boxplot(v1,v2,v3)

# 결측치..? 이상값..? 뭐에 대한....??? 일단 나중에 본다고 하심
boxplot(v1,v2,v3, col = c('blue', 'yellow', 'pink'), names = c('BLUE', 'YELLOW', 'PINK'), horizontal=T)

# 관계도 그리기 : igraph() _ 관계도이기 떄문에 연관성이 있는가에 따라 그림
# 서로 연관있는 데이터들을 연결해서 표현해준다. 소셜 네트워크
install.packages('igraph')
library('igraph')


g1 = graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6, 2,1))
g1
plot(g1)

name=c('홍길동대표', '일지매부장', '김유신과장', '손흥민대리', '윤봉길대리',
       '이순신부장', '유관순과장', '사임당대리', '강감찬부장', '광개토과장',
       '정몽주대리')
pemp=c('홍길동대표','홍길동대표', '일지매부장', '김유신과장', '김유신과장',
       '홍길동대표', '이순신부장', '유관순과장', '홍길동대표', '강감찬부장',
       '광개토과장')

emp = data.frame(이름=name, 상사이름=pemp)
emp

g = graph.data.frame(emp, directed = T)
plot(g, layout=layout.fruchterman.reingold, vertex.size=10, edge.arrow.size=0.3) # vertex.size는 동그라미 모양의 크기

plot(g, layout=layout.fruchterman.reingold, vertex.size=10, edge.arrow.size=0.3,
     vertex.label=NA)

dev.new()
plot(g, layout=layout.fruchterman.reingold, vertex.size=10, edge.arrow=0.5)
savePlot('network.png', type = 'png')



# 데이터 정제
# 빠진 데이터 찾기 : 결측치 정제
# 결측치
# - 누락된 값, 비어있는 값
# - 얘네 포함 시 함수 사용 불가 >> 분석 결과가 왜곡됨
# 그렇기 때문에 저거 후 분석해야 함


df = data.frame(gender=c('M', 'F', NA, 'M', 'F'), score=c(5,4,3,4,NA))   # NA는 not aplicable..? 이였음
df

# 결측치 확인
is.na(df)   # 결극치가 있는 값은 true가 들어감
table(is.na(df))
table(is.na(df$gender))
table(is.na(df$score))

mean(df$socre)  # NA값이 하나라도 있으면 NA처리됨
# 이럴경우 결측치를 제거해야함
# 
# 결측치 제거
# 결측치 있는 행 제거   _ filter는 dplyr에서 library에서 사용함
df %>%
  filter(is.na(score))

df %>%
  filter(!is.na(score))   # 행 제거 시 이걸로 씀

# 결측치 제거한 데이터 분석
df1 = df %>%
  filter(!is.na(score))

mean(df1$score)
sum(df1$score)
# 이렇게 없애줘야 평균치나 합계같은 걸 할 수 있다고 함


# 여러 변수에 동시에 결측치 없는 데이터를 동시에 추출
df1 = df %>%
  filter(!is.na(score) & !is.na(gender))
df1
df


# 결측치가 하나라도 있으면 제거
df2 = na.omit(df)   # 위에 작성한 경우랑 같게 찍힘
df2

# 함수에 결측치 제외 가능 : na.rm=T
mean(df$score)

mean(df$score, na.rm = T)

exam = read.csv('csv_exam.csv')
exam


exam[c(3,8,15), 'math']=NA
exam

exam %>%
  summarise(mean_math=mean(math))


exam %>%
  summarise(mean_math=mean(math, na.rm=T))    # NA 제거 기능 넣음


# 결측치 대체값으로 대체하기
# - 결측치가 많을 경우, 제외하면 데이터 손실 큼
# >> 대안 : 다른 값 채워넣기
# 
# 
# 결측치 대체법
# - 대표값으로 일괄대체 : 평균, 최빈값, 중앙값
# - 혹은 통계분석기법 이용, 혹은 예측값을 추정해서 대체

# 평균 값으로 결측치 대체

mean(exam$math, na.rm=T)
exam$math = ifelse(is.na(exam$math), 55, exam$math)     # NA값이 55로 들어감
exam$math

mean(exam$math)


# 이상치 : 정상범주에서 크게 벗어난 값
# - 이상치 포함 시 분석 결과 왜곡
# >> 결측 처리 후 제외하고 분석
# 
# 이상치 종류
# - 존재할 수 없는 값 : 결측처리(무조건 해야함)
# - 극단적인 값 : 정상범위 기준을 정해서 결측처리
# 
# 이상치 제거 :존재할 수 없는 값

out = data.frame(gender=c(1,2,1,3,2,1), score=c(5,4,3,4,2,6))
out

# 이상치 확인
table(out$gender)
table(out$score)

# 결측치 처리
out$gender = ifelse(out$gender == 3, NA, out$gender)

# 위 문장에 in제시어를 사용
out$gender = ifelse(out$gender %in% c(1,2), out$gender, NA)
out

out$score = ifelse(out$score > 5, NA, out$score)
out

# 결측처리후 분석
out %>%
  filter(!is.na(gender) & !is.na(score)) %>%
  group_by(gender) %>%
  dplyr::summarise(mean_score=mean(score))

# 이상치 제거 : 극단적인 값
# - 정상 범주에서 크게 벗어나면 결측처리
# 
# 판단 기준 
# - 논리적 판단
# - 통계적 판단 : boxplot() 이용

library(ggplot2)
mpg                 # 데이터 분석 및 시각화를 학습하기 위해 기본적으로 제공되는 내장 샘플 데이터

boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats    # 3행이 중앙값 대충 그런식으로 됨

# 결측처리
mpg$hwy = ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))


# 결측치 제외하고 분석
mpg %>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  dplyr::summarise(mean_hwy=mean(hwy))


mpg

mpg[c(65,124,131,153,212), 'hwy'] = NA




#####################     문제      #####################
#
# Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지 알아보려고 합니다.
# 분석을 하기 전에 우선 두 변수에 결측치가 있는지 확인해야 합니다.
# drv 변수와 hwy 변수에 결측치가 몇 개 있는지 알아보세요.

mpg$hwy
table(is.na(mpg$drv))
table(is.na(mpg$hwy))     # 이럴 경우 true 값이 8로 나오는 게 정상이라고 위의 코드를 다 실행했을 때의 경우임


# Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고,
# 어떤 구동방식의 hwy 평균이 높은지 알아보세요.
# 하나의 dplyr 구문으로 만들어야 합니다.

mpg %>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  dplyr::summarise(mean_hwy=mean(hwy))





