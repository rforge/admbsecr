## Functions that automatically generate starting values for parameters.

## Not lifted from the secr package.
## Grabs the average recapture distance, or something.
autosigma <- function(args){
    capt <- args$capt
    traps <- args$traps
    bincapt <- capt$bincapt
    ave.rc.dist <- function(x){
        trap.ids <- which(x == 1)
        if (length(trap.ids) > 1){
            rc.locs <- traps[trap.ids, ]
            rc.dists <- distances(rc.locs, rc.locs)
            w <- length(rc.dists[rc.dists > 0])
            out <- mean(rc.dists[rc.dists > 0])
        } else {
            out <- NA
            w <- NA
        }
        c(out, w)
    }
    mean.dists <- apply(bincapt, 1, ave.rc.dist)
    mean.dists <- mean.dists[, !is.na(mean.dists[1, ])]
    sum(mean.dists[1, ]*mean.dists[2, ])/sum(mean.dists[2, ])
}

## Write own pdot function.
autoD <- function(args){
    detfn <- args$detfn
    mask <- args$mask
    A <- args$A
    traps <- args$traps
    sv <- args$sv
    detpar.names <- args$detpar.names
    pars <- sv[detpar.names]
    cutoff <- args$cutoff
    if (!is.null(cutoff)){
        pars$cutoff <- cutoff
    }
    esa <- A*sum(p.dot(points = mask, traps = traps, detfn = detfn, pars = pars))
    ## HT-like estimator for D is n/esa.
    nrow(args$capt$bincapt)/esa
}

autog0 <- function(args){
    0.95
}

autoz <- function(args){
    autosigma(args)
}

autosigma.toa <- function(args){
    0.0025
}

autokappa <- function(args){
    10
}

autob0.ss <- function(args){
    do.call(args$ss.link, list(max(args$capt$ss)))
}

autob1.ss <- function(args){
    buffer <- attr(args$mask, "buffer")
    cutoff <- args$cutoff
    max.ss <- max(args$capt$ss)
    out <- (max.ss - cutoff)/(buffer/2)
    if (args$ss.link == "log"){
        out <- out/max.ss
    }
    out
}

autosigma.ss <- function(args){
    ss <- c(args$capt$ss)
    sd(ss[ss >= args$cutoff])
}

autoalpha <- function(args){
    2
}


autoshape <- function(args){
    autosigma(args)/args$sv[["scale"]]
}

autoscale <- function(args){
    sqrt(autosigma(args))
}
