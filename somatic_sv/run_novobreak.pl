#!/usr/bin/perl

use strict;
use warnings;


###configuration 
my $novobreak="/home/users/xu/novoBreak_distribution_v1.1.1";
my $tumor_dir="/home/proj/MDW_genomics/xu/final_bam/";
my $normal_dir="/home/proj/MDW_genomics/xu/final_bam/";
my $output_dir="/home/proj/MDW_genomics/xu/novobreak";
my $genome="/home/users/xu/bwa/galgal5.fa";

##sample identifiers 
my @tumors=("738-1_S1","741-1_S2","756-3_S3","766-1_S4","798-1_S5","833-1_S6","834-2_S7","855-1_S8","863-1_S9","918-3_S10","927-2_S11","834-2_2_S12","911-1_2_S13","777-3_S14","787-2_S15","788-1_S16","794-1_S17","835-1_S18","841-3_S19","842-2_S20","884-2_S21","901-2_S22","906-1_S23","911-1_S24","842-2_2_S25","901-2_2_S26");

my @normals=("738-0_S33","741-0_S34","756-0_S35","766-0_S36","798-0_S41","833-0_S42","834-0_S43","855-0_S46","863-0_S47","918-0_S50","927-0_S51","834-0_S43","911-0_S30","777-0_S37","787-0_S38","788-0_S39","794-0_S40","835-0_S44","841-0_S45","842-0_2_S28","884-0_S48","901-0_2_S29","906-0_S49","911-0_S30","842-0_2_S28","901-0_2_S29");

foreach my $num (0..0){
	
	
	my $tumor_bam=join("",$tumor_dir,$tumors[$num],"_Bwa_RG_dedupped_realigned.bam");
	my $normal_bam=join("",$normal_dir,$normals[$num],"_Bwa_RG_dedupped_realigned.bam");
	
	$num++;
	my $sample=join("","S",$num);
	system "mkdir  $output_dir/$sample";
	if (-e $tumor_bam and -e $normal_bam){
		`qsub -b y -q all.q -l vf=80G,core=20 -N "NB_$sample"  "bash $novobreak/run_novoBreak.sh $novobreak/ $genome $tumor_bam $normal_bam 20 $output_dir/$sample"`;

	}
	else {
		print "$tumor_bam not exists\n" if ! -e $tumor_bam;
    	print "$normal_bam not exists\n" if ! -e $normal_bam;
		die; 
	}
}



