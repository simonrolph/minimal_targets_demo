#create 
dir.create("inputs")
dir.create("outputs")

x <- sample(1:100,100,replace = T)
y <- x*2+sample(1:50,100,replace = T)

df <- data.frame(x = x, y = y)
write.csv(df,"inputs/data2.csv",row.names = F)

rm(df)
rm(x)
rm(y)