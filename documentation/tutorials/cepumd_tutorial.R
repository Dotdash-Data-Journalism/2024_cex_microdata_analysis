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

# TODO: Find median CU expenditures and expenditure density for non-Interview 
# Food at Home items. Everything except "Food prepared by consumer unit on out 
# of town trips" and "Food and non alcoholic beverages". 
# As well as non-Diary Other Vehicle Expenses which is everything but 
# "Vehicle products and cleaning services",  
# "Miscellaneous auto repair and servicing", and "Gas tank repair and replacement"

# Getting UCCs for Diary Food at Home category
diary22_hg <- ce_hg(
  2022,
  "diary",
  hg_zip_path = file.path(ce_data_dir, "stubs.zip")
)

fah_d_uccs <- ce_uccs(diary22_hg, ucc_group = "FOODHOME")

# Getting UCCs for Interview Other Vehicle Expenses and Gasoline, other fuels, and motor oil
interview22_hg <- ce_hg(
  2022,
  "interview",
  hg_zip_path = file.path(ce_data_dir, "stubs.zip")
)

ove_i_uccs <- ce_uccs(interview22_hg, ucc_group = "VEHOTHXP")
gas_i_uccs <- ce_uccs(interview22_hg, ucc_group = "GASOIL")

# To use weighted column with density use
# geom_density(aes(weight = weight_column))

## Getting median of DIARY ONLY Food at Home
ce_fah_prep <- ce_prepdata(
  2022,
  "diary",
  diary22_hg,
  uccs = fah_d_uccs,
  dia_zp = file.path(ce_data_dir, "diary22.zip")
) 

ce_fah_mean <- ce_fah_prep %>% 
  ce_mean() %>% 
  pull(mean_exp)

ce_fah_prep %>% 
  ce_quantiles(probs = seq(.1, .9, by = 0.1))

ce_fah_median <- ce_fah_prep %>% 
  ce_quantiles(probs = 0.5) %>% 
  pull(quantile)

filter(diary22_hg, ucc %in% fah_d_uccs) %>% 
  write_csv("~/Downloads/food_away_from_home_diary_uccs.csv")

ggplot(ce_fah_prep, aes(x = cost)) +
  geom_density(aes(weight = finlwt21)) + 
  scale_y_continuous(labels = scales::percent) +
  scale_x_continuous(labels = scales::dollar) +
  geom_vline(aes(xintercept = ce_fah_median), color = "red") +
  geom_vline(aes(xintercept = ce_fah_mean), color = "blue") +
  theme(legend.position = "none")

ggplot(ce_fah_prep, aes(x = cost)) +
  geom_histogram(aes(weight = finlwt21), binwidth = 300) +
  geom_vline(aes(xintercept = ce_fah_median), color = "red") +
  geom_vline(aes(xintercept = ce_fah_mean), color = "blue") +
  theme(legend.position = "none") +
  labs(title = "Histogram of Diary Survey Only Food At Home Expenditures",
       subtitle = "2022. Red line is median and blue is weighted mean.")
  
## Weighted mean of INTEGRATED Food at Home
ce_fah_integ_prep <- ce_prepdata(
  2022,
  "integrated",
  integ22_hg,
  uccs = ce_uccs(integ22_hg, ucc_group = "FOODHOME"),
  dia_zp = file.path(ce_data_dir, "diary22.zip"),
  int_zp = c(file.path(ce_data_dir, "intrvw22.zip"),
             file.path(ce_data_dir, "intrvw21.zip"))
) 

ce_fah_integ_prep %>% 
  ce_mean()

## Getting medians for INTERVIEW ONLY Other Vehicle Expenses and Gasoline, other fuels, and motor oil
ce_ove_prep <- ce_prepdata(
  2022,
  "interview",
  interview22_hg,
  uccs = ove_i_uccs,
  int_zp = c(file.path(ce_data_dir, "intrvw22.zip"),
             file.path(ce_data_dir, "intrvw21.zip"))
)

ce_ove_mean <- ce_ove_prep %>% 
  ce_mean() %>% 
  pull(mean_exp)

ce_ove_prep %>% 
  ce_quantiles(probs = seq(.1, .9, by = 0.1))

ce_ove_median <- ce_ove_prep %>% 
  ce_quantiles(probs = 0.5) %>% 
  pull(quantile)

filter(interview22_hg, ucc %in% ove_i_uccs) %>% 
  write_csv("~/Downloads/other_vehicle_expenses_interview_uccs.csv")

ggplot(ce_ove_prep, aes(x = cost)) +
  geom_density(aes(weight = finlwt21)) + 
  scale_y_continuous(labels = scales::percent) +
  scale_x_continuous(labels = scales::dollar) +
  geom_vline(aes(xintercept = ce_ove_median), color = "red") +
  geom_vline(aes(xintercept = ce_ove_mean), color = "blue") +
  theme(legend.position = "none")

ggplot(ce_ove_prep, aes(x = cost)) +
  geom_histogram(aes(weight = finlwt21), binwidth = 1000) +
  geom_vline(aes(xintercept = ce_ove_median), color = "red") +
  geom_vline(aes(xintercept = ce_ove_mean), color = "blue") +
  theme(legend.position = "none") +
  labs(title = "Histogram of Interview Survey Only Other Vehicle Expenses Expenditures",
       subtitle = "2022. Red line is median and blue is weighted mean.")

##
ce_gas_prep <- ce_prepdata(
  2022,
  "interview",
  interview22_hg,
  uccs = gas_i_uccs,
  int_zp = c(file.path(ce_data_dir, "intrvw22.zip"),
             file.path(ce_data_dir, "intrvw21.zip"))
)

ce_gas_mean <- ce_gas_prep %>% 
  ce_mean() %>% 
  pull(mean_exp)

ce_gas_prep %>% 
  ce_quantiles(probs = seq(.1, .9, by = 0.1))

ce_gas_median <- ce_gas_prep %>% 
  ce_quantiles(probs = 0.5) %>% 
  pull(quantile)

filter(interview22_hg, ucc %in% gas_i_uccs) %>% 
  write_csv("~/Downloads/gasoline_other_fuels_motor_oil_interview_uccs.csv")

ggplot(ce_gas_prep, aes(x = cost)) +
  geom_density(aes(weight = finlwt21)) + 
  scale_y_continuous(labels = scales::percent) +
  scale_x_continuous(labels = scales::dollar) +
  geom_vline(aes(xintercept = ce_gas_median), color = "red") +
  geom_vline(aes(xintercept = ce_gas_mean), color = "blue") +
  theme(legend.position = "none")


ggplot(ce_gas_prep, aes(x = cost)) +
  geom_histogram(aes(weight = finlwt21), binwidth = 100) +
  geom_vline(aes(xintercept = ce_gas_median), color = "red") +
  geom_vline(aes(xintercept = ce_gas_mean), color = "blue") +
  theme(legend.position = "none") +
  labs(title = "Histogram of Interview Survey Only Gasoline, Other Fuels, and Motor Oil Expenditures",
       subtitle = "2022. Red line is median and blue is weighted mean.")

