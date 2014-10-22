context("Language Detection")

test_that("Language API returns list of probabilities for list of languages", {
  
  language_set <- c(
    "English",
    "Spanish",
    "Tagalog",
    "Esperanto",
    "French",
    "Chinese",
    "French",
    "Bulgarian",
    "Latin",
    "Slovak",
    "Hebrew",
    "Russian",
    "German",
    "Japanese",
    "Korean",
    "Portuguese",
    "Italian",
    "Polish",
    "Turkish",
    "Dutch",
    "Arabic",
    "Persian (Farsi)",
    "Czech",
    "Swedish",
    "Indonesian",
    "Vietnamese",
    "Romanian",
    "Greek",
    "Danish",
    "Hungarian",
    "Thai",
    "Finnish",
    "Norwegian",
    "Lithuanian"
  )
  test_string <- "Clearly an English sentence."
  languages <- language(test_string)
  
  expect_is(languages, "list")
  expect_true(all(names(languages) %in% language_set))
  expect_equal(sum(unlist(languages)), 1)
})

test_that("Throws error on empty text", {
  expect_error(language())
  expect_error(language(""))
  expect_error(language(" "))
})
