use strict;
use warnings;

sub quiz {
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
		chomp($res);
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
$score++ if ($answers[$indexa] eq $_);
$indexa++
}
#print @answers;
#print @response;
#print $score;
close IN;
close QU;
close AN;
return $score;
# print "Your score = $score";
}

sub signup{
open FH,'>>','Database.txt' or die $!;
# Accepting Username and Password
print "Username :";
my $username = <STDIN>;
print "Password :";
my $password = <STDIN>;
sleep (1);
my $output = quiz(); 
print "Your Overall Score is $output\n";
print "Login again to see other features";
my @databasekeys = ($username,$password,$output);
chomp(@databasekeys);
print FH "\n";
print FH join(":",@databasekeys);
close FH;
}

sub login {
open FH,'<','Database.txt' or die $!;
my %users;
while (<FH>)
{
chomp;
my ($username, @datas) = split ':';
$users{$username} = \@datas;
}

print "Enter your username :";
my $loginuser =<STDIN>;
chomp ($loginuser);
# $\ ="\n";	
if (exists $users{$loginuser})
	{
foreach ( sort keys %users)
{
	my $local = $loginuser eq $_;
	# print $local;
    if ($local == 1)
	{
	print "Password :";
	my $loginpass = <STDIN>;
	chomp($loginpass);
	if ($loginpass eq ${$users{$_}}[0])
		{
         print "Successfully logged in\n";
		 print "Your test score : ${$users{$_}}[1]\n";
		}
	else
	{
		print 'Login Error';
		exit;
	}
    }
}
	}
else {
	print 'Username error';
}
close FH;
print 'Do you want to edit the Questions(y/n):';
my $qeditans =<STDIN>;
chomp($qeditans);
if ($qeditans eq 'y'){
	questionedit();
	print"Thank you\n";
	exit;
}
else{
	print"Terminating the program.See you later\n";
	exit;
}
close QU;
}

sub questionedit {
	
open QU,'+<','quiz.txt' or die $!;
open AN,'+<','ans.txt' or die $!;
my @questions;
while (<QU>)
{
chomp;
my @temp = split ':';
push @questions,\@temp;
}

my @modque;
foreach my $temp1 (@questions)
{
	print 'Enter your question :';
	 $modque[0] = <STDIN>;
	 chomp($modque[0]);
	print 'Enter first choice :';
	 $modque[1] = <STDIN>;
	 chomp($modque[1]);
	print 'Enter Second choice :';
	 $modque[2] = <STDIN>;
	 chomp($modque[2]);
	print 'Enter Third choice :';
	 $modque[3] = <STDIN>;
	 chomp($modque[3]);
	print 'Enter Fourth choice :';
	 $modque[4] = <STDIN>;
	 chomp($modque[4]);
    @$temp1=@modque;
}
seek QU,0,0;
foreach (@questions){
	print QU join (":",@$_);
	print QU "\n";
}

my @answers;
while (<AN>)
{
chomp;
@answers = split ':';
}
my $tempans=0;
foreach (@answers){
	print"Enter the answer for respective question:";
	$answers[$tempans] = <STDIN>;
	chomp($answers[$tempans]);	
	$tempans++;
}

seek AN,0,0;
print AN join(":",@answers);

}

print 'Are you an existing user?(y/n):';
my $euser = <STDIN>;
chomp($euser);
login () if ($euser eq 'y');
signup() if ($euser eq 'n');


