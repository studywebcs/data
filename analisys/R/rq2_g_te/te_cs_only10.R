library(tseries)
library(RTransferEntropy)
library(varhandle)

apps=c("phpmyadmin", "dokuwiki", "opencart", "phpbb", "phppgadmin" , "mediawiki", "prestashop", "vanilla",
       "dolibarr", "roundcubemail", "openemr", "kanboard")

#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

outfile=paste0(path, "analysis/correlacao_4/rq2_g_te/data/te08_csonly_by_klloc.csv")

ttee = function(xa, xb, nlag){
  
  
  
  
  te_result=transfer_entropy(xa, xb, nlag, nlag, 0.8, entropy=c('Renyi'), quiet=T , seed=TRUE,shuffles = 500)
  
  te1=te_result$coef[1,1]
  p1=te_result$coef[1,4]
  
  te2=te_result$coef[2,1]
  p2=te_result$coef[2,4]
  
  if (p1<= 0.05 ){ c1="*" } else {c1=""}
  if (p2<= 0.05 ){ c2="*" } else {c2=""}

  return (paste("TE:", round(te1, digits=2),  round(p1, digits=2), c1, round(te2, digits=2),  round(p2, digits=2), c2, sep=";"))
  
}

loga= function (key, value, nlag){
  
  key1=paste0("L", nlag, ":", key)
  cat (paste(key1, value,  "\n"))
  cat(paste0(a, " ; " , key1, value), sep = "\n", file = outfile, append = TRUE)
  
}

doSixCombinations= function(nlag){
  
  #  te1=ttee(xn_server,xn_client)
  #  loga ("server,client;", te1)
  
  te1=ttee(xn_server,xn_client,nlag)
  loga ("server,client;", te1 , nlag)
  
  te2= ttee(xn_server,xn_client_js,nlag)
  loga ("server,client_js;", te2, nlag)
  
  te3=ttee(xn_client,xn_server,nlag)
  loga ("client,server;", te3, nlag)
  
  te4=ttee(xn_client,xn_client_js, nlag)
  loga ("client,client_js;", te4, nlag)
  
  te5=ttee(xn_client_js,xn_server, nlag)
  loga ("client,server;", te5, nlag)
  
  te6=ttee(xn_client_js,xn_client, nlag)
  loga ("client_js,client;", te6, nlag)
}



for (app in apps){
  
  
  
  rm.all.but(c("app*", "path", "outfile"))

  source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))
  #source(paste0(path, "analysis/correlacao_3_1file/code_smells_only_average_inc.R"))

  # pp.test(xn_server)
  # pp.test(xn_client)
  # pp.test(xn_client_js)



  a=app
  ################## te ##############################
  print (paste("======" , app, "=======\n"))
  cat("transfer entropy : direct and reverse, TE, p, issig\n")

#  te1=ttee(xn_server,xn_client)
#  loga ("server,client;", te1)
  

  doSixCombinations(1)
  doSixCombinations(2)
  #doSixCombinations(3)
  #doSixCombinations(4)



  

}








