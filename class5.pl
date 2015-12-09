#!/usr/bin/perl
=begin GHOSTCODE
$text = "The quick brown fox jumps over the lazy dog";
if($text =~ / (q[a-z]*) ([a-z]+)/){
	print "there's a match: $1 $2";
}else{
	print"No match";
}

open(file, "KenLayEmail.txt");
while($line = <file>){
	chomp $line;
	if($line =~ /^From: (\S+\@\S+\.\S+)/){
		$from = $1;
	}
	if($line =~ /^To: (\S+\@\S+\.\S+)/){
		$to = $1;
		$to =~ s/,//;
		$from =~ tr/a-z/A-Z/;
		print"Email from $from to $1\n";
	}
}
=end GHOSTCODE
=cut
open(file, "KenLayEmail.txt");
while($line = <file>){
	chomp $line;
	if($line =~ /^Date: .{3}, (\d+ \S+ \d+)/){
		$date =$1;
		$count{$date}++;
		
		($day,$month,$year) = split(/ /,$date);
		$d{$day}++;
		$m{$month}++;
		$y{$year}++;
	}
}close file;
=begin GHOSTCODE
foreach $date(sort keys %count){
	print "$date\t";
	print $count{$date};
	print"\n";
}
=end GHOSTCODE
=cut
foreach $date(sort {$a<=>$b} keys %m){
	print "$date\t";
	print $m{$date};
	
	$n = $m{$date};
	$nf = int($n/50);
	for($i=0;$i<$nf;$i++){
		print"*";
	}
	print"\n";
}
