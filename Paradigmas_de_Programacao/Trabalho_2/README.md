Para criar o arquivo executavel:

1. carregue na pasta Trabalho_2 carregue o arquivo Src/main.lisp no sbcl

    sbcl --load Src/main.lisp

2. Depois dentro do sbcl execute:

    (sb-ext:save-lisp-and-die "result" :toplevel #'main :executable t :compression 9)

3. Assim, o executavel 'result' ira ser criado, basta executa-lo
