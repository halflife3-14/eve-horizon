use strict;
use warnings;
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
         print 'Successfully logged in ';
	     exit;
		}
	else
	{
		print 'Login Error';
	}
    }
}
	}
else {
	print 'Username error';
}
close FH;
	