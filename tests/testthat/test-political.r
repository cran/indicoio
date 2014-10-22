context("Political Sentiment Analysis")

test_that("Political API returns list of probabilities for four parties", {
  
  political_set <- c("Libertarian", "Liberal", "Conservative", "Green")
  test_string <- "Guns don't kill people, people kill people."
  affilation <- political(test_string)
  
  expect_is(affilation, "list")
  expect_true(all(names(affilation) %in% political_set))
  expect_equal(sum(unlist(affilation)), 1)
})

test_that("Throws error on empty text", {
  expect_error(political())
  expect_error(political(""))
  expect_error(political(" "))
})
