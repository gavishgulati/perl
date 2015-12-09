#!/usr/bin/perl
use LWP::Simple;
use JSON;
use Data::Dumper;

$json = JSON->new->allow_nonref;

#This code fetches comments from a picture on a page called "The LAD Bilble".
# I am planning to fetch info from various pages where people use offensive language 
#a lot(For eg JUSTIN BIEBER fan page). As of now for checking this code I have only used one image as object.
# Also this token expires every hour so change it please.

#$file = get "https://graph.facebook.com/v2.5/{object-id(could be a picture, video or something else)}/comments?access_token={YOUR_API_KEY}";
$file = get "https://graph.facebook.com/v2.5/2525813007465874/comments?access_token=CAACEdEose0cBABUWTNoYbAsoRCbFsmcSs8qwxMKBcSQSKDtC0E5zrv1NIbNiaRFGC8U67xtpdQqj81ufXU6GBcK2AMXeQw0JDCTQ1HhJW2xlmUdAG1ZB8U1NO6V2EP7gyEEW3WYpt8ObexFUFvZA7Q6rZAJ6ydy8VIsnN51VlLTLxSJk6SaHEgSQFtW2eyC1zZBd13NJEiFLBh6JuaeU";

$filename = 'gavish29.csv';
open($fh, '>>', $filename) or die "Could not open file '$filename' $!";

$jsonHash = $json->decode($file);
$content      = $jsonHash->{"data"};
	foreach $observation (@$content) {
		print $fh $observation->{"message"}."\n";
	}
close $fh;