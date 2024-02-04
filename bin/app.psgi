#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use archivos_planos;

archivos_planos->to_app;

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use archivos_planos;
use Plack::Builder;

builder {
    enable 'Deflater';
    archivos_planos->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use archivos_planos;
use archivos_planos_admin;

use Plack::Builder;

builder {
    mount '/'      => archivos_planos->to_app;
    mount '/admin'      => archivos_planos_admin->to_app;
}

=end comment

=cut

