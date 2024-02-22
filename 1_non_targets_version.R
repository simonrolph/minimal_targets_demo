#here is a very simple example of a non-pipelined workflow, it loads in some data, fits a model and generates a plot

#load the data
df <- read.csv("inputs/data.csv")

# fit a linear model
mod1 <- lm(y~x,df)

#some new data to make predictions from
newdata1 <- data.frame(x=20:60)

#making a prediction
pred1 <- data.frame(x = newdata1$x,
                    y = predict(mod1,newdata = newdata1))

# base R plot
#save a plot ("outputs/plot.png") with a line on it and a title
png(file="outputs/plot1.png",width=600, height=350)
plot(df)
lines(pred1,col="red")
title("My nice plot")
dev.off()


# or a ggplot2 plot
library(ggplot2)
p1 <- ggplot(df,aes(x = x,y = y))+
  geom_point()+
  geom_line(data = pred1,col="red")+
  ggtitle("My nice ggplot")

p1
ggsave("outputs/plot2.png",p1)


#remove the files before building a targets
file.remove("outputs/plot.png")
file.remove("outputs/plot2.png")




