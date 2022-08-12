package gem_compiler;

use strict;
use warnings;

print "Iterkocze Gem Compiler 0.0.0.00....00.00000.14\n";

my $file = 'main.gem';
open my $info, $file or die "Could not open $file: $!";

my $OUTFILE = 'assembly.asm';
my $output_string = "";

$output_string .= "
    section .data\n
";  

while( my $line = <$info>)  {   
    if (rindex($line, "Remember", 0) == 0) {
        my @def = split(' ', $line); 
        my $string = $def[1];
        my $var_name = $def[3];    
        $output_string .= "
            ${var_name}: db ${string},10\n
            ${var_name}Len equ \$ - ${var_name}\n
        ";    
    }
    last if $. == 2;
}

$output_string .= "
    global _start\n
    section .text\n
    _start:\n
";  

open my $info2, $file or die "Could not open $file: $!";

while( my $line = <$info2>)  {   
    if (rindex($line, "Write", 0) == 0) {
        my @def = split(' ', $line); 
        my $var_name = $def[1];   
        $output_string .= "
            mov eax, 4\n
            mov ebx, 1\n
            mov ecx, ${var_name}\n
            mov edx, ${var_name}Len\n
            int 0x80 \n
        ";    
    }
    last if $. == 2;
}

$output_string .= "
    mov eax, 1\n
    int 0x80\n
";  

close $info;
close $info2;

open(FH, '>', $OUTFILE) or die $!;
print FH $output_string;

