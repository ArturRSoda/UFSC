.data
#_save: .word ...          # completar com Estímulo 1.1 ou 1.2
_save:
.word 6
.word 6
.word 6
.word 6
.word 7

_k: .word 6             
.text
.globl main
main: # inicialização
la $s6, _save                    # completar com 1 pseudoinstrução
lw $s5, _k                       # completar com 1 pseudoinstrução
add $t0, $zero, $zero            # completar com 1 instrução nativa      
Loop: # corpo do laço
sll $t1, $s3, 2    #t1 = i*4
add $t1, $t1, $s6  #t1 += save[0]
lw $t0, 0($t1)     #t0 = t1 (save[i])
bne $t0, $s5, Exit #se save[1] != k, va para exit   
addi $s3, $s3, 1   #i++   
j Loop		   #va para loop
                
Exit: # rotina para imprimir inteiro no console
addi $v0, $zero, 1
add $a0, $zero, $s3
syscall     
