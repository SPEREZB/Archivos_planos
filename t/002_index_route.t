use strict;
use warnings;

use archivos_planos;
use Test::More tests => 4;
use Plack::Test;
use HTTP::Request::Common;
use Ref::Util qw<is_coderef>;

# ESTABLECER UN ENTORNO DE TESTEO PARA Dancer2
my $app = archivos_planos->to_app;
ok( is_coderef($app), 'Got app' ); 
my $test = Plack::Test->create($app);

# TEST DE ENDPOINT GET '/'
my $res  = $test->request( GET '/' );

ok( $res->is_success, '[GET /] successful' );

# TEST DE ENDPOINT POST '/'
my $post_res = $test->request( POST '/', [ archivo => 'Contenido del archivo'] );

ok( $post_res->is_success, '[POST /] successful' );

# TEST DE ENDPOINT POST '/guardar'

my $post_res_save = $test->request( POST '/guardar', [ contenido => 'Contenido del archivo', nombre_archivo => 'archivo.txt', tipo_archivo => 'txt' ] );

ok( $post_res_save->is_success, '[POST /guardar] successful' );