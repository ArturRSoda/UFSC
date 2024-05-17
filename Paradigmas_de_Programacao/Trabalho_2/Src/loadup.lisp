(load "Src/package.lisp")
(load "Src/utils.lisp")
(load "Src/position.lisp")
(load "Src/board.lisp")
(load "Src/solve.lisp")
(load "Src/main.lisp")

(sb-ext:save-lisp-and-die "result"
    :toplevel #'myPack::main
    :executable t
    :compression 9)
