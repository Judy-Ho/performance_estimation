load("data/synthetic.rdata")

source("src/utils.r")
source("src/estimation-procedures.r")
source("src/workflows.r")
source("src/metrics.r")
source("src/learning-models.r")

library(tsensembler)

form <- target ~ .
nfolds <- 10
embedded_time_series <- synthetic$TS1

library(parallel)
final_results <- 
  mclapply(1:length(embedded_time_series),
         function(i) {
           cat(i, "\n\n")
           ds <- embedded_time_series[[i]]
           
           x <-
             workflow(
               ds = ds,
               form = form,
               predictive_algorithm = "rbr",
               nfolds = nfolds,
               outer_split = .8
             )
           
           x
         }, mc.cores = 5)

save(final_results, file = "final_results_synthetic_ts1_rbr.rdata")

