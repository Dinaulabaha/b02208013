setwd("~/Desktop/b02208013/codepen/R")
#基本組成爬蟲的程式
install.packages("XML")
library(XML)
install.packages("httr")
library(httr)
install.packages("RCurl")
library(RCurl)

#抓這一頁
pathURL="https://www.ptt.cc/bbs/movie/index.html"
tempDATA=getURL(pathURL)
xmlDoc=htmlParse(tempDATA, encoding="UTF-8")
title=xpathApply(xmlDoc,"//div[@class=\"title\"]",xmlValue)
url=xpathApply(xmlDoc,"//div[@class=\"title\"]/a//@href")
author=xpathApply(xmlDoc,"//div[@class=\"author\"]")
date=xpathApply(xmlDoc,"//div[@class=\"date\"]")
alldata=data.frame(title,url)

#迴圈
subpathURL="https://www.ptt.cc/bbs/movie/index"
startNO=4649
endNO=4667

for(i in c(startNO:endNO))
{
  pathURL=paste(subpathURL, i,".html",sep="")
  print(pathURL)
tempDATA=getURL(pathURL)
xmlDoc=htmlParse(tempDATA, encoding="UTF-8")
title=xpathApply(xmlDoc,"//div[@class=\"title\"]",xmlValue)
url=xpathApply(xmlDoc,"//div[@class=\"title\"]/a//@href")
author=xpathApply(xmlDoc,"//div[@class=\"author\"]")
date=xpathApply(xmlDoc,"//div[@class=\"date\"]")
result=tryCatch({
  alltitle=rbind(alltitle,data.frame(title))
  print(url)},error=function(err){print(url)}
}


