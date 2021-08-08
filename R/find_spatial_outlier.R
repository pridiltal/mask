#' Generate two dimensional feature space from tensor data.
#'
#' @description  This function converts the original three way dataset into
#' two dimensional feature space.
#' @param data 	3-way array of data, A mode- space
#' @param ncomp Number of components. Default is set to 2
#' @param center Whether to center the data
#' @param center.mode	 If centering the data, on which mode to do this
#' @param scale	 Whether to scale the data
#' @param scale.mode 	scaling the data, on which mode to do this
#' @param alpha Threshold for determining the cutoff for outliers.
#' @param tensor_decom Method to decompose the 3-way array
#' @return a list with components
#' \item{outliers}{The indexes of the spatial observations determined to be outliers.}
#' \item{out_scores}{Outliying score of each spatial observation}
#' \item{type}{Type of each spatial observation: outlier or typical}
#' \item{plot_data}{A-mode component data with ourlying measures}
#' @export
#' @importFrom rrcov3way Parafac
#' @importFrom stray find_HDoutliers
#' @importFrom magrittr "%>%"
#' @importFrom dplyr mutate
#' @examples
#' library(rrcov3way)
#' data(Arno)
#' result <- find_spatial_outlier(
#'   data = Arno, tensor_decom = "Tucker3"
#' )
#' result$out_data
find_spatial_outlier <- function(data, ncomp = 2, center = TRUE, center.mode = c("A", "B", "C"),
                                 scale = TRUE, scale.mode = c("A", "B", "C"), alpha = 0.01,
                                 tensor_decom = c("Tucker3", "parafac")) {

  if (tensor_decom == "Tucker3") {
    res <- rrcov3way::Tucker3(data, robust = TRUE)
  }
  if (tensor_decom == "parafac") {
    res <- rrcov3way::Parafac(data, ncomp, center,
                              center.mode, scale,
                              scale.mode, robust = TRUE )
  }

  out <- stray::find_HDoutliers(res$rd, alpha = alpha)
  out_data <- res$rd %>%
    as.data.frame() %>%
    dplyr::mutate(site = rownames(res$A),
                  type = out$type,
                  score = out$out_scores) %>%
    dplyr::select(site, type, score)

  return(list(
    outliers = out$outliers,
    out_scores = out$out_scores,
    type = out$type,
    out_data = out_data
  ))
}
