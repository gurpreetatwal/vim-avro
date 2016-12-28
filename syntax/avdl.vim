" Vim syntax file
" Language:     Apache Avro
" Maintainer:   Gurpreet Atwal<git@gatwal.com>
" Filenames:    *.avdl
" Last Change:  2016 Dec 28
" Version:      0.2

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
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

" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_avdl_syn_inits")

  if version < 508
    let did_avdl_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink avroAnnotation Default
  HiLink avroComment Comment
  HiLink avroDefault Default
  HiLink avroEscaped Default
  HiLink avroFixedDeclaration Statement
  HiLink avroFixedName Identifier
  HiLink avroMessageDeclaration Identifier
  HiLink avroStatement Statement
  HiLink avroTodo Todo
  HiLink avroType Type
  HiLink avroTypeDeclaration Statement
  HiLink avroTypeName Identifier

  delcommand HiLink
endif

let b:current_syntax = 'avdl'
