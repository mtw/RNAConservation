![GitHub](https://img.shields.io/github/license/mtw/RNAConservation)

# RNAConservation

## Background
One possibility to find structured, potentially functional RNA elements is to search for patterns of covariation in multiple sequence alignments (MSAs) of homologous nucleotide sequences. This can be done by finding a consensus structure, i.e. a secondary structure that all sequences in the MSA can fold into. The [ViennaRNA](https://github.com/ViennaRNA/ViennaRNA) Packages comes with __RNALalifold__, a tool for prediction of locally stable consensus structures from MSAs. Depending on the length of the MSA, __RNALalifold__ will predict many consensus structures, and manual evaluation of these becomes tedious when numbers go into the hundreds.

## Objective
The main objective of the __RNAConservation__ pipeline is to post-process and evaluate hundreds or even thousands of locally stable consensus structures for traits of RNA structure conservation. To this end, the core script __pp_RNALalifold.sh__ runs different tools (provided with the package or third-party) on aligned RNAs (in Stockholm format). Currently, three metrics are computed for each locally stable consensus structure: The maximum covariation level sensu __RNAalifold__, the __RNAz__ class probability, and the __alifoldz__ z-score. Obviously, high covariation level, high class probability, and low z-score are indicative of structurally conserved, functional RNAs.

## Prerequisites
The __RNAConservation__ pipeline builds on different tools of the [ViennaRNA](https://github.com/ViennaRNA/ViennaRNA) metaverse, as well as third-party software:

* [RNAalifold](https://github.com/ViennaRNA/ViennaRNA)
* [RNAz](https://github.com/ViennaRNA/RNAz)
* [alifoldz](https://github.com/ViennaRNA/RNAz/blob/master/perl/alifoldz.pl)
* [easel](https://github.com/EddyRivasLab/easel)
* [ImageMagick](https://github.com/ImageMagick/ImageMagick)
* [Infernal](https://github.com/EddyRivasLab/infernal) (optional)
* [LocARNA](https://github.com/s-will/LocARNA) >= v2.0RC8 (optional)

## Example Workflow
* Set an environment variable ``RNACONSERVATIONDIR`` to the directory of your __RNAConservation__ installation
* Add ``$RNACONSERVATIONDIR/bin`` to your ``PATH`` environment variable
* Optional: Open a new Shell and run ``RNAconservation_resources.sh -l``. This will check for presence of all third-party tools, and issue an error unless all tools are found
* Run __RNALalifold__ on an RNA MSA (here, using a maximum base pair span of 150nt):

  `RNALalifold --noLP -L 150 --auto-id --aln --aln-EPS --aln-EPS-cols=160 --aln-EPS-ss --aln-stk=ALL --id-prefix=ALL -r --cfactor 0.6 --nfactor 0.5 --csv -f S < myMSA.stk`
* Copy the generated multi-Stockholm file into a new folder and split it into in individual MSA files in Stockholm format:

  `split_stockholm.pl -a ALL_0001.stk`
* Once this is done, remove the original multi-Stockholm file:

   `rm ALL_0001.stk`

* Run __pp_RNALalifold.sh__ on all .stk files in the current directory:

    `pp_RNALalifold.sh -g -s`
