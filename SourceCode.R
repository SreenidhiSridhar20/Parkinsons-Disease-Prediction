New_data<-parkinson_data

New_data$HNR
New_data$status
New_data$name<-NULL

Processed_data<-na.omit(New_data)


Processed_data<-data.frame(Processed_data)


print(Processed_data)

#kmeans#


result<-data.frame(Processed_data$HNR,Processed_data$spread2)
print(result)

(s<- kmeans(result,2))
s$cluster
plot(result[c("Processed_data.HNR","Processed_data.spread2")],
     col = s$cluster)
points(s$centers[,c("Processed_data.HNR","Processed_data.spread2")],
       col = 1:6,pch = 8, cex=2)

#classification

library(rpart)
library(rpart.plot)

h<-Processed_data[sample(nrow(Processed_data)), ]
h

train_tree<-h[1:150,]
train_tree
test_tree<-h[151:195,]


train_tree$status<- as.factor(unlist(train_tree$status))
test_tree$status<- as.factor(unlist(test_tree$status))

model_fit <- rpart(status~., data = h, method = 'class')
print(model_fit)
rpart.plot(model_fit, extra = 106)

predict_seen <-predict(model_fit, test_tree, type = 'class')
summary(predict_seen)

table_pred <- table(test_tree$status, predict_seen)
table_pred

accuracy_Test <- sum(diag(table_pred)) / sum(table_pred)
print(accuracy_Test)

