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
#'   data = Arno, center.mode = "B",
#'   scale.mode = "B", tensor_decom = "Tucker3"
#' )
#' p <- plot_spatial_outliers(X = result$out_data)
#' p + viridis::scale_color_viridis(discrete = TRUE) +
#' ggplot2::xlim(-1.1,0.1)
#'
plot_spatial_outliers <- function(X, label_outlier = TRUE, nudge_y = 0.05) {

  F1 = F2 =  site = type = NULL
  p <- ggplot(data = X, aes(F1, F2, color = type)) +
    geom_point() +
    scale_color_manual(values = c("outlier" = "red", "typical" = "black")) +
    theme(aspect.ratio = 1) +
    ggtitle("Component plot, A-mode") +
    xlab("First Component") +
    ylab("Second Component")

  if (label_outlier) {
    out_data <- X %>% dplyr::filter(type == "outlier")
    p <- p +
      geom_text(data = out_data, aes(x = F1, y = F2, label = site), color = "black", nudge_y = nudge_y)
  }
  return(p)
}
