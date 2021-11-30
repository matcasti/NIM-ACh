
# News builder helper -------------------------------------------------------------------------

news_generator <- function(news, for_sidebar = TRUE) {

  sidebar <- '
  <article>
  	<a href="{root}news/news-{news$current}.html" class="image"><img src="{root}images/{news$img}" alt="" /></a>
  	<p>{news$main}</p>
  </article>
  '
  index_or_news <- '
  <article>
  	<a href="{root}news/news-{news$current}.html" class="image"><img src="{root}images/{news$img}" alt="" /></a>
  	<h3>{news$main}</h3>
  	<p>{news$desc}</p>
  	<ul class="actions">
  		<li><a href="{root}news/news-{news$current}.html" class="button">Más</a></li>
  	</ul>
  </article>
  '
  if (isTRUE(for_sidebar)) {
    glue::glue(sidebar)
  } else if (isFALSE(for_sidebar)) {
    glue::glue(index_or_news)
  } else stop("for_sidebar must be a logical of length one", call. = F)
}

# Posts ----
news <- list(
  ## Post 1 ----
  list(
    current = 1,
    # Title of post
    main = "Hemos vuelto a crear fuertes alianzas con el proyecto MEDIANTAR de la Universidad de Minas Gerais, Brasil",
    # Description of article
    desc = "Se establecen acuerdos y colaboración para la campaña Antártica 2021-2022 entre Brasil, Perú y Chile.", 
    # Main picture for post (path to file)
    img = "news-1-fig-1.png"
  )
  
  ## Post 2 ----
  , list(
    current = 2,
    # Title of post
    main = "NIM-ACh formará parte de los evaluadores del 1er Concurso de Innovación, Ciencia y Tecnología de HABITAT",
    # Description of article
    desc = "Este proyecto es desarrollado por la Universidad Arturo Prat de Chile y cuenta con la colaboración de destacados profesores en el campo de la investigación del clima extremo en el país.", 
    # Only name of file (with file extension)
    img = "news-2-fig-1.png"
  )
  
  ## Post 3 ----
  , list(
    current = 3,
    # Title of post
    main = "Profesora colaboradora de NIM-ACh, expondrá en un Seminario Colombiano",
    # Description of article
    desc = "Ruby mendez, profesora colaboradora de NIM-ACh, expondrá en el Seminario Colombiano de Actualización en Educación Física, Recreación Y Deportes de la Universidad de Cundinamarca.", 
    # Only name of file (with file extension)
    img = "news-3-fig-1.png"
  )
)

# Number of current posts
current <- seq_len(length.out = length(news))