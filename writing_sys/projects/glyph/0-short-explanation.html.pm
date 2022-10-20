#lang pollen

◊(define-meta title            "An short introduction to my glyph project")
◊(define-meta doc-publish-date "2022-10-19")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "A whole lot of issues regarding font")


◊section{Overview}

Goal: Provide AI integration to the font design process. 

◊horizontal

My main point is that, the use of vector image, i.e. curves parameterized by control points, is not only necessary, but also beneficial (in the sense that it prunes a huge space of illegitimate shapes).

Say ◊${x} is a glyph, and ◊${P(x)} the likelihood of real world font glyphs. Each glyph ◊${x_\theta} is parameterized by some inhererent parameters, i.e. the control points, ◊${\theta}.

Assume we have a ranking/scoring function ◊${f} such that ◊${f(x)} indicates how good it is, basically:

◊$${
f(x) =
  \begin{array}{ c l }
    \textrm{high value} & \quad \textrm{if } x \sim P(x) \\
    \textrm{low value}  & \quad \textrm{otherwise, for example, if x is just noise}
  \end{array}
}

Further assume a glyph is computed by applying a rendering function ◊${R} to its inherent parameters ◊${\theta}: ◊${x = R(\theta)}
then the design process of a glyph, (getting the optimal control points) can be formulated as follows
◊$${ \theta^* = \mathop{argmax}_{\theta} f(R(\theta))  }

In particular, when we design both ◊${f} and ◊${R} to be differentiable functions, then ◊${\theta} can de obtained by running cheap gradient-based optimization.

In some sense, kerning is also doable in this framework
◊raw{
    ◊margin-note{
        Optimization process of the kerning of L and V, assuming we have a learned scoring function. The only parameter ◊${\theta } here that needs to be inferred is the horizontal distance of two glyphs. While randomly initialized, it converges into an ideal position.
    }
    ◊p[#:align "center" #:width="100%"]{
        ◊img[#:src "https://luxxxlucy.github.io/projects/2022_glyph/assets/kern_demo.gif" #:style "background-color:black" #:width "20%"]{}
    }
}

In this example, the score function is also a learned model, an energy-based model, which is an unsupervised (or self-supervised) learning model that approximates the unnormalized data likelihood.

◊section{Beyond}

◊subsection{What I am currently doing}

◊items{
    ◊item{
    An interpreter that can, given a existing font, take specification and generate a rare Hanzi glyph. In other words, it auto-completes the font.
    }
}

◊subsection{Planning to do}

◊items{
    ◊item{
    A constraint-based parameterization of shapes, instead of the usual more conventional interpolation based methods.
    }
    ◊item{
    Methods for enforcing a certain aesthetic feature consistently among all glyphs.
    }
}

