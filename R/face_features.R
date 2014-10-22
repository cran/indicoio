#' Detects face features
#'
#' Given an grayscale input image of a face, returns a 48 dimensional feature vector explaining that face.
#' Useful as a form of feature engineering for face oriented tasks.
#' Input should be in a list of list format, resizing will be attempted internally but for best
#' performance, images should be already sized at 48x48 pixels.
#' @inheritParams face_emotion
#' @return List with face features
#' @keywords indico.io machine learning API face features recognition
#' @seealso \code{\link{face_emotion}}, \code{\link{image_features}}
#' @export
#' @import httr rjson stringr
#' @examples
#' img <- matrix(runif(48*48, 0, 1), nrow = 48)
#' features <- face_features(img)
#' length(features)
#' 
face_features <- function(img, local.api = FALSE) {
  
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
  api <- str_c(api, "facialfeatures")
  
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
