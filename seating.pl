#!/usr/bin/perl -w
use strict;

my @presents = ();  ## 出席者
my @numbers = ();   ## 数
my %postions = ();  ## 出席者と数
my $i = 1;

if ( !$ARGV[0] ) {
 print "Usage: perl seating.pl <file>.\n";
 exit 1;
}

open(FILE, "< $ARGV[0]") or die "$!";

while ( <FILE> ) {
  chomp($_);             ## 改行の除去
  $_ =~ s/\s//g;         ## 空白文字の除去
  if ( $_ !~ /^\#+.*/ ) {  ## コメント行を除く
    push(@presents, $_);
    push(@numbers, $i);
    $i++;
  }
}

close(FILE);

## 出席者と数の紐付け
foreach ( @presents ) {
  my $num = splice(@numbers, int( rand(@numbers) ), 1);  ## ランダムな数字を取得
  $postions{$_} = $num;
}

print "The attendance\n";
for ( $i=1; $i<=@presents; $i++) {
  print "$presents[$i-1]\t";
  print "\n" if $i%5 == 0;
}
print "\n";

print "What's your name?: ";
while ( <STDIN> ) {
  chomp($_);          ## 改行の除去
  last if ( $_ eq "quit" || $_ eq "q" );
  if ( exists $postions{$_} ) {
    print "$_\'s number is $postions{$_}\n";
  }
  else {
    print "Unmatch your name.\n";
    print "Try again.\n";
  }
  print "What's your name?: ";
}

