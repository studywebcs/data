rm(list = ls())

#apps
app = "phpmyadmin"
app ="dokuwiki"   #15,85
app="opencart" #15,85
app="phpbb" #20,80
# # # # # ####### app="phppgadmin"
# # # # # ####### app="mediawiki"
# app="prestashop"
# app="vanilla"
# app="dolibarr"
# app="roundcubemail"
app="openemr" #20,80
#app="kanboard"
#path

print(app)


#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

source(paste0(path, "analysis/correlacao_5/code_smells_issues_inc.R"))

outfilelm=paste0(path, "analysis/correlacao_5/rq3_issues/data_scope/lm/csn_lm_issues_", app, ".csv")
outfilete08=paste0(path, "analysis/correlacao_5/rq3_issues/data_scope/te08/te08_csn_issues_", app, ".csv")
outfilete08lag2=paste0(path, "analysis/correlacao_5/rq3_issues/data_scope/te08lag2/te08lag2_csn_issues_", app, ".csv")
outfilete08lag3=paste0(path, "analysis/correlacao_5/rq3_issues/data_scope/te08lag3/te08lag3_csn_issues_", app, ".csv")
outfilete08lag4=paste0(path, "analysis/correlacao_5/rq3_issues/data_scope/te08lag4/te08lag4_csn_issues_", app, ".csv")



library(RTransferEntropy)
####library(lmtest)
#library(tseries)


print (nrow(issues))

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




head(cs)

cs_scope=cbind.data.frame(cs$server_id, cs$client_id, cs$client_id)

for (i in 12:14){
  #i=21
  #i=8
  
  
  te = te2 = te11 = te12 = te21 = te22 = te31 = te32 = rr = 0
  p = p2 = p11 = p12 = p21 = p22 = p31 = p32 = pp = 0
  c= c2 = c11 = c12 = c21 = c22 = c31 = c32 = cc=  ""
  
  
  
  a=colnames(cs)[i]
  
  unique=length(unique(cs[,i]))
  
  print(paste(a, " unique values:", unique))
  
  if (sum(cs[, i]) == 0){
    te=0
  } else if (length(unique(cs[,i])) == 1 ){
    te = te11 = te21 = te31 = rr = cs[1,i]
    p = p11 = p21= p31 = pp = paste0(" all cs=",te)
    #} else if (a == "CouplingBetweenObjects"){
  } else if (unique <=2){
    c = c11 = c21 = c31 = cc = "unique <=2"
  } else {
    
    
    
    series = cs[,i]

    
    
    z_series = zoo(series, cs$date)
    x_series = as.xts(z_series)
    
    
    
    #calc_te()
    
    te_result=transfer_entropy(x=x_series, y=x_issues, lx=1, ly=1, q=0.8, entropy=c('Renyi') ,quiet=TRUE ,  seed=TRUE,shuffles = 500, quantiles = c(20,80))
    
    te=te_result$coef[1,1]
    p=te_result$coef[1,4]
    
    te2=te_result$coef[2,1]
    p2=te_result$coef[2,4]
    
    if (p<= 0.05 ){ c="*" } else {c=""}
    if (p2<= 0.05 ){ c2="*" } else {c2=""}
    
    
    te_result1=transfer_entropy(x_series, x_issues, 2, 2, 0.8, entropy=c('Renyi'), quiet=T, seed=TRUE,shuffles = 500, quantiles = c(20,80))
    
    te11=te_result1$coef[1,1]
    p11=te_result1$coef[1,4]
    
    te12=te_result1$coef[2,1]
    p12=te_result1$coef[2,4]
    
    if (p11<= 0.05 ){ c11="*" } else {c11=""}
    if (p12<= 0.05 ){ c12="*" } else {c12=""}
    
    
    te_result2=transfer_entropy(x_series, x_issues, 3, 3, 0.8, entropy=c('Renyi'), quiet=T , seed=TRUE,shuffles = 500, quantiles = c(20,80))
    
    te21=te_result2$coef[1,1]
    p21=te_result2$coef[1,4]
    
    te22=te_result2$coef[2,1]
    p22=te_result2$coef[2,4]
    
    if (p21<= 0.05 ){ c21="*" } else {c21=""}
    if (p22<= 0.05 ){ c22="*" } else {c22=""}
    
    
    
    te_result3=transfer_entropy(x_series, x_issues, 4, 4, 0.8, entropy=c('Renyi'), quiet=T , seed=TRUE,shuffles = 500, quantiles = c(20,80))
    
    te31=te_result3$coef[1,1]
    p31=te_result3$coef[1,4]
    
    te32=te_result3$coef[2,1]
    p32=te_result3$coef[2,4]
    
    if (p31<= 0.05 ){ c31="*" } else {c31=""}
    if (p32<= 0.05 ){ c32="*" } else {c32=""}
    
    
    ################ lm ##################################
    
    fit <- lm(x_issues ~ x_series)
    
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