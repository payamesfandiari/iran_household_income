library(ggplot2)
library(reshape2)
library(Hmisc)

results = data.frame(urban=character(), shamsiyear=character(), decile=integer(), mean_decile_income=integer(), stringsAsFactors=FALSE) 

for (year in c(80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95)){
  salary = read.csv(paste(year,"/UP4S01.csv",sep=""))
  if("ADDRESS" %in% colnames(salary)){
    colnames(salary)[1] <- "Address"
  }
  if("DYCOL15" %in% colnames(salary)){
    salary = salary[,c("Address","DYCOL15")]
    salary$DYCOL15 = as.numeric(as.character(salary$DYCOL15))
  }else{
    colnames(salary)[1] <- "Address"
    salary = salary[,c("Address","COL13")]
    salary$COL13 = as.numeric(as.character(salary$COL13))
  }
  colnames(salary)[2] <- "inc1"
  
  profit = read.csv(paste(year,"/UP4S02.csv",sep=""))
  if("ADDRESS" %in% colnames(profit)){
    colnames(profit)[1] <- "Address"
  }
  if("DYCOL15" %in% colnames(profit)){
    profit = profit[,c("Address","DYCOL15")]
    profit$DYCOL15 = as.numeric(as.character(profit$DYCOL15))
  }else{
    colnames(profit)[1] <- "Address"
    profit = profit[,c("Address","COL13")]
    profit$COL13 = as.numeric(as.character(profit$COL13))
  }
  colnames(profit)[2] <- "inc2"
  
  otherIncome = read.csv(paste(year,"/UP4S03.csv",sep=""))
  if("ADDRESS" %in% colnames(otherIncome)){
    colnames(otherIncome)[1] <- "Address"
  }else{
    otherIncome$DYCOL06 = as.numeric(as.character(otherIncome$DYCOL06))
  }
  otherIncome$tot = rowSums(otherIncome[,c(3,4,5,6,7,8)],na.rm=TRUE)
  otherIncome = otherIncome[,c("Address","tot")]
  colnames(otherIncome)[2] <- "inc3"
  
  if (file.exists(paste(year,"/UP4S04.csv",sep=""))) {
    fourthThing = read.csv(paste(year,"/UP4S04.csv",sep=""))
    fourthThing = fourthThing[,c(1,5)]
    colnames(fourthThing)[2] <- "inc4"
    fourthThing$inc4 = as.numeric(as.character(fourthThing$inc4))
  }
  

  
  fullData = merge(salary,profit, by="Address", all=TRUE)
  fullData = merge(fullData,otherIncome, by="Address", all=TRUE)
  
  if (file.exists(paste(year,"/UP4S04.csv",sep=""))) {
    fullData = merge(fullData,fourthThing, by="Address", all=TRUE)
    fullData[is.na(fullData)] <- 0
    fullData$tot = rowSums(fullData[,c(2,3,4,5)],na.rm=TRUE)
  }else{
    fullData[is.na(fullData)] <- 0
    fullData$tot = rowSums(fullData[,c(2,3,4)],na.rm=TRUE)
  }

  mean_decile_income = levels(cut2(fullData$tot,g=10,levels.mean=TRUE))

  numbers = c(1,2,3,4,5,6,7,8,9,10)
  years = rep(year,10)
  ur = rep("urban",10)
  
  addToRes = data.frame(ur,years,numbers,mean_decile_income)
  results = rbind(results,addToRes)
}
