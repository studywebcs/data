#apps
app = "phpmyadmin"
app="dokuwiki"
app="opencart"
app="phpbb"
app="phppgadmin"
app="mediawiki"
app="prestashop"
app="vanilla"
app="dolibarr"
app="roundcubemail"
app="openemr"
app="kanboard"

path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"

output_dir= paste0(path, "analysis/correlacao_4/rq1_evolution/g_cs_group/")

source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))

############################# intensity ###################

cs_i= cs[ , c("date", "server_i", "client_i", "client_js_i")] 

cs1 = melt(cs_i, id.vars="date")

ggplot(cs1, aes(date,value, col=variable)) + geom_line(size=1.2) +
  labs(x = "Date (years)", y = "cs") +
  scale_x_date(date_breaks = "1 years",date_labels = "%y")+
  ggtitle(app) +
  theme(
    legend.position = "none", 
    #legend.position = "top",
    text = element_text(size = 16)
  )

ggsave(file=paste0(output_dir, app , "_evol_cs_group_absolute.svg"), width = 10, height = 6.5)

#######################  density of intensity #####################

cs_id= cs[ , c("date", "server_id", "client_id", "client_js_id")]  

cs2 = melt(cs_id, id.vars="date")

#cs_server_intensity
ggplot(cs2, aes(date,value, col=variable)) + geom_line(size=1.2) +
  labs(x = "Date (years)", y = "cs") +
  scale_x_date(date_breaks = "1 years",date_labels = "%y")+
  ggtitle(app) +
  theme(
      legend.position = "none", 
      text = element_text(size = 16)
  )
  #theme(legend.position = "top")


ggsave(file=paste0(output_dir, app , "_evol_cs_group_density.svg"), width = 10, height = 6.5)
