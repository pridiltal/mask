
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mask <img src="man/figures/logo.png" align="right" height="150" />

<!-- badges: start -->

<!-- badges: end -->

The goal of mask is to provide a framework to detect spatial anomalies
in multivariate spatio-temporal data (tensor data, multiway data). An
anomaly is a spatial point or region that deviates significantly from
the global and/or local distribution of a given network

## Installation

You can install mask from github with:

``` r
# install.packages("devtools")
devtools::install_github("pridiltal/mask")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(mask)
library(rrcov3way)
#> Loading required package: rrcov
#> Loading required package: robustbase
#> Scalable Robust Estimators with High Breakdown Point (version 1.5-2)
#> Robust Methods for Multiway Data Analysis, Applicable also for
#> Compositional Data (version 0.1-18)
#> 
#> Attaching package: 'rrcov3way'
#> The following object is masked from 'package:stats':
#> 
#>     reorder
data(Arno)

result <- find_spatial_outlier( data = Arno, center.mode = "B", scale.mode = "B", tensor_decom = "Tucker3")
p <- plot_spatial_outliers(X = result$out_data)
p + viridis::scale_color_viridis(discrete = TRUE) +
ggplot2::xlim(-1.1,0.1)
#> Scale for 'colour' is already present. Adding another scale for 'colour',
#> which will replace the existing scale.
```

<img src="man/figures/README-example-1.png" width="100%" />
