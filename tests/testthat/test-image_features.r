context("Image Features Detection")

test_that("Image Features Detection API returns proper answer", {
  
  test_image <- matrix(runif(64*64, 0, 1), nrow = 64)
  features <- image_features(test_image)
  
  expect_is(features, "list")
  expect_equal(length(features), 2048)
})

test_that("Throws error on empty or wrong image", {
  expect_error(image_features())
  expect_error(image_features(array(10)))
})
