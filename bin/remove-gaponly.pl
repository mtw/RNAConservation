#!/usr/bin/env perl
#
# remove gap-only sequences from MSA files
# Last changed Time-stamp: <2022-02-01 22:46:38 mtw>

use strict;
use warnings;
use Getopt::Long qw( :config posix_default bundling no_ignore_case );
use Carp;
use Getopt::Long;
use Data::Dumper;
use Pod::Usage;
use Bio::AlignIO;

my $infile_aln = undef;
my $infmt = 'clustalw';
my $outfmt = undef;
my ($in,$out);
my $suffix="out";
my $ratio = 1;

my %table = (
	     'clustalw' => 'aln',
	     'stockholm' => 'stk',
	     'maf' => 'maf',
	     'fasta' => 'fa',
	    );

Getopt::Long::config('no_ignore_case');
pod2usage(-verbose => 1)
  unless GetOptions("a|aln=s"      => \$infile_aln,
		    "i|infmt=s"    => \$infmt,
		    "o|outfmt=s"   => \$outfmt,
		    "r|gapratio=s" => \$ratio,
		    "man"          => sub{pod2usage(-verbose => 2)},
		    "help|h"       => sub{pod2usage(1)}
		   );

unless (defined ($infile_aln)){
  warn "Please provide an input multiple sequence alignment (MSA) file to  -a|--aln option.";
  pod2usage(-verbose => 0);
}

unless (-f $infile_aln){
  warn "Cannot find input multiple sequence alignment (MSA) privided via -a|--aln option.";
  pod2usage(-verbose => 0);
}

if ($ratio < 0 || $ratio > 1){
  warn "gap ratio parameter mut be 0 < r < 1";
   pod2usage(-verbose => 0);
}


if (defined $outfmt) {$outfmt = lc $outfmt}
unless (defined $outfmt) {$outfmt=$infmt}
(defined $table{$outfmt} ) ? $suffix = $table{$outfmt}: die "No file suffix known for $infmt";

if (defined $infile_aln){
  $in  = Bio::AlignIO->new(-file   => "$infile_aln",
			   -format => $infmt,
			   -displayname_flat => 1);
  $out = Bio::AlignIO->new(-fh   => \*STDOUT ,
			   -format => $outfmt,
			   -displayname_flat => 1);
}
else { croak "Could not process input alignment" }

my $aln = $in->next_aln();
$aln->set_displayname_flat();
my $l   =  $aln->length;
my $dim =  $aln->num_sequences;
#print "+++ $dim sequences with length $l  in alignment +++\n";
my $gapstring = ("-"x$l);
#print "gapstring\n$gapstring\n\n\n";
my @keep = ();

foreach my $i (1..$dim){
  my $alnT = $aln->get_seq_by_pos($i);
  my $seq = $alnT->seq();
  # check if we have a gap-only substring of length $l, aka gap-only sequence
  index($seq,$gapstring) == 0 ? next : 1;
  # To get # of matches put regex in list context, and put that into scalar context:
  my $count = () = $seq =~ /\-/gi;
  if ($count <= $ratio * $l){
    push @keep, $i ;
    # print "keep $seq\n";
  }
}

my $subset = $aln->select_noncont(@keep);
$out->write_aln($subset);

__END__

=head1 NAME

remove-gaponly.pl - Remove lines with many gaps or gap-only lines from MSA files

=head1 SYNOPSIS

remove-gaponly.pl [-a|--aln I<FILE>] [-i|--infmt I<STRING>]
[-o|--outfmt I<STRING>] [-r|--gapratio I<FLOAT>] [options]

=head1 DESCRIPTION

This script removes gap-only lines, or lines with a predefined amount
of gap symbols from MSA files.

=head1 OPTIONS

=over

=item B<-a|--aln>

Input MFA file

=item B<-i|--infmt>

Input MSA file type. Default is 'ClustalW'

=item B<-o|--outfmt>

Output MSA file type. Defaults to the type of the input MSA file

=item B<-r|--gapratio>

Maximum fraction of allowed gaps in a sequence (0 < r < 1). Sequences
with more gaps will be stripped from the MSA.

=item B<--help -h>

Print short help

=item B<--man>

Prints the manual page and exits

=back

=head1 AUTHOR

Michael T. Wolfinger E<lt>michael@wolfinger.euE<gt>

=cut
