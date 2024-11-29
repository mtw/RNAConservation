#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

my $maxcovar=0;
my $gapali=0;
my $what;
my %cov = (
	   0 => 0,
	   1 => 0,
	   2 => 0,
	   3 => 0,
	   4 => 0,
	   5 => 0,
	   6 => 0);

while(<>){
  chomp;
  my $reduce=5;
  next unless (/^\s+\d+/);
  my @data = split;
  # print "new line: $_\n";
	next if ($data[@data-1] =~ /[\+\-]$/);
  if ($data[@data-1] =~ /\-\-\:(\d+)$/){
    $gapali++;
  }

  #print "$_ $data[2] >".eval(@data)."\n";
  if ($data[2]<=2){ # mismatches
		my $covar = @data - $reduce;
		if ($data[@data-1] =~ /\-\-\:(\d+)$/){
			$covar--;
		}
    if ($covar > $maxcovar){
      $maxcovar = $covar;
		}
  	$cov{$covar}++;

    # print join ("\t",@data),"\t[[",$#data,"]]\n";
  }
}

if ($gapali > 0) { $what = "gapali_".$gapali }
else { $what = $cov{$maxcovar} }
print "$maxcovar\t$what";
exit($maxcovar);
