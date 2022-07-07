#lang pollen

◊(define-meta title            "Meta Plan")
◊(define-meta doc-publish-date "2022-05-11")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")



◊horizontal

◊section{Main statement}

1. mix use of different models for the best of all. "小孩子才做选择".
2. make actual good use of the approach, I do not want to do things that only used in publication but has near-to-none use in real-world.
2. make things interpretable, and most importantly, make in interpretable in a context and domain specific way.
3. make the approach simple and brutal. for the sake of the bitter lesson.

◊section{The "leading-to-" roadmap}

The structure generation.
-> with the Glyph part, glyph part leads to liyi.
    Neural gudied search
    -> with program synthesis, leads to Kevin
    -> with receipt generation, leads to Michael
-> with the top-down decomposation approach
    -> leads to Kevin
Terpret 
-> leads to Kevin

◊section{Outline}

◊numbered-items{
    ◊item{Structure generation project}
    ◊numbered-items{
        ◊item{◊link["./projects/glyph/prototype_approach.html"]{Simplified approach}}
        ◊item{◊link["./projects/glyph/approach.html"]{Full Approach general}}
        ◊numbered-items{
            ◊item{◊link["./projects/glyph/implicit.html"]{Implicit Knowledge}}
            ◊item{◊link["./projects/glyph/explicit.html"]{Explicit Knowledge}}
        }
        ◊item{The innate reparameterzation in explicit knowledge part can also be used to do trick in do better graph generation◊note{see Automatically Building Diagrams for Olympiad Geometry Problems} as well as in the TerpreT project see below}
    }
    ◊numbered-items{
        ◊item{First and most important application, font◊note{◊link["./projects/glyph/index.html"]{The glyph project}}}
        ◊item{EBM neural-guided program search}
        ◊item{General Graph generatoon. Perhaps go more neural, GFlowNet?}
        ◊item{Move on to other structure generation. 明式家具 斗拱}
        ◊item{Structured Text generation, post-rock?}
        ◊item{Recipe Generation }
    }
    ◊item{Learning (TerpreT, etc) project}
    ◊numbered-items{
        ◊item{
            Initial try, including the master thesis◊note{◊link["https://summit.sfu.ca/item/21305"]{Neural Disjunctive Normal Form}, Master thesis} and a blog dedicated on how to optimize discrete parameters.◊note{◊link["https://luxxxlucy.github.io/projects/2020_discrete/discrete.html"]{On more interesting blocks with discrete parameters in deep learning, July 2020}}
        }
        ◊item{
            Close look, the problem of learning of soft local minima, initial solution ◊note{◊link["https://luxxxlucy.github.io/projects/2020_terpret/terpret.html"]{Solving the TerpreT problem}, July 2020}
            and generalize to categorical variables.◊note{◊link["https://luxxxlucy.github.io/projects/2021_terpret/index.html"]{Mitigating The Failures Of Gradient-Based Program Induction}, June 2021}
        }
        ◊item{
            New Try:
            1. new framework, a general circuit compliation software, compare different optimization backend, including the four backend in TerpreT as well as probablistic circuit.
            2. Integrate the figure making software into this framework
            2. TerpreT + Mixed REAS update 
            3. The modification of the computation graph. simolification, factorization, infer and create new link, reparameterization (x+y = 1 -> y = 1-x,  two varaible can be changed to one variable), etc.
        }
    }
}