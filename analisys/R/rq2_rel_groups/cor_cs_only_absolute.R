#apps
#app = "phpmyadmin"
#app="dokuwiki"
# app="opencart"
# app="phpbb"
# app="phppgadmin"
#app="mediawiki"
#app="prestashop"
#app="vanilla"
#app="dolibarr"
#app="roundcubemail"
#app="openemr"
#app="kanboard"

library(tseries)
library(RTransferEntropy)

apps=c("phpmyadmin", "dokuwiki", "opencart", "phpbb", "phppgadmin" , "mediawiki", "prestashop", "vanilla",
       "dolibarr", "roundcubemail", "openemr", "kanboard")

path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"

outfile=paste0(path, "analysis/correlacao_4/rq2_rel_groups/data/cor_csonly_absolute.csv")

loga= function (key, value){
  
  cat (paste(key, value,  "\n"))
  cat(paste0(a, " ; " , key, value), sep = "\n", file = outfile, append = TRUE)
  
}

for (app in apps){

  source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))
  #source(paste0(path, "analysis/correlacao_4/code_smells_only_average_inc.R"))

  # pp.test(xn_server)
  # pp.test(xn_client)
  # pp.test(xn_client_js)


  # differenced time series
  dx_server <- na.omit(diff(x_server))
  dx_client <- na.omit(diff(x_client))
  dx_client_js <- na.omit(diff(x_client_js))
  
  lx_server <- na.omit(stats::lag(x_server))
  lx_client <- na.omit(stats::lag(x_client))
  lx_client_js <- na.omit(stats::lag(x_client_js))
  
  x_server_a1 = x_server[-1,]
  x_client_a1 = x_client[-1,]
  x_client_js_a1 = x_client_js[-1,]

  a=app
  ############### cor ###########################
  print (paste("======" , app, "=======\n"))
  #cat("Correlations: SxC, SxCjs, CxCjs\n")
  
  ca=cor(x_server,x_client)
  cb=cor(x_server,x_client_js)
  cc=cor(x_client,x_client_js)
  
  #cat(paste(app, a, b, c, "\n"))
  loga ("server,client;", round(ca, digits = 2))
  loga ("server,client_js;", round(cb, digits = 2))
  loga ("client,client_js;", round(cc, digits = 2))
  
  
  #cat("Correlations: SxlagC, SxlagCjs, CxlagS, CxlagCjs, CjsxlagS, CjsxlagC \n")
  
  ca=cor(x_server_a1,lx_client)
  cb=cor(x_server_a1,lx_client_js)
  
  cc=cor(x_client_a1,lx_server)
  cd=cor(x_client_a1,lx_client_js)
  
  ce=cor(x_client_js_a1,lx_server)
  cf=cor(x_client_js_a1,lx_client)
  
  
  loga ("server, lag client;", round(ca, digits = 2))
  loga ("server, lag client_js;", round(cb, digits = 2))
  
  loga ("client,lag server;", round(cc, digits = 2))
  loga ("client,lag client_js;", round(cd, digits = 2))
  
  loga ("client_js,lag server;", round(ce, digits = 2))
  loga ("client_js,lag client;", round(cf, digits = 2))
  
  #cat(paste(app,"-lag", a, b, c, d, e, f, "\n"))
  
  
  cat("Correlations: dSxdC, dSxdCjs, dCxdCjs\n")
  ca=cor(dx_server,dx_client)
  cb=cor(dx_server,dx_client_js)
  cc=cor(dx_client,dx_client_js)
  
  loga ("diff server,diff client;", round(ca, digits = 2))
  loga ("diff server,diff client_js;", round(cb, digits = 2))
  loga ("diff client,diff client_js;", round(cc, digits = 2))
  
  #cat(paste(app, "-diff", a, b, c, "\n"))
  
  
  #print ("===========")
  
  
  
  #cat(paste0(app, " , " , te," , " , p1, " , " ,c1, " , " , te2," , " , p2, " , " ,c2, "\n "))
}








