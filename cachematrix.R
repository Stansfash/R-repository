## Put comments here that give an overall description of what your
## functions do

# Overall Description of the Functions in the code below
# These functions create a special matrix object that can store a matrix and cache its inverse. 
# This is useful because calculating the inverse of a matrix can be computationally expensive, 
# and caching avoids redundant recalculations if the matrix has not changed.


## Write a short comment describing this function
## The makeCacheMatrix function creates a special "matrix" object that can cache its inverse.
## This object is a list containing functions to:
## 1. Set the matrix
## 2. Get the matrix
## 3. Set the inverse of the matrix
## 4. Get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL  # Initialises the inverse as NULL
  
  # Function to set the matrix and reset the cached inverse
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  
  # Function to get the matrix
  get <- function() x
  
  # Function to set the inverse of the matrix
  setInverse <- function(inverse) inv <<- inverse
  
  # Function to get the inverse of the matrix
  getInverse <- function() inv
  
  # Returning a list containing the functions for the matrix and its inverse
  list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}


## Write a short comment describing this function
# The cacheSolve function computes the inverse of the special "matrix" returned by makeCacheMatrix.
# If the inverse has already been computed and the matrix has not changed, it retrieves the inverse from the cache. 
# If not, it computes the inverse, caches it, and then returns it.

cacheSolve <- function(x, ...) {
    inv <- x$getInverse()  # Retrieve the cached inverse if it exists
    
    # If the inverse is already cached, return it
    if (!is.null(inv)) {
        message("getting cached inverse")
        return(inv)
    }
    
    # Otherwise, compute the inverse
    mat <- x$get()  # Getting the matrix
    inv <- solve(mat, ...)  # Computing the inverse using solve()
    
    x$setInverse(inv)  # Caching the inverse
    
    inv  # Return the inverse
}




