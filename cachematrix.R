## ==IDENTIFICATION=============================================================
## Marc Denis
## Johns-Hopkins University via Coursera.org
## Data Science Specialization - Course 2: R Programming
## Week 3: Programming Assignment 2
## =============================================================================


## ==OVERALL DESCRIPTION========================================================
## These two functions allow the user to generate the inverse matrix
## in an efficient way, in a sense that it only requires the user to calculate
## the inverse matrix once. If the matrix does not change, then the user
## can retrieve the value of the inverse matrix from the cache and thus does
## not need to compute it again, saving some time.
## =============================================================================


## ==WARNING====================================================================
## It is assumed here that the matrix we want to get the inverse from
## can actually be inverted (i.e.: it is a non-singular square matrix, implying
## that its numbers of rows and columns are equal, and that its determinant
## is different from zero).
## Should any matrix passed as an argument be singular or non-square, then
## the solve function will return an error.
## To avoid this, I have added a "stop" function to force
## the cacheSolve function to exit if it detects the matrix is not inversible.
## =============================================================================


## ==STEP 1=====================================================================
## The function makeCacheMatrix generates a list of four functions.
## How to use it efficiently: store it in an empty variable, such as:
## exemple <- makeCacheMatrix(1:4,2,2).
##
## Function 1 (setm): sets the value of the matrix you pass as an argument, into
## a variable called x.
## Function 2 (getm): allows you to retrieve the value of the matrix x you just
## passed into setm.
## Function 3 (setinvm): stores into the cache the value of the inverse matrix
## (uses the object invm to store this value).
## Function 4 (getinvm): retrieves the value of the cached inverse matrix
## (that has been stored earlier into the object invm).
## =============================================================================

makeCacheMatrix <- function(x = matrix()) {
        invm <- NULL
        setm <- function(y,yrow,ycol) {
                x <<- matrix(y,yrow,ycol)
                invm <<- NULL
        }
        getm <- function () x
        setinvm <- function(solve) invm <<- solve
        getinvm <- function() invm
        list(setm = setm, getm = getm, setinvm = setinvm, getinvm = getinvm)
}


## ==STEP 2=====================================================================
## The function cacheSolve below takes a list generated by makeCacheMatrix
## as an argument.
## It then retrieves the inverse matrix thanks to the item getinvm.
## If the inverse matrix has NEVER been calculated before, then invm is NULL.
## The inverse matrix is thus generated and stored in the cache, using the
## the setinvm function.
## The function is however terminated if the matrix cannot be inverted.
##
## If the inverse matrix HAS already been calculated, then the value of invm
## is not NULL, as it has been automatically retrieved from the cache with
## the function getinvm.
## There is therefore no need to compute the inverse matrix a second time.
## The value of the inverse matrix is hence immediately returned from invm.
## =============================================================================

cacheSolve <- function(x, ...) {
        invm <- x$getinvm()
        if (!is.null(invm)) {
                message("Retrieving the cached inverse matrix...")
                return(invm)
        }
        data <- x$getm()
        if (nrow(data)!=ncol(data)) {
                stop("This matrix is not square, hence it does not have
                     an inverse! Exiting...")
        }
        if (det(data)==0) {
                stop("This matrix has a nil determinant.
                     Hence, it does not have an inverse! Exiting...")
        }
        invm <- solve(data)
        x$setinvm(invm)
        invm
        ## Returns a matrix that is the inverse of 'x'.
}