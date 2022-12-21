rm(list = ls())

#apps
app = "phpmyadmin"
app ="dokuwiki"   
app="opencart" #20,80
app="phpbb"
app="phppgadmin" #20,80
# app="mediawiki"
# app="prestashop"
# app="vanilla"
# app="dolibarr"
# app="roundcubemail"
# app="openemr"  #15,85
app="kanboard"
#path

print(app)


#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))

outfilelm=paste0(path, "analysis/correlacao_4/rq5_time_to_release/data/lm/csn_lm_ttr_", app, ".csv")
outfilete08=paste0(path, "analysis/correlacao_4/rq5_time_to_release/data/te08/te08_csn_ttr_", app, ".csv")
outfilete08lag2=paste0(path, "analysis/correlacao_4/rq5_time_to_release/data/te08lag2/te08lag2_csn_ttr_", app, ".csv")
outfilete08lag3=paste0(path, "analysis/correlacao_4/rq5_time_to_release/data/te08lag3/te08lag3_csn_ttr_", app, ".csv")
outfilete08lag4=paste0(path, "analysis/correlacao_4/rq5_time_to_release/data/te08lag4/te08lag4_csn_ttr_", app, ".csv")


library(RTransferEntropy)
####library(lmtest)
#library(tseries)


print (nrow(x_versionage))

#x_issues =x_issues / (cs$serverLOC + cs$clientLOC) teste
########################################################################################
if (file.exists(outfilelm)) { file.remove(outfilelm) }
if (file.exists(outfilete08)) { file.remove(outfilete08) }
if (file.exists(outfilete08lag2)) { file.remove(outfilete08lag2) }
if (file.exists(outfilete08lag3)) { file.remove(outfilete08lag3) }
if (file.exists(outfilete08lag4)) { file.remove(outfilete08lag4) }

cat(paste0("CS; te; p; issig; te2; p2; issig2"), sep = "\n", file = outfilete08)
cat(paste0("CS; te; p; issig; te2; p2; issig2"), sep = "\n", file = outfilete08lag2)
cat(paste0("CS; te; p; issig; te2; p2; issig2"), sep = "\n", file = outfilete08lag3)
cat(paste0("CS; te; p; issig; te2; p2; issig2"), sep = "\n", file = outfilete08lag4)
cat(paste0("CS; r^2; p; issig"), sep = "\n", file = outfilelm)

#### teste length(unique(cs_metrics[,12]))
for (i in 6:35){
#i=21
#i=8
  
  
  te = te2 = te11 = te12 = te21 = te22 = te31 = te32 = rr = 0
  p = p2 = p11 = p12 = p21 = p22 = p31 = p32 = pp = 0
  c= c2 = c11 = c12 = c21 = c22 = c31 = c32 = cc=  ""

  
  
  a=colnames(cs_metrics)[i]
  
  unique=length(unique(cs_metrics[,i]))
  
  print(paste(a, " unique values:", unique))
  
  if (sum(cs_metrics[, i]) == 0){
    te=0
  } else if (length(unique(cs_metrics[,i])) == 1 ){
    te = te11 = te21 = te31 = rr = cs_metrics[1,i]
    p = p11 = p21= p31 = pp = paste0(" all cs=",te)
  #} else if (a == "CouplingBetweenObjects"){
  } else if (unique <=2){
    c = c11 = c21 = c31 = cc = "unique <=2"
  } else {

    
    
    series = cs_metrics[,i]
    if (i <= 23) {
      series=series/cs_metrics$PHP * 1000
    } else if (i <=29){
      series = series / cs_metrics$Client *1000
    } else {
      series = series / cs_metrics$JavaScript *1000
    }

    
    z_series = zoo(series, cs$date)
    x_series = as.xts(z_series)
    

    
    #calc_te()
    
    te_result=transfer_entropy(x=x_series, y=x_versionage, lx=1, ly=1, q=0.8, entropy=c('Renyi') ,quiet=TRUE ,  seed=TRUE,shuffles = 500, quantiles = c(10,90))
    
    te=te_result$coef[1,1]
    p=te_result$coef[1,4]
    
    te2=te_result$coef[2,1]
    p2=te_result$coef[2,4]
    
    if (p<= 0.05 ){ c="*" } else {c=""}
    if (p2<= 0.05 ){ c2="*" } else {c2=""}
    
    
    te_result1=transfer_entropy(x_series, x_versionage, 2, 2, 0.8, entropy=c('Renyi'), quiet=T, seed=TRUE,shuffles = 500, quantiles = c(10,90))
    
    te11=te_result1$coef[1,1]
    p11=te_result1$coef[1,4]
    
    te12=te_result1$coef[2,1]
    p12=te_result1$coef[2,4]
    
    if (p11<= 0.05 ){ c11="*" } else {c11=""}
    if (p12<= 0.05 ){ c12="*" } else {c12=""}
    
    
    te_result2=transfer_entropy(x_series, x_versionage, 3, 3, 0.8, entropy=c('Renyi'), quiet=T , seed=TRUE,shuffles = 500, quantiles = c(10,90))
    
    te21=te_result2$coef[1,1]
    p21=te_result2$coef[1,4]
    
    te22=te_result2$coef[2,1]
    p22=te_result2$coef[2,4]
    
    if (p21<= 0.05 ){ c21="*" } else {c21=""}
    if (p22<= 0.05 ){ c22="*" } else {c22=""}
    
    
    
    te_result3=transfer_entropy(x_series, x_versionage, 4, 4, 0.8, entropy=c('Renyi'), quiet=T , seed=TRUE,shuffles = 500, quantiles = c(10,90))
    
    te31=te_result3$coef[1,1]
    p31=te_result3$coef[1,4]
    
    te32=te_result3$coef[2,1]
    p32=te_result3$coef[2,4]
    
    if (p31<= 0.05 ){ c31="*" } else {c31=""}
    if (p32<= 0.05 ){ c32="*" } else {c32=""}
    
    
    ################ lm ##################################
    
    fit <- lm(x_versionage ~ x_series)
    
    suma=summary(fit)
    pp=suma$coefficients[2,4]
    rr=suma$r.squared
    
    if (pp <= 0.05 ){ cc="*" } else { cc="" }
    
  }
  cat(paste0(a, " , " , te," , " , p, " , " ,c, " , " , te2," , " , p2, " , " ,c2, "\n "))
  cat(paste0(a, " ; " , te," ; " , p, " ; " ,c, " ; " , te2," ; " , p2, " ; " ,c2), sep = "\n", file = outfilete08, append = TRUE)

  
  cat(paste0(a, " , " , te11," , " , p11, " , " ,c11, " , " , te12," , " , p12, " , " ,c12, "\n "))
  cat(paste0(a, " ; " , te11," ; " , p11, " ; " ,c11, " ; " , te12," ; " , p12, " ; " ,c12), sep = "\n", file = outfilete08lag2, append = TRUE)

  cat(paste0(a, " , " , te21," , " , p21, " , " ,c21, " , " , te22," , " , p22, " , " ,c22, "\n "))
  cat(paste0(a, " ; " , te21," ; " , p21, " ; " ,c21, " ; " , te22," ; " , p22, " ; " ,c22), sep = "\n", file = outfilete08lag3, append = TRUE)

  cat(paste0(a, " , " , te31," , " , p31, " , " ,c31, " , " , te32," , " , p32, " , " ,c32, "\n "))
  cat(paste0(a, " ; " , te31," ; " , p31, " ; " ,c31, " ; " , te32," ; " , p32, " ; " ,c32), sep = "\n", file = outfilete08lag4, append = TRUE)


  cat(paste0(a, " , " , rr, " , " , pp, " , " , cc, " \n "))
  cat(paste0(a, " ; " , rr, " ; " , pp, " ; " , cc), sep = "\n", file = outfilelm, append = TRUE)
  
  print ("-----------------")
}
print ("end")


