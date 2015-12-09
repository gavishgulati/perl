#!/usr/bin/perl
use JSON;
use LWP::Simple;
use Data::Dumper;

$json = JSON->new->allow_nonref;
$marker = 0;
$fileName = "http://real-chart.finance.yahoo.com/table.csv?s=AAPL&a=08&b=01&c=2015&d=08&e=30&f=2015&g=d&ignore=.csv";

$file = get $fileName;

$stockTicker = "AAPL";

@lines = split(/\n/,$file);

foreach $line (@lines) {
	 
	
($date,$open,$high,$low,$close,$volume,$adj) = (split(/,/,$line));
$weather{$date}{"stockPriceChange"} = $close - $open;
$weather{$date}{"date"} = $date;
$weather{$date}{"tickerSymbol"} = $stockTicker;

$Date2 = $date;
$Date2 =~ s/-//g;

$jsonFile = get "http://api.wunderground.com/api/8f22a9ece2e9226f/history_".$Date2."/q/NY/New_York.json";
$jsonHash = $json->decode($jsonFile);
$rec      = $jsonHash->{"history"}->{"observations"};
foreach $record (@$rec) {
	if ( $record->{"date"}->{"hour"} eq "08" ) {
		$weather{$date}{"let_it_rain"}  = $record->{"rain"};
		$weather{$date}{"tempi"} = $record->{"tempi"};
		}
	}
}
$jsonData = $json->pretty->encode( \%weather );
print $jsonData;
print "Thank you for waiting Dr. Golbeck. PLease see the data above."