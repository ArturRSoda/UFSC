.data
_save: .word 9999, 7, 6, 1, 6, 4, 5, 6, 0                    # completar com Estímulo 2.1 ou Estímulo 2.2
_k: .word 6 
_error: .asciiz "Index Out of Bounds Exception"	    
.text
.globl main
main: # inicialização
la $s6, _save           # $s6 = addr base do save            completar com 1 pseudoinstrução
lw $s5, _k              # $s5(k) = 6                         completar com 1 pseudoinstrução
lw $t3, 4($s6)          # $t3 = tamanho do save              completar com 1 instrução nativa
addi $s3, $zero, 0      # $t0(i) = 2                         completar com 1 instrução nativa
Loop: 
# verificação de limite do arranjo
sltu $t4, $s3, $t3 	              # $t4 = 1, se 0 <= i < t3 // $t4 = 0, se i < 0 ou i > t3   teste de índice: completar com 1 instrução nativa
beq $t4, $zero, IndexOutOfBounds      # desvio para mensagem de erro: completar com 1 instrução nativa
# corpo do laço
sll $t1, $s3, 2     #t1 = i*4
add $t1, $t1, $s6   #t1 += save[0]
lw $t0, 8($t1)      #t0 = t1 (save[i+2])               # você terá que modificar esta instrução!
bne $t0, $s5, Exit  #se save[1] != k, va para exit
addi $s3, $s3, 1    #i++       
j Loop               #va para loop

Exit: # rotina para imprimir inteiro no console
addi $v0, $zero, 1
add $a0, $zero, $s3
syscall
j End

IndexOutOfBounds: # rotina para imprimir mensagem de erro no console
addi $v0, $zero, 4
la $a0, _error
syscall
End:   
