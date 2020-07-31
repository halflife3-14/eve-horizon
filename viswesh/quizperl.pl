use strict;
use warnings;
# open FH,'>>','Database.txt' or die $!;
open QU,'<','quiz.txt' or die $!;
open IN,'<','info.txt' or die $!;
open AN,'<','ans.txt' or die $!;

my @information;
while (<IN>)
{
chomp;
my @temp1 = split ':';
push @information,\@temp1;
}
foreach (@information){
 print "$_\n" foreach @$_;
 }
sleep (5);
my @questions;
my $score = 0;
my @response;
while (<QU>)
{
chomp;
my @temp = split ':';
push @questions,\@temp;
}
foreach (@questions)
{
     foreach (@$_)
        {
		 print "$_\n"; 
        }
		print 'Your Response :';
		my $res = <STDIN>;
		push @response,$res;
}
chomp(@response);

my @answers;
while (<AN>)
{
	chomp;
	@answers = split ':';
}
my $indexa=0;
foreach (@response){
$score++ if ($answers[$indexa] == $_);
$indexa++
}
#print @answers;
#print @response;
#print $score;
close IN;
close QU;
close AN;