# Eric Riner
# Oct 25 2016
# INFO 370

nodeData  = read.table("pubmed_nodes_INFO370.txt", sep = "\t", header = TRUE, quote="", fill=TRUE)
linkData  = read.table("pubmed_links_INFO370.txt", sep = "\t", header = TRUE, quote="", fill=TRUE)

View(nodeData)  # allows me to view the data in nodeData
View(linkData)  # allows me to view the data in linkData

sort(table(linkData$cited),decreasing=TRUE)[1:3]    # returns the ID of the top 3 most cited papers
sort(table(nodeData$journal),decreasing=TRUE)[1:3]  # returns the ID of the top 3 most cited journals

dates = as.numeric(nodeData$date_pub)   # converts dates to ints
hist(dates)                             # prints a histogram
