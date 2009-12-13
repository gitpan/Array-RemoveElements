package Array::RemoveElements;
use warnings;
use strict;

use List::MoreUtils qw(any);

=head1 NAME

Array::RemoveElements - remove named elements from an array

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

This module receives two arrays. All elements from the second array will be 
removed from the first if found there.

Example:

    use Array::RemoveElements;

    my $volumes = Array::remove_elements(\@all_volumes, \@excluded_volumes);
    foreach my $vol (@{$volumes}) {
        # do something with the remaining volumes ...
    }

This module has been developed to simplify the process of writing plugins for 
Nagios, where often a list of items to check is determined by the script, but 
several items should be excluded by means of --exclude.

=head1 EXPORT

Only one function is exported on request: 

    remove_elements
    
=cut 

our @EXPORT_OK = qw( remove_elements );
use base qw(Exporter);

=head1 FUNCTIONS

=head2 remove_elements

This function receives two array-references. Any element from the second 
array, will be removed from the first. This is true, wether or not the elements
are listed more than once.

The resulting array is returned by reference.

=head3 Debugging

An optional third argument can be used to turn on debugging-output. If set to 
something greater than 0, additional information is printed to stderr.

Example: 

    my $volumes = Array::remove_elements(\@all_volumes, \@excluded_volumes, 1);
    ... 
    
=cut

sub remove_elements {
    my $all     = shift;    # ref to array
    my $exclude = shift;    # ref to array
    my @diff;               # @diff = @{$all} - @{$exclude}
    my $debug = shift;
    if ( not defined $debug ) {
        $debug = 0;         # defaults to 0 (=no debugging output)
    }

  ELEMENT: foreach my $element ( @{$all} ) {
        if ( any { /^$element$/ } @{$exclude} ) {
            print {*STDERR} "Element $element excluded" . "\n" if $debug > 0;
            next ELEMENT;
        }
        else {
            push @diff, $element;
        }
    }
    return \@diff;
}
1;    # End of Array::RemoveElements
__END__

=head1 AUTHOR

Ingo LANTSCHNER, C<< <perl [at] lantschner.name> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-array-removeelements at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Array-RemoveElements>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Array::RemoveElements


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Array-RemoveElements>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Array-RemoveElements>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Array-RemoveElements>

=item * Search CPAN

L<http://search.cpan.org/dist/Array-RemoveElements/>

=item * NetApp-Monitoring.info

L<http://www.netapp-monitoring.info/>

=back


=head1 ACKNOWLEDGEMENTS



=head1 COPYRIGHT & LICENSE

Copyright 2009 Ingo LANTSCHNER, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut


