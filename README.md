# RNAConservation
This is a pipeline to characterize RNA structure conservation, built around the [ViennaRNA](https://github.com/ViennaRNA/ViennaRNA) Package. 

## Background
One possibility to find structured, potentially functional RNA elements is to search for patterns of covariation in multiple sequence alignments (MSAs) of homologous nucleotide sequences. This can be done by finding a consensus structure, i.e. a secondary structure that all sequences in the MSA can fold into. The [ViennaRNA](https://github.com/ViennaRNA/ViennaRNA) Packages comes with __RNALalifold__, a tool for prediction of locally stable consensus structures from MSAs. Depending on the length of the MSA, __RNALalifold__ will predict many consensus structures, and manual evaluation of these becomes tedious when numbers go into the hundreds. 

## Objective
The main objective of the __RNAConservation__ pipeline is to post-process and evaluate hundreds or even thousands of locally stable consensus structures for traits of RNA structure conseration. To this end, the core script __pp_RNALalifold.sh__ runs different tools (provided with the package or thrid-party) on aligned RNAs (in Stockholm format). Currently, three metrics are computed for each locally stable consensus structure: The maximum covariation level sensu __RNAalifold__, the __RNAz__ class probability, and the __alifoldz__ z-score. Obviously, high covariation level, high class probability, and low z-score are indicative of structurally conserved, functional RNAs. 

## Prerequisites
The __RNAConservation__ pipeline builds on different tools of the [ViennaRNA](https://github.com/ViennaRNA/ViennaRNA) metaverse, as well as third-party tools:
