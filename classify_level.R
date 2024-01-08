library(dplyr)
data <- read.delim("~/Desktop/abhi1/kegg/abhi/data.tsv")
View(data)
colnames(data)<-c("level1","level2","level3","function.","Description")
pred_metagenome_unstrat_descrip <- read.delim("~/Desktop/abhi1/kegg/abhi/pred_metagenome_unstrat_descrip.tsv")
View(pred_metagenome_unstrat_descrip)
pred_metagenome_unstrat_descrip
table1<-data.frame(pred_metagenome_unstrat_descrip)
View(table1)
table2<-data.frame(data)
View(table2)
#######################level1########################################################
level1<-merge(table1, table2[, c("function.", "level1")], by="function.", all.x=TRUE)
result_level1 <- level1 %>%
  group_by(#function., 
           #description, 
           level1) %>%
  summarise(Chaetoceros = sum(Chaetoceros), Isochrysis = sum(Isochrysis),Prymnesium = sum(Prymnesium)) %>%
  ungroup()
View(result_level1)
write.table(result_level1, "result_level1.tsv", sep = '\t', row.names = FALSE)
#################################level2#############################################
level2<-merge(table1, table2[, c("function.", "level2")], by="function.", all.x=TRUE)
result_level2 <- level2 %>%
  group_by(#function., 
    #description, 
    level2) %>%
  summarise(Chaetoceros = sum(Chaetoceros), Isochrysis = sum(Isochrysis),Prymnesium = sum(Prymnesium)) %>%
  ungroup()
View(result_level2)
write.table(result_level2, "result_leve2.tsv", sep = '\t', row.names = FALSE)
#################################level3#############################################
level3<-merge(table1, table2[, c("function.", "level3")], by="function.", all.x=TRUE)
result_level3 <- level3 %>%
  group_by(#function., 
    #description, 
    level3) %>%
  summarise(Chaetoceros = sum(Chaetoceros), Isochrysis = sum(Isochrysis),Prymnesium = sum(Prymnesium)) %>%
  ungroup()
View(result_level3)
write.table(result_level3, "result_level3.tsv", sep = '\t', row.names = FALSE)
####################################################################################
library(dplyr)

# Your data
data <- data.frame(
  a = c("a1", "a1", "a2"),
  b = c("v1", "v1", "v2"),
  c = c(2, 5, 7),
  d = c(6, 7, 9)
)

# Group by columns 'a' and 'b' and summarize the data
result <- data %>%
  group_by(a, b) %>%
  summarise(c = sum(c), d = sum(d)) %>%
  ungroup()
