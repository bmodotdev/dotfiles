#!/usr/bin/env perl

package script::foo;

use strict;
use warnings;

use Getopt::Long::Descriptive	();
use Log::Log4perl				qw( :levels );
use Log::Log4perl::Layout		();

use constant SUCCESS => 0;
use constant FAILURE => 1;

# Modulino
exit( __PACKAGE__->new(\@ARGV)->run() ) unless caller;

sub new {
	my $class = shift;

	my ($opt, $usage) = Getopt::Long::Descriptive::describe_options(

		# Usage description
		'%c %o <some-arg>',

		# Options
		[ 'integer|i=i',	'An integer with short option -i',
			{ required	=> 1 } ],

		[ 'string|s=s',		'A string with short option -s',
			{ default	=> 'foobar' } ],
		[],
		[ 'help|h'		=>  'Print this help message' ],
		[ 'debug_level' => hidden => { one_of => [
			[ 'verbose|v'	=> 'Show debug output' ],
			[ 'quiet|q'		=> 'Show only errors' ],
		], default => $INFO } ],

		# describe_options arguments
		{ show_defaults => 1 }
	);

	# Help
	if ($opt->help) {
		print $usage->text;
		exit SUCCESS;
	}

	return bless $opt, $class;
}

sub run {
	my $self	= shift;
	my $logger	= $self->get_logger();

	return SUCCESS;
}

sub get_logger {
	my $self	= shift;

	my $logger	= Log::Log4perl->get_logger( (caller(1))[3] );
	my $layout	= Log::Log4perl::Layout::PatternLayout->new('[%d] [%p] [%M %L] %m%n');
	my $screen_appender	= Log::Log4perl::Appender->new(
		'Log::Log4perl::Appender::ScreenColoredLevels',
		name	=> 'screenlog',
		stderr	=> 1,
	);

	$screen_appender->layout( $layout );
	$logger->add_appender( $screen_appender );
	$logger->level( $self->{debug_level} );

	return $logger;
}

1;

=pod

=encoding UTF-8
