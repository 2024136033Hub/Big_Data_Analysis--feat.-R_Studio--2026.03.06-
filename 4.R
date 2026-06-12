setwd("C:r_data")
Sys.setlocale('Lc_ALL', 'Korean')

library(lubridate)
library(dplyr)
library(ggplot2)


###################################################

# 자주 사용되는 기본 함수
# aggregate() : 다양한 함수를 사용하여 셜과 출력
# apply() : 다양한 기능
# cor() : 상관함수
# cumsum() : 설정된 지점까지의 누적합
# cumprom() : 설정된 지점까지의 누적곱
# diff() : 차이나는 부분을 찾는다
# length() : 요소갯수
# max() : 최대값
# min() : 최소값
# mean() : 평균
# median() : 중앙값
# order() : 요소의 원위치
# prod() : 누적 곱
# range() : 범위
# rank() : 순위
# sd() : 표준편차
# rev() : 역순
# sort() : 정렬
# summary() : 요약
# sweep() : 일괄적빼기
# tapply() : 벡터에서 주어진 함수 연산
# var() : 분산


#############################################

v1 = c(1,2,3,4,5)
v2 = c('a','b','c','d','e')

max(v1)
max(v2)
mean(v1)
mean(v2)
sd(v1)
sum(v1)
var(v1)

install.packages("googleVis")
library(googleVis)
Fruits

# aggregate(계산될 컬럼 ~ 기준될 컬럼, 데이터, 함수) : 데이터프레임 상대로 주어진 함수값 구하기
 
# 년도별로 판매된 수량의 총합
aggregate(Sales~Year, Fruits, sum)

# 과일별로 가장 많이 판매된 수량
aggregate(Sales~Fruit, Fruits, max)

# 과일별로 최대판매량에 연도를 추가해서 과일별, 년도별 최대 판매량 출력
aggregate(Sales~Fruit+Year, Fruits, max)

# apply(데이터, 행(1)/열(2), 계산될 함수) : matrix에 유용하게 사용(행,열을 대상으로 작업)
m1 = matrix(c(1,2,3,
              4,5,6), 2, by=T)
m1

apply(m1, 1, sum) # 형별로 구함
apply(m1, 2, sum)
apply(m1[,c(2,3)], 2, sum)  # m1의 모든값의 2열과 3열을 출력하고 싶으면..




# lapply(데이터, 함수) _ 리스트를 다루는 함수임
# 비슷한 함수로는 sapply(데이터 함수)가 있음 둘 다 list 처리를 도움

# lapply(데이터, 함수) / sapply(데이터 함수) : list 처리
l1 = list(Fruits$Sales)
l2 = list(Fruits$Profit)
l1
l2

lapply(c(l1, l2), max)  # 출력결과 : list형

sapply(c(l1,l2), max)   # 출력 결과 : 백터형

# 데이터프레임에서 사용
lapply(Fruits[,c(4,5)], max)
sapply(Fruits[,c(4,5)], max)

# tapply(출력값, 기준컬럼, 함수) : 데이터셋의 factor 처리
# mapply(함수, 벡터1, 벡터2, ... 벡터n) : 벡터나 리스트를 데이터프레임처럼 처리
# - 데이터 프레임이 아닌 벡터나 리스트 형태로 데이터가 있을 때 마치 데이터프레임처럼 
# 연산을 해주는 함수. 단, 벡터들의 요소객수가 동일해야 한다

Fruits
tapply(Sales, Fruit, sum)   # 이 방식으로 사용하면 안되고 아래 방식으로 쓰면 됨
tapply(Fruits$Sales, Fruits$Fruit, sum)  # 다만 이럴 시.. 다독성 ⇣

# 컬럼명을 변수로 직접 사용하기 : attach
# attach() : 컬럼명을 변수처럼 직접 사용. 공통적으로 계속 사용되는 대상 데이터프레임을
# 지정할 때, $ : dataframe$컬럼명은 입력할 데이터가 몇 개 안될 때 사용
                # 위의 형식은 

attach(Fruits)
tapply(Sales, Fruit, sum)

# 판매된 과일별 합계
tapply(Sales, Fruit, sum)
aggregate(Sales~Fruit, Fruits, sum)
# 위 두 코드들은 출력형태를 다르지만 결과 값이 같음


# 년도별 판매된 합계
tapply(Sales, Year, sum)
aggregate(Sales~Year, Fruits, sum)

v1 = c(1,2,3,4,5)
v2 = c(10,20,30,40,50)
v3 = c(100,200,300,400,500)

mapply(sum, v1,v2,v3)   # 같은 인덱스 위치에 있는 애들을 계산한다..?
mapply(max, v1,v2,v3)


# 사용자 정의 함수 : 함수를 직접 만들어서 사용
# 힘수명 = function(인수 또는 입력값) {
#     수식1
#     수식2
#     ...
#     return(반환값)
# }
# 
# 1. 입력값이 없는 경우

my1 = function(){
  return(10)
}

my1   # 이건 형태만 보여줘서 아래 코드 형식으로 적어야 제대로 보여줌
my1()

# 2. 입력값(인자)이 있는 경우

my2 = function(a){
  b = a^2
  return(b)
}

my2(3)


my3 = function(a,b){
  c = abs(a-b)  # 절대값을 구해주는 형식 사용
  return(c)
}

my3(3, 4)


my4 = function(a,b){
  if (a > b) {
    c = a-b
  } else {
    c = b-a
  }
  return(c)
}

my4(3,4)

# sort() : 정렬함수
s1 = Fruits$Sales
s1  # 확인하면 해당 값은 정렬이 되어있지 않은 상태

sort(s1)  # 기본값으로 오름차순으로 정렬함
sort(s1, decreasing = T)  # 이렇게 되면 내림차순으로 정렬함

# plyr() : 원본 데이터를 분석하기 쉬운 행텨로 나누어서 다시 새로운 형태로 만들어주는 패키지
# - apply() 함수를 확장
# - ply(data, 기준컬럼, 함수)란, 함수앞에 두글자 : 첫글자는 입력될 데이터 유형, 두번째 그자는 
# 출력될 데이터 유형
# - d: dataframe, a : array(matrix), l : list
# - dlply(), laply()

install.packages('plyr')
library(plyr)

f = read.csv('fruits_10.csv')
f

#summarise : 기존 컬럼의 데이터끼리 모은 후 함수를 적용(sql의 group by와 유사)
#
# 년도별, 과일이름별로 최고판매량과 최저가격을 구해라.
ddply(f, 'year', summarise, max_qty = max(qty), min_price = min(price))

# 년도별, 과일이름별로 최고판매량과 최저 가격을 구해라.
ddply(f, c('year', 'name'), summarise, max_qty = max(qty), min_price = min(price))

# transform : 만약 동일한 컬럼이 아닌 각 행별로 연산을 수행해서 해당값을 함께 출력해야 할 경우
# - 즉, 주어진 데이터 프레임에서 기준 컬럼으로 모은 후 계산해서 출력하고 싶은 경우 >> summarise,
# 다른 계산을 해서 각 행별로 각각 출력하고 싶은 경우 >> transform
f

# pct_pty는 해당 과일의 판매수량이 기준 컬럼으로 합계계한 총 판매개수대비 몇 %를 차지하는지 계산
dpply(f, 'name', transform, sum_qty = sum(qty), pct_qty = round((qty*100)/sum(qty),2))

# dplyr() : plyr()와 동시에 사용한다면 충돌의 위험성
# 얘만이 사용하는 특성 함수가 있음
# 1. filter : 조건을 줘서 필터링, 행출력
# 2. select : 특정컬럼만 선택
# 3. arrange : 정렬
# 4. mutate : 새로운 변수 생성
# 5. summarise(with group_by) : 주어진 데이터를 집계(min, max, mean, count)

install.packages("dplyr")
library(dplyr)

d1 = read.csv('야구성적.csv')
d1
View(d1)

# filter
# 경기 수가 120경기 이상인 선수
d2 = filter(d1, 경기>=120)
d2

# 경기수가 120경기 이상이면서 득점도 80점 이상인 선수
d3 = filter(d1, 경기>=120 & 득점>=80)
d3

# 포지션이 1루수가이거나 3루수인 선수
d4 = filter(d1, 포지션=='1루수' | 포지션=='3루수')
d4
# 위 아래 같은 코드
d4 = filter(d1, 포지션 %in% c('1루수', '3루수'))
d4

# select
# 선수명, 포지션, 팀 데이터만 조회
select(d1, 선수명, 포지션, 팀)

# 순위~타수까지 조회
select(d1, 순위:타수)   # 연속된 데이터를 가져올 때는 :(콜론) 사용

# 특정 컬럼제외
select(d1, -홈런, -타점, -도루)   # 이럴 경우 -한 칼럼들 제외하고 다 나옴

# %>% : 여러 문장을 조합해서 사용할 때 쓰는 기호
# 선수명, 팀, 경기, 타수를 조회하되 타수가 400이상인 선수
d1 %>%
  filter(타수 >= 400) %>%
  select(선수명, 팀, 경기, 타수)

# arrange
d1 %>%
  filter(타수 >= 400) %>%
  select(선수명, 팀, 경기, 타수) %>%
  arrange(타수)
# 내림차순으로 출력하고 싶을 시 아래 코드 형식으로 작성
d1 %>%
  filter(타수 >= 400) %>%
  select(선수명, 팀, 경기, 타수) %>%
  arrange(desc(타수))


# mutate _ 얘는 새로운 변수를 생성하는 함수임
d1 %>%
  select(선수명, 팀, 경기, 타수) %>%
  mutate(경기X타수 = 경기*타수) %>%
  arrange(desc(경기X타수))


# 안타율 컬럼생성 : 안타/타수 구해서 할푼리로 출력 _ 소수점 3째자리까지 출력이기 때문 중간에 3넣어줘야 함
de1 %>%
  select(선수명, 팀, 경기, 안타, 타수) %>%
  mutate(안타율 = round(안타/타수,3) %>%
  arrange(desc(안타율))


# summarise _ 얘는 group_by를 무조건 써야하는 형태임
# 팀별로 평균 경기 횟수
d1 %>%
  group_by(팀) %>%
  dplyr::summarise(avg = mean(경기, na.rm=T))

d1 %>%
  group_by(팀) %>%
  dplyr::summarise(across(경기, mean)

d1 %>%
  group_by(팀) %>%
  dplyr::summarise(across(경기, ~mean(., na.rm = T)))

# 여러 칼럼을 대상으로 집계
# 티미별로 경기와 타수의 평균
d1 %>%
  group_by(팀) %>%
  dplyr::summarise(across(c(경기, 타수), mean))
                   
d1 %>%
  group_by(팀) %>%
  dplyr::summarise(across(c(경기, 타수), ~mean(., na.rm = T)))
