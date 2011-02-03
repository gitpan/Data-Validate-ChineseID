#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Data::Validate::ChineseID' ) || print "Bail out!
";
}

diag( "Testing Data::Validate::ChineseID $Data::Validate::ChineseID::VERSION, Perl $], $^X" );
