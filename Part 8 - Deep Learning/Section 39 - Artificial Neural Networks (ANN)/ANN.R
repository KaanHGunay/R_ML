# Arificial Neural Networks

# Importing Data
dataset = read.csv('Churn_Modelling.csv')
dataset = dataset[4:14]

# Encoding the categorical variable as factor
dataset$Geography = as.numeric(factor(dataset$Geography,
                           levels = c('France', 'Spain', 'Germany'),
                           labels = c(1, 2, 3)))
dataset$Gender = as.numeric(factor(dataset$Gender,
                        levels = c('Female', 'Male'),
                        labels = c(1, 2)))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Exited, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set[-11] = scale(training_set[-11])
test_set[-11] = scale(test_set[-11])

# Fitting classifier to the Training set
library(h2o)
h2o.init(nthreads = -1) # Hesaplama yaparken tüm boşta olan çekirdekleri kullan
classifier = h2o.deeplearning(y = 'Exited', # Sonuç vektörünün adı
                              training_frame = as.h2o(training_set), # veri seti h2o objesine çevrilerek
                              activation = 'Rectifier', # Rextifier activation algoritmasını kullan
                              hidden = c(6, 6), # Kaç layer olacaksa nöron sayısı ile verilir
                              epochs = 100, # kaç jenerasyonun bulunacağı
                              train_samples_per_iteration = -2) # kaç örnekte ağırlıkların güncelleneceği / otomatik belirle -2

# Predicting the Test set results
prob_pred = h2o.predict(classifier, newdata = as.h2o(test_set[-11]))
y_pred = ifelse(prob_pred > 0.5, 1, 0)
y_pred = as.vector(y_pred)

# Making the Confusion Matrix
cm = table(test_set[, 11], y_pred)

h2o.shutdown() # h2o serverını kapatma