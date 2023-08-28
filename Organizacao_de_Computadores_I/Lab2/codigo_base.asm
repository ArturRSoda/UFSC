.data 
# Seção 1: variáveis f, g, h, i, j 
# armazenadas em memória (inicialização)
_f: .word 1    #variável f e valor inicial
_g: .word 2
_h: .word 4
_i: .word 8
_j: .word 16
# Seção 2: jump address table
jat: 
.word L0       #endereço do label L0
.word L1
.word L2
.word L3
.word L4
.word default   #endereço do label default

.text
.globl main
main:
# Seção 3: registradores recebem valores
# inicializados (exceto variável k)
lw $s0, _f
lw $s1, _g
lw $s2, _h
lw $s3, _i
lw $s4, _j
# carrega em $t4 o endereço-base de jat
la $t4, jat

# Seção 4: testa se k está no intervalo
# [0,4], caso contrário desvia p/ default
slti $t0, $s5, 5          # $t0 = 1, se k < 5
beq $t0, $zero, default   # se $t0 != 0, goto default
slti $t0, $t5, 0          # $t0 = 1, se k < 0
bne $t0, $zero, default   # se $t0 = 0, goto default

# Seção 5: calcula o endereço de jat[k]
sll $s5, $s5, 2   # k = k*4
add $t0, $t4, $s5 # $t0 = $t4 (addr base do jat) + $s5 (k)

# Seção 6: desvia para o endereço que se 
# encontra armazenado em jat[k]
jr $t0

# Seção 7: codifica as alternativas de 
# execução

L0:	addi $s0, $s0, 0 #expressao definida no relatorio
	j Exit
	
L1:	sub $s0, $s1, $s2
	j Exit
	
L2:	add $t1, $s1, $s2
	add $s0, $t1, $s4	
	j Exit
	
L3:	or $t1, $s3, $s2
	or $s0, $t1, $s4
	j Exit

L4:	and $s0, $s2, $s5
	j Exit
	
default: sub $t1, $s3, $s5
	addi $s0, $t1, 5

Exit: nop
