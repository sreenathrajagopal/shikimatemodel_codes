############################################################
#TITLE : MULTICORE PROCESSING OF XSAMPLE FOR 1000 ITERATIONS
#AUTHOR : SREENATH R.
#########################################################  


# AQUIRING THE REQUIRED LIBRARIES
require(LIM)
require(foreach)
require(doMC)
registerDoMC(6) # CORES SPECIFICATIONS
args <- commandArgs(trailingOnly = TRUE) # COMMAND LINE ARGUMENTS AQUIRED
model <- args[1]
model_name <- unlist(strsplit(model,"[.]"))
l <- Setup(model) # SETTING UP THE MODEL
LP <- Linp(l)
write.csv (data.frame(t(LP$X)),file="Biomass_opt.csv")
a <- read.csv("Biomass_opt.csv")
x <- a[2]
y <- as.matrix(x)
start <- Sys.time()
foreach(i = 1:6) %dopar% # SUBMITTING THE XSAMPLE TASK FOR 6 CORES
{
	name <- paste(model_name[1],"_sample_",i,".csv",sep="") 
	samp <- Xsample(l,iter=167,jmp=0.2,x0=y)
	write.csv(samp,name)
}
j <- 1
while(j <= 6){ # POOLING ALL THE XSAMPLE RESULTS INTO A SINGLE FILE
	name <- paste(model_name[1],"_sample_",j,".csv",sep="")
	y <- read.csv(name)
	z <- y[,-1]
  	if(j == 1){
		data <- z[-1,]
  	}
	else {
		data <- rbind(data,z[-1,])
	}
j <- j+1
}
stop <- Sys.time()
time <- stop - start
print(time)
file_out <- paste(model_name[1],"_posybal_all.csv",sep="")
write.csv(data,file_out) # THE FINAL FILE IS SAVED AS .CSV FILE
	
