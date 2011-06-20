use inc::Module::Install;
name 'HTML-LDRFullFeed';
all_from 'lib/HTML/LDRFullFeed.pm';
readme_pod_from 'lib/HTML/LDRFullFeed.pm';
githubmeta;

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
