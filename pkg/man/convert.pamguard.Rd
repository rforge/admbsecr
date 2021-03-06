% Generated by roxygen2 (4.0.1): do not edit by hand
\name{convert.pamguard}
\alias{convert.pamguard}
\title{Create a capture history object from a PAMGuard output file}
\usage{
convert.pamguard(dets, mics, time.range = NULL, sound.speed = 330)
}
\arguments{
\item{dets}{Detection output dataframe from PAMGuard.}

\item{mics}{A matrix containing the coordinates of microphone
locations.}

\item{time.range}{A vector of length two, providing a range of
times for which a subset should be taken to create the capture
history.}

\item{sound.speed}{The speed of sound in metres per second.}
}
\description{
Converts a PAMGuard output file to a capture history object
suitable for use with the \link{admbsecr} function. This uses
\link{make.acoustic.captures} to allocate call identities to
detections.
}

