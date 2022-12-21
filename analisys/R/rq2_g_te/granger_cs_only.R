library(lmtest)
library(tseries)
#library(RTransferEntropy)


apps=c("phpmyadmin", "dokuwiki", "opencart", "phpbb", "phppgadmin" , "mediawiki", "prestashop", "vanilla",
       "dolibarr", "roundcubemail", "openemr", "kanboard")


#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

outfile=paste0(path, "analysis/correlacao_4/rq2_g_te/data/granger_csonly_density.csv")


gg= function(xa, xb, nlag){
  g = grangertest( xb ~ xa, order=nlag )

  gp=g$`Pr(>F)`[2]
  if (gp <= 0.05 ){ gc="*" } else { gc="" }

  return (paste(round(gp, digits = 2), ";", gc))
}


loga= function (key, value, nlag){
   
   cat (paste(paste0("L", nlag, ":", key), value,  "\n"))
   cat(paste0(a, " ; " , paste0("l", nlag, ":", key), value), sep = "\n", file = outfile, append = TRUE)
   
}


doSixCombinations= function(nlag){
  
  g1=gg(xn_server,xn_client,nlag)
  loga ("server,client;", g1 , nlag)
  
  g2= gg(xn_server,xn_client_js,nlag)
  loga ("server,client_js;", g2, nlag)
  
  g3=gg(xn_client,xn_server,nlag)
  loga ("client,server;", g3, nlag)
  
  g4=gg(xn_client,xn_client_js, nlag)
  loga ("client,client_js;", g4, nlag)
  
  g5=gg(xn_client_js,xn_server, nlag)
  loga ("client,server;", g5, nlag)
  
  g6=gg(xn_client_js,xn_client, nlag)
  loga ("client_js,client;", g6, nlag)
}


for (app in apps){
  
  source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))
  #source(paste0(path, "analysis/correlacao_3_1file/code_smells_only_average_inc.R"))
  
  # pp.test(xn_server)
  # pp.test(xn_client)
  # pp.test(xn_client_js)
  
  
  a=app
  ################## g ##############################
  print (paste("======" , app, "=======\n"))
  cat("granger causality : p, issig\n")
  #lag1
 
  doSixCombinations(1)
  doSixCombinations(2)
  doSixCombinations(3)
  doSixCombinations(4)
  
  #print ("===========")
  
}
print ("end")