package Data::Validate::ChineseID;

use strict;
use warnings;
use Data::Validate::Date;

our $VERSION = '0.01';

sub new {
    my $class = shift;
    bless {},$class;
}

sub is_chinese {
    my $self = shift;
    my $id = shift;

    return unless defined $id;

    if ($id =~ /^(\d{6})(\d{8})(\d{3})(\d|X)$/ ) {
        my $location = $1;
        my $birthday = $2;
        my $sequence = $3;
        my $checkcode = $4;

        my $t = Data::Validate::Date->new;
        unless ($t->is_date($birthday) ) {
            return;
        }

        my @num = split//, $location.$birthday.$sequence;

        my @idx = (7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2);
        my %hash = (0=>'1',1=>'0',2=>'X',3=>'9',4=>'8',5=>'7',6=>'6',7=>'5',8=>'4',9=>'3',10=>'2');
        my $sum = 0;

        for (@num) {
           my $tmp = shift @idx;
           $sum += $_ * $tmp;
        }

        return $hash{$sum%11} eq $checkcode ? 1 : undef;

    } else {
        return;
    }
}

1;

=head1 NAME

Data::Validate::ChineseID - validate Chinese identity card

=head1 VERSION

Version 0.01


=head1 SYNOPSIS

    use Data::Validate::ChineseID;

    my $test = Data::Validate::ChineseID->new;
    my $re = $test->is_chinese('510522198702097567');

    print "the card number is ", $re ? '' : 'not', " a Chinese";


=head1 METHODS

=head2 new()

Create the object.

    my $test = Data::Validate::ChineseID->new;

=head2 is_chinese()

Validate the given identity card number is a Chinese or not, return 1 for true, undef for false.
Since 15 bits id card is do out of date, we accept only 18 bits card number.

    my $re = $test->is_chinese('510522198702097567');


=head1 AUTHOR

Peng Yong Hua <pyh@mail.nsbeta.info>


=head1 BUGS/LIMITATIONS

If you have found bugs, please send email to <pyh@mail.nsbeta.info>


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Data::Validate::ChineseID


=head1 COPYRIGHT & LICENSE

Copyright 2011 Peng Yong Hua, all rights reserved.

This program is free software; you can redistribute it and/or modify 
it under the same terms as Perl itself.
