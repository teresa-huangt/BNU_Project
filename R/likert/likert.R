 
# install
install.packages("xlsx")
install.packages("foreign")
install.packages("Scale")

# reading in data
# from excel # row1 as label!?
library(xlsx)
 my_data <- read.xlsx("F:/Work/OTHER/R/likert/test.xlsx", sheetIndex=1)

# from spss no try
 library(foreign)
 my_data <- read.spss("YourDataFileHere.sav", to.data.frame=T)
 
 # 
 library(Scale)
 my_scale <- Scale(my_data)
 

 # reverse item
 my_scale <- Scale(my_data, reverse=c(1))
 
 # add labels
 # my_scale <- Scale(my_data, col_names= paste('q', 1:20, sep=''))
 # "paste" will create a vector such as c("q1", "q2", ..., "q20")
 my_scale <- Scale(my_data, col_names= c("q11","q12","q13","q14","q15","q21","q22","q31","q32","q33"))
 
 
 # ****************merge****************************************************** 
 my_scale <- Scale(my_data, reverse=c(1), col_names= c("q11","q12","q13","q14","q15","q21","q22","q31","q32","q33"))
 
 
 # pre-process
 my_scale_pr <- PreProc(my_scale)
 
 # analysis
 my_scale_it <- ItemAnalysis(my_scale_pr)
 
 # report
 my_table <- ReportTable(my_scale_it)
 
 