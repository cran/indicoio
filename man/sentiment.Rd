% Generated by roxygen2 (4.0.2): do not edit by hand
\name{sentiment}
\alias{sentiment}
\title{Returns a scalar estimate of the sentiment of the text}
\usage{
sentiment(text, local.api = FALSE)
}
\arguments{
\item{text}{text for analysis}

\item{local.api}{logical, whether use local or remote API}
}
\value{
Numerical value roughly in the range from 0 to 1 with 0.5 indicating neutral sentiment.
For reference, 0 suggests very negative sentiment and 1 suggests very positive sentiment.
}
\description{
Given input text, returns a scalar estimate of the sentiment of that text.
}
\examples{
emotion <- sentiment("Thanks everyone for the birthday wishes!!
                      It was a crazy few days ><")
emotion
cat(sprintf("This text has \%s tonality",
             ifelse(emotion > 0.5, "positive", "negative")))
}
\seealso{
\code{\link{political}}, \code{\link{language}}
}
\keyword{API}
\keyword{analysis}
\keyword{indico.io}
\keyword{learning}
\keyword{machine}
\keyword{sentiment}

