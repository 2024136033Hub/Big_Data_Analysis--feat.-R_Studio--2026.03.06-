setwd("C:/r_data")
Sys.setlocale("LC_ALL", "Korean_Korea.UTF-8")

library(lubridate)
library(dplyr)
library(plyr)
library(ggplot2)
library(googleVis)
library(stringr)


# ggplot2 : plot()함수의 확장 버전
# ggplot(dataframe, aes(x=x축 데이터, y=y축데이터)) + geom_함수

# geom 부분 설정 값
# - stat : 주어진 데이터에서 geom에 필요한 데이터를 생성한다
# - stat_bin : 아래와 같은 데이터를 갖는 dataframe 출력
#   1. count : 각 항목의 빈도수
#   2. density : 각 항목의 밀도수
#   3. ncount : count와 같으나 값의 범위가 (0,1)로 스케일링 됨


kor = read.table("학생별국어성적_new.txt", header = T, sep = ",", fileEncoding = "euc-kr")
kor
ggplot(kor, aes(x=이름, y=점수))+geom_point()

# geom_bar() : barplot과 비슷한 역할

ggplot(kor, aes(x=이름, y=점수)) + geom_bar(stat = 'identity')
gg1 = ggplot(kor, aes(x=이름, y=점수)) + geom_bar(stat = 'identity', color='red', fill='green')
gg1+theme(axis.text.x = element_text(angle = 45,
                                     hjust = 1, vjust = 1,
                                     color = 'blue', size = 8))

kem = read.csv("학생별과목성적_국영수_new.csv",
               fileEncoding = "euc-kr")
kem

library(plyr)
skem2 = arrange(kem, 이름, 과목)
skem2

skem2 = ddply(skem, '이름', transform, 누적합계=cumsum(점수))
skem2       # 48번째 줄부터 씀

skem3 = ddply(skem2, '이름', transsform, 누적합계=cumsum(점수),
              lebal=cumsum(점수)=0.5*점수)
skem3

gg2 = ggplot(skem3, aes(x=이름, y=점수, fill = 과목)) + 
  geom_bar(stat='identoty', position_stack(reverse = T)) +
  geom_bar(aes(y=label, label=paste(점수,'점')), color='black', size=4)

gg2+theme(axis.text.x =element_text(angle = 45, hjust = 1,
                                    vjust = 1, color = 'black',
                                    size = 8))+guides(fill=guide_legend(reverse))

install.packages("gridExtra")
library(gridExtra)
mtcars
mt=mtcars

# geom_point()
g1 = ggplot(mt, aes(x=hp, y=mpg))
g1+geom_point()

g2=g1+geom_point(color='blue')
g2

g3=g1+geom_point(aes(color=factor(am)))
g3

View(mt)

g4=g1+geom_point(size=7)
g4

g5=g1+geom_point(aes(size=wt))
g5

g6=g1+geom_point(aes(shape=factor(am), size=wt))
g6

g7=g1+geom_point(aes(shape=factor(am), size=wt, color=factor(am)))
g7

g8=g1+geom_point(aes(shape=factor(am), size=wt, color=factor(am))) +
  scale_color_manual(values = c('red', 'green'))
g8

g9=g1+geom_point(color='blue')+geom_line()
g9

g10=g1+geom_point(color='blue')+geom_line()+labs(x='마력', y='연비')
g10



# geom_line()
th = read.csv("학생별과목별성적_3기_3명.csv", fileEncoding = "euc-kr")
th

ss=arrange(th, 이름, 과목)
ss

ggplot(ss, aes(x=과목, y=점수, group = 이름, color=이름)) + 
  geom_line()+
  geom_point(size=6, shape=22)    # shape : 0~25





install.packages("multilinguer")
library(multilinguer)

install.packages("remotes")
library(remotes)



install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = 'binary')
remotes::install_github("haven-jeon/KoNLP", upgrade='never',
                        INSTALL_opts=c("--no-multiarch"), force=TRUE)


# github 끌어오려다가 다른 교수님께서 해당 기기에 수업해서 생긴 git으로 인해 git 충돌 이슈로 담주에 수업 이어서 나감

library(tidyverse)
library(tidytext)
library(wordcloud2)
library(stringr)
library(wordcloud)


txt = readLines("BTS유엔연설_국문.txt")
txt

# 데이터 프레임으로 변환
df <- data.frame(text = txt)

# 단어 분리
words = df %>%
  unnest_tokens(word, text)


# 한글만 추출 + 2글자 이상
words <- words %>%
  filter(str_detect(word, "[가-힣]")) %>%
  filter(nchar(word) >= 2)

# 빈도 계산
freq <- words %>%
  dplyr::count(word, sort = TRUE)

freq


wordcloud2(freq, size=1, color="random")




