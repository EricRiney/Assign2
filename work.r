# Eric Riner
# INFO 370

nodeData  = read.table("370_Assign2_App_data/pubmed_nodes_INFO370.txt", sep = "\t", header = TRUE, quote="", fill=TRUE)
linkData  = read.table("370_Assign2_App_data/pubmed_links_INFO370.txt", sep = "\t", header = TRUE, quote="", fill=TRUE)

library(MASS) # need fractions

View(nodeData)  # allows me to view the data in nodeData
View(linkData)  # allows me to view the data in linkData

Alpha   = 0.85      # constant
Epsilon = 0.00001   # constant

setwd("/Users/ericriner/Documents/Code/UW/370/Assign2")

data        <- c(1, 0, 2, 0, 4, 3, 3, 0, 1, 1, 0, 0, 2, 0, 4, 0, 1, 0, 0, 0, 1, 0, 0, 1, 8, 0, 3, 0, 5, 2, 0, 0, 0, 0, 0, 0)
matrixData  <- matrix(data, nrow = 6, ncol = 6, byrow = TRUE)
matrixData            # sanity check
diag(matrixData) <- 0 # zeros out the diag of the matrix

lilMatrix       = fractions(sweep(matrixData, 2, colSums(matrixData), FUN="/"))         # normals it out
lilMatrixScale  = fractions(scale(matrixData, center=FALSE, scale=colSums(matrixData))) # scale it out
danglingNodes   = attr(lilMatrixScale, 'scaled:scale') 

for (i in  1:6) {
  if((danglingNodes[i] == 0)) {
    danglingNodes[i]=1
  }
  else if(!is.na(danglingNodes[i] != 0)) {
    danglingNodes[i]=0
  }
}

articleVector = fractions(c(3/14,2/14, 5/14, 1/14, 2/14, 1/14)) 
initialStartVector = fractions(c(1/6,1/6,1/6,1/6,1/6,1/6))

lilMatrix[,2] <- fractions(c(3/14,2/14, 5/14, 1/14, 2/14, 1/14))
alphaDotE <- c(0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85, 0.85)
alphaDotEmatrix <- matrix(alphaDotE, nrow = 6, ncol = 6, byrow = TRUE)

P     = lilMatrix * Alpha + (1 - Alpha) * alphaDotEmatrix # P inﬂuence vector
k     = 16 # gonna itterate
PtoK  = P^k

NewP            = (Alpha * alphaDotEmatrix)* as.vector(PtoK) +  as.vector((Alpha * danglingNodes%*%PtoK + (1 - Alpha))) * Alpha 
iterationThing  = fractions(scale(NewP, center=FALSE, scale=colSums(NewP)))
convergeThing   = attr(iterationThing, 'scaled:scale')

ef = lilMatrix%*%NewP/sum(lilMatrix%*%NewP)

>ef
[1] 34.0510 17.2030 12.1755  3.6532 32.9166  0.0000