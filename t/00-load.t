#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Array::RemoveElements' );
}

diag( "Testing Array::RemoveElements $Array::RemoveElements::VERSION, Perl $], $^X" );
