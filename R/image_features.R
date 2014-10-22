#' Detects image features
#'
#' Given an input image, returns a 2048 dimensional sparse feature vector explaining that image.
#' Useful as a form of feature engineering for image oriented tasks.
#' 
#' * Input can be either grayscale or rgb color and should either be a numpy array or nested list format.
#' 
#' * Input data should be either uint8 0-255 range values or floating point between 0 and 1.
#' 
#' * Large images (i.e. 1024x768+) are much bigger than needed, resizing will be done internally to 64x64 if needed.
#' 
#' * For ideal performance, images should be square aspect ratio but non-square aspect ratios are supported as well.
#' @inheritParams face_emotion
#' @return List with image features
#' @keywords indico.io machine learning API image features recognition
#' @seealso \code{\link{face_emotion}}, \code{\link{face_features}}
#' @export
#' @import httr rjson stringr
#' @examples
#' img <- matrix(runif(64*64, 0, 1), nrow = 64)
#' features <- image_features(img)
#' 
#' length(features)
#' min(unlist(features))
#' max(unlist(features))
#' sum(unlist(features))
#' 
image_features <- function(img, local.api = FALSE) {
  
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
  api <- str_c(api, "imagefeatures")
  
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

