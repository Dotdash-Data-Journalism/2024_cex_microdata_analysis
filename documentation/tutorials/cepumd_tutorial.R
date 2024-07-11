library(tidyverse)
library(knitr)
library(readxl)
library(cepumd)

# Mirrored from here: https://arcenis-r.github.io/ajr-portfolio/posts/20240124-cepumd-intro/cepumd-intro.html

ce_data_dir <- "../../microdata"
cepumd_ua <- "anesta@dotdashmdp.com"

ce_data_download <- function(url, path_root, file_name, user_agent) {
  download.file(
    url,
    fs::path(path_root, file_name),
    mode = "wb",
    headers = list(
      "User-Agent" = user_agent
    )
  )
}

ce_pumd_urls <- c("https://www.bls.gov/cex/pumd/data/csv/intrvw22.zip",
  "https://www.bls.gov/cex/pumd/data/comma/intrvw21.zip",
  "https://www.bls.gov/cex/pumd/data/csv/diary22.zip",
  "https://www.bls.gov/cex/pumd/data/comma/diary21.zip",
  "https://www.bls.gov/cex/pumd/stubs.zip",
  "https://www.bls.gov/cex/pumd/ce-pumd-interview-diary-dictionary.xlsx"
)

ce_pumd_filenames <- str_extract(ce_pumd_urls, "(?<=/)[a-zA-Z0-9-]+\\.\\w+$")

pwalk(
  list(ce_pumd_urls,
       ce_pumd_filenames),
  function(x, y) {
    ce_data_download(url = x, path_root = ce_data_dir,
                     file_name = y, user_agent = cepumd_ua)
  },
  .progress = T
)

integ22_hg <- ce_hg(
  2022,
  "integrated",
  hg_zip_path = file.path(ce_data_dir, "stubs.zip")
)

ce_microdata_prep <- ce_prepdata(
  2022,
  "integrated",
  integ22_hg,
  uccs = ce_uccs(integ22_hg, expenditure = "Pets", ucc_group = "PETS"),
  dia_zp = file.path(ce_data_dir, "diary22.zip"),
  int_zp = c(file.path(ce_data_dir, "intrvw22.zip"),
             file.path(ce_data_dir, "intrvw21.zip"))
) 

ce_microdata_prep %>% 
  ce_mean()


