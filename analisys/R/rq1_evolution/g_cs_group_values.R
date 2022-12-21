#apps
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

#path= "D:/americo/OneDrive - ISCTE-IUL/doc_code/data_phd2/"
path= "D:/dwork/artigo_c2/"

output_dir= paste0(path, "analysis/correlacao_4/rq1_evolution/g_cs_group/")

source(paste0(path, "analysis/correlacao_4/code_smells_only_inc.R"))



#######################  density of intensity #####################

cs_id= cs[ , c("date", "server_id", "client_id", "client_js_id")]  

cs2 = melt(cs_id, id.vars="date")


s=round(mean(cs[,"server_id"]), digits=2)
s_sd=round(sd(cs[,"server_id"]), digits=2)

c=round(mean(cs[,"client_id"]), digits=2)
c_sd=round(sd(cs[,"client_id"]), digits=2)

cjs=round(mean(cs[,"client_js_id"]), digits=2)
cjs_sd=round(sd(cs[,"client_js_id"]), digits=2)

print(paste(app, s, s_sd, c, c_sd, cjs, cjs_sd, sep=";"))


