use strict;
use warnings;
open QU,'+<','quiz.txt' or die $!;


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

close QU;

