#lang pollen

◊(define-meta title            "Approach: Overview")
◊(define-meta doc-publish-date "2022-04-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")

◊section{A Scenario of application}

Now let us first start with a scenario of application: when you have a font yet a character of interest is missing in this font, you would like the machine to compute a probable glyph for the missing character.

This is a standard problem in Chinese font design process, i.e., when the deisgners has completed the initial visual design by constructing a handful of exemplar characters, the journey of suffering begins. 
The designers will try to use the same visual design to design more characters.

◊section{Approach}

◊mermaid{
  graph BT
        Y[Y] -->|render| Y_[Y_] -->|f| Y__["E(Y)"]
        X1[X_1] -->|render| X1_[X1_] -->|f| X1__["E(X)"]
        Y__ --> aggregate(("$prod$"))
        X1__ --> aggregate
        aggregate --> P["P(X,Y)"]

}


Treat the parameter using <Variational Auto-Decoder: A Method for Neural Generative Modeling from Incomplete Data>