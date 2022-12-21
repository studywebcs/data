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

library(lmtest)
library(tseries)
#library(RTransferEntropy)


apps=c("phpmyadmin", "dokuwiki", "opencart", "phpbb", "phppgadmin" , "mediawiki", "prestashop", "vanilla",
       "dolibarr", "roundcubemail", "openemr", "kanboard")


path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"

outfile=paste0(path, "analysis/correlacao_4/rq2_g_te/data/granger_csonly_absolute.csv")


gg= function(xa, xb){
  g = grangertest( xb ~ xa, order=1 )

  gp=g$`Pr(>F)`[2]
  if (gp <= 0.05 ){ gc="*" } else { gc="" }

  return (paste(round(gp, digits = 2), ";", gc))
}


loga= function (key, value){
   
   cat (paste(key, value,  "\n"))
   cat(paste0(a, " ; " , key, value), sep = "\n", file = outfile, append = TRUE)
   
}



for (app in apps){
  
  source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))
  #source(paste0(path, "analysis/correlacao_3_1file/code_smells_only_average_inc.R"))
  
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
  ################## g ##############################
  print (paste("======" , app, "=======\n"))
  cat("granger causality : p, issig\n")
  #direct
  g1=gg(x_server,x_client)
  loga ("server,client;", g1)

  
  
  g2= gg(x_server,x_client_js)
  loga ("server,client_js;", g2)

  
  g3=gg(x_client,x_client_js)
  loga ("client,client_js;", g3)

  
  
  
  #lag
  g11=gg(x_server_a1,lx_client)
  loga ("server,lag client;", g11)

  
  g12= gg(x_server_a1,lx_client_js)
  loga ("server,lag client_js;", g12)  ### este mal antes

  
  g13=gg(x_client_a1,lx_server)
  loga ("client,lag server;", g13)

  
  g14=gg(x_client_a1,lx_client_js)
  loga ("client,lag client_js;", g14)

  
  g15= gg(x_client_js_a1,lx_server)
  loga ("client_js,lag server;", g15)

  
  g16=gg(x_client_js_a1,lx_client)
  loga ("client_js,lag client;", g16)

  
  
  #diff
  g21=gg(dx_server,dx_client)
  loga ("diff server, diff client;", g21)

  
  g22= gg(dx_server,dx_client_js)
  loga ("diff server,diff client_js;", g22)

  
  g23=gg(dx_client,dx_client_js)
  loga ("diff client, diff client_js;", g23)

  
  #print ("===========")
  
  
  
  
}