setwd("C:/r_data")
Sys.setlocale('LC_ALL', 'Korean')
Sys.setlocale("LC_ALL", "Korean_Korea.UTF-8")

library(lubridate)
library(dplyr)
library(plyr)
library(ggplot2)
library(googleVis)



# 조건문, 반복문
# 비교연산자 : ==, !=, >=, <=, >, <
# 
# 조건문
# if(조건식) : 조건식 1개, 조건이 참인 경우에만 실행문
# 
# if(조건식) {
#   조건식이 참인 경우 실행문
# } else {
#   조건식이 거짓인 경우 실행문
# }
# 
# 절대값 구하기

my1 = function(x) {
  if (x < 0)  {
    return(-x)
  } else {
    return(x)
  }
}

my1(-1)
my(1)


# if(조건식1) {
#   조건식 1이 참인 경우 실행문
# } else if(조건식2) {
#   조건식 2가 참인 경우 실행문
# } ..... {
#   조건식 n이 참인 경우 실행문
# } else {
#   모든 조건식이 거짓인 경우 실행문
# }
# 
# 문제1) 입력된 숫자가 0보다 크면 2배의 값을 출력하고 0일 경우 0을 출력하고
# 0보다 작을 경우 1/2 배의 값을 출력하는 문장을 만드세요

my2 = function(y) {
  if (y > 0) {
    return(2*y)
  } else if (y == 0) {
    y = 0
  } else {
    y = y*1/2
  }
  return(y)
}

my2(3)
my2(0)
my2(-3)


# ifelse(a, b, c) : a가 참이면 b를 실행, 거짓이면 c를 실행
# 홀, 짝

no = scan()   # 해당 줄 코드 실행 후, console에 아래 함수에 넣을만한 수를 넣어주고 enter 누르면 된다고 함..?
ifelse(no %% 2 == 0, '짝', '홀')

if (no %% 2 == 0) {
  print('짝')
} else {
  print('홀')
}

# 서로 다른 두 개의 숫자를 입력받아서 두 숫자 사이에 존재하는 숫자의 갯수를 구하여라
n1 = scan()
n2 = scan()
ifelse(n1 > n2, n1-n2-1, n2-n1-1)

no = scan()
ifelse(no[1] > no[2], no[1]-no[2]-1, no[2]-no[1]-1)



# 반복문
# while : 조건이 있는 경우

no = 0
while(no < 5){
  print(no)
  no = no+1
}



# break : 해당 반복문을 빠져나와라(종료)

x = 1
while (x < 5) {
  x = x+1
  if (x == 4) {
    break
  }
  print(x)
}


# next : 해당 반복문을 빠져나와서 다시 조건식으로 분기

x = 1
while (x < 5) {
  x = x+1
  if (x == 4) {
    next
  }
  print(x)
}


# for : 반복의 횟수가 지정되어 있는 경우
# 정수 n을 입력받아서 1부터 n까지의 합계

my3 = function(n) {
  i = 0
  for(j in 1:n) {
    i = i+j
  }
  print(i)
}

my3(10)


# 반복문의 실제 사용
# 특정 변수에 들어있는 값이10이상이면 colors 값에
# 'red'를 넣고 6~9까지면 'yellow'를 넣고 그 이하면 'green'을 넣는 예제
colors = c()
for (i in length(x)) {
  if (x[i] >= 10) {
    colors = c(colors, 'red')
  } else if (x[i] >= 6) {
    colors = c(colors, 'yellow')
  } else {
    colors = c(colors, 'green')
  }
}


# 여러 조건 동시에 지정
# ! : not
# &&(&) : and
# ||(|) : or

# 문제2) 두 개의 숫자를 입력받은 후 주 값이 모두 양수일 경우 두 수의 곱을 출력하고
# 두 값 중 하나라도 0이나 음수일 경우는 두 수의 합을 출력하세요.

my4=function(a,b) {
  if ((a >= 1) && (b >= 1)) {
    c = a*b
  } else {
    c = a+b
  }
  return(c)
}


my4(2,3)
my4(0,2)
my4(-1,3)



# 특정 패턴만 골라내기
# grep(패턴, 벡터) : 벡터에서 특정패턴을 찾아 그 위치 출력

c1 = c('apple', 'Apple', 'APPLE', 'banana', 'grape')
grep('apple', c1)

c2 = c('apple', 'banana')
grep(c2, c1)  # 이 코드를 사용 시 console창에
"grep(c2, c1)에서:
인자 'pattern'는 반드시 길이가 1 보다 커야 하고, 오로지 첫번째 요소만이 사용될 것입니다" 뜸 

grep(paste(c2, collapse = '|'), c1)     # collapse = '|' : 두 가지 패턴을 동시에 찾을 때 사용
grep(paste(c2, collapse = '|'), c1, value = T)

grep('pp', c1)
grep('pp', c1, value = T)   # 소문자랑 대문자로 쓴 apple이 있다는 걸 보여줌

grep('^A', c1, value = T)   # 대문자 A로 시작하는 거 찾아줌 _ ^A
grep('e$', c1, value = T)   # 소문자 e로 끝나는 거 찾아줌 _ e$

c2 = c('grape1', 'apple1', 'apple', 'orange', 'Apple')
grep('[1-9]', c2, value = T)
grep('[[:upper:]]', c2, value = T)


# nchar() : 입력된 배열이나 문자열의 길이 나타냄
c1
nchar(c1)

install.packages("stringr")
library(stringr)

str_length(c1)

nchar('홍길동')
nchar('a b')


# paste('a', 'b', 'c') : a,b와 c를 합쳐서 하나의 문자열처럼 출력 _ paste의 합치다라는 의미 그대로 임
paste('홍', '길', '동')   # 합쳐지는 데 각각 사이에 공백이 생김 >> 그러므로 아래의 str_c를 사용하면 공백이 없어짐
str_c("홍", "길", "동")   # '랑 "는 차이 없는 것 같음

paste('홍', '길', '동', sep='')
paste('홍', '길', '동', sep='-')  # 글자 중간 중간에 - 들어감 _ sep= 사용으로 그러는 거
paste('I', '\'m', ' a boy', sep='')


# substr('a', 시작위치, 끝나는위치) : 특정부분만 골라내기
substr('abc123', 3,3)
str_sub('abc123', 3,3)

substr('abc123', 3,5)


# strsplit('문자열', split='기준 문자') : 특정 글자를 기준으로 분리
strsplit('2026/04/17', split = '/')

# regexpr(패턴, 문자열) : 특정 패턴을 찾기
grep('-', '010-1111-2222')
regexpr('-', '010-1111-2222')   # 위보다 좀 더 상세하게 정보를 줌








######################################################################################
# 
# - 벡터와 조건문 혼합 코드 작성
# 
# - 형변환 연산자 함수 활용 코드 작성
# 
# - 데이터프레임 활용 함수 코드 작성
# 
# - matrix 활용 함수
# 아래와 같은 m1의 이름으로 matrix가 주어졌을 때 apple과 peach의 데이터만 출력 출력하는 코드를 작성하시오
#
# - list 활용함수 
# 아래와 같이 l1의 이름으로 list를 생성하였을 때 l1의 name키에서 "이순신의 값을 삭제하는 명령문을 작성하시오(단, length를 사용하여라)
l1 = list(name="홍길동", "이순신", "유관순",
          addr="서울",
          tel="010-1111-1111",
          pay=500) 
# 
# 정답)
l1$name[length(l1$name)-1]=NA
l1$name
# 
# - subset함수
# 다음과 같은 벡터가 있을 때 세 벡터를 하나로 묶어 데이터프레임 df에 저장한 후 blood 열이름 값이 'B'가 아닌 행들을 추출해 df.nb에 저장하는 코드를 작성하시오
blood <- c('A','O','AB','B','B')
rh <- c('+','+','-','+','+')
age <- c(21,30,43,17,26)
# 
# 정답)
df = data.frame(blood, rh, age)
df.nb = subset(df,blood != 'B')
#
# 
######################################################################################







# 아래꺼는 수업 시작 전 적으셨는데.. 맨 처음에 왜 적으신거지;;;;;
# if(조건식2) {
#   조건식1이 참인 경우 실행문
# } else if(조건식2) {
#   조건식2가 참인 경우 실행문
# } ..... {
#   조건식 n이 참인 경우 실행문
# } else {
#   모든 조건식이 거짓인 경우 실행문
# }
# 
# 


