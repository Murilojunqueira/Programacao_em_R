

# Função para enviar os detalhes das respostas dos alunos
submit_log <- function(){
  
  ## Link do meu formulário
  gformrURL <- "https://docs.google.com/forms/d/1VuhpXOLVxnC3Emq_jjRWJs8dlyLV1WcfC2BLQIXugyo/prefill"
  
  
  # Please edit the link below
  ## link da função original
  #pre_fill_link <- "https://docs.google.com/forms/d/1ngWrz5A5w5RiNSuqzdotxkzgk0DKU-88FmnTHj20nuI/viewform?entry.1733728592"
  
  # Do not edit the code below
  #if(!grepl("=$", pre_fill_link)){
  #  pre_fill_link <- paste0(pre_fill_link, "=")
  #}
  
  # Retorna TRUE se o usuário não quiser enviar a resposta ao instrutor.
  e <- get("e", parent.frame())
  if(e$val == "No" | e$val == "Nao") return(TRUE)
  
  
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
  # browseURL(paste0(pre_fill_link, encoded_log))
  
  # Novo mecanismo de feedback
  ping <- googleformr::gformr(gformrURL)
  ping(encoded_log)
  
  # Aviso envio do formulário
  message("Respostas enviadas ao instrutor!")
  
  # Finaliza a questão
  return(TRUE)
  
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
