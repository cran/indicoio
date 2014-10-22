context("Face Features Detection")

test_that("Face Features Detection API returns proper answer", {
  
  test_image <- matrix(runif(48*48, 0, 1), nrow = 48)
  features <- face_features(test_image)
  
  expect_is(features, "list")
  expect_equal(length(features), 48)
})

test_that("Throws error on empty or wrong image", {
  expect_error(face_features())
  expect_error(face_features(array(10)))
})
