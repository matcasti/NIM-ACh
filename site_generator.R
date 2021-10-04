
# Prepare workspace ---------------------------------------------------------------------------


# Load required libraries
library(glue)

# And source helper scritps
source("news_helper.R")

# Remove directory if exists (to start over)
unlink(x = "_site", recursive = TRUE)


# Create folders with subdirectories ----------------------------------------------------------


# Create directory
dir.create("_site")
dir.create("_site/news")

# Copy the content 'i' in root to _site
for (i in c("assets", "images")) {
  dir.create(paste0("_site/", i))
  file.copy(
    from = list.files(i, full.names = TRUE),
    to = paste0("_site/", i),
    recursive = TRUE
  )
}

# Copy CNAME file
file.copy(from = "resources/CNAME", to = "_site/CNAME")

# Main pages ----------------------------------------------------------------------------------
# Index, News and Research

# Root (for sidebar in nested directories)
root <- ""

# Create news for sidebar
news_sidebar <- lapply(head(news, n = 3), news_generator, TRUE) |>
  paste0(collapse = "\n\n")

# Create news for index and news page
news_index <- lapply(head(news), news_generator, FALSE) |>
  paste0(collapse = "\n\n")
  
# Create sidebar
sidebar <- readLines("resources/sidebar.txt") |>
  paste0(collapse = "\n") |>
  glue::glue()

social_media <- readLines("resources/social_media.txt") |>
  paste0(collapse = "\n")

# Create HOMEPAGE
readLines("resources/index.txt") |>
  paste0(collapse = "\n") |>
  glue::glue() |>
  cat(file = "_site/index.html")

# Create NEWS page
readLines("resources/news.txt") |>
  paste0(collapse = "\n") |>
  glue::glue() |>
  cat(file = "_site/news.html")

# Create RESEARCH page
readLines("resources/research.txt") |>
  paste0(collapse = "\n") |>
  glue::glue() |>
  cat(file = "_site/research.html")

# Create MEMBERS page
readLines("resources/members.txt") |>
  paste0(collapse = "\n") |>
  glue::glue() |>
  cat(file = "_site/members.html")

# Create ABOUT page
readLines("resources/about.txt") |>
  paste0(collapse = "\n") |>
  glue::glue() |>
  cat(file = "_site/about.html")

# News posts ----------------------------------------------------------------------------------

root <- "../"

# Create news for sidebar within news directory
news_sidebar <- lapply(head(news, n = 3), news_generator, TRUE) |>
  paste0(collapse = "\n\n")

# Create new nested sidebar
sidebar_nested <- readLines("resources/sidebar.txt") |>
  paste0(collapse = "\n") |>
  glue::glue()

# Create news
for (i in current) {
  body <- readLines(paste0("news/news-", i, ".txt")) |>
    paste0(collapse = "\n")
  
  readLines("resources/news-template.txt") |> 
    paste0(collapse = "\n") |>
    glue::glue() |>
    cat(file = paste0("_site/news/news-", i, ".html"))
}


