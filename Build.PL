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
    },
    add_to_cleanup      => [ 'Array-RemoveElements-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
