# word cloud2
# install.packages("wordcloud2") 

# library
library(wordcloud2) 

# have a look to the example dataset
head(demoFreq)

wordcloud2(demoFreq, size=1.6)

# change color
# Gives a proposed palette
wordcloud2(demoFreq, size=1.6, color='random-dark')

# or a vector of colors. vector must be same length than input data
wordcloud2(demoFreq, size=1.6, color=rep_len( c("green","blue"), nrow(demoFreq) ) )

# Change the background color
wordcloud2(demoFreq, size=1.6, color='random-light', backgroundColor="black")

# letter shape
letterCloud( demoFreq, word = "R", color='random-light' , backgroundColor="black")
letterCloud( demoFreq, word = "PEACE", color="white", backgroundColor="pink")