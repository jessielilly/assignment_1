---
  title: "as_2"
author: "Jessie Lilly"
date: "February 16, 2018"
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown


##load tidyverse

```{r}
blpw.all <- readRDS("~/RM11/assignment_2/blpw.all.RDS")
View(blpw.all)
```

## Delete rows that were not recaptured (N)

```{r}

blpw.recap <- filter(blpw.all,"recap" =="R")

```

## I then grouped the data by band

```{r}
blpw.recap %>% group_by(band)
```




