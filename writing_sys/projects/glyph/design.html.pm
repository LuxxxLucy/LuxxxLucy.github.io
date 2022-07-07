#lang pollen

◊(define-meta title            "Design Document and Manual: 东京梦华录")
◊(define-meta doc-publish-date "2022-04-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")

The main difference of this document with the approach document is that this document is mainly about fonts, the domain-specific issues.

◊section{Parser}


implementation notes:
https://www.antlr.org

relevant code
https://github.com/jimmymasaru/ids-tools
https://github.com/cjkvi/cjkvi-ids
https://github.com/kawabata/glyphwiki-afdko
https://github.com/kawabata/ids-edit
https://github.com/kawabata/ids
https://github.com/Radically/HanazonoLite
https://github.com/Radically/radically

https://github.com/fasiha/idsgrep-emscripten

relevant doument
https://en.wikipedia.org/wiki/Ideographic_Description_Characters_(Unicode_block)
https://www.unicode.org/charts/unihan.html
https://www.unicode.org/versions/Unicode14.0.0/ch18.pdf
https://www.unicode.org/reports/tr50/
https://www.unicode.org/reports/tr38/
https://www.unicode.org/reports/tr37/
https://www.unicode.org/reports/tr11/

◊section{Grounding}

The grounding is designed to be formulated as follows:

Given non-reference signals, and a loose prior belief of the template structure of the signals, discover the structure of the data into a actual-parametrized template.

* extra point: multiple instance learning. Learn to associate different variations of signal into one symbol.

1. for font: discover the part registration
2. subtitles: discover the actual segmentation
3. NN interpretation: discover and organize the concepts

For font project, more specifically, we are given a initial rough tree structure, we are going to induce the actual tree structure, devided the square into different regions.
And then we group all the shapes inside one region, and link them to the symbol defined in the tree representation.

parametric subshape recognition is shown to be NP.  So what I provided here this is not a good solution, but still okay.

Given a parsed structure, find the relevant shape in a font.
that is, mapping the shapes to the shape id

◊section{Forward model}

1. compile to forward model （PyTorch, PyDiffVG)
2. compile to SVG

◊section{Batch parse and grounding}

Constructing a database. 

Each id now should have multiple instances.

Sanity check the instances

◊section{Initial version: spacing and scale}

This is ignoring the multiple instance of the same shape id. Just randomly pick one.

Finish the displaying, 
as well as the font generation process

◊section{Second version: with shape variation}

shape interpolation: learn a model from a set of shapes that have the same id.
