library(foreign)
#cor<-read.spss("F:/Work/Speech_amusia/RTand_other.sav",use.value.labels=FALSE,to.data.frame=TRUE)
cor<-as.matrix(read.spss("F:/Work/Speech_amusia/amusiaVScontrol/toSPSS_Control/TONERTother.sav",use.value.labels=FALSE,to.data.frame=TRUE))

#cor<-as.matrix(cor)

library("psych")
fdrvalue<-corr.test(cor, use = "pairwise",method="pearson",adjust="fdr",alpha=.05)
library(corrplot)
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(fdrvalue$r, method="color", col=col(200),  
         type="full", 
         addCoef.col = "black", # Add coefficient of correlation
         tl.col="black", tl.srt=45, #Text label color and rotation
         # Combine with significance
         p.mat = fdrvalue$p, sig.level = 0.05, insig = "blank", 
         # hide correlation coefficient on the principal diagonal
         diag=FALSE 
)
#corrplot(fdrvalue$r,method="color",type="full",order="hclust",col=col(200),tl.col="black",tl.srt=15,diag=FALSE)
#corrplot(fdrvalue$r, type="upper", order="hclust",tl.col="black",tl.srt=45,p.mat = fdrvalue$p, sig.level = 0.05, insig = "blank")
library("PerformanceAnalytics")
chart.Correlation(cor, histogram=TRUE, pch=19)

#
qplot(factor(group2),FDfix , data = cor, color=factor(group2),alpha=I(1/2.5),size=20,xlab = "Group", ylab = "Frequency discrimination threshold ",main = "Pitch Perception")
