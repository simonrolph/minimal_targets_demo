#load the data
df <- read.csv("inputs/data.csv")

#what's the mean of each value
stat1 <- colMeans(df)

# fit a linear model
mod1 <- lm(y~x,df)

#some new data to make predictions from
newdata1 <- data.frame(x=20:60)

#making a prediction
pred1 <- data.frame(x = newdata1$x,
                    y = predict(mod1,newdata = newdata1))

#save a plot ("outputs/plot.png") with a line on it and a title
png(file="outputs/plot.png",width=600, height=350)
plot(df)
lines(pred1,col="red")
title("My nice plot")
dev.off()


# or a ggplot
library(ggplot2)
p1 <- ggplot(df,aes(x = x,y = y))+
  geom_point()+
  geom_line(data = pred1,col="red")+
  ggtitle("My nice plot")

p1
ggsave("outputs/plot.png",p1)


