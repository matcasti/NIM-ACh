
# Instagram feed builder helper ---------------------------------------------------------------

fetch <- 2 # menu(choices = c("Yes", "No"), title = "Fetch data from profile?")

if (fetch == 1) {
  
  method_1 <- "https://www.instagram.com/nimach_group/channel/?__a=1"
  method_2 <- "https://www.instagram.com/nimach_group/?__a=1"
  
  httr::reset_config()
  
  # Method 1
  web_parsed <- httr::GET(url = method_1) |> 
    httr::content(as = "text", encoding = "UTF-8")
  
  shortcodes <- regmatches(
    x = web_parsed, 
    m = gregexpr(
      pattern = "\"shortcode\":\".{10,12}\"", 
      text = web_parsed
    ))[[1]]
  
  # Method 2 if method 1 does not work
  if (length(shortcodes) == 0) {
    web_parsed <- httr::GET(url = method_2) |> 
      httr::content(as = "text", encoding = "UTF-8")
    
    shortcodes <- regmatches(
      x = web_parsed, 
      m = gregexpr(
        pattern = "\"shortcode\":\".{10,12}\"", 
        text = web_parsed
      ))[[1]]
  }
  
  post_id <- shortcodes |> 
    gsub(pattern = "\"shortcode\":\"", replacement = "") |> 
    gsub(pattern = "\"", replacement = "")
  
  rm(web_parsed, shortcodes)
} else if (fetch == 2) {
  
  post_id <- data.table::fread(file = "resources/insta/post_ids.csv", key = "order")$post_id |> rev()
  
} else stop("fetch needs to be 1 or 2", call. = FALSE)

insta_feed_generator <- function(post_id) {
  readLines("resources/insta/insta_post.txt") |> 
    paste0(collapse = "\n") |> 
    glue::glue()
}
