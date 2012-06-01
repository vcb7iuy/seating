#!/usr/bin/perl -w
use strict;

my @presents = ();  ## 出席者
my @numbers = ();   ## 数
my $i = 1;

if ( !$ARGV[0] ) {
 print "Usage: perl seating.pl <file>.\n";
 exit 1;
}

open(FILE, "< $ARGV[0]") or die "$!";

while ( <FILE> ) {
  if ( $_ !~ /^\#+.*/ ) {  ## コメント行を除く
    $_ =~ s/\r//;          ## 改行の除去
    $_ =~ s/\n//;          ## 改行の除去
    push(@presents, $_);
    push(@numbers, $i);
    $i++;
  }
}

print "name\t| number\n----------------\n";
for ( $i = 0; $i < @presents; $i++ ) {
  my $num = splice(@numbers, int( rand(@numbers) ), 1);  ## ランダムな数字を取得
  print "$presents[$i]\t|   $num\n";
}

close(FILE);

