install.packages("installr")
library(installr)
updateR()

print(100)
100

print('100')
"100"

print(100+100)
100+100


#  --------------------------  3주차  ------------------------------------------
d1 = 100
class(d1)

d1 = '100'
class(d1)

print(1)
print(1, 2) // 한개만 출력됨
print('1', '2')

cat(1, ':', 'a', '\n', 2, ":", 'b')


# 1. 숫자형
a = 120

a <- 130  # 등호와 의미 동일

a = 1:20  # 1~20까지 배열 느낌으로 저장하는 것 같음
a
a[1]
a[12]
a[20]

a = 3+(4*5)
a

1+2; 2*3; 4/5


# 산술연산자
#  +, -, *, **, ^(캐럿)
2**3
2^3

# 나누기
# / : 나누기 결과를 실수 값으로 표현
# %/% : 몫
# %% : 나머지
 
5/2
5%/%2
5%%2 

10000
100000
1e2
3e3
3e-2

'1' # 식은 문자형
'1' + '2' #이항연산자에 수치가 아닌 인수입니다라는 결과가 나오면서 에러 발생함

# 강제형변환 : as.~  하면 바뀐다고 함
# ex) int형, float형, double형 ... ...
as.numeric('1') + as.numeric('2')   # numeric 실수형인듯..?


# 2. 문자형
# 'first'
first = 'a'
class(first)


# 3. 진리값 : TRUE/FALSE
# & : AND연산 (모두가 참인 경우 >> 참)
# | : OR연산 (하나라도 참이면 참)
# ! : NOT연산 (반전)

3&0
3&-2  # r에서는 0만 거짓임
0.3&-2

3|0
0|0

!0


# 4. NA/NULL
# NA : 잘못된 값이 들어올 경우(Not applicable, Not Available) 얘네를 결측치라고 하고 나중에 제거하거나 살려서 쓴다고 함
# NULL : 값이 없는 경우

cat(1, NA, 2)
cat(1, NULL, 2)

sum(1, NA, 2)
sum(1, NULL, 2)


# 5. factor형 : 여러번 중복되어 나오는 데이터들을 각 값으로 모아서 대표값을 출력함
# csv : 데이터 또는 컬럼을 구분하는 구분자를 ,로 해놓은 파일

# 디렉토리 설정해줘야지 파일을 불러올 수 있음
setwd("C:/r_data")
Sys.setlocale('LC_ALL', 'Korean')
getwd() # 얘는 못 넣어도 111줄 코드랑 112줄 코드는 들어가야 함


t1 = read.csv("factor_test.txt")
t1

class(t1)
str(t1)

f1 = factor(t1$blood)
f1

summary(f1)


# 문제) 위 자료의 성별을 요약하기
f2 = factor(t1$sex)
f2
summary(f2)


# 6. 날짜와 시간
# 6-2. Base패키지로 날짜 시간 제어
Sys.Date()
Sys.time()
date()

"2026-03-20"
class("2026-03-20")


# 문제) "2023-03-10"의 문자데이터를 날짜 데이터로 바꾸고 타입을 확인하시오.

class(as.Date("2026-03-20")

as.Date("03-20-2026")

# 날짜형태 지정
# %d : 일일
# %m : 월
# %Y : 년(4자리)
# %y : 년(2자리)

as.Date("03-20-2026", format="%m-%d-%Y")
as.Date("032026", "%m%d%y")   # format을 적는 건 취향


# 문제) 다음 데이터를 날짜형으로 변환하여라.
# "2026년 3월 20일"
as.Date("2026년 3월 20일", "%Y년 %m월 %d일")

as.Date(100, "2026-03-20")  #100일 후 날짜 측정
as.Date(-100, "2026-03-20")  #100일 전 날짜 측정
as.Date("2026-03-20")+100  #100일 후 날짜 측정


# 6-2. lubridate 패키지 사용
install.packages("lubridate")
library(lubridate)

d = now()
year(d)
month(d)
day(d)
wday(d, label = T)  # 현재 요일 출력_labal을 사용x >> 요일을 숫자로 알려줌..


d - days(2)) #2일 전의 날짜
d + days(2) #2일 뒤의 날짜

d + years(2) #2년 뒤의 날짜


# 문제) 현재 날짜와 시간에 1년 2개월 3일 4시간 5분 6초를 더해라
d + years(1) + months(2) + days(3) + hours(4) + minutes(5) + seconds(6)

# seq()
seq(as.Date("2026-01-01"), as.Date("2026-12-31"), 1)
seq(as.Date("2026-01-01"), as.Date("2026-12-31"), 'day')
seq(as.Date("2026-01-01"), as.Date("2026-12-31"), 'month')
d = seq(as.Date("2026-01-01"), as.Date("2126-12-31"), 'year')

d[45]
d[35:45]  # 범위값 가져옴
d[c(35,45)]   # 결합할 때 사용

# 변수
v1 = 'aaa'
v1

v1 = 1:10
v1

v1 = 'a', 'b', 'c'  # 변수에 값을 넣어주기 위해서 백터형식만 가능함 >> 그래서 넣어주기 위해서는 컨바인(= c())를 써야함

v1 = c('a', 'b', 'c')
v1
v1[1]
v1[2]
v1[3]   # 결과적으로 각각 배열을 갖고 되는 형식임

v1 = c(1,2,3,4,5)
v1
class(v1)

v2 = c('a','b','c')
v2
class(v2)

v3 = c(1,2,3,4,'5')
v3
class(v3)   #숫자와 문자가 같이 있으면 다 문자가 됨

# 변수 설정시 유의 사항
# 1. 대소문자 구분
# 2. 영어, 숫자 모두 사용가능하지만 시작은 반드시 문자
변수=1
변수

# 3. 예약어는 사용 못한다
# if, else, ifelse, for, while, break, TRUE,  NA, in. seq ... ...

n1 = '1'
n2 = 2
n1 + n2

as.numeric(n1) + n2


# --------------------------------------------------------------------





