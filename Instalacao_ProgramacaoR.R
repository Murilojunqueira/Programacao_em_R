# Arquivo de Instalação do curso 'Programação em R'

if(!"swirl" %in% rownames(installed.packages())) {install.packages("swirl")}
library(swirl)
select_language(language = "portuguese")
try(uninstall_course("Programacao em R"), silent = TRUE)
install_course_github("Murilojunqueira", "Programacao_em_R")


swirl()
