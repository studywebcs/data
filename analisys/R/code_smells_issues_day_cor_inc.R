#library(ggplot2)
#library(scales)
#library(dplyr) 
library(zoo)
#library(corit)  # interpolate irregular data and compute correlation
library(BINCOR)  # correlation for binned data (irregularly sampled)
#library(pracma)
#library(dplR)
#library(reshape2)
#library(lubridate)
library(xts)  ##### adicionado



file_server= paste0(path, "issues_bugs/cs_window_issues/cs_metrics_window_" ,app , ".csv")
cs_metrics <- read.csv(file_server,header=TRUE,sep=";")
date_d <- as.Date(cs_metrics$Date)


file_issues=paste0(path, "issues_bugs/issues_by_date/", app, "_iss_day.csv")
issues_day <- read.csv(file_issues,header=TRUE,sep=";")

#date_d <- as.Date(cs_metrics$Date)

#maxdate_iss=as.Date(nextv[app])
#maxdate_cs= date_d[length(date_d)]


############################# all ###################
cs = cbind.data.frame(date=as.Date(cs_metrics$Date), 
                      server_i=rowSums(cs_metrics[, 6:23] ),
                      client_i=rowSums(cs_metrics[, 24:29] ),
                      client_js_i=rowSums(cs_metrics[, 30:35] ), 
                      all_i=rowSums(cs_metrics[, 6:35] )
)

#######################  density of intensity #####################
cs$serverLOC = cs_metrics$PHP
cs$clientLOC = cs_metrics$Client
cs$client_jsLOC = cs_metrics$JavaScript
cs$versionage = cs_metrics$VersionAge
cs$age = cs_metrics$Age

cs$version = cs_metrics$Version

cs$server_id = cs$server_i / cs$serverLOC * 1000
cs$client_id = cs$client_i / cs$clientLOC *1000
cs$client_js_id = cs$client_js_i / cs$client_jsLOC * 1000


cs$server_idt = cs$server_i / (cs$serverLOC + cs$clientLOC) * 1000
cs$client_idt = cs$client_i / (cs$serverLOC + cs$clientLOC) *1000
cs$client_js_idt = cs$client_js_i / (cs$serverLOC + cs$clientLOC) * 1000

#####################################################################
###  zoo objects
###  only smells absolute number
z_server = zoo(cs$server_i, cs$date)
z_client = zoo(cs$client_i, cs$date)
z_client_js = zoo(cs$client_js_i, cs$date)

###  smells by size LOC - density  -> zoo normalized by LLOC
zn_server = zoo(cs$server_id, cs$date)
zn_client = zoo(cs$client_id, cs$date)
zn_client_js = zoo(cs$client_js_id, cs$date)

znt_server = zoo(cs$server_idt, cs$date)
znt_client = zoo(cs$client_idt, cs$date)
znt_client_js = zoo(cs$client_js_idt, cs$date)

#### x_issues (absolute) and xn_issues (normalized)  ###########################################

x_server = as.xts(z_server)   ### smells nao
x_client= as.xts(z_client)
x_client_js= as.xts(z_client_js)

xn_server = as.xts(zn_server)
xn_client= as.xts(zn_client)
xn_client_js= as.xts(zn_client_js)

xnt_server = as.xts(znt_server)
xnt_client= as.xts(znt_client)
xnt_client_js= as.xts(znt_client_js)

############################### issues ###########################
#"date(created)";"number_issues"

issues= cbind.data.frame(date = as.Date(issues_day$date.created.) , nissues = as.numeric(issues_day$number_issues))

z_issues = zoo(issues$nissues, issues$date)
x_issues = as.xts(z_issues)





