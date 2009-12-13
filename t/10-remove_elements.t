#!perl -T

use strict;
use warnings;

use Test::More  tests => 8 + 1;
use Test::NoWarnings;
use Test::Differences;

use Array::RemoveElements qw{ remove_elements };


{
    my @all             = qw( rot grün blau gelb lila );
    my @exclude         = qw( rot blau );
    my @expected_diff   = qw( grün gelb lila);
    do_test(\@all, \@exclude, \@expected_diff, 'Basic: 2 elements excluded');
}

{
    my @all             = qw( rot grün blau gelb lila );
    my @exclude         = qw( rot grün blau gelb lila );
    my @expected_diff   = qw( );
    do_test(\@all, \@exclude, \@expected_diff, 'All elements are excluded');
}

{
    my @all             = qw( rot grün blau gelb lila );
    my @exclude         = qw(  );
    my @expected_diff   = qw( rot grün blau gelb lila);
    do_test(\@all, \@exclude, \@expected_diff, 'No elements are excluded');
}

{
    my @all             = qw( rot grün blau gelb lila );
    my @exclude         = qw( blau blau grün );
    my @expected_diff   = qw( rot gelb lila);
    do_test(\@all, \@exclude, \@expected_diff, 'Element excluded twice');
}

{
    my @all             = qw( rot grün grün blau gelb gelb lila );
    my @exclude         = qw( gelb blau grün );
    my @expected_diff   = qw( rot lila);
    do_test(\@all, \@exclude, \@expected_diff, 'Elements listed twice but excluded once');
}

{
    my @all             = 1 .. 100;
    my @exclude         = 52;
    my @expected_diff   = 1 .. 51;  push @expected_diff, 53 .. 100;
    do_test(\@all, \@exclude, \@expected_diff, 'One of 100 is excluded (numeric)');
}

{
    my @all             = 'a' .. 'z';
    my @exclude         = 'x';
    my @expected_diff   = 'a' .. 'w';  push @expected_diff, 'y' .. 'z';
    do_test(\@all, \@exclude, \@expected_diff, 'One of 26 is excluded (letter x)');
}

{
    my @all             = 'a' .. 'f';
    my @exclude         = 'a' .. 'z';
    my @expected_diff; # empty array
    do_test(\@all, \@exclude, \@expected_diff, 'Exclusion-list longer than all');
}

sub do_test {
    my $all             = shift;
    my $exclude         = shift;
    my $expected_diff   = shift;
    my $test_name       = shift;

    my $diff = remove_elements($all, $exclude);
    eq_or_diff $diff, $expected_diff, "$test_name";
}