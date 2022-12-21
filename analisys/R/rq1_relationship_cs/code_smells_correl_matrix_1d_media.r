

path= "D:/dwork/artigo_c2/"
output_dir= paste0(path, "analysis/correlacao_4/rq1_relationship_cs/corr_matrix_ordern_media/j.csv")

app="phpmyadmin"
source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))



do_cor=function(){

  print(app)

  source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))


  
  cs_server <- cs_metrics[, 6:23]
  cs_client <- cs_metrics[, 24:29]
  cs_client_js <- cs_metrics[, 30:35]

  #####cs_server=cs_server[, colSums(cs_server != 0) > 0]   #remove with zeros
  cs_server[,is.na(cs_server)] = 0
  #print(typeof(cs_server))
  
  density
  cs_server_d = cs_server / cs$serverLOC * 1000
  cs_client_d = cs_client / cs$clientLOC * 1000
  cs_client_js_d = cs_client_js / cs$client_jsLOC * 1000

  s<-ts(cs_server_d[,1:ncol(cs_server_d)])
  c<-ts(cs_client_d[,1:ncol(cs_client_d)])
  j<-ts(cs_client_js_d[,1:ncol(cs_client_js_d)])


  res = cor(j)
  res[is.na(res)] = 0

  return(res)

}


app="phpmyadmin"
M1 = do_cor()
app="dokuwiki"
M2 = do_cor()
app="opencart"
M3 = do_cor()
app="phpbb"
M4 = do_cor()
app="phppgadmin"
M5 = do_cor()
app="mediawiki"
M6 = do_cor()
app="prestashop"
M7 = do_cor()
app="vanilla"
M8 = do_cor()
app="dolibarr"
M9 = do_cor()
app="roundcubemail"
M10 = do_cor()
app="openemr"
M11 = do_cor()
app="kanboard"
M12 = do_cor()


List_M<-list(M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12)

print(List_M) 

MA=Reduce("+",List_M)/length(List_M)

MA2 = round(MA, 2)

lower<-MA2
lower[lower.tri(MA2, diag=TRUE)]<-""
lower<-as.data.frame(lower)
lower


write.csv2(lower, output_dir)




