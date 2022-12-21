library(lmtest)
library(tseries)
#library(RTransferEntropy)


apps=c("phpmyadmin", "dokuwiki", "opencart", "phpbb", "phppgadmin" , "mediawiki", "prestashop", "vanilla",
       "dolibarr", "roundcubemail", "openemr", "kanboard")


#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

outfile=paste0(path, "analysis/correlacao_4/rq2_g_te/data/cor_csonly_absolute.csv")


gg= function(xa, xb){
  
  ca=cor(xa,xb)
  return (paste(round(ca, digits = 2)))
  
  
}


loga= function (key, value){
   
   cat (paste(key, value,  "\n"))
   cat(paste0(a, " ; " ,  key, value), sep = "\n", file = outfile, append = TRUE)
   
   
}


doSixCombinations= function(){
  
  g1=gg(x_server,x_client)
  loga ("server,client;", g1)
  
  g2= gg(x_server,x_client_js)
  loga ("server,client_js;", g2)
  
  # g3=gg(xn_client,xn_server)
  # loga ("client,server;", g3)
  
  g4=gg(x_client,x_client_js)
  loga ("client,client_js;", g4)
  
  # g5=gg(xn_client_js,xn_server)
  # loga ("client,server;", g5)
  # 
  # g6=gg(xn_client_js,xn_client)
  # loga ("client_js,client;", g6)
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
  cat("correlation : p, issig\n")
  #lag1
 
  doSixCombinations()

  
  #print ("===========")
  
}
print ("end")