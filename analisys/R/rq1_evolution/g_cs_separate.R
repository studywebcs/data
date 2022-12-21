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

output_dir= paste0(path, "analysis/correlacao_4/rq1_evolution/g_cs_separate/")

source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))

# read data code smells (cs_client_docuwiki, cs_cliente_js_docuwiki, cs_server_docuwiki)
cs_server <- cs_metrics[, 6:23] 
cs_client <- cs_metrics[, 24:29] 
cs_client_js <- cs_metrics[, 30:35]

metrics= cbind.data.frame("Server side LOC"=cs$serverLOC, 
                          "Client side LOC"=cs_metrics$Client,
                          "Client Side JavaScript LOC"=cs$client_jsLOC,
                          "TotalLOC"=cs_metrics$SUM)

########## raw plots ############
plotCS = function(dat, type){
  
  d = data.frame(dat[, 1:ncol(dat)])
  d$Date= as.Date(cs_metrics$Date)
  
  d <- melt(d, id.vars="Date")
  
  # Everything on the same plot
  ggplot(d, aes(Date,value, col=variable)) + geom_line(size=1.2) +
    labs(x = "Date (years)", y = type) +
    scale_x_date(date_breaks = "1 years",date_labels = "%y")+
    #ggtitle(app, subtitle = type)+
    ggtitle(paste(app,"- evolution of",type))+
    theme(
    legend.position="right",
  #legend.position = "none",
    legend.margin=margin(c(0,0,-0.5,0), unit="line"), text = element_text(size = 16)
  )
  
  #,legend.text=element_text(size=8) 
  ggsave(file=paste0(output_dir, app , "_evol_", type ,".svg"), width = 10, height = 6.5)
}

plotCS(cs_server, "code smells server")
plotCS(cs_client, "code smells client")
plotCS(cs_client_js, "code smells client js")
plotCS(metrics, "metrics")


cs_server_d = cs_server / cs$serverLOC * 1000
cs_client_d = cs_client / cs$clientLOC * 1000
cs_client_js_d = cs_client_js / cs$client_jsLOC * 1000


plotCS(cs_server_d, "code smells density server")
plotCS(cs_client_d, "code smells density  client")
plotCS(cs_client_js_d, "code smells client density  js")

print ( head(cs$date) )
print ( head(cs_server$CyclomaticComplexity) )
print ( head(cs$serverLOC) )
print ( head(cs_server_d$CyclomaticComplexity) )

## ver se bate certo





