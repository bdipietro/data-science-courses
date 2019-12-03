library(tidyverse)
library(gutenbergr)
library(tidytext)
library(readr)

options(digits = 3)
data("gutenberg_metadata")

#head(gutenberg_metadata)

pattern <- "+Pride and Prejudice+"

gutenberg_metadata %>% 
  filter(str_detect(title, pattern = "Pride and Prejudice")) %>% 
  nrow()

str_detect(gutenberg_metadata[5,]$title, pattern = "")

gutenberg_works(str_detect(title, pattern = "Pride and Prejudice"), languages = "en", distinct = TRUE, only_languages = TRUE)

pp <- gutenberg_download(1342, mirror="http://aleph.gutenberg.org/")
words <- pp %>% unnest_tokens(word, text, token = "words")
nrow(words)

words_sans_stop <- words %>% filter(!word %in% stop_words$word)

words_sans_stop_digit <- words_sans_stop %>% filter(!str_detect(word, pattern = "\\d"))
words_sans_stop_digit

words_sans_stop_digit %>% group_by(word) %>% summarize(n = n()) %>% filter(n > 100) %>% nrow()
words_sans_stop_digit %>% group_by(word) %>% summarize(n = n()) %>% arrange(desc(n))
