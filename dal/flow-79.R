# This is a hack of https://github.com/OuhscBbmc/miechv-3/blob/master/manipulation/osdh/osdh-flow.R
#   That file runs everything (those dozens of files) dynamically.
#   This one is hard-coded, and requires one manual stop (to run the C#).
#   But since there are so few files, I think it's an acceptable compromise.

rm(list=ls(all=TRUE)) #Clear the memory for any variables set from any previous runs.

# ---- load-sources ------------------------------------------------------------


# ---- load-packages -----------------------------------------------------------
library(magrittr)
requireNamespace("testit")

# ---- declare-globals ---------------------------------------------------------
path_sources <- c(
  "dal/import-79-metadata.R",
  "dal/import-79-raw.R",
  "dal/outcomes/outcomes-79.R",
  "analysis/eda/counts/counts.Rmd"
)

file.exists(path_sources)
all_sources_exist <- path_sources %>%
  purrr::map_lgl(file.exists) %>%
  all()
if( !all_sources_exist ) stop("All source files to be run should exist.")


# ---- load-data ---------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------

# ---- run-sources -------------------------------------------------------------

message("Preparing to run\n\t", paste(path_sources, collapse="\n\t"))

(start_time <- Sys.time())


# dir.create(output="./stitched-output/dal/", recursive=T)
knitr::stitch_rmd(script="./dal/import-79-metadata.R", output="./stitched-output/dal/import-metadata.md")
knitr::stitch_rmd(script="./dal/import-79-raw.R", output="./stitched-output/dal/import-raw.md")
rmarkdown::render("analysis/eda/counts/counts.Rmd", envir=new.env())                                             # Watch out, this file is actually knitted twice (see below).

stop("Now run the C# program, then come back to run the rest of the R scripts.")

knitr::stitch_rmd(script="./dal/outcomes/outcomes-79.R", output="./stitched-output/dal/outcomes/outcomes-79.md") # dir.create("./stitched-output/dal/outcomes/", recursive=T)
rmarkdown::render("analysis/eda/counts/counts.Rmd", envir=new.env())                                             # Watch out, this file is actually knitted twice (see above).


message("Completed flow-79 at ", Sys.time(), " (in ", round(elapsed_duration, 2), " mins.)")

# ---- verify-values -----------------------------------------------------------
