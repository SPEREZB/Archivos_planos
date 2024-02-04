# ARCHIVO NECESARIO PARA REALIZAR LAS PRUEBAS UNITARIAS

# EXPORTAMOS TODO ESTE ARCHIVO EN EL NOMBRE archivos_planos PARA TESTEAR SUS FUNCIONES
package archivos_planos;
use Dancer2; 
use File::HomeDir;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'archivos_planos' };
};
 
post '/' => sub {
    my $upload = request->upload('archivo');

    if ($upload) { 
        my $content = $upload->content;
        template 'index', { content => $content, mensaje => '' };
    } else {
        template 'index', { content => '', mensaje => 'Error: No se seleccionó ningún archivo.' };
    }
};

post '/guardar' => sub {
   my $content = params->{'contenido'};
    my $file_name = params->{'nombre_archivo'};
    my $file_type = params->{'tipo_archivo'};
    
    if ($file_type eq "txt") {
        $file_name .= ".txt";
    } else {
        $file_name .= ".csv";
    }

    my $download_dir = File::Spec->catfile(File::HomeDir->my_home, 'Downloads', $file_name);

    if (-e $download_dir) {
        template 'index', { content => $content, mensaje => "Error: ya existe un archivo con el nombre: $file_name. Por favor, elige otro nombre." };
    } else {
        open(my $file, '>:encoding(utf-8)', $download_dir);
        print $file $content;
        close $file;

        template 'index', { content => $content, mensaje => "$file_name guardado exitosamente" };
    }
};

true;
