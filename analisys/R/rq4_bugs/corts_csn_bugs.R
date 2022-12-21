rm(list = ls())

#apps
app = "phpmyadmin"
app ="dokuwiki"
app="opencart"
app="phpbb"
# # # # ####### app="phppgadmin"
# # # # ####### app="mediawiki"
app="prestashop"
app="vanilla"
app="dolibarr"
app="roundcubemail"
app="openemr"
app="kanboard"

print(app)
#path
#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

source(paste0(path, "analysis/correlacao_4/code_smells_bugs_day_cor_inc.R"))

outfile=paste0(path, "analysis/correlacao_4/rq4_bugs/data_corts/corts_csn_bugs_", app, ".csv")


sink()


####  calculate correlation - other way, using library Bincor

v4=cbind(as.Date(issues$date), issues$nissues)   


print ("cor_ts ,  p   , sig")

cat(paste0("CS; cor_ts; p; sig"), sep = "\n", file = outfile, append = TRUE)

for (i in 6:35){
  a=colnames(cs_metrics)[i]
  if (sum(cs_metrics[, i]) == 0){
    b=0
    p=""
    c=""
  } else if (length(unique(cs_metrics[,i])) == 1 ){
    b=cs_metrics[1,i]
    p=paste0(" all cs=",b)
    c=""
    
  } else {
    series = cs_metrics[,i]
    if (i <= 23) {
      series=series/cs_metrics$PHP * 1000
    } else if (i <=29){
      series = series / cs_metrics$Client *1000
    } else {
      series = series / cs_metrics$JavaScript *1000
    }
    
    v=cbind(date_d, series )
    sink("NUL")
    bincorA.tmp <- bin_cor((v), (v4), FLAGTAU=3, "newnameA.tmp")
    
    binnedtsA <- bincorA.tmp$Binned_time_series
    cor1 =  cor_ts(binnedtsA[,1:2], binnedtsA[,c(1,3)],KoCM="pearson")
    sink()
    b=round(cor1$estimate, 2)
    p=round(cor1$p.value, 5)
    #p=format(cor1$p.value, scientific = FALSE)
    
    if (p<= 0.05 )
      c="  *"
    else
      c=""
    
  }

  
  cat (paste0(a, ", ",b ,", ",  p ,", ", c ,"\n"))
  cat(paste0(a, " ; " , b, " ; " , p, " ; ", c), sep = "\n", file = outfile, append = TRUE)
}
print (paste("end", app))


