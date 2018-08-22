# Multi Linear Regression

dataset = read.csv('50_Startups.csv')

dataset$State = factor(dataset$State,
                         levels = c('New York', 'California', 'Florida'),
                         labels = c(1, 2, 3))


library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
trainig_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

regressor = lm(formula = Profit ~ ., # . -> R.D.Spend + Administration + Marketing.Spend + State
               data = trainig_set) 

Y_pred = predict(regressor, newdata = test_set)

# P değeri 0.05 değeri altında olan değerler ile eğitilirse
r2 = lm(formula = Profit ~ R.D.Spend,
               data = trainig_set) 

Y_pred2 = predict(r2, newdata = test_set)

# Building the optimal model using Backward Elimination
regressor_be = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
                  data = dataset)
regressor_be = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
                  data = dataset)
regressor_be = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
                  data = dataset)
regressor_be = lm(formula = Profit ~ R.D.Spend,
                  data = dataset)
summary(regressor_be)

y_pred = predict(regressor_be, newdata = test_set)

# Backward Elimination Function
backwardElimination <- function(x, sl) {
  numVars = length(x)
  for (i in c(1:numVars)){
    regressor = lm(formula = Profit ~ ., data = x)
    maxVar = max(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"])
    if (maxVar > sl){
      j = which(coef(summary(regressor))[c(2:numVars), "Pr(>|t|)"] == maxVar)
      x = x[, -j]
    }
    numVars = numVars - 1
  }
  return(summary(regressor))
}

SL = 0.05
dataset = dataset[, c(1,2,3,4,5)]
backwardElimination(training_set, SL)