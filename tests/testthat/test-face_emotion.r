context("Face Emotion Detection")

test_that("Face Emotion Detection API returns proper answer", {
  
  fer_set <- c("Angry", "Sad", "Neutral", "Surprise", "Fear", "Happy")
  test_image <- matrix(runif(48*48, 0, 1), nrow = 48)
  emotion <- face_emotion(test_image)
  
  expect_is(emotion, "list")
  expect_true(all(names(emotion) %in% fer_set))
  expect_equal(sum(unlist(emotion)), 1)
})

test_that("Throws error on empty or wrong image", {
  expect_error(face_emotion())
  expect_error(face_emotion(array(10)))
})
