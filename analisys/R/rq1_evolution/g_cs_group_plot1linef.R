app = "phpmyadmin"
app="dokuwiki"
app="opencart"
app="phpbb"
app="phppgadmin"
app="mediawiki"
app="prestashop"
app="vanilla"
app="dolibarr"
app="roundcubemail"
app="openemr"
app="kanboard"

path= "D:/dwork/artigo_c2/"

source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))

outfile=paste0(path, "analysis/correlacao_4/rq1_trends/")


plota = function (x, y, app, name){
  svg(paste0(outfile, app, "_", name, "_trend.svg"), 10, 6)
  
  plot(x , y, ylim=c(0,max(y)), main = paste(app, "-" , name))
  myline.fit <- lm(y ~ x)
  print(summary(myline.fit))
  abline(myline.fit) 

  dev.off() 
  
}
#######################  density of intensity #####################
cs_id= cs[ , c("date", "server_id", "client_id", "client_js_id")]  

x=cs_id[,"date"]

name="server_id"
y=cs_id[,name]
plota(x,y, app, name)

name="client_id"
y=cs_id[,name]
plota(x,y, app, name)

name="client_js_id"
y=cs_id[,name]
plota(x,y, app, name)




