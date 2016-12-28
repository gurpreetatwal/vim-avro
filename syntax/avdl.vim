" Syntax file for Avro IDL files.

if exists('b:current_syntax')
  finish
endif

syn case match

" Delegate to JSON syntax highlighting for defaults.
syn include @json syntax/json.vim

syn keyword avroTodo TODO todo FIXME fixme XXX xxx contained
syn region avroComment start="/\*" end="\*/" contains=avroTodo
syn match avroComment "//.\{-}\(?>\|$\)\@=" contains=avroTodo

" All named declarations (types and messages) are easy to spot since they use
" the same identifier highlight.
syn keyword avroTypeDeclaration enum error protocol record union nextgroup=avroTypeName skipwhite
syn match avroTypeName /\v[^{]+/ contained
syn keyword avroFixedDeclaration fixed nextgroup=avroFixedName skipwhite
syn match avroFixedName /\v\w+/ contained nextgroup=avroFixedSize
syn region avroFixedSize start=/\v\(/ end=/\v\)/ contained contains=@json
syn match avroMessageDeclaration /\v\w+\ze\(/

" Annotations and defaults, which use JSON notation.
syn region avroAnnotationRegion matchgroup=avroAnnotation start=/\v\@[^(]+\(/ end=/\v\)/ contains=@json,jsonString
syn region avroDefaultRegion matchgroup=avroDefault start=/\v\=/ end=/\v,|\)|;/ contains=@json,jsonString skipwhite

syn region avroEscaped  start=/`/ end=/`/
syn keyword avroStatement throws oneway
syn keyword avroType array boolean bytes double float int long map null string void

hi def link avroAnnotation Default
hi def link avroComment Comment
hi def link avroDefault Default
hi def link avroEscaped Default
hi def link avroFixedDeclaration Statement
hi def link avroFixedName Identifier
hi def link avroMessageDeclaration Identifier
hi def link avroStatement Statement
hi def link avroTodo Todo
hi def link avroType Type
hi def link avroTypeDeclaration Statement
hi def link avroTypeName Identifier

let b:current_syntax = 'avdl'
