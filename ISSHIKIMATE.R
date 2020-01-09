###########################################################
# Usage : For generating the list of reactions that are found to be running at a minimal flux for a given threshold of the metabolite of interest. 
#Author : sreenath
######################################################## 
args <- commandArgs(trailingOnly = TRUE)
file_name  <- args[1]   #The Matrix of solutions containing the simulation results of the given population is passed as an argument
get_csv <- read.csv(file_name,header=TRUE,sep=",")
csv_main <- as.data.frame((get_csv[,-1]))
print("Analysing the randomisation data")

colnames <- names(csv_main)
rnum <- nrow(csv_main)
cnum <- ncol(csv_main)
dataf <- data.frame(matrix(vector(),nrow=1,ncol=cnum,dimnames=list(c(),c(colnames))))


print("stage2")
i <- 1
while(i <= ncol(csv_main)){
  csv_main[rnum+1,i] <- max(csv_main[i],na.rm= TRUE)
  csv_main[rnum+2,i] <- min(csv_main[i],na.rm= TRUE)
  i <- i+1
  }
varrow = c() 
varcol = c()
print("stage3") 
i <- 1
j <- 1
while(i <= rnum){
  if(csv_main[i,"Transport_shikimate"] > 0.7*csv_main[rnum+1,"Transport_shikimate"] ){    # selecting the ones above the threshold considered threshold in 70 percent of max shikimate and above  If the name of the target flux reaction is changed you can get the results for that metabolite.
    k <- 1
    while(k < cnum){
    if(csv_main[rnum+1,k] > 0 && csv_main[rnum+2,k] >= 0){     # Identifying fluxes that are running less than 10 percent of their max flux (ideal for knock out) 
      if(csv_main[i,k] < 0.1*csv_main[rnum+1,k] ){
	varrow <- c(varrow,i)
	varcol <- c(varcol,k)
    }
    }
    if(csv_main[rnum+1,k] <=  0 && csv_main[rnum+2,k] < 0){
      if(csv_main[i,k] > 0.1*csv_main[rnum+2,k] ){
	varrow <- c(varrow,i)
	varcol <- c(varcol,k)
    }
    }
    if(csv_main[rnum+1,k] > 0 && csv_main[rnum+2,k] < 0){
      if(csv_main[i,k] < 0.1*csv_main[rnum+1,k] && csv_main[i,k] > 0.1*csv_main[rnum+2,k]){
	varrow <- c(varrow,i)
	varcol <- c(varcol,k)
    }
    }
   
    k <- k+1
    }
    if(j == 1){
      dataf[j,] <- csv_main[i,]
      j <- j+1
    }
    if(j > 1){
      dataf <- rbind(dataf,csv_main[i,])
      }
    }  
    i <- i+1
}  



kd1 <- data.frame(matrix(varrow,nrow=length(varrow),ncol=1,dimnames=list(c(),c("ROW"))))
kd2 <- data.frame(matrix(varcol,nrow=length(varcol),ncol=1,dimnames=list(c(),c("COLUMN"))))
knockdowns <- cbind(kd1,kd2)
write.csv(knockdowns,"kncdwn.csv") #Listing the columns that are running low fluxes
write.csv(dataf,"maxshikimate.csv") # creates a csv files enlisting the entries amongst the samples producing maximate shikimate.

x <- read.csv("Final_ecoli_model_posybal_all.csv")
y <- x[-1]
a <- read.csv("kncdwn.csv")
z <- c(unique(a[[3]]))
len <- length(z)
q <- c()
i <- 1
while(i <= length(z)){
a <- z[i]
q <- c(q,colnames(y[a]))
i <- i+1
}

write.table(q,row.names=FALSE,col.names=FALSE,quote=FALSE,"reactions_shikimate.txt") # This shall dump a file enlisting the reactions that are running low for maximising current target reaction flux






