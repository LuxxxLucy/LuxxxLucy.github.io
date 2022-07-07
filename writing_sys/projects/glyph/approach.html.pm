#lang pollen

◊(define-meta title            "Approach: Overview")
◊(define-meta doc-publish-date "2022-04-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")

◊section{A Scenario of application}

The target of this approach is about generating precise structures, most importantly fonts, so we will assume typography as the example here.

Now let us first start with a scenario of application: when you have a font yet a character of interest is missing, you would like the machine to compute a probable glyph for the missing character.

This is a standard problem in Chinese font design process, i.e., when the deisgners has completed the initial visual design by constructing a handful of exemplar characters, the journey of suffering begins. 
The designers will try to use the same visual design to design more characters.

The existing deep learning approaches tries to treat it like another image or sequence generation problem. This fails to capture the nuances in typography design. I reviewed the failure of pure neural approach in ◊link["https://luxxxlucy.github.io/projects/2020_glyph/index.html"]{this post}◊note{◊link["https://luxxxlucy.github.io/projects/2020_glyph/index.html"]{A Review of Failure - Deep Generative Model for Chinese Fonts}}.

The existing symbolic approaches try to give a rule-based generation process, yet there is not much learning here as all the specs and rules are given by human.

◊section{My criteria}

1. I want to public the code and the tools. Many things are so trivial theoretically yet painful, too many good works did not release the code and I hate it.

2. I like symbolic methods which provides easier way to manage, extend and maintain. Neural approaches cannot do that, but there are things that symbolic methods cannot do, even the other statistical methods cannot do as well. There are good points about neural approaches, I just want to make it manageable, extendable, and maintainable.

◊items{
        ◊item{justified and interpretable, meaningful, and light-weighted}
        Neural module often fails because of it lacks a simple meaning and intended function, and a lot of times is very blackbox. -> So I decide to be simple, single-purpose, and make it to be interpretable as possible (as a assumed human designer)
        A lot of interpretability research was done in a way that is not context and domain-specific. which is bad.
        ◊item{Maintainable/extensible}
        Needs to be able to compose NNs.
        we can enable multiple energy network, for logical composition, self-train a NN energy and add to it
}

◊section{Main workflow}

So here we need a hybrid neural-symbolic approach, we need to learn both explicit and implicit constraints.
The approach is a mix of program synthesis, probabilistic inference, networks (Energy-based models, to be more specific):

◊numbered-items{
    ◊item{Using a spec language to represent glyph, read and parse the target spec}
    ◊item{Grounding, discover and parameterize: the ontology, relationships into a hierarchical relational graph}
    ◊item{Compile into a differentiable computation graph}
    ◊item{
        Discover and enforce explicit constraints. ◊strong{explicit constraints}

        Discover: find the relation and constraints techniques from data mining and program synthesis

        Enforce: Some constraint can be made innate by re-parameterization, some by relaxed-soft-loss function.
    }
    ◊item{
        Discover and enforce implicit constraints

        Discover: define the perturbation process and learn the Energy. Learn a probabilistic model using Energy-based model, parameterizing the joint probability. 
        1. model-agnostic way of training
        2. use human guided perturbation&hints to guide the energy landscape.

        Enforce: stack the Energy models that deal with different things
        }
    ◊item{The actual generation is done by sampling, which generates samples that satisfy both ◊strong{explicit} and ◊strong{implicit} constraints}
    ◊item{An extra layer to make it a useful piece of software.}
}

◊section{Technical challenges and milestones}

And by my estimation, we are going to divide the project into the following components and will have to tackle them one by one and then finally complete the project.

◊numbered-items{
    ◊item{Font decomposation and representation. This includes the design of a EIDS-like domain specific language, an parser/interpreter, segment and decompose the glyphs and grounded them with a domain specific language}
    ◊item{
        how to have a good forward model.
        how to get a good re-parameterization.
    }
    ◊item{
        ways to use implicit knowledge
            where it comes.
            how to enforce

    }
    ◊item{
        ways to use explicit knowledge
            where it comes.
            how to enforce
    }
    ◊item{
        ways to integrate every thing
    }
}





