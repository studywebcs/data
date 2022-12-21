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

#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

output_dir= paste0(path, "analysis/correlacao_4/rq1_relationship_cs/corr_matrix_order/")

source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))

cs_server <- cs_metrics[, 6:23] 
cs_client <- cs_metrics[, 24:29] 
cs_client_js <- cs_metrics[, 30:35]

cs_server=cs_server[, colSums(cs_server != 0) > 0]   #remove with zeros

s<-ts(cs_server[,1:ncol(cs_server)])
c<-ts(cs_client[,1:ncol(cs_client)])
j<-ts(cs_client_js[,1:ncol(cs_client_js)])

library(corrplot)
library(svglite)
#library(RColorBrewer)
#source("http://www.sthda.com/upload/rquery_cormat.r")


 # corrplot(cor(s,s), method = "circle", tl.col = "black", na.label="-", addCoef.col = TRUE, number.digits = 1, number.cex=0.75,
 #          type = 'upper', diag = FALSE, order="FPC")

# type = 'upper', diag = FALSE, order="FPC")

gencor = function (a,b, name, size){
    svg(file=paste0(output_dir ,app, name,".svg"),width=size)#, pointsize=12)
        
  corrplot(cor(a,b), method = "circle", tl.col = "black", na.label="-", 
           addCoef.col = TRUE, number.digits = 1, number.cex=0.75,
           type = 'upper', diag = FALSE, order="FPC")
  dev.off()
}

#type upper nao da para os cruzados 

gencor(s,s, "_server_server", 10)
gencor(c,c, "_client_client" , 5)
gencor(j,j, "_javascript_javascript", 5)

#gencor(s,c, "_server_client" , 10)
#gencor(s,j, "_server_javascript", 10)
#gencor(c,j, "_client_javascript", 5)




### Error in eigen(corr) : non-square matrix in 'eigen'
# para as nao quadradas 


