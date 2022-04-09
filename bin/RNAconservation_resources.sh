#!/usr/bin/env bash
# Last changed Time-stamp: <2022-04-09 05:07:43 mtw>


RC_rnaz=$(which RNAz)
RC_alifoldz=$(which alifoldz.pl)
RC_rnaalifold=$(which RNAalifold)
RC_rnafold=$(which RNAfold)
RC_eslreformat=$(which esl-reformat)
RC_convert=$(which convert)
RC_refold=$(which refold.pl)
RC_alifoldmaxcovar="$RNACONSERVATIONDIR/bin/alifold_maxcovar.pl"
RC_removegaponly="$RNACONSERVATIONDIR/bin/remove-gaponly.pl"
RC_reformataln="$RNACONSERVATIONDIR/bin/reformat_aln.pl"
RC_stripaln="$RNACONSERVATIONDIR/bin/strip_aln.pl"

function check_tools {
  if [ ! -f "${RC_rnaz}" ]
  then
     echo "RNAz not not found, exiting ..."
      exit 3
  else
     echo "RNAz at ${RC_rnaz}"
  fi

  if [ ! -f "${RC_refold}" ]
  then
    echo "refold.pl not not found, exiting ..."
    exit 3
  else
    echo "refold.pl at ${RC_refold}"
  fi

  if [ ! -f "${RC_alifoldz}" ]
  then
    echo "alifoldz.pl not not found, exiting ..."
    exit 3
  else
    echo "alifoldz.pl at ${RC_alifoldz}"
  fi

  if [ ! -f "${RC_rnafold}" ]
  then
    echo "RNAfold not not found, exiting ..."
    exit 3
  else
    echo "RNAfold at ${RC_rnafold}"
  fi

  if [ ! -f "${RC_rnaalifold}" ]
  then
    echo "RNAalifold not not found, exiting ..."
    exit 3
  else
    echo "RNAalifold at ${RC_rnaalifold}"
  fi

  if [ ! -f "${RC_convert}" ]
  then
    echo "convert not not found, exiting ..."
    exit 3
  else
    echo "convert at ${RC_convert}"
  fi

  if [ ! -f "${RC_eslreformat}" ]
  then
    echo "esl-reformat not not found, exiting ..."
    exit 3
  else
    echo "esl-reformat at ${RC_eslreformat}"
  fi

  if [ ! -f "${RC_alifoldmaxcovar}" ]
  then
    echo "alifold_maxcovar.pl not not found, exiting ..."
    exit 3
  else
    echo "alifold_maxcovar.pl at ${RC_alifoldmaxcovar}"
  fi

  if [ ! -f "${RC_removegaponly}" ]
  then
    echo "remove_gaponly.pl not not found, exiting ..."
    exit 3
  else
    echo "remove_gaponly.pl at ${RC_removegaponly}"
  fi

  if [ ! -f "${RC_reformataln}" ]
  then
    echo "reformat_aln.pl not not found, exiting ..."
    exit 3
  else
    echo "reformat_aln.pl at ${RC_reformataln}"
  fi

  if [ ! -f "${RC_stripaln}" ]
  then
    echo "strip_aln.pl not not found, exiting ..."
    exit 3
  else
    echo "strip_aln.pl at ${RC_stripaln}"
  fi
}

for i in "$@"
do
  case $i in
    -l)          # make RNAz locarna-aware
      check_tools
      shift
      ;;
    *)
        # unknown option
        ;;
  esac
done

export LANG="C"
