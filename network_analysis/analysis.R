# Load the igraph library
library(igraph)

# Read the edges from the file
edges <- read.table('data/edges.txt')

# Create a graph object
my_graph <- graph.edgelist(as.matrix(edges), directed=TRUE)

# Plot the graph
plot(my_graph)

# Get some network centrality measures
degree(my_graph)
betweenness(my_graph)