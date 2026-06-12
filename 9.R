setwd("C:/r_data")
Sys.setlocale("LC_ALL", "Korean_Korea.UTF-8")

library(lubridate)
library(dplyr)
library(plyr)
library(ggplot2)
library(googleVis)
library(stringr)

install.packages(c(
  "tidyverse", "tidytext", "stringr", "wordcloud", "wordcloud2", "RColorBrewer"
))  # tidy시리즈는 한국어..? 관련, wordcloud는 데이터 분석 및 시각화 관련, RColor은 색상 관련

library(tidyverse)
library(tidytext)
library(stringr)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)



# 1. txt 파일 읽기
d1 = readLines("BTS유엔연설_국문.txt", encoding="utf-8")
d1



# 2. 데이터프레임으로 변환
df = data.frame(txt = d1)



# 3. 단어 추출(KoNLP extractNoun()의 대체)
d2 = df %>%
  unnest_tokens(word, txt)
d2



# 4. 한글만 추출
d3 = d2 %>%
  filter(str_detect(word, "[가-힇]"))
d3



# 5. 단어 길이 필터링
d3 = d3 %>%
  filter(nchar(word) >= 2) %>%
  filter(nchar(word) <= 7)



# 6. 단어핸들링     단점 : 일일히 다 없애줘야 함
d3$word = gsub("\\d+", "", d3$word)
d3$word = gsub("\\.", "", d3$word)   # 마침표를 없앤다는 말
d3$word = gsub(" ", "", d3$word)   # 공백을 없앤다는 말
d3$word = gsub("\\'", "", d3$word)   # 작은따옴표를 없앤다는 말
d3$word = gsub('\\"', "", d3$word)   # 큰따옴표를 없앤다는 말

d3$word = gsub("이", "", d3$word)
d3$word = gsub("들", "", d3$word)
d3$word = gsub("쯤", "", d3$word)

d3$word = gsub("나", "자신", d3$word)
d3$word = gsub("내", "자신", d3$word)
d3$word = gsub("저", "자신", d3$word)

d3



# 7. 빈 문자열 제거
d3 = d3 %>%
  filter(word != "")



# 8. 불용어 제거
stopword_ko = c("그리고", "그러나", "하지만", "합니다",
                "있습니다.", "여러분", "위한", "통해")

d3 = d3 %>%
  filter(!word %in% stopword_ko)



# 9. 단어 빈도수 계산
wc = table(d3$word)
wc

# 상위 20개만 출력
top20 = head(sort(wc, decreasing = TRUE), 20)
top20



# 10. 워드클라우드
pal = brewer.pal(9, "Set3")

wordcloud(names(top20), freq = top20, scale = c(5, 1), rot.per = 0.25,
          min.freq = 2, random.order = FALSE, random.color = TRUE, colors = pal,
          family="Malgun Gonthic")






# 명사 추출 버전

install.packages(c(
  "tidyverse", "tidytext", "stringr", "wordcloud", "wordcloud2", "RColorBrewer"
))  # tidy시리즈는 한국어 관련, wordcloud는 ??관련, RColor은 색상 관련

library(tidyverse)
library(tidytext)
library(stringr)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)


# 1. 라이브러리 로드
# MeCab 기반의 빠른 한글 형태소 분석 라이브러리(명사추출용)
install.packages("RcppMeCab")
library(RcppMeCab)



# 2. 데이터 불러오기
d1 = readLines("BTS유엔연설_국문.txt", encoding = "UTF-8")    # 한글파일을 가져와 열었을 때 한글이 깨질 시 해당파일에 들어가서 utf-8 파일인지 확인해야함
d1

# 텍스트 마이닝을 위해 문자열벡터를 데이터프레임 구조로 변환
# stringsAsFactors = FALSE : 텍스트가 factor데이터로 변환되는 것을 방지
df = data.frame(txt=d1, stringsAsFactors = FALSE)
df



# 3. 명사 추출(형태소 분석)
# RcppMecab::pos() -> 단어와 품사가 붙은 리스트 구조가 반환된다
# 예) "나의" -> 나 :NP + 의 :JKG
pos_res = RcppMeCab::pos(df$txt)

pos_res

d2 = pos_res %>%
  unlist() %>% 
  enframe(name=NULL, value = "pos_token") %>%
  filter(str_detect(pos_token, "/NNG|/NNP")) %>%
  mutate(word=str_remove(pos_token, "/.*")) %>%
  select(word)

View(d2)



# 4. 데이터 정제
d3 = d2 %>%
  filter(str_detect(word, "[가-힣]")) %>%
  filter(nchar(word) >= 2 & nchar(word) <= 7)

d3$word = gsub("^나$|^내$|^저$", "자신", d3$word)  # 나로 시작하고 나로 끝나는 단어..?
d3$word = gsub("^네$|", "너", d3$word)



# 5. 빈도 계산 및 불용어 제거
stop_words_ko = c("여러분", "대한", "위한", "통해",
                  "때문", "합니다", "성", "말", "흠", "말씀")

wc = d3 %>%
  filter(!word %in% stop_words_ko) %>%
  dplyr::count(word, sort=TRUE)

top20 = head(wc, 20)
top20


# 6. 시각화
par(family="Malgun Gothic")
                                #n은 빈도수             #8을 8개색을 의미
wordcloud(words = top20$word, freq = top20$n, colors = brewer.pal(8, "Dark2"),
          random.order = FALSE, random.color = TRUE)

wordcloud(words = wc$word, freq = wc$n,
          colors = brewer.pal(8, "Dark2"),
          random.order = FALSE, random.color = TRUE,
          fontFamily = "Malgun Gothic")

wordcloud2(data = top20, color = "random-light",
           backgroundColor = "black", shape = "star")

wordcloud2(data = wc, color = "random-light",
           backgroundColor = "black", shape = "star")






########################################################
# 사용자 사전 생성
########################################################
user_nouns <-c(
  "성산일출봉",
  "한라산 국립공원",
  #..? 뭐지;;
  
)






























