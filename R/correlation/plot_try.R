
library(foreign)
cor<-read.spss("F:/Work/Speech_amusia/amusiaVScontrol/wordandothers-剔除三人算ssdt与tonenback相关显著.sav",use.value.labels=FALSE,to.data.frame=TRUE)
#cor<-read.spss("F:/Work/Speech_amusia/amusiaVScontrol/speech_diffConditions_wmfd_cor/wordandothers2+.sav",use.value.labels=FALSE,to.data.frame=TRUE)
cor<-read.spss("F:/Work/Speech_amusia/amusiaVScontrol/wordandothers2+.sav",use.value.labels=FALSE,to.data.frame=TRUE)

# install.packages("ggplot2")
# ggplot2 examples
 library(ggplot2) 
 qplot(FDfix,FDrov , data = cor, geom = c("point", "smooth"))
 ## compare 3 group meanwhile in different tasks
 # task:
 qplot(factor(group3),FDrov , data = cor, color=factor(group3),alpha=I(1/2.5),size=20)
 qplot(FDfix,FDrov , data = cor, color=factor(group2),geom = c("point", "smooth"))
 qplot(TONEnback,FDfix,TONEnback , data = cor, color=factor(group2),geom = c("point", "smooth"),span = 1,size=1)