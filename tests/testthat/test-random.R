context("Test graph6 <-> matrix conversions on some random graphs")


set.seed(666)

# How many networks to test
howmany <- 50

# Network sizes to test
sizes <- round(seq(2, 128, length=howmany))



for( s in sizes ) {
  p <- runif(1)
  
  m <- makeg(s, p) # adjacency matrix
  mname <- paste(m[lower.tri(m)], collapse="")
  
  test_that(paste0("Converting matrix <-> graph6 on graph of size ", s), {
    expect_silent(
      g6 <- as_graph6(m)
    )
    expect_s3_class(g6, "graph6")
    expect_silent(
      m2 <- as_adjacency(g6)[[1]]
    )
    expect_is(m2, "matrix")
    expect_true(ncol(m2) == nrow(m2))
    expect_type(m2, "double")
    expect_identical(m, m2)
  })
  
  test_that("Converting igraph <-> graph6", {
    requireNamespace("igraph", quietly=TRUE)
    ig <- igraph::graph_from_adjacency_matrix(m, mode="undirected")
    ig6 <- as_graph6(ig)
    ig2 <- as_igraph(ig6)
    expect_true(
      igraph::identical_graphs(ig, ig2[[1]])
    )
  })
  
  test_that("Converting network <-> graph6", {
    requireNamespace("network", quietly=TRUE)
    net <- network::as.network(m, directed=FALSE)
    ng6 <- as_graph6(net)
    net2 <- as_network(ng6)
    expect_identical(net, net2[[1]])
  })
}

#-------------------------------------------------------------------------------
#dgraph6 tests

for( s in sizes ) {
  p <- runif(1)
  
  m <- maked(s, p) # adjacency matrix
  mname <- paste(m, collapse="")
  
  context(paste0("Testing matrix -> dgraph6 conversion on graph ", paste(deparse(m), collapse=" ")))
  
  expect_silent(
    g6 <- as_dgraph6(m)
  )
  expect_s3_class(g6, "dgraph6")
  
  context(paste0("Testing matrix <- dgraph6 conversion on graph ", g6))
  expect_silent(
    m2 <- as_adjacency(g6)[[1]]
  )
  expect_is(m2, "matrix")
  expect_true(ncol(m2) == nrow(m2))
  expect_type(m2, "double")
  expect_identical(m, m2)
}

#-------------------------------------------------------------------------------
#sparse6 test

howmany <- 5
sizes <- round(seq(100, 200, length=howmany))

for( s in sizes ) {
  p <- runif(1,min=0.05,max=0.15) #only sparse networks
  
  m <- makeg(s, p) # adjacency matrix
  mname <- paste(m[lower.tri(m)], collapse="")
  m[lower.tri(m)] <- 0
  m <- which(m==1,arr.ind = T)
  m <- t(apply(m,1,sort,decreasing= TRUE))
  m <- m[order(m[,1]),]
  colnames(m) <- NULL
  mode(m) <- "double"
  
  test_that(paste0("Converting matrix <-> sparse6 on graph of size ", s), {
    expect_silent(
      g6 <- as_sparse6(m)
    )
    expect_s3_class(g6, "sparse6")
    expect_silent(
      m2 <- as_elist(g6)[[1]]
    )
    m2 <- t(apply(m2,1,sort,decreasing= TRUE))
    m2 <- m2[order(m2[,1]),]
    
    expect_is(m2, "matrix")
    expect_type(m2, "double")
    expect_true(all(m[,1]==m2[,1]))
    expect_true(all(m[,2]==m2[,2]))
  })
}