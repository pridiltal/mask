
#' Display spatial outliers in two dimensional A-mode component plot
#'
#' @description Provide a 2D scatterplot of data for visual exploration.
#' For data with more than two dimensions, two dimensional scatterplot is produced
#' using the first two pricipal components.
#' @param X A-mode component data with ourlying measures produced by \code{\link{find_spatial_outlier}}
#' @param label_outlier Whether to display labels of outlying observations. Default is set to TRUE.
#' @param nudge_y Vertical adjustment to nudge labels by. Useful for offsetting text from points, particularly on discrete scales.
#' @import ggplot2
#' @importFrom magrittr "%>%"
#' @importFrom dplyr filter
#' @return A ggplot object of data space with detected outliers (if any).
#' @export
#' @examples
#' library(rrcov3way)
#' data(Arno)
#' result <- find_spatial_outlier(
#'   data = Arno, tensor_decom = "Tucker3"
#' )
#' p <- plot_spatial_outliers(X = result$out_data)
#' print(p)
#'
plot_spatial_outliers <- function(X, label_outlier = TRUE, nudge_y = 0.05) {

  X <- X %>%
    mutate(site_ID = 1:nrow(X))
  p <- ggplot(data = X, aes(x= site_ID, y = score, color = type)) +
    geom_point() +
    scale_color_manual(values = c("outlier" = "red", "typical" = "black")) +
    ggtitle("Outlier scores") +
    xlab("Site") +
    ylab("Outlier scores")

  if (label_outlier) {
    out_data <- X %>% dplyr::filter(type == "outlier")
    p <- p +
      geom_text(data = out_data, aes(x= site_ID,
                                     y = score,
                                     label = site),
                color = "black", nudge_y = nudge_y)
  }
  return(p)
}
