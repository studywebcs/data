#for cs only and issues

########################## groups #################################

csg = data.frame(date=as.Date(cs_metrics$Date))

csg$server_complexity = cs_metrics$CyclomaticComplexity + cs_metrics$NPathComplexity + cs_metrics$ExcessiveClassComplexity
csg$server_size = cs_metrics$ExcessiveMethodLength + cs_metrics$ExcessiveClassLength + cs_metrics$ExcessiveParameterList + cs_metrics$ExcessivePublicCount + 
  cs_metrics$TooManyFields + cs_metrics$TooManyMethods + cs_metrics$TooManyPublicMethods
csg$server_design = cs_metrics$NumberOfChildren + cs_metrics$DepthOfInheritance + cs_metrics$CouplingBetweenObjects +cs_metrics$DevelopmentCodeFragment
csg$unused_code = cs_metrics$UnusedPrivateField + cs_metrics$UnusedLocalVariable + cs_metrics$UnusedPrivateMethod + cs_metrics$UnusedFormalParameter


z_server_complexity = zoo(cs$server_complexity, cs$date)
z_server_size = zoo(cs$server_size, cs$date)
z_server_design = zoo(cs$server_design, cs$date)
z_server_unused_code = zoo(cs$server_unused_code, cs$date)

x_server_complexity = as.xts(z_server_complexity) 
x_server_size = as.xts(z_server_size)
x_server_design = as.xts(z_server_design)
x_server_unused_code = as.xts(z_server_unused_code)

## cli
csg$client_embed_inhtml = cs_metrics$embed.JS + cs_metrics$inline.JS + cs_metrics$embed.CSS + cs_metrics$inline.CSS 
csg$client_embed_injs = cs_metrics$css.in.JS + cs_metrics$css.in.JS

z_client_embed_inhtml = zoo(cs$client_embed_inhtml, cs$date)
z_client_embed_injs = zoo(cs$client_embed_injs, cs$date)

x_client_embed_inhtml  = as.xts(z_client_embed_inhtml )
x_client_embed_injs = as.xts(z_client_embed_injs)

##js
csg$client_js_size = cs_metrics$max.lines + cs_metrics$max.lines.per.function + cs_metrics$max.params
csg$client_js_complexity = cs_metrics$complexity + cs_metrics$max.depth + cs_metrics$max.nested.callbacks

z_client_js_size = zoo(cs$client_js_size, cs$date)
z_client_js_complexity = zoo(cs$client_client_js_complexity, cs$date)

x_client_js_size = as.xts(z_client_js_size)
x_client_js_complexity = as.xts(z_client_js_complexity)