 ```
 Chapter 29 Notes
 foo 
 pkg::foo
 
 rmarkdown::html_document
 
 output:
  html_document:
    toc: true
    toc_float: true
    pdf_document: default
    code_folding: hide
  
  
  word_document (.docx)
  odt_document (.odt)
  rtf_document (.rtf)
  github_document = md_document
  
  
  

  
# or ## new slide at #first or ## second level header
 *** horizontal rule= new slide w/ no header
 
 ioslides_presentation = ioslides
 
 slidy_presentation = W3C Slidy
 
 beamer_presentation = LaTeX Beamer
 
 revealjs::revealjs_presentation requires revealjs package
 
 
 htmlwidgets
 
 library(leaflet)
 dygraphs
 DT
 threejs
 DiagrammeR
 
 
 Shiny
 
 runtime:shiny
 
 library(shiny)
 textInput
 numericInput
 
 library(shiny)

textInput("name", "What is your name?")
numericInput("age", "How old are you?", NA, min = 0, max = 150)
 
Data Science Functions:

title = function(arguments)

{ what you want it to do using argument headings

}

call function:

title(arguments)


if family, use consistent names, starting names.


*if must have conditions & followed by {}

log()
mean()
(trim)
(na.rm)
t.test(x, y, alternative, mu, paired, var.equal, conf.level)


... = arbitrary number of inputs
  