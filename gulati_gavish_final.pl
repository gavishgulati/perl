#!/usr/bin/perl
use Net::Twitter;
use Data::Dumper;
use LWP::Simple;


#put your keys and secrets here

$consumer_key    = "8VjL9RzHss55CYhF44gymRkZH";
$consumer_secret = "9j03bZSdHX9U75kOiM3RyDH3RMap8UDK8iDsGCY0zkqZ0H2hgV";
$token           = "1494777014-47cHz4p3wgK2Ud5vAa7p2HdMNkTTwwzBsR287sq";
$token_secret    = "VKYYUztfL4kSufetCPLIrFwIlI0VhcPNEeHhlhfW9Zt8J";
 
$nt =
  Net::Twitter->new(
	traits              => [qw/API::RESTv1_1/],
	consumer_key        => $consumer_key,
	consumer_secret     => $consumer_secret,
	access_token        => $token,
	access_token_secret => $token_secret,
  );

print"Enter a term you want to search:";
$search_term = <>;
chomp $search_term;

#using the search function in Net::Twitter
 my $r = $nt->search({q=>$search_term,
 	count=>100
 });
 open( fh, '>>', 'gulati_gavish_data.csv');
    for my $status ( @{$r->{statuses}} ) {
        print fh $status->{text};
        print  fh "\n";
  }
