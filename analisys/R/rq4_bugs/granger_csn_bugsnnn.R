rm(list = ls())

#apps
# # # # # # ####### app="phppgadmin"
# # # # # # ####### app="mediawiki"


app = "phpmyadmin"
app="dokuwiki"
app="opencart"
app="phpbb"
app="prestashop"
app="vanilla"
app="dolibarr"
app="roundcubemail"
app="openemr"
app="kanboard"
#path

#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

path2=paste0(path, "analysis/correlacao_4/rq4_bugs/data_grangernnn/")

outfile1=paste0(path2, "lag1/granger_cs_bugs_", app, "_lag1.csv")
outfile2=paste0(path2, "lag2/granger_cs_bugs_", app, "_lag2.csv")
outfile3=paste0(path2, "lag3/granger_cs_bugs_", app, "_lag3.csv")
outfile4=paste0(path2, "lag4/granger_cs_bugs_", app, "_lag4.csv")

if (file.exists(outfile1)) { file.remove(outfile1) }
if (file.exists(outfile2)) { file.remove(outfile2) }
if (file.exists(outfile3)) { file.remove(outfile3) }
if (file.exists(outfile4)) { file.remove(outfile4) }

source(paste0(path, "analysis/correlacao_4/code_smells_bugs_inc.R"))

# library(RTransferEntropy)
library(lmtest)
#library(tseries)
#library(forecast)
x_issues = x_issues / cs_metrics$SUM * 1000   # for issuesn


########################################################################################

# #x_issues
# x_issues1=(lag(x_issues0))
# #x_issues1
# x_issues1[1]=0
# #x_issues1

for (i in 6:35){
#i=6
  
    a=colnames(cs_metrics)[i]

    
    unique=length(unique(cs_metrics[,i]))
    
    print(paste(a, " unique values:", unique))
    
    gp1= gp2 = gp3 = gp4 = 1
    
    if (sum(cs_metrics[, i]) == 0){
      gc1=gc2=gc3=gc4=0
    } else if (length(unique(cs_metrics[,i])) == 1 ){
      gc1=gc2=gc3=gc4= paste0(" all cs=",cs_metrics[1,i])
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

      
      g1 = grangertest( x_issues ~ x_series, order=1 )
      gp1=g1$`Pr(>F)`[2]
      if (gp1 <= 0.05 ){ gc1="*" } else { gc1="" }
      
      
      g2 = grangertest( x_issues ~ x_series, order=2 )
      gp2=g2$`Pr(>F)`[2]
      if (gp2 <= 0.05 ){ gc2="*" } else { gc2="" }
      
      if (unique <=3){
        
        gc3 = gc4 = "unique <=3"
      
      } else {
        
        g3 = grangertest( x_issues ~ x_series, order=3 )
        gp3=g3$`Pr(>F)`[2]
        if (gp3 <= 0.05 ){ gc3="*" } else { gc3="" }

    
        g4 = grangertest( x_issues ~ x_series, order=4 )
        gp4=g4$`Pr(>F)`[2]
        if (gp4 <= 0.05 ){ gc4="*" } else { gc4="" }
        
      }

      
    }   
    
    cat(paste0(a,"-" , 1," , " , gp1, " , " ,gc1, "\n "))
    cat(paste0(a, " ; " , gp1," ; " , gc1), sep = "\n", file = outfile1, append = TRUE)   

    cat(paste0(a,"-" , 2," , " , gp2, " , " ,gc2, "\n "))
    cat(paste0(a, " ; " , gp2," ; " , gc2), sep = "\n", file = outfile2, append = TRUE)
    
    cat(paste0(a,"-" , 3," , " , gp3, " , " ,gc3, "\n "))
    cat(paste0(a, " ; " , gp3," ; " , gc3), sep = "\n", file = outfile3, append = TRUE)
    
    cat(paste0(a,"-" , 4," , " , gp4, " , " ,gc4, "\n "))
    cat(paste0(a, " ; " , gp4," ; " , gc4), sep = "\n", file = outfile4, append = TRUE)
    
    print ("-------------------------")
}



