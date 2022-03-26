library(tidyverse)
library(magrittr)
library(lubridate)
library(tsibble)

train_data <- read.csv("C:/Users/lakna/Desktop/data storm/data competition/train_data.csv")
validation_data <- read.csv("C:/Users/lakna/Desktop/data storm/data competition/train_data.csv")
test_data <- read.csv("C:/Users/lakna/Desktop/data storm/data competition/test_data.csv")


# Summary 
skimr::skim(train_data)

# Set DateID to date type 
# Set CategoryCode and ItemCode to factor
train_data <- train_data %>%
  dplyr::transmute(
    CategoryCode = as.factor(CategoryCode),
    ItemCode = as.factor(ItemCode),
    DateID = lubridate::mdy(DateID),
    DailySales = DailySales
  )

# Fill the gaps
train_data <- train_data %>%
  as_tsibble(key = c(CategoryCode, ItemCode), index = DateID) %>%
  fill_gaps(DailySales = 0) %>% 
  group_by_key() %>% 
  tidyr::fill(CategoryCode, ItemCode, .direction = "down")











