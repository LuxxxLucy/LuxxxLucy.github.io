#lang pollen

◊(define-meta title            "Jialin Lu")
◊(define-meta doc-publish-date "")
◊(define-meta author           "")
◊(define-meta summary          "introduction of myself")

I write this page to be used as an introduction of myself about what I’ve done and what I am working on, you can also check this page after the meeting so that you can check for relevant information.

    ◊link["https://luxxxlucy.github.io/pdf/cv.pdf"]{CV}
    ◊link["https://luxxxlucy.github.io"]{homepage}
    ◊link["https://github.com/LuxxxLucy"]{github}
    ◊link["https://scholar.google.ca/citations?user=BeYo3C4AAAAJ&hl=en"]{Google Scholar}

◊horizontal

◊h2{Experience}

◊summary["click to expand"]{

    ◊point_entry["2014 - 2018"]{Zhejiang University}
    ◊items{
        ◊item{BEng in Computer Science}
        ◊item{BEng in Industrial design}
    }

    ◊point_entry["2018 - 2021"]{Simon Fraser University}
    ◊items{
        ◊item{MSc in Computing Science}
        ◊item{Supervised by Martin Ester◊note{◊link["https://scholar.google.ca/citations?user=ZYwC_CQAAAAJ&hl=en"]{Martin Ester - Google Scholar}}}
    }

    ◊point_entry["2021 July - now"]{Huawei Vancouver Research Center}
    ◊items{
        ◊item{Promoted to Senior Engineer B in Dec 2021}
        ◊item{Work with a small team working on an adaptive security engine, which provides firewall filtering service that is efficient as well as intelligent (AI/ML integrated).
            ◊numbered-items{
                ◊item{our work is used by other teams as core modules for developing a next-generation commercial product, I was specifically in charge of developing a high performance protocol stack and a module for load balancing}
                ◊item{Also provide some side minor projects: such as an unified configuration management system, code generation according to a DSL, a profiler to critical performance/latency analysis}
            }
        }
    }

}

◊h2{Research: first half of master study}

◊summary["click to expand"]{

At first I do research on explaining blackbox machine learning models◊note{Papers:
◊strong{Interpretable drug response prediction using a knowledge-based neural network} Oliver Snow, Hossein Sharifi Noghabi, Jialin Lu, Olga Zolotareva, Mark Lee, Martin Ester, KDD 2021
◊strong{Revisit Recurrent Attention Model from an Active Sampling Perspective} Jialin Lu, NeurIPS 2019 Neuro↔AI Workshop
◊strong{An Active Approach for Model Interpretation} Jialin Lu, Martin Ester, NeurIPS 2019 workshop on Human-centric machine learning (HCML2019)
◊strong{Checking Functional Modularity in DNN By Biclustering Task-specific Hidden Neurons} Jialin Lu, Martin Ester, NeurIPS 2019 Neuro↔AI Workshop
◊strong{An Interactive Visualization Tool for Understanding Active Learning} Z Wang, J Lu, O Snow, M Ester
}

However I found that precise and explainable ML might not be achieved by a purely blackbox network, certain knowledge still has to be incorporated by symbolic methods. So I start to think about hybrid models

}

◊h2{Approach one to neuro-symbolic}

◊summary["click to expand"]{
    ◊raw{
        ◊margin{
        ◊img[#:src "https://luxxxlucy.github.io/projects/2020_neural_dnf/assets/two_stage.png" #:width "70%"]
        }
    }
    This is the first try-out called Neural Disjunctive Normal Form.

    Essentially this is about a two stage model where the network produces certain high level output, which are then used by a symbolic module to produce the right output.
    We will use some kind of relaxation so to so to convert a non-differentiable computation into a differentiable one and then enable gradient based optimization.

    This will enable to solve some tasks that involves both the perception and some reasoning.
    ◊img[#:src "https://luxxxlucy.github.io/projects/2020_neural_dnf/assets/mnist_sums_to_odd.png"]{}
    ◊summary["click to expand: Example Result"]{
    ◊figure["https://luxxxlucy.github.io/projects/2020_neural_dnf/assets/mnist_sums_to_odd_result.png"]{Inspecting the learned model}}

    I did some work on this direction, including the master thesis◊note{◊link["https://summit.sfu.ca/item/21305"]{Neural Disjunctive Normal Form}, Master thesis} and a blog dedicated on how to optimize discrete parameters.◊note{◊link["https://luxxxlucy.github.io/projects/2020_discrete/discrete.html"]{On more interesting blocks with discrete parameters in deep learning, July 2020}}

    However it has two problems:
    ◊numbered-items{
        ◊item{about the semantic meaning of the predicates learned by the network, i.e., symbolic grounding. 
        Sometimes, for some dataset, everything will be perfect, the NN will learn to have the right output; sometimes it becomes non-sense.
        I have not been able to find a good approach for this. There are simply too many problems, see for example, a simple sanity check experiment◊note{See Sec 3 of <Failures of Gradient-Based Deep Learning>, a tiny and well-designed experiment}}
        ◊item{about the learning algorithm.
            There are cases where symbolic learning algorithms (constraint-solver based, for example) can solve very easily, yet the relaxation-and-optimize-by-gradient fail miserably.
            The TerpreT problem is one such example, I tackled this problem in this blog.◊note{◊link["https://luxxxlucy.github.io/projects/2020_terpret/terpret.html"]{Solving the TerpreT problem}, July 2020}
            I also show how to do categorical variables and used to sample vector images.◊note{◊link["https://luxxxlucy.github.io/projects/2021_terpret/index.html"]{Mitigating The Failures Of Gradient-Based Program Induction}, June 2021}
            ◊raw{
                ◊margin{
                ◊p[#:align "center" #:width="100%"]{
                    ◊img[#:src "https://luxxxlucy.github.io/projects/2021_terpret/assets/circle_target.png" #:style "background-color:black" #:width "40%"]{}
                    ◊img[#:src "https://luxxxlucy.github.io/projects/2021_terpret/assets/output.gif" #:style "background-color:black" #:width "40%"]{}
                }
                ◊p[#:align "center" #:width="100%"]{
                    ◊strong{Left}: target image. ◊strong{Right}: the sampling process.
                    The task is given an image, find a SVG element (circile, square, etc) as well as its parameters (center, radius, etc) which after rendering approximates the image.
                }
                }
            }
        }
    }
}



◊h2{Approach two, More recent}

◊summary["click to expand"]{
Approach two (recent project)

The target is about the synthesis of Fonts, which requires to learn both explicit and implicit constraints.

The existing deep learning approaches tries to treat it like another image or sequence generation problem. This fails to capture the nuances in typography design. I reviewed the failure of pure neural approach in ◊link["https://luxxxlucy.github.io/projects/2020_glyph/index.html"]{this post}◊note{◊link["https://luxxxlucy.github.io/projects/2020_glyph/index.html"]{A Review of Failure - Deep Generative Model for Chinese Fonts}}.

The existing symbolic approaches try to give a rule-based generation process, yet there is not much learning here as all the specs and rules are given by human.

So here we also need a hybrid neural-symbolic approach.
I am working on an approach that is a mix of program synthesis, probabilistic inference, networks (Energy-based models, to be more specific):

◊numbered-items{
    ◊item{Discover the ontology, relationships and constraints into a hierarchical relational graph, using program synthesis and pattern mining. This models the ◊strong{explicit constraints}}
    ◊item{Compile into a differentiable computation graph}
    ◊item{Learn a probabilistic model using Energy-based model, parameterizing the joint probability. This models the ◊strong{implicit constraints}}
    ◊item{The actual generation is done by sampling, which generates samples that satisfy both ◊strong{explicit} and ◊strong{implicit} constraints}
}

Unfortunately this is not finished so I cannot show you the results now.

◊raw{
    ◊figure["https://luxxxlucy.github.io/projects/2022_glyph/assets/computation_graph.svg"]{Differentiable computation graph}
}

Besides for the generation, we can also use this approach to do kerning, which is a sub-task of font design.
◊raw{
    ◊p[#:align "center" #:width="100%"]{
        ◊img[#:src "https://luxxxlucy.github.io/projects/2022_glyph/assets/kern_demo.gif" #:style "background-color:black" #:width "20%"]{}
    }
    ◊p[#:align "center" #:width="100%"]{
        Sampling process of the kerning
    }
}

}


◊h2{LTN demo}

◊summary["click to expand"]{
    I also implemented a simple version of the LTN for the clustering mode.◊note{see ◊link["https://github.com/LuxxxLucy/ltn_demo"]{github}}

    My feeling that is there is too many tricky cases to handle.
◊raw{
    ◊p[#:align "center" #:width="100%"]{
        ◊img[#:src "https://raw.githubusercontent.com/LuxxxLucy/ltn_demo/master/ltn_clustering_demo.gif" #:style "background-color:black" #:width "40%"]{}
    ◊p[#:align "center" #:width="100%"]{
        optimization process for a simple clustering task using logic tensor networks
    }
    }
    ◊margin{
        ◊link["https://github.com/LuxxxLucy/ltn_demo"]{my simple LTN clustering demo implemented in Julia, github}
    }
}
}
