# Eric Riner
# INFO 370

nodeData  = read.table("370_Assign2_App_data/pubmed_nodes_INFO370.txt", sep = "\t", header = TRUE, quote="", fill=TRUE)
linkData  = read.table("370_Assign2_App_data/pubmed_links_INFO370.txt", sep = "\t", header = TRUE, quote="", fill=TRUE)

View(nodeData)  # allows me to view the data in nodeData
View(linkData)  # allows me to view the data in linkData

Alpha   = 0.85      # constant
Epsilon = 0.00001   # constant

# sort(table(linkData$cited),decreasing=TRUE)[1:3]    # returns the ID of the top 3 most cited papers
# sort(table(nodeData$journal),decreasing=TRUE)[1:3]  # returns the ID of the top 3 most cited journals

# dates = as.numeric(nodeData$date_pub)   # converts dates to ints
# hist(dates)                             # prints a histogram

