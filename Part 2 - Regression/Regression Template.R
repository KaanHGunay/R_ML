# Regression Template

# Importing Data
dataset = read.csv('Position_Salaries.csv') 
dataset = dataset[2:3] # Gerekli verileri seçme

# Splitting the dataset into the training set and test set
# install.packages('caTools')
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Purchased, SplitRatio = 0.8)
# trainig_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)

# Features Scaling
# trainig_set[, 2:3] = scale(trainig_set[, 2:3])
# test_set[, 2:3] = scale(test_set[, 2:3])

# Fitting Regression to the dataset
# Create Regressor

# Prediction Regression
y_pred = predict(regressor, data.frame(Level = 6.5))

# Visualing Regressing Model result
library(ggplot2)
ggplot()+
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = dataset)),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Regression Model)') +
  xlab('Levels') +
  ylab('Salary')

# Visualing Regressing Model result (smoother)
library(ggplot2)
X_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot()+
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = X_grid, y = predict(regressor, newdata = data.frame(Level = X_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Regression Model)') +
  xlab('Levels') +
  ylab('Salary')
