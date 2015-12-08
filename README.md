# parallel_glmnet
This function executes de cv.glmnet function from the glmnet library.
All the available CPUs cores are used. 
The regularizer (alpha parameter in glmnet) must be specified, as well the number of folds used in the CV resampling, a logical indicator if the Parallel backend should be used, and a seed number.
