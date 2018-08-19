dataset = read.csv('Data.csv')
# dataset = dataset[, 2:3]

library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
trainig_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Features Scaling
# trainig_set[, 2:3] = scale(trainig_set[, 2:3])
# test_set[, 2:3] = scale(test_set[, 2:3])
