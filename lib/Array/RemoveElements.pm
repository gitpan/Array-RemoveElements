package Array::RemoveElements;
use warnings;
use strict;

use List::MoreUtils qw(any);
use Data::Dumper;

=head1 NAME

Array::RemoveElements - remove named elements from an array

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';

=head1 SYNOPSIS

This module is used to remove elements in an exclusion-list from elements in an 
'all'-list. 

Example 1: remove_elements

    use Array::RemoveElements qw( remove_elements );

    my $volumes = Array::remove_elements(\@all_volumes, \@excluded_volumes);
    foreach my $vol (@{$volumes}) {
        # do something with the remaining volumes ...
    }
    
All elements from the second array will be removed from the first if found 
there. 

An other function ('excluded') has been implemented, which can be useful inside of a loop, 
when the name of the excluded elements are packed into a data-structure, only 
visible inside of the loop.

Example 2: excluded
    
    use Array::RemoveElements qw( excluded );
    
    foreach my $vol ( @all_volumes ) {
        next if excluded($vol, \@excluded_vols);
        # ...
    }

This module has been developed to simplify the process of writing plugins for 
Nagios, where often a list of items to check is determined by the script, but 
several items should be excluded by means of --exclude. If --exclude is undef, 
all elements are returned. 

=head1 EXPORT

These functions are exported on request: 

    remove_elements
    excluded

=cut

our @EXPORT_OK = qw( remove_elements excluded );
use base qw(Exporter);

=head1 FUNCTIONS

=head2 remove_elements

This function receives two array-references. Any element from the second 
array, will be removed from the first. This is true, wether or not the elements
are listed more than once.

The resulting array is returned by reference.

=head3 Debugging

An optional third argument can be used to turn on debugging-output. If set to 
something greater than 0, additional information is printed to stderr. The 
higher the value, the more details are printed [0..3]. 

Example with debugging on: 

    my $volumes = Array::remove_elements(\@all_volumes, \@excluded_volumes, 1);
    ... 

=cut

sub remove_elements {
    my $all     = shift;    # ref to array
    my $exclude = shift;    # ref to array
    my @diff;               # will be returned. The idea: "@diff = @{$all} - @{$exclude}"
    my $debug = shift;
    if ( not defined $debug ) {
        $debug = 0;         # defaults to 0 (=no debugging output)
    }
    print {*STDERR} "Dump of \$all in Array::RemoveElements:\n" . Dumper($all) . "\n" if $debug > 1;
    if (not defined $exclude) {
        print {*STDERR} 'All elements will be returned, because the exclusion-array is undef' . "\n" if $debug > 0;
        return $all;
    }
    ELEMENT: foreach my $element ( @{$all} ) {
        if ( any { /^$element$/ } @{$exclude} ) {
            print {*STDERR} "Element $element excluded" . "\n" if $debug > 0;
            next ELEMENT;
        }
        else {
            print {*STDERR} "Element $element included" . "\n" if $debug > 1;
            push @diff, $element;
        }
    }
    return \@diff;
}

=head2 excluded

This function receives two values (scalar name of an element and a list of 
elements to exclude) and returns either 1 or 0.

Typical usage is inside of an foreach-loop as boolean argument for 
a 'next if ()'

    foreach my $vol ( @all_volumes ) {
        my $vol_name = $vol->child_get_string('name');
        next if excluded($vol_name, \@excluded_vols, $DEBUG);
        # do something with $vol
        # ...
    }

=cut

sub excluded {
    use constant YES => 1;
    use constant NO  => 0;
    my $element = shift;    # name of the element
    my $exclude = shift;    # ref to array of names to exclude
    my $debug = shift;
    if ( not defined $debug ) {
        $debug = 0;         # defaults to 0 (=no debugging output)
    }
    if (not defined $exclude) {
        print {*STDERR} "Exclusion-array is undef ==> element $element NOT excluded" . "\n" if $debug > 0;
        return NO;
    }
    if ( any { /^$element$/ } @{$exclude} ) {
        print {*STDERR} "Element $element excluded" . "\n" if $debug > 0;
        return YES;
    } else {
        print {*STDERR} "Element $element NOT excluded" . "\n" if $debug > 0;
        return NO;
    }
    die 'ERROR at l146 in RemoveElements.pm - this should not happen' . "\n";
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

=item * Authors homepage about Nagios

L<http://nagios.lantschner.name/>

=back


=head1 ACKNOWLEDGEMENTS



=head1 COPYRIGHT & LICENSE

Copyright 2009 Ingo LANTSCHNER, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut


