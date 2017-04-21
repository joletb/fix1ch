#!/usr/bin/perl

use strict;
use Getopt::Std;


my $infile = shift @ARGV;
if (!$infile) {
	print("fix1ch.pl infile.aac");
	exit 1;
}

my %opts;
my $VERSION = "0.01";
getopts('vhmrf:i:', \%opts);

my $audfile =  $opts{'i'} ? $opts{'i'} : "${infile}.aac";
my $outfile = "${infile}-fixed.aac";

open (INFILE, "$infile") or die("No input found for $infile : $!");
open (OUTFILE, ">$outfile") or die("No output found for $outfile : $!");
binmode(INFILE);
binmode(OUTFILE);
local $/;
my $hex_string = <INFILE>;

substr($hex_string, 3, 1) = "\x80";

print OUTFILE $hex_string;

close(INFILE);
close(OUTFILE);
