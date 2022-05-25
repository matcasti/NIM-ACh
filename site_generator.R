
# Prepare workspace ---------------------------------------------------------------------------


# Load required libraries
library(glue)
library(httr)

# And source helper scritps
source("resources/news/helper.R")
source("resources/insta/helper.R")

# Remove directory if exists (fresh start)
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

  ## Create objects for glue replacement ------------------------------------------------------
  
    # Root (for sidebar in nested directories)
    root <- ""
    
    # Create news for sidebar
    news_sidebar <- lapply(tail(news, n = 3) |> rev(), news_generator, TRUE) |>
      paste0(collapse = "\n\n")
    
    # Create news for index and news page
    news_index <- lapply(tail(news) |> rev(), news_generator, FALSE) |>
      paste0(collapse = "\n\n")
      
    # Create sidebar
    sidebar <- readLines("resources/sidebar.txt") |>
      paste0(collapse = "\n") |>
      glue::glue()
    
    # Create social media icons
    social_media <- readLines("resources/social_media.txt") |>
      paste0(collapse = "\n")
    
    # Create google analytics HTML-JS tag
    g_analytics <- readLines("resources/g_analytics.txt") |> 
      paste0(collapse = "\n") 
    
    # Create lines of research
    rch_lines <- readLines("resources/rch_lines.txt") |> 
      paste0(collapse = "\n")
    
    insta_feed <- lapply(head(post_id), insta_feed_generator) |> 
      paste0(collapse = "\n\n")
    
    carousel <- readLines("resources/carousel.txt") |> 
      paste0(collapse = "\n")
    
    colaboration <- readLines("resources/colaboration.txt") |> 
      paste0(collapse = "\n")

  ## Create HTML files ------------------------------------------------------------------------
  
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
    
    # Create PROJECT page
    readLines("resources/project.txt") |>
      paste0(collapse = "\n") |>
      glue::glue() |>
      cat(file = "_site/project.html")
    
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
  news_sidebar <- lapply(tail(news, n = 3) |> rev(), news_generator, TRUE) |>
    paste0(collapse = "\n\n")
  
  # Create new nested sidebar
  sidebar_nested <- readLines("resources/sidebar.txt") |>
    paste0(collapse = "\n") |>
    glue::glue()
  
  # Create news
  for (i in current) {
    body <- readLines(paste0("resources/news/news-", i, ".txt")) |>
      paste0(collapse = "\n") |> 
      glue::glue()
    
    readLines("resources/news/news-template.txt") |> 
      paste0(collapse = "\n") |>
      glue::glue() |>
      cat(file = paste0("_site/news/news-", i, ".html"))
  }


