## WORD CLOUD
# REFERENCE:http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know

# Install
install.packages("tm") # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Read the text file 
text <- readLines(file.choose())
# Load the data as a corpus
docs <- Corpus(VectorSource(text))
# Inspect the content of the document
inspect(docs)

# Replacing ¡°/¡±, ¡°@¡± and ¡°|¡± with space:
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Remove your own stop word
# specify your stopwords as a character vector
# docs <- tm_map(docs, removeWords, c("Äã", "ÎÒ","Ëý")) 

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))


# build a term-document matrix
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

# generate the word cloud
# words : the words to be plotted
# freq : their frequencies
# min.freq : words with frequency below min.freq will not be plotted
# max.words : maximum number of words to be plotted
# random.order : plot words in random order. If false, they will be plotted in decreasing frequency
# rot.per : proportion words with 90 degree rotation (vertical text)
# colors : color words from least to most frequent. Use, for example, colors =¡°black¡± for single color.
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
wordcloud(words = d$word, freq = d$freq, min.freq = 2,
          max.words=200, random.order= FALSE, rot.per=0, 
          colors=brewer.pal(10, "Set3")) # Reds
#The following palettes are available for use with these scales:

#Diverging
#BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral

#Qualitative
#Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3

#Sequential
#Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd
