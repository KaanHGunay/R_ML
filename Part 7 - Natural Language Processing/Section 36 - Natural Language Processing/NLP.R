# Natural Language Processing

# Importing Dataset
dataset_original = read.delim('Restaurant_Reviews.tsv', quote = '', stringsAsFactors = FALSE)

# Cleaning the texts
library(tm)
library(SnowballC) # Gereksiz kelimeler için
corpus = VCorpus(VectorSource(dataset_original$Review)) # Tüm cümleleri alma
corpus = tm_map(corpus, content_transformer(tolower)) # Tüm harfleri küçüğe çevirme
corpus = tm_map(corpus, removeNumbers) # Sayıları silme
corpus = tm_map(corpus, removePunctuation) # Noktalamaları silme
corpus = tm_map(corpus, removeWords, stopwords()) # Gereksiz kelimeleri silme and, or, a, an gibi
corpus = tm_map(corpus, stemDocument) # Fiillerin hepsini 1. hale getirir
corpus = tm_map(corpus, stripWhitespace) # Fazladan bulunan boşlukları siler

# Creating the Bag of Words model
dtm = DocumentTermMatrix(corpus) # Sparse matrix oluişturma
dtm = removeSparseTerms(dtm, 0.999) # sparse matrixini %99.9 0 olacak şekilde düzenleme
dataset = as.data.frame(as.matrix(dtm)) # Data Frame çeviriyoruz
dataset$Liked = dataset_original$Liked # datasete sonuçlarıda ekliyoruz

# Encoding the target feature as factor
dataset$Liked = factor(dataset$Liked, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting Decision Tree Classification to the Training set
library(randomForest)
classifier = randomForest(x = training_set[-692], # son sonuç kolonu hariç
                          y = training_set$Liked,
                          ntree = 30)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-692])

# Making the Confusion Matrix
cm = table(test_set[, 692], y_pred)
