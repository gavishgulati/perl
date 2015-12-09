#!/usr/bin/perl
use JSON;
use LWP::Simple;
use Data::Dumper;

$json = JSON->new->allow_nonref;
$headerLine = 0;
$fileName = "http://real-chart.finance.yahoo.com/table.csv?s=FB&a=03&b=1&c=2015&d=03&e=30&f=2015&g=d&ignore=.csv";
$file = get $fileName;
$fileName =~ /\?s=(.*)&/;
$ticker = ( split( /&/, $1 ) )[0];

@lines = split( /\n/, $file );

foreach $line (@lines) {
	
	if($headerLine == 0){
		$headerLine = 1;
		next;
	} 
	
	($date)  = ( split( /,/, $line ) )[0];
	($open)  = ( split( /,/, $line ) )[1];
	($close) = ( split( /,/, $line ) )[4];
	$hash{$date}{"date"}             = $date;
	$hash{$date}{"tickerSymbol"}     = $ticker;
	$hash{$date}{"stockPriceChange"} = $close - $open;
	$requestDate                     = $date;
	$requestDate =~ s/-//g;

	$jsonFile = get "http://api.wunderground.com/api/d40d931af74cd1fe/history_".$requestDate."/q/NY/New_York.json";
	$jsonHash = $json->decode($jsonFile);
	$obs      = $jsonHash->{"history"}->{"observations"};
	foreach $observation (@$obs) {
		if ( $observation->{"date"}->{"hour"} eq "09" ) {
			$hash{$date}{"rain"}  = $observation->{"rain"};
			$hash{$date}{"tempm"} = $observation->{"tempm"};
		}
	}
}

$jsonString = $json->pretty->encode( \%hash );

print $jsonString;

print "\nResults printed to file: kulkarni_bhagyashree_hw6.txt.";
