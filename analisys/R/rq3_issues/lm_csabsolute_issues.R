rm(list = ls())

#apps
# # # # # ####### app="phppgadmin"
# # # # # ####### app="mediawiki"


app = "phpmyadmin"
app="prestashop"
app="vanilla"
app="dolibarr"
app="roundcubemail"
app="kanboard"
# 
app ="dokuwiki"   #15,85
app="opencart" #20,80
app="phpbb" #20,80
app="openemr" #20,80

#path

print(app)


#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

source(paste0(path, "analysis/correlacao_4/code_smells_issues_inc.R"))

outfilelm=paste0(path, "analysis/correlacao_4/rq3_issues/data_absolute/lm/csabs_lm_issues_", app, ".csv")


print (nrow(issues))

#x_issues =x_issues / (cs$serverLOC + cs$clientLOC) teste
########################################################################################
if (file.exists(outfilelm)) { file.remove(outfilelm) }

cat(paste0("CS; r^2; p; issig"), sep = "\n", file = outfilelm)

#### teste length(unique(cs_metrics[,12]))
for (i in 6:35){
#i=21
#i=8
  
  
  rr = 0
  pp = 0
  cc=  ""

  a=colnames(cs_metrics)[i]
  
  unique=length(unique(cs_metrics[,i]))
  
  print(paste(a, " unique values:", unique))
  
  if (sum(cs_metrics[, i]) == 0){
    rr=0
  } else if (length(unique(cs_metrics[,i])) == 1 ){
    rr = cs_metrics[1,i]
    pp = paste0(" all cs=",rr)
  #} else if (a == "CouplingBetweenObjects"){
  } else if (unique <=2){
    cc = "unique <=2"
  } else {

    
    
    series = cs_metrics[,i]
    # if (i <= 23) {
    #   series=series/cs_metrics$PHP * 1000
    # } else if (i <=29){
    #   series = series / cs_metrics$Client *1000
    # } else {
    #   series = series / cs_metrics$JavaScript *1000
    # }

    
    z_series = zoo(series, cs$date)
    x_series = as.xts(z_series)
    

    
    ################ lm ##################################
    
    fit <- lm(x_issues ~ x_series)
    
    suma=summary(fit)
    pp=suma$coefficients[2,4]
    rr=suma$r.squared
    
    if (pp <= 0.05 ){ cc="*" } else { cc="" }
    
  }
  
  cat(paste0(a, " , " , rr, " , " , pp, " , " , cc, " \n "))
  cat(paste0(a, " ; " , rr, " ; " , pp, " ; " , cc), sep = "\n", file = outfilelm, append = TRUE)
  
  print ("-----------------")
}
print ("end")


