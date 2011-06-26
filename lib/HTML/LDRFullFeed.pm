package HTML::LDRFullFeed;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
__PACKAGE__->mk_accessors( qw( api_key ) );
__PACKAGE__->make_ro_accessor( qw( result wedata) );

our $VERSION = '0.01';

use URI;
use Web::Scraper;
use WebService::Wedata;

sub new {
    my $class = shift;
    return $class->SUPER::new( {@_} );
}

sub extract {
    my ( $self, $url ) = @_;

    my $wedata   = WebService::Wedata->new( $self->{api_key} );
    my $database = $wedata->get_database('LDRFullFeed');
    my @info = grep $url =~ $_->{data}->{url}, @{ $database->get_items() };

    return unless @info;

    $self->{wedata} = $info[0]->{data};
    $self->{wedata}{name} = $info[0]->{name};

    $self->{result} = scraper {
        process $self->{wedata}{xpath}, 'content' => 'TEXT';
    }->scrape( URI->new($url) );
}

1;
__END__

=head1 NAME

HTML::LDRFullFeed - An HTML content extractor by LDRFullFeed.

=head1 SYNOPSIS

  use HTML::LDRFullFeed;

  my $ldr = HTML::LDRFullFeed->new( api_key => 'YOUR_API_KEY');
  $ldr->extract('http://www.example.com/');
  say $ldr->{result}{content};

=head1 DESCRIPTION

HTML::LDRFullFeed is An HTML content extractor by LDRFullFeed.

=head1 AUTHOR

Hidekazu Tanaka E<lt>hidekazu.tanaka@gmail.comE<gt>

=head1 SEE ALSO

L<http://wedata.net/databases/LDRFullFeed/items>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
