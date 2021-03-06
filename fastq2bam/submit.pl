#!/usr/bin/perl

#this script was used to submit jobs to our computer cluster
#requir fastq2bam.pl in the same directory
#usage: perl submit.pl

use strict;
use warnings;

#sample identifiers
my %hash=(
	'002683_Line-6' =>'S31',
	'002684_Line-7' =>'S32',
	'017738-0'  =>'S33',
	'017738-1'	=>'S1',
	'017741-0'	=>'S34',
	'017741-1'	=>'S2',
	'017756-0'	=>'S35',
	'017756-3'	=>'S3',
	'017766-0'	=>'S36',
	'017766-1'	=>'S4',
	'017777-0'	=>'S37',
	'017777-3'	=>'S14',
	'017787-0'	=>'S38',
	'017787-2'	=>'S15',
	'017788-0'	=>'S39',
	'017788-1'	=>'S16',
	'017794-0'	=>'S40',
	'017794-1'	=>'S17',
	'017798-0'	=>'S41',
	'017798-1'	=>'S5',
	'017833-0'	=>'S42',
	'017833-1'	=>'S6',
	'017834-0'	=>'S43',
	'017834-2_2'=>'S12',
	'017834-2'	=>'S7',
	'017835-0'	=>'S44',
	'017835-1'	=>'S18',
	'017841-0'	=>'S45',
	'017841-3'	=>'S19',
	'017842-0_2'=>'S28',
	'017842-2_2'=>'S25',
	'017842-2'	=>'S20',
	'017855-0'	=>'S46',
	'017855-1'	=>'S8',
	'017863-0'	=>'S47',
	'017863-1'	=>'S9',
	'017884-0'	=>'S48',
	'017884-2'	=>'S21',
	'017901-0_2'=>'S29',
	'017901-2_2'=>'S26',
	'017901-2'	=>'S22',
	'017906-0'	=>'S49',
	'017906-1'	=>'S23',
	'017911-0'	=>'S30',
	'017911-1_2'=>'S13',
	'017911-1'	=>'S24',
	'017918-0'	=>'S50',
	'017918-3'	=>'S10',
	'017927-0'	=>'S51',
	'017927-2'	=>'S11',
	'6x7-F1'	=>'S27');

foreach my $num (1..51){
	my $sample=join("","S",$num);
	foreach my $key (keys %hash){
		if ($hash{$key}	eq "$sample"){
			system "perl fastq2bam.pl --sample $key >$sample.sub"; #direct the output to a file
            my $cmd=qq(qsub -b y -l vf=48G,core=1 -q all.q -N "$sample" "sh $sample.sub"\n);
			print "$cmd\n";
            #system "$cmd"; #uncomment this line if you do need to submit the job
		}

	}

}

