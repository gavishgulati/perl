#!/usr/bin/perl
use Data::Dumper;
use JSON;
use LWP::Simple;
# trying to use new module from CPAN but didn't work.
use List::MoreUtils qw( uniq );
$json = JSON->new->allow_nonref;

#this piece of code is to extract message(somewhat with loads of other stuff) and date.
#start
open( gavish, "KenLayEmail.txt" );
$i = 0;
while (<gavish>) {
	$line = $_;
	chomp($line);
	if ( $line =~ /([\d]{2}\/[\d]{2}\/[\d]{4})\s[\d]{2}:[\d]{2}\s[A|P]M/g ) {
		$crap = $line;
		$date[$i] = $1;
		$i++;

		$crap = substr( $crap, 0, 300 );

		$hash{$date}{"crap"} = $crap;
	}
}
close FILE;

#end
#-------------------------------------------------------

#this code chunk is to extract score values from Alchemy API.
#start
$file = get
"http://gateway-a.watsonplatform.net/calls/text/TextGetTextSentiment?apikey=da2c781b2ea519ad4243c59b182e45f9a242f473&text=$crap&outputMode=json";
$jsonHash = $json->decode($file);
$score    = $jsonHash->{"docSentiment"}->{"score"};
#end
#------------------------------------------------------------
#this piece of code is to extract any stock share
#start
open($fh, '>>', "gulati_gavish_hw7.csv");
 open (hw, "enronStockPrices.csv");
    while (<hw>)
     {
     $line = $_;
    chomp ($line);
    ($date, $close, $high, $low, $volume)=split(/,/,$line);

	$hash{$date}{"stockPriceChange"} = $high - $low;
	$hash{$date}{"date"}             = $date;
	
foreach $key (sort(keys %hash)) {
 	print $fh $date.",".$score.",".$close.",".$hash{$date}{"stockPriceChange"};       
}
}
#end
close $fh;
close hw;
