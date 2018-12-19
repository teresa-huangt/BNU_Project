#plot circle

# paras
a=rnorm(300 , mean=0 , sd=4)
b=rnorm(300 , mean=0 , sd=4)
c=rnorm(300 , mean=8 , sd=8)

#backgroud color
par(bg="black")

# 边距（下左上右） 以行为单位
par(mar=c(0,0,0,0))

# cex放大倍数，bty=n不绘制边框 xaxt=n不绘制x轴坐标
plot(a ,b , cex=abs(c) , col=rgb(0.5,0.2,1,0.25) , pch=20 , 
     bty="n" , xaxt="n" , yaxt="n" , xlab="" , 
     ylab="" , xlim=c(-3,10) , ylim=c(-3,10))
#
#dev.off()
