# Programacao_em_R

Tradução do para o português curso Swril [R Programming Alt](https://github.com/swirldev/swirl_courses/tree/master/R_Programming_Alt), criado para a [Especialização em Ciência de Dados](https://www.coursera.org/specializations/jhu-data-science), Coursera.



### Instalação com o github

Execute os comandos abaixo no R para instalar o curso. Requer conexão com a internet.

```r
if(!"swirl" %in% rownames(installed.packages())) {install.packages("swirl")}
library(swirl)
select_language(language = "portuguese")
try(uninstall_course("Programacao em R"), silent = TRUE)
install_course_github("Murilojunqueira", "Programacao_em_R")
```

### Fazendo o curso

Para acessar o curso, basta executar as seguintes linhas:

```r
library(swirl)
select_language(language = "portuguese")
swirl()
```

E então seguir o caminho dentro do swirl até o curso "Programacao em R"


### Instalação Manual

1. baixe [esse arquivo](https://github.com/Murilojunqueira/Programacao_em_R/blob/master/Instalacao_ProgramacaoR.R).
2. Coloque o arquivo no seu diretório de trabalho
3. Digite (ou copie) no console do R:

```r
source("Instalacao_ProgramacaoR.R")
```



### Ajuda

Para entrar em contato comigo para essa tradução, me envie um email para mjunqueira@ufpa.br

Para entrar em contato com os criadores do swirl vá em  http://swirlstats.com/, 

Ou envie um email para info@swirlstats.com