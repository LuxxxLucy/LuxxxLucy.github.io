#lang pollen

◊(define-meta title            "Simplified Approach")
◊(define-meta doc-publish-date "2022-07-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")


This is a simplified version of the approach. The full approach is really too complicated and consists of a lot of details and dirty techniques so I felt it perhaps is necessary to write about a simplified approach first (but even the simplified version is already complicated enough)

◊section{The Scenario of application}

Commercial Chinese fonts usually is very incomplete, which creates problems of all sorts.

The main target in the current simplified approach thus here is to auto-complete the missing characters given a font.

◊section{problem formulation}

A font file is collection of vector images together with a variety of spec and features. 
Here we will abstract and define a font ◊${\mathbf{F}}
as a set of vector images ◊${\mathbf{F} = \{ x \}}.

Also, we have a set of description of the glyph as ◊${\mathbf{A} = \{ \alpha \}}. 
Basically, for each glyph, we have an ideal description of the glyph in the mind ◊${\alpha}, and then a glyph is instantiated into an actual glyph ◊${x} in a font.

◊${|\mathbf{A}|} is larger than ◊${|\mathbf{F}|}.

Now assume we have the following function.

Assume a hypothesis space generator ◊${\mathbb{S}} that construct the space of all the possible instantiated glyph given an abstract glyph description.
Further assume we have a ranking/scoring function ◊${f} such that ◊${f(x)} indicates how good it is. Basically, ◊${f} can be considered as a ranking or scoring function, or a surrogate model or just an energy of the unnormalized probability P_{\mathbb{F}}(x). 

◊$${
f(x) =
  \begin{array}{ c l }
    \textrm{high value} & \quad \textrm{if } x \sim  P_{\mathbb{F}}(x) \\
    \textrm{low value}  & \quad \textrm{otherwise, for example, if x is just noise}
  \end{array}
}

In particular, the choice of ◊${f} is defined as such that it is differentiable. So we can just run gradient-based optimization to get

◊$${
    \hat{x} = \underset{x \in \quad \mathbb{S}(alpha)}{\operatorname{arg max}} f(x)
}

So basically we first construct a hypothesis space ◊${\mathbb{S}(alpha)} and then use ◊${f} to find the best suited glyph. And this found glyph is the synthesized result.

disclaimer: there are in fact many kinds of ◊${f}, including a lot of possible things, but here in this simplified approach, we can just treat ◊${f} as a single feedforward neural network.

note: It is worth noting that since ◊${x} is a vector image, we are not using a sequence model or a graph neural network to take the input. Instead we will use a differentiable rendering of the vector image into bitmap, and then feed the bitmap into the neural network.

The reason being:
1. sequence/graph neural network in our case is very difficult to train and usually requires more efforts (and model size) to make it work. yet Convolutional network is efficient, and easy to train.
2. when human read and judge the vector images of fonts, the designer do not directly judges the vector image sequence control points, but do it (primarily) by looking at the rendered bitmap. So it is better for the machine to also adopt the same approach by (primarily) looking at the rendered result
3. CNN are also shown to have particular similarity to human visual system, and various good properties in the visual realm (the deep image prior, etc)
4. The differentiable rendering technique is new, yet seems to be quite mature and stable/ use-friendly for our task.

◊section{Reason of using this backward optimization based approach.}

use a direct generative model DNN sucks at it

why this backward optimization approach:
1. it is more difficult to have a solution generator than just a solution verifier
2. it is a flexible framework which 


Inference:

y = argmax f_implicit(y) + f_explicit(y)

explicit:
- this I would not talk about

implicit:
- domain-agnostic ways of training
    - iterative optimization meta-gradient (similar to domain adaption)
    - noise contrastive
- domain specific
    - human guided perturbation, use this perturbation to guide the training of the training

problem:
1. first. how to train and how to adapt to new situation.
2. how to generate the whole auto-completion

