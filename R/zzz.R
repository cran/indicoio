
# Creates new environment for the package
if (!exists(".indicoio")) {
  .indicoio <- new.env()
}

.onAttach <- function(libname, pkgname) {
  # Shows welcome message
  packageStartupMessage("\n========================================================\nindicoio: A simple R wrapper for the indico set of APIs \nFind more at: http://indico.io\n========================================================\n")
}

.onLoad <- function(libname, pkgname) {
  # Sets package-wide variables
  if (exists(".indicoio")) {
    .indicoio$header <- c("Content-type" = "application/json",
                          "Accept" = "text/plain")
    .indicoio$remote_api <- "http://apiv1.indico.io/"
    .indicoio$local_api  <- "http://localhost:9438/"
  }
}

