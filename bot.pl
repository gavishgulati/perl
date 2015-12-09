#usr/bin/perl
use LWP::Simple;
use XML::Bare;
use Net::Twitter;
use Data::Dumper;

#twitter funda
$consumer_key = "FbIUOTnIi8yrTsAXj9HGTpaDi";
$consumer_secret = "UEVEu8hUPJxz3eDMP8BLQnk3F6nCVeHI7kqxNFq2wEpI62GSOH";
$token = "4207138935-UYpkzM8Sf5wZLzDkRq22eFfYAToYfOSoxEuxchT";
$token_secret = "lrcSeDIfh0FOVTpfPQxNKpqjETwLlHXe4RNlGLj2ECf8E";

my $nt = Net::Twitter->new(
      traits   => [qw/API::RESTv1_1/],
      consumer_key        => $consumer_key,
      consumer_secret     => $consumer_secret,
      access_token        => $token,
      access_token_secret => $token_secret,
  );
#fetch mentions for @superguru_API user
my $r = $nt->mentions({count=> 1});
for my $status (@{$r}){
$var = "$status->{text}\n";
$username = "$status->{user}{screen_name}\n";
}
print $var."\n";
$var =~ s/\@superguru_API//ig;

#logic to not repeat same status when this script is put on scheduler
my $r1 = $nt->home_timeline({
      count=> 1
   });

for my $status1 (@{$r1}){
$myStatus = "$status1->{text}\n";
}
print "$mystatus 111";
#API funda for wolfram
#app ID for using wolfram
$appid="5A6VU4-72RT8H2EQW";
$file = get"http://api.wolframalpha.com/v2/query?appid=$appid&input=$var&format=plaintext";
$bare = new XML::Bare( text=>$file);
$root = $bare->parse();

$output = $root->{queryresult}->{pod}->[1]->{subpod}->{plaintext}->{value};
print "$output22 \n";
$size = length($output);
$usernameSize = length($username);
$totalsize = $size + $usernameSize;

if ($totalsize > 140){
	$outputNew = substr( $output, 0, 140 );
	print "I am here";
}
else{
	$outputNew = $output;
	print "I am here1";
}
if ($outputNew eq "(data not available)"){
#do nothing
}
elsif($outputNew eq ""){
#do nothing

}
elsif($outputNew eq $myStatus){
#do nothing

}
else{
    $nt->update({ status => "@" . "$username" . " " . "$outputNew" });
    print "I am here22";
}
