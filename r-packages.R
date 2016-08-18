options("repos"="http://cran.rstudio.com") # set the cran mirror

packages <- c("ggplot2",
              "tidyr",
              "dplyr",
              "stringr",
              "rstudio",
              "knitr",
              "rmarkdown",
              "Deducer",
              "DeducerExtras",
              "iplots",
              "tourr"
              )
packages <- setdiff(packages, installed.packages()[, "Package"])
if (length(packages) != 0){
  (install.packages(packages))
}
update.packages(ask=FALSE)
