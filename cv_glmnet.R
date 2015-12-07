
##########################################
##########################################
#Author: Pablo Campos
#Code to execute in parallel the cv.glmnet function from the glmnet library,
#using all the available CPU cores
#The Gini coefficient is reported instead of the Area under ROC curve

cv_glmnet<-function(matrix,inc,regularizer,numfolds, par, numcores, seed)
{
  library(glmnet)
  library(doParallel)
  library(parallel)
  library(iterators)
  library(ggplot2)
  library(Matrix)  
  
  registerDoParallel(cores=numcores)
  
  set.seed(seed)
  cv_par<-cv.glmnet(matrix,inc,family="binomial", alpha=regularizer, type.measure="auc",
                    nfolds = numfolds, parallel = par)
  
  qplot(log(cv_par$lambda),2*(cv_par$cvm)-1,color=factor(1))
  
  lambdas<-cv_par$lambda
  ginis<-2*(cv_par$cvm)-1
  nozero<-cv_par$nzero
  dfginis<-cbind(lambdas,ginis,nozero)
  
  matrizbetas<-cv_par$glmnet.fit$beta
  matrizbetas<-as.matrix(matrizbetas)
  matrizbetas<-as.data.frame(matrizbetas)
  write.csv(matrizbetas,"matrizbetas.csv")
  write.csv(dfginis,"dfginis.csv")
  
  return(cv_par)
}

##########################################
##########################################

