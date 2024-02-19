use Dancer2;
use File::HomeDir;
use Encode;  
  
# CONFIGURACIÓN PARA USAR ARCHIVOS ESTATICOS DESDE LA CARPETA public
set public_dir => path(dirname(__FILE__), 'public'); 

get '/' => sub {
    my $content = ''; 
    template 'index', { content => $content, mensaje => '' };
};

post '/' => sub {
    my $upload = request->upload('archivo');

    if ($upload) { 
        my $content = $upload->content; 

          unless (utf8::is_utf8($content)) { 
            $content = decode('UTF-8', $content, Encode::FB_CROAK);
        }
        
        template 'index', { content => $content, mensaje => '' };
    } else {
        template 'index', { content => '', mensaje => 'Error: No se seleccionó ningún archivo.' };
    }
};
   
get '/limpiar' => sub {
    redirect '/';
};

post '/guardar' => sub {
    # OBTENEMOS NUESTROS VALORES Y LOS ASIGNAMOS A LAS VARIABLES CORRESPONDIENTES
    my $content = request->body_parameters->{'contenido'};
    my $file_name = request->body_parameters->{'nombre_archivo'};
    my $file_type = request->body_parameters->{'tipo_archivo'};

    # VERIFICAR SI SE PROPORCIONÓ UN NOMBRE PARA EL ARCHIVO  
    unless ($file_name) {
        return template 'index', { content => $content, mensaje => "Error: Debes proporcionar un nombre de archivo." };
    }

    # VERIFICAR SI HAY CONTENIDO EN EL ARCHIVO
    unless ($content) {
        return template 'index', { content => $content, mensaje => "Error: El archivo está vacío. Por favor, proporciona contenido." };
    }

    # COMPROBAR SI SE ESCOGIÓ 'txt' o 'csv'
    if ($file_type eq "txt") { 
        $file_name .= ".txt";
    } else {
        $file_name .= ".csv";
    }
 
    # CONFIGURACIÓN PARA INDICAR QUE LOS ARCHIVOS SE GUARDEN EN LA CARPETA DE DESCARGAS
    my $download_dir = File::Spec->catfile(File::HomeDir->my_home, 'Downloads', $file_name);
    
    # COMPROBAR SI YA EXISTE UN ARCHIVO CON ESE NOMBRE
    if (-e $download_dir) {
        template 'index', { content => $content, mensaje => "Error: ya existe un archivo con el nombre: $file_name. Por favor, elige otro nombre." };
    } else {
        open(my $file, '>', $download_dir);
        print $file $content;
        close $file;

        template 'index', { content => $content, mensaje => "$file_name guardado exitosamente" };
    }
}; 

start;