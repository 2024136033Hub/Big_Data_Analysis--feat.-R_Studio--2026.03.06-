setwd("C:/r_data")
Sys.setlocale('LC_ALL', 'Korea')

install.packages("lubridate")   # 버전 업뎃하면서 없어져서 다시 씀씀
library(lubridate)



# 서로 다른 데이터타입 처리 객체
# 1. list
# - 백터와 비슷한 형태(키, 값)으로 저장


l1 = list(name = '홍길동',
          addr = '서울',
          tel = '010-1111',
          pay = 500)
l1


# 특정 키만 조화
l1$addr   # $를 붙이면 l1이 가지고 있는 키들을 보여줌 >> 이런 식으로 얘네들이 가지고 있는 키 혹은 컬럼을 확인 가능함

          
# list 에 요소 추가/삭제
l1$brith = '2026'
l1$brith

l1$name
l1$name = c('고길동', '마이콜')
l1$name
l1$name[length(l1$name)+1] = '둘리'   # 인덱스를 이용해 삽입하는 방법
l1$name


# append() 사용
l1$name = append(l1$name, '홍길동', after=1)
l1$name



# list 삭제
# 1. 특정값을 삭제
l1$name[length(l1$name)-1]=NA  # 끝에서 2번째꺼 삭제, 다만 삭제되기 때문에 값이 비어있을 수 밖에 없기 때문에 비어있다고 표현하기 위에 뒤에 =NA를 넣어줘야한다고 함
l1$name


# 2. 리스트 키 삭제
l1$brith = NULL     # 뒤에 삭제를 원하는 리스트 키에 =NULL을 붙여  삭제시킬 수 있음 >> 그래서 해당 줄 명령어 사용시 l1$를 사용하면 birth가 삭제되는 걸 확인할 수 있음


# 2. dataframe
# 2-1. 각 컬럼(라벨)별로 먼저 생성 후 data.frame으로 모든 컬럼을 합친다
no = c(1,2,3,4)
name = c('Apple','Banana','Peach','Grape')
price = c(500,200,100,300)
qty = c(5,2,3,7)

sales = data.frame(NO=no, NAME=name, PRICE=price, QTY=qty)
sales
class(sales)
str(sales)


# 2-2. 행렬로 생성
sales2 = matrix(c(1, 'Apple', 500, 5,
                  2, 'Peach', 200, 2,
                  3, 'Banana', 100, 4,
                  4, 'Grape', 50, 7), 4, by=T)
sales2
d1 = data.frame(sales2)
d1

names(d1) = c('NO','NAME','PRICE','QTY')
d1


# 데이터 조회
sales
sales$NAME
sales[1,3]  # sales 1행의 3열 출력
sales[,2]
sales[3,]
sales[c(1,3),]
sales[,c(2,4)]
sales[,c(1:3)]


# 원하는 조건만 검색 : subset()
subset(sales, qty <= 5)
subset(sales, price == 200)
subset(sales, name == 'Apple')


# 데이터추가/합치기 : rbind(), cbind(), merge()
no = c(1,2,3)
name = c('apple','banana','peach')
price=c(100,200,300)

df1 = data.frame(No=no, Name=name, Price=price)
df1

no = c(10,20,30)
name = c('train','car','ship')
price = c(1000,2000,3000)
df2 = data.frame(No=no, Name=name, Price=price)
df2

df3 = cbind(df1, df2)
df3

df4 = rbind(df1, df2)
df4

df5 = data.frame(name=c('apple','banana','cherry'), price=c(300,200,100))
df6 = data.frame(name=c('apple','cherry','berry'), qty=c(10,20,30))
cbind(df5, df6)
rbind(df5, df6)   # 얘 같은 경우 이름이 일치하지 않는다고 뜸;;

merge(df5,df6)    # 얘같은 경우 합쳐지는 게 합집합적으로 합쳐져서 apple과 cherry만 남음
merge(df5,df6,all = T)  # 그래서 다 나오게 하려면 이런 식으로 all = T를 뒤에 붙여야 함





# 문제1) no(번호)가 4, 5이고, 이름이 'mango', 'berry'와 가격이 각 400, 500인 데이터 생성 후 df1행 추가
df1

n1 = data.frame(NO = c(4,5), NAME = c('mango', 'berry'), PRICE=c(400,500))
df1 = rbind(df1,n1)
df1

# 문제2) qty(수량)이 (10,20,30,40,50)인 데이터를 열추가 하시오
df1 = cbind(d1,qty=c(10,20,30,40,50))
df1

class(df1)
str(df1)
# >> 3개의 데이터가 갖는 값..?과 3개의 변수가 있는 걸 확인할 수 있음






# 데이터 수정 : 
install.packages("dplyr")   # 패키지 설치_검색한 결과, 데이터 전처리 및 조작을 빠르고 쉽게 할 수 있도록 돕는 패키지라고 함
library(dplyr)

# 업뎃 전이라서 업뎃하려고 적음_아래 3줄은 보지 말기
#install.packages("installr")
#library(installr)
#check.for.updates.R()

df1 = data.frame(var1=c(1,2,1),
                 var2=c(2,3,3))
df2=df1

df2 = rename(df2, v2=var2)    # rename은 많이 쓴다고 하심
df2


# 변수 조합해서 파생 변수 만들기
df1

df1$var_sum = df1$var1 + df1$var2
df1

install.packages("ggplot2")   # 그래프나 차트를 그릴 때 사용함
library(ggplot2)

mpg
View(mpg)   #V는 무조건 대문자

class(mpg)
str(mpg)
head(mpg)
tail(mpg)

mpg1=mpg
mpg1 = rename(mpg1, city=cty)
mpg1

mpg1 = rename(mpg1, highway=hwy)
View(mpg1)

setwd("C:/r_data")


# scan() : 텍스트 파일을 읽어
s1 = scan('scan_1.txt')
s1
s1[2]

s2 = scan('scan_2.txt')
s2

s2 = scan('scan_2.txt', what='')  # 이럴경우 문자열로 변환되어서 출력함
s2

s3 = scan('scan_3.txt')
s3

s3 = scan('scan_3.txt',what = '')
s3

s4 = scan('scan_4.txt',what = '')
s4

input = scan()
input
input[3]

input2 = readline() # readline()를 이용해 뛰어쓰기를 포함한 값을 받을 수 있음
input2

input2 = readline("R U OK? ")
input2



# readLines() : 파일을 읽어서 벡터에 저장
input3 = readLines('scan_4.txt')
input3


# read.table() : 데이터를 읽어서 데이터프레임에 저장
# - 주석이나 공백을 제외하고 읽는다
# 기본적으로 컬럼명이 없다고 판단

f = read.table('fruits.txt')
f

f = read.table('fruits.txt', header = T)  # header를 붙여줘야 컬럼명 나옴 >> header를 안 붙인 위의 경우 컬렁명이 V1, V2 이런식으로 나옴
f

f2 = read.table('fruits_2.txt')
f2

f2 = read.table('fruits_2.txt', skip=2)   # skip대상 같은 경우, 주석줄도 포함시킴
f2

f2 = read.table('fruits_2.txt', nrow=2)   # nrow는 주석 제외하고 측정함
f2

f2 = read.table('fruits_2.txt', skip=2, nrow=2)
f2


# read.csv() : csv파일 읽기
# read.table()와 다르게 기본적으로 컬럼명이 있다고 판단

f3 = read.csv('fruits_3.csv')
f3

f3 = read.csv('fruits_4.csv')
f3

f3 = read.csv('fruits_4.csv', header = F)
f3

lab = c('NO','NAME','PRICE','QTY')
f3 = read.csv('fruits_4.csv', header = F, col.names = lab)
f3
# 프로그래밍 언어에서는 쓰는 걸 저장하는 의미로도 쓰인다고 함


# read.csv() -> write.csv(), read.table() -> write.table(), readLines() -> write()
t = read.csv('csv_test.txt')
t
write.csv(t, 'csv_t.csv')
t1 = read.csv('csv_t.csv')
t1


t2 = read.table('csv_test.txt', sep=',')
t2

t2 = read.table('csv_test.txt', sep=',', header = T)
t2

