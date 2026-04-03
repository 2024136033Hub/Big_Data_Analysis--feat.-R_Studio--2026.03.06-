set("C:/r_data")
Sys.setlocale('LC_ALL', 'Korean')

# 데이터 처리 객체
# - 동일 데이터 타입
# 1. 스칼라 : 단일 데이터 처리
# 2. 백터 : 1차원 배열(= 스칼라를 여러 개 합친 것)
# 3. matrix : 2차원 배열(= 벡터를 여러 개 합친 것)
# 4. array : 3차원 배열(= matrix를 여러 개 쌓아올린 것)
# 
# - 다른 데이터 타입
# 1. list : 벡터와 비슷(python의 list랑 다르고 오히려 python의 dictionary랑 유사함-(키, 값) 형태)
# 2. dataframe : 엑셀의 표나 DB의 테이블과 같음(DB의 컬럼처럼 라벨이 있음_숫자 문자 들어가는 거 가능)

# 백터 : 1차원 배열
# 1. c() 함수로 작성 _  C함수_컴바인 함수
# 2. 인덱스는 1부터 시작
# 3. 하나의 자료형만 사용
# 4. 결측값은 'NA'로 사용
# 5. NULL은 어떤 형식도 취하지 않는 특별한 객체

c(1,2,3,4,5)  # 백터
c(1,2,'3',4,5)  #숫자와 문자가 같이 있으면 다 문자로 변함

v1 = c(1,2,3,4,5)
v1
v1[1]
v1[0] # 0번지 사용 불가
v1[-3]  # 파이썬은 역방향으로 해서 3만 출력되는데 R은 3만 제외하고 출력함
v1[3]   # -가 없어서 해당 위치 값으로 출력

length(v1)

# 문제) v1의 첫번째 인덱스에서부터 끝에서 세번쨰 인덱스까지의 값을 출력하시오.
# 단, length()를 이용할 것.
v1[1:3]
v1[1:(length(v1)-2)]  # 옳은 정답

v1[-1:3]  # 얘는 사용불가함
v1[-1:-3]

v1[2:4]
v1[2] = 6
v1

v1 = c(v1,7)
v1

v1[9] = 9   # 7번지와 8번지를 비워두고 만들다보니 값이 없어서 NA(=사용할 수 없는 값)로 표시됨
v1


v1 = append(v1, 10, after=3)  # 옵션은 after
append(v1, c(11,12), after=4)

append(v1, 12, after = 0)



# 벡터 연산
c(1,2,3) + c(4,5,6)
c(1,2,3) + 1

v1 = c(1,2,3)
v2 = c(4,5,6)
v1+v2

union(v1,v2)  # 합집합 결과로 나옴

v3 = c(1,2,3,4,5)   # 두 벡터의 길이가 다른 경우 순환 원리가 적용
v1+v3

v1 = c(1,2,3)
v2 = c(3,4,5)
v1-v2

setdiff(v1, v2) #setdifference    # 차집합
intersect(v1,v2)  # 교집합

# 벡터의 각 컬럼에 이름 지정 가능
f = c(10,20,30)
f


names(f) = c('apple', 'banana', 'peach')
f

# 함축어로 함수를 만드는 경우도 있다고 함;;


# 벡터에 연속적인 데이터 할당 가능함 >> seq(),rep() _ 얘는 replicate임 repeat 아님 주의!!

v4 = c(1:5)   # 컴바인은 :
v4

v5 = seq(1,5)   # 시퀀스는 ,
v5

v6 = seq(-2, 2)
v6

c6 = c(-2:2)
c6

v7 = seq(1, 10, 2)
v7

v8 = rep(1:10, 2)  # 1~10까지 2번 복제하라
v8

v8 = rep(1:10, each=2)
v8



# 벡터의 길이
v1
length(v1)
NROW(v1)  # 어떤 단어 앞에 n이 붙는다면 갯수를 의미함 >> 그래서 여기서는 행의 갯수 의미 || 저장되는 값들은 컬럼을 통해 저장되는 것 같음..?



# 벡터의 특정 문자 포함 여부

v7
3 %in% v7   #v7안에 3이 있는 지 확인
4 %in% v7


# matrix
# 1. 벡터를 여러개 합친 형태 : 형렬
# 2. 모든 컬럼과 행은 동일한 타입을 가짐
# 3. 기본적으로 열로 생성
# 4. 다른 데이터타입의 데이터를 저장할 경우, 데이터 프레임 사용

m1 = matrix(c(1,2,3,4))
m1
NROW(m1)  # 위에서 4개를 넣었기 때문에 m1 출력 시 4줄로 나옴

m2 = matrix(c(1,2,3,4), nrow = 2)
m2

m3 = matrix(c(1,2,3,4), nrow = 2, byrow = T)
m3

m4 = matrix(c(1,2,3,4), 2, by = T)    # 생략 가능 _ m3이랑 같은 말
m4

m4[1,1]
m4[2,1]
m4[,1]
m4[1,]

m4 = matrix(c(1,2,3,
              4,5,6,
              7,8,9), 3, by = T)   # 이런식으로도 생성 가능
m4


# 새로운 행과 열 추가 : rbind() _ 행 묶어줌 = 행 추가   || cbind() _ 열 묶어줌 = 열 추가
m4

m4 = rbind(m4, c(11,12,13))
m4

m4 = cbind(m4, c(20,21,22)) # 이런 경우, 칸이 안 맞아 순환원리를 이용해 값을 채워줌
m4

m4 = rbind(m4, c(15,16,17,18,19))
m4



# 행, 열 이름 지정
# 메트릭스에서 이름 바꿀 떄는 colnames로 바꿈, 행 이름은 rownames
rownames(m4) = c(1,2,3,4,5)
m4

colnames(m4) = c('1st', '2nd', '3rd', '4th')
m4


# matrix 사용
m1 = matrix(1:20, 4, by=T)
m1

dimnames(m1) = list(c(1,2,3,4), c('a','b','c','d','e'))
m1


# 색인(=인덱싱)
m1[2,3]
m1[-3,]   # 3행 빼고 모든 행렬 출력

# 행렬조건
m1 >= 10
m1

# 10 이상인 원소 출력
m1[m1>=10]

# m1의 c열의 값이 10이상인 행 출력
m1[, 'c'] >= 10
m1[m1[, 'c'] >= 10, ]


# m1의 e값이 20인 행의 3~5번째의 컬럼 출력
m1[m1[,'e']==20, 3:5]



# matrix 문제
no = c(1,2,3,4)
name = c('apple', 'banana', 'peach', 'berry')
price = c(500,200,200,50)
qty = c(5,2,7,9)

no
name
m1 = cbind(no, name, price, qty)
m1

# 1. peach 가격 출력
m1[m1[,'name']=='peach', 'price']

# 2. apple과 peach의 데이터만 출력
m1[m1[, 'name']=='apple' | m1[, 'name']=='peach',]

# 3. sales라는 컬럼 생성(단, sales는 price*qty)
sales = m1[,'price']*m1[,'qty']
sales = as.numeric(m1[,'price'])*as.numeric(m1[,'qty'])
sales
cbind(m1,sales)

# 4. 첫번째 컬럼제거 후 각 행번호 설정
rownames(m1) = m1[,1]     # 1열의 이름으로 바꾼다는 의미
m1
m1 = m1[,-1]
m1

# 5. qty가 5이상인 과일 이름 출력
m1[m1[,'qty']>=5, 'name']
# matrix를 벡터로 구성한 후 비교연산으로 원소를 추출 시,
# 1차원 벡터로 리턴을 함(행렬 고조를 잃어버린다)

# 6. 5번째 과일추가(mango, 100원, 10개)
v1 = c('mango', 100, 10)
m1 = rbind(m1, v1)    # 행으로 들어가니 rbind
m1
rownames(m1)[5]=5   # m1에 있는 5번째 줄의 이름을 5로 바꾸라는 의미



# array : 3차원 배열(행, 렬 높이)
# matrix를 쌓아 놓은 형태

a1 = array(c(1:12), dim=c(3,4))     # dim은 dimansion..?인듯
a1

a2 = array(c(1:12), dim=c(2,2,3))
a2 = array(c(1:12), dim=c(2,2,3), by=T)   # 얘는 안됨
a2

a2[1,1,3]

a3 = matrix(1:12, 2, by=T)    # ??
a3 = array(c(1:12), dim=c(2,2,3))
a4 = array(a3, dim=c(2,2,3))    # ??
a4 = aperm(a3, c(2,1,3))
a4


