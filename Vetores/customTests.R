
# Formula para notificar a conclusão da mensagem por email
notify <- function() {
  e <- get("e", parent.frame())
  if(e$val == "Nao") return(TRUE)
  
  good <- FALSE
  while(!good) {
    # Get info
    name <- readline_clean("Qual seu nome completo? ")
    name <- enc2utf8(name)
    address <- readline_clean("Qual o e-mail da pessoa que quer notificar (seu instrutor)? ")
    
    # Repeat back to them
    message("\nOs dados abaixo estao corretos?\n")
    message("Seu nome: ", name, "\n", "Enviar Para: ", address)
    
    yn <- select.list(c("Sim", "Não"), graphics = FALSE)
    if(yn == "Sim") good <- TRUE
  }
  
  # Get course and lesson names
  course_name <- attr(e$les, "course_name")
  lesson_name <- attr(e$les, "lesson_name")
  
  subject <- paste(name, "acabou de completar", course_name, "-", lesson_name)
  body = ""
  
  # Send email
  swirl:::email(address, subject, body)
  
  # Enviar detalhes
  submit_log()
  
  hrule()
  message("Eu acabei de criar um novo email com os seguintes dados:\n")
  message("Para: ", address)
  message("Assunto: ", subject)
  message("Corpo: <vazio>")
  
  message("\nSe o email nao foi enviado, voce pode envia-lo manualmente.")
  hrule()
  

  
  # Return TRUE to satisfy swirl and return to course menu
  TRUE
}

# Duas funções auxiliares para a função acima.

readline_clean <- function(prompt = "") {
  wrapped <- strwrap(prompt, width = getOption("width") - 2)
  mes <- stringr::str_c("| ", wrapped, collapse = "\n")
  message(mes)
  readline()
}

hrule <- function() {
  message("\n", paste0(rep("#", getOption("width") - 2), collapse = ""), "\n")
}

# Função para enviar os detalhes das respostas dos alunos
submit_log <- function(){
  
  # Please edit the link below
  ## link da função original
  #pre_fill_link <- "https://docs.google.com/forms/d/1ngWrz5A5w5RiNSuqzdotxkzgk0DKU-88FmnTHj20nuI/viewform?entry.1733728592"
  
  ## Link do meu formulário
  pre_fill_link <- "https://docs.google.com/forms/d/e/1FAIpQLSen_pX0d_W7ElCQRUJxShBSnQ9a9lqHYshUUXopfH5eZEgfcA/viewform?usp=pp_url&entry.167070803"
  
  # Do not edit the code below
  if(!grepl("=$", pre_fill_link)){
    pre_fill_link <- paste0(pre_fill_link, "=")
  }
  
  p <- function(x, p, f, l = length(x)){if(l < p){x <- c(x, rep(f, p - l))};x}
  
  temp <- tempfile()
  log_ <- getLog()
  nrow_ <- max(unlist(lapply(log_, length)))
  log_tbl <- data.frame(user = rep(log_$user, nrow_),
                        course_name = rep(log_$course_name, nrow_),
                        lesson_name = rep(log_$lesson_name, nrow_),
                        question_number = p(log_$question_number, nrow_, NA),
                        correct = p(log_$correct, nrow_, NA),
                        attempt = p(log_$attempt, nrow_, NA),
                        skipped = p(log_$skipped, nrow_, NA),
                        datetime = p(log_$datetime, nrow_, NA),
                        stringsAsFactors = FALSE)
  write.csv(log_tbl, file = temp, row.names = FALSE)
  encoded_log <- base64encode(temp)
  browseURL(paste0(pre_fill_link, encoded_log))
}


# Duas funções auxiliares para a função acima.

# Get the swirl state
getState <- function(){
  # Whenever swirl is running, its callback is at the top of its call stack.
  # Swirl's state, named e, is stored in the environment of the callback.
  environment(sys.function(1))$e
}

# Retrieve the log from swirl's state
getLog <- function(){
  getState()$log
}

# End
