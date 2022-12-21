rm(list = ls())

#apps
app = "phpmyadmin"
# app="dokuwiki"
# app="opencart"
# app="phpbb"
# # # ####### app="phppgadmin"
# # # ####### app="mediawiki"
# app="prestashop"
# app="vanilla"
# app="dolibarr"
# app="roundcubemail"
# app="openemr"
# app="kanboard"
#path

print(app)

#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

source(paste0(path, "analysis/correlacao_4/code_smells_issues_inc.R"))

outfileg=paste0(path, "analysis/correlacao_4/rq3_issues/data_cor/cor_spearman_csn_issues_", app, ".csv")


#library(RTransferEntropy)
#library(lmtest)
#library(tseries)
#library(forecast)

########################################################################################

cat(paste0("CS; cor"), sep = "\n", file = outfileg)

#### teste length(unique(cs_metrics_after[,12]))
for (i in 6:35){
#i=6
  

    a=colnames(cs_metrics)[i]
    
    if (sum(cs_metrics[, i]) == 0){
      gp=glp=gdp= "all 0"
      gc=glc=gdc= 0
    } else if (length(unique(cs_metrics[,i])) == 1 ){
      
      gp=glp=gdp="all the same value="
      gc=glc=gdc= cs_metrics[1,i]
    } else {

      
      series = cs_metrics[,i]
      if (i <= 23) {
        series = series / cs_metrics$PHP *1000
      } else if (i <=29){
        series = series / cs_metrics$Client *1000
      } else {
        series = series / cs_metrics$JavaScript *1000
      }
  
      z_series = zoo(series, cs$date)
      x_series = as.xts(z_series)
      
      ca=cor(x_series,x_issues, method = "spearman")
      #ca=cor(series, issues_df$nissues)
      
    } 
    
    
     #print (g$`Pr(>F)`[2])
      cat(paste0(a, " , " , ca,  "\n "))
      cat(paste0(a, " ; " , ca), sep = "\n", file = outfileg, append = TRUE)
    
  

    print ("-------------------------")
}
  
