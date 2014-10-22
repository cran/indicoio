#' Detects face emotion
#'
#' Given a grayscale input image of a face, returns a probability distribution over emotional state.
#' Input should be a two-dimensional strucrure (like data.frame or matrix), resizing will be attempted internally but for best
#' performance, images should be already sized at 48x48 pixels.
#' @param img image data
#' @param local.api logical, whether use local or remote API
#' @return List with face emotions probability pairs
#' @keywords indico.io machine learning API face emotions recognition
#' @seealso \code{\link{face_features}}, \code{\link{image_features}}
#' @export
#' @import httr rjson stringr png
#' @examples
#' ## Example 1
#' img <- matrix(runif(48*48, 0, 1), nrow = 48)
#' emotion <- face_emotion(img)
#' 
#' most.possible <- sort(unlist(emotion), decreasing = TRUE)[1:2]
#' cat(sprintf("Detected '%s' emotion with probability %0.4f.\n",
#'             names(most.possible)[1], most.possible[1]))
#' cat(sprintf("Next possible is '%s' emotion with probability %0.4f.", 
#'             names(most.possible)[2], most.possible[2]))
#' 
#' ## Example 2
#' # Reads PNG file
#' file.face <- system.file("extdata", "face1.png", package = "indicoio")
#' img <- readPNG(file.face)
#' # Converts to grayscale
#' img <- 0.2126 * img[, , 1] + 0.7152 * img[, , 2] + 0.0722 * img[, , 3]
#' # Plots image
#' plot(0:1, 0:1, xlab = "", ylab = "", axes = FALSE, col = "white")
#' rasterImage(img, xleft = 0, ybottom = 0, xright = 1, ytop = 1)
#' # Detects emotion
#' face_emotion(img)
#' 
face_emotion <- function(img, local.api = FALSE) {
  
  # Checks parameters
  if (missing(img)) {
    stop("No image for analysis provided!")
  }
  
  if (length(dim(img)) != 2) {
    stop("Image should be represented by two-dimensional structure!")
  }
  
  # Converts to anonymous data.frame
  img <- data.frame(img)
  colnames(img) <- NULL
  
  api <- ifelse(local.api, .indicoio$local_api, .indicoio$remote_api)
  api <- str_c(api, "fer")
  
  # Makes request
  response <- POST(api, 
                   accept_json(),
                   add_headers(.indicoio$header),
                   body = toJSON(list(data = img))
  )
  stop_for_status(response)
  
  # Returns results
  answer <- content(response, as = "parsed", type = "application/json")
  if ("error" %in% names(answer)) {
    stop(answer[["error"]])
  }
  answer[["results"]]

}

