use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Array::RemoveElements',
    license             => 'perl',
    dist_author         => 'Ingo LANTSCHNER <perl [at] lantschner.name>',
    dist_version_from   => 'lib/Array/RemoveElements.pm',
    build_requires => {
        'Test::More' => 0,
        'Test::Differences' => 0.4801,
        'Test::More' => 0.47, 
        'Test::NoWarnings' => 0.084,
        
    },
    requires => {
        'perl' => 5.006, 
        'base' => 1.01, 
        'constant' => 1.02, 
        'Data::Dumper' => 0,
        'Exporter' => 0,
        'List::MoreUtils' => 0.22,
    },
    
    add_to_cleanup      => [ 'Array-RemoveElements-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
