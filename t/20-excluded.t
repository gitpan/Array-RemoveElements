#!perl -T

use strict;
use warnings;

use Test::More  tests => 6 + 1;
use Test::NoWarnings;

use lib '../lib';
use Array::RemoveElements qw{ excluded };

use constant YES => 1;
use constant NO  => 0;

{
    my $element         = 'rot';
    my @exclude         = qw( rot blau );
    my $expected_result = YES;
    do_test($element, \@exclude, $expected_result, 'Basic: matching element in exclusion-list');
}
{
    my $element         = 'rot';
    my @exclude         = qw( grün blau );
    my $expected_result = NO;
    do_test($element, \@exclude, $expected_result, 'Basic: no matching elem. in exclusion-list');
}
{
    my $element         = 'rot';
    my @exclude         = qw( rot grün blau rot );
    my $expected_result = YES;
    do_test($element, \@exclude, $expected_result, 'Matching elem. twice in exclusion-list');
}
{
    my $element         = 'rot';
    my @exclude         = qw(  );
    my $expected_result = NO;
    do_test($element, \@exclude, $expected_result, 'empty exclusion-list');
}
{
    my $element         = 'rot';
    my @exclude         = qw( rotlicht rotbraun grün feurrot);
    my $expected_result = NO;
    do_test($element, undef, $expected_result, 'partly matching elements in excl. list');
}
{
    my $element         = 'rot';
    my $expected_result = NO;
    do_test($element, undef, $expected_result, 'undefined exclusion-list');
}

sub do_test {
    my $elem             = shift;
    my $exclude         = shift;
    my $expected_res   = shift;
    my $test_name       = shift;

    my $res = excluded($elem, $exclude);
    ok $res == $expected_res, "$test_name";
}