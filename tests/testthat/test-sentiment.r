context("Positive/Negative Sentiment Analysis")

test_that("Sentiment API returns numerical value", {
  
  test_string <- "Worst song ever."
  emotion <- sentiment(test_string)
  
  expect_is(emotion, "numeric")
})

test_that("Throws error on empty text", {
  expect_error(sentiment())
  expect_error(sentiment(""))
  expect_error(sentiment(" "))
})
