# Simple Linear Regression

dataset = read.csv('Salary_Data.csv')

library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
trainig_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Features Scaling
# trainig_set[, 2:3] = scale(trainig_set[, 2:3])
# test_set[, 2:3] = scale(test_set[, 2:3])

# Fitting SLR to the Training Set
regressor = lm(formula = Salary ~ YearsExperience,
               data = trainig_set)

# Prediction the Test set Result
Y_pred = predict(regressor, newdata = test_set)

# Visualising Trainig set result
library(ggplot2)
ggplot() + 
  geom_point(aes(x = trainig_set$YearsExperience, y = trainig_set$Salary),
             colour = 'red') +
  geom_line(aes(x = trainig_set$YearsExperience, y = predict(regressor, newdata = trainig_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience (Training Set)') +
  xlab('Years of Experiencfe') +
  ylab('Salary')

# Visualising Test set result
ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = 'red') +
  geom_line(aes(x = trainig_set$YearsExperience, y = predict(regressor, newdata = trainig_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience (Test Set)') +
  xlab('Years of Experience') +
  ylab('Salary')