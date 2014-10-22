indicoio
========

R-based client for Machine Learning API

## Install

```r
library(devtools)
devtools::install_github("IndicoDataSolutions/IndicoIo-R")
```

## Usage

```r
library(indicoio)
```

### Positive/Negative Sentiment Analysis

```r
emotion <- sentiment("Thanks everyone for the birthday wishes!!
                      It was a crazy few days ><")
emotion
cat(sprintf("This text has %s tonality", 
             ifelse(emotion > 0.5, "positive", "negative")))
```

### Political Sentiment Analysis

```r
affilation <- political("I am so proud to stand here today 
                         as Prime Minister of four nations
                         in one United Kingdom.")
affilation
most.like <- names(affilation[which.max(unlist(affilation))])
least.like <- names(affilation[which.min(unlist(affilation))])
cat(sprintf("This text is most like %s and least like %s", 
            most.like, least.like))

```

### Language Detection

```r
languages <- language("Monday: Delightful with mostly sunny skies.
                            Highs in the low 70s.")
languages
most.possible <- sort(unlist(languages), decreasing = TRUE)[1:2]
cat(sprintf("Detected %s language with probability %0.4f.\n",
            names(most.possible)[1], most.possible[1]))
cat(sprintf("Next possible is %s with probability %0.4f.", 
            names(most.possible)[2], most.possible[2]))
```

### Face Emotion Detection

```r
## Example 1
img <- matrix(runif(48*48, 0, 1), nrow = 48)
emotion <- face_emotion(img)

most.possible <- sort(unlist(emotion), decreasing = TRUE)[1:2]
cat(sprintf("Detected '%s' emotion with probability %0.4f.\n",
            names(most.possible)[1], most.possible[1]))
cat(sprintf("Next possible is '%s' emotion with probability %0.4f.", 
            names(most.possible)[2], most.possible[2]))

## Example 2
# Reads PNG file
file.face <- system.file("extdata", "face1.png", package = "indicoio")
img <- readPNG(file.face)
# Converts to grayscale
img <- 0.2126 * img[, , 1] + 0.7152 * img[, , 2] + 0.0722 * img[, , 3]
# Plots image
plot(0:1, 0:1, xlab = "", ylab = "", axes = FALSE, col = "white")
rasterImage(img, xleft = 0, ybottom = 0, xright = 1, ytop = 1)
# Detects emotion
face_emotion(img)
```

### Face Features Detection

```r
img <- matrix(runif(48*48, 0, 1), nrow = 48)
features <- face_features(img)
length(features)
```

### Image Features Detection

```r
img <- matrix(runif(64*64, 0, 1), nrow = 64)
features <- image_features(img)

length(features)
min(unlist(features))
max(unlist(features))
sum(unlist(features))
```
