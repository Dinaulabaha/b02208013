subPath <- "https://tw.news.yahoo.com/world/archive/"
startNO= 1
endNO= 10
alldata = data.frame()

for( pid in startNO:endNO )
{
  urlPath=paste(subPath, pid, ".html", sep='') 
  temp=getURL(urlPath, encoding="big5")
  xmldoc=htmlParse(temp)
  title=xpathSApply(xmldoc, "//div[@class=\"story\"]//h4", xmlValue)
  path=xpathSApply(xmldoc,"//div[@class=\"story\"]//a[@class=\"more\"]//@href")
  Errorresult=tryCatch(
    {subdata=data.frame(title,path)
    alldata=rbind(alldata,subdata) 
    },warning=function(war){print(paste("MY_WARNING:", urlPath))},
    error=function(err){print(paste("MY_ERROR:", urlPath))},
    finally={print(paste("End Try&Catch", urlPath))}
  )
}

write.table(alldata, file = "news.csv")

suburlPath="https://www.ptt.cc"
for( i in 1:length(alldata[,1]) )
{
  ipath=paste(suburlPath, alldata$path[i], sep='')
  print(ipath)
  content=getURL(ipath, encoding = "big5")
  xmldoc=htmlParse(content)
  article=xpathSApply(xmldoc, "//div[@id=\"main-content\"]", xmlValue)
  filename=paste("./data/", i, ".csv", sep='')
  write.csv(article, filename)
}

