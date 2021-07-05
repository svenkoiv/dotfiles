" Java
setlocal suffixesadd=.java
" Tabs
setlocal smarttab
setlocal expandtab
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4

" ALE
" -----------------------------
let b:ale_linters = {'java': []}
" let g:ale_java_checkstyle_executable = 'java -jar checkstyle-8.36.2-all.jar'
" let g:ale_java_javac_classpath = 'checkstyle-8.36.2-all.jar'
" let b:ale_java_javac_classpath = 'checkstyle-8.36.2-all.jar'
" let g:ale_java_checkstyle_executable='/home/skoiv/Projects/impulss/checkstyle-8.36.2-all.jar'
" let g:ale_java_checkstyle_config='/home/skoiv/Projects/impulss/buildsettings/checkstyle.xml'
