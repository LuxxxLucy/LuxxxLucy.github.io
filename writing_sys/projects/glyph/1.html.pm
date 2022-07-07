#lang pollen

◊(define-meta title            "The difficulty for computation: the nuance of typographic design")
◊(define-meta doc-publish-date "2022-04-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")


◊section{A Scenario of application}

Now let us first start with a scenario of application: synthesize rare or arbitrary new Chinese Characters.

Written Chinese (to some extent CJKV) uses logograhic symbols. 

As contrary to languages that use an alphabet to compose a relatively small set characters into syllables and then into the words, the logographic writing system relies on a huge ton of ten thousands of characters which are already words that convey some semantic meaning. 
the written system gradually develops to serve as a written medium where different pronounciations/speaks can be stacked on, including the various Sinitic languages (or by Beijing's perspective, dialects) and to some lesser extent Japanese and Korean.
The good thing about this system is that it democratizes the composition and invention of new words by combining several characters to an easy and common maneuver, and these new words are readily understandable by a second person without the need to lookup dictionary.

◊strong{However, regarding the making of font, the logogram-based system is a costly business}, and has been such for a long time before the digital age.◊note{Even though the Chinese invented movable type printing in 11-th century, the movable type system never really help the Chinese in advancing the printing industry, because the massive character set is a costly asset to maintain, unlike Gutenberg's case of alphabet which eventually boosted the printing press. An alphabet-based writing system makes much much more economical sense than a logographic system.
}
The big problem of a massive set of these logograms.
Each glyph needs to be implemented, the typographical consideration such as consistency enforces the designer to spend way more effort.
The time and human working need for a Chinese and English font.
Objectively speaking, a logogram-based system does not make much economical sense as it is easier to manage a alphabet of some 50 letters, than manage 10000 logograhic glyphs.


This disadvantageous situation does not stopped there, though, it continue to exist in the digitical age.

Font is important as ever in the digital age in the visual display of texts. Yet the main problem for Chinese fonts is that
1. there aren't so many fonts
2. all of the fonts are, strictly speaking, incomplete.

The main problem is the large size of the character set. 
A reasonable commercial font would need around 5000, while the remainning glyphs is absent, so make the font incomplete.
in special cases like in specific entity, historially used yet deprecate in modern times, professional usage in historical and literature materials, as well as newly invented characters. 
It is very common to in real life to encounter cases where one or two character is not supported in a fontface.
Very few fonts managed to provide more than 60000, only one seem to cover the entirety of all UTF standard Chinese characters (though it is the Japanese variation, Kanji, which has a lot of minor differences), and they all are very boring and dull. And that is why in a lot of cases, people will still choose to use incomplete fonts because of its aesthetic value.

This first stage's goal is to provide such a way to produce reasonably well designed rare characters from a target fontface.

◊margin-note{Disclaimer: The legal implication of this application is complicated and I certainly do not want to get any trouble. Here I state that I do not intend to make commercial use of it; will not help anyone gaining such; and will report to the rightful owner of the font shall any misdeed occur and be discovered by myself.}

(DaType and Intelligent Layout for Information Display: An Approach Using Constraints and Case-based Reasoning). 
◊note{Maybe it is just me, but I found papers in the 90s to be more interesting and easier to read because only important/relevant references are cited.}

DaType is great, but the main problem is where the spec comes from.
For the Latin alphabet the difficulty is in partially relief because it is relatively easy to write a spec for thirty letters.  
It is tedious but it is still doable.

◊section{The story of ◊strong{two} space}


The two work flow.

First, control point to rendered to human, 
Now this is where the dark magic is. To illustrate how it is. and especially the Chinese font
example are adjusted that the glyph should be at the center, (but not the real geometric center)
we make things to have equal space/distance between them, yet the real aboslute distance are differenc.

The second, purely symbolic are.

1. make sure some basic constraints are speicfied, for example in Latin alphabet, the position of every is set to be equal.
2. make sure the reused shape are consistent (except for deliberate exceptions), sometimes this is very subtle in visual effect, yet it has to be done for consistency.
3. make sure the style of the points are good. Just like in programming we have a coding style, the control points should also follow some basic standard.


However,
the existing either work on the perceptual realm, or in the symbolic realm

Perceptural realm. -> the results are good but not detailed enough, too many things prevent we treated like a serious product

The symbolic realm, mostly have two school.
1. old school. Have a good reason and theory yet do not know how the spec come from. (require constraint learning/acquisiton)
2. new school. Use a model to model the joint prob of the control points. Most of them treat it as a sequence modelling.
However, this is bad.
Unlike the deep image prior for rendered image, statiscal modelling in the sequence is not so sense-making. As the control points are not actual sequence (it indeed has a sequence representation), 
yet the points forms some hierarchy and sets.
Also the sequence for a equivalent shape is not unique, it is easy to alter the order the control points,
we can even modify the cubic and quadratic bezier curve and make a large set of sequence that has exactly the same rendering result.
or the issue of overlapping.

◊figure["./asset/two_space.svg"]{an figure}

We want to do better in a hybrid model.


inducing constraints that are about the relation of shapes cannot be handled without a perceptual component

Machine aided Font design require to handle two nuances, one for consistency and one for delusion.
Deep learning is good yet as we will argue provides limited help

◊section{Approach}


Review some works, check the prior wor ksection

Why EBM instead of 
EBM are better robustness, calibration of uncertainty

YOUR CLASSIFIER IS SECRETLY AN ENERGY BASED MODEL AND YOU SHOULD TREAT IT LIKE ONE

sampling based learning is good, yet it is costly.

neural approximate inference is also good in theory, but the problem is that the parameters for each character has different meaning and different size. It would still be doable, yet then this becomes unnecessarily useless.

In this paper we talk about what is the ideal way to use ML to do font kerning.
We lists some good things that we wish to obtain, and then figure out an approach to check all the boxes.

Here we propose a hybrid, most part symbolic, approach, following the idea of "design by example"(cite model by example and shape by example) and case-based reasoning.
We also want to make a dark magic model (DNN, Probabilistic inference) as small as possible.
DNN is also not easy to train (underfitting and overfitting hurs especially so in our case)
(also why we want to use case-based reasoning.)

We will utlize DNN, but not for its  predictive performance or magic pwoer, but for a good in-hand approximation of human visual processin.

DNN is also so good at compositional/combinatorial issues. And when we have a large set of glyphs, training a DNN or anything probabilistic modelling would be very expensive.
So we are using case-based reasoning.

We will start with kerning, then spacing,, consistency and exception mining, decomposition and lastly whole synthesis of glyphs.

Human designers take hard efforts to design and a lot of them is hard to talk with language
.
Here we present what we can do, we start with the fact that a reasonably well-designed font glyph represents human designers' dedicated work and is thus optimal according to the designer's standard.

Here we do not wish to automate the whole process, yet just providing some routines to help the font design process.


What we offer:
◊items{
  ◊item{
	  for ◊em{implicit} constraints, neural network. Find a flexible framework that is able to modify and extend.
  }
  ◊item{
    for ◊em{explicit} constraints, data mining and discover. Discover constraints and design space hierarchy to automatically learn from data. Techniques learned from Program synthesis.
  }
  ◊item{
    These two can be unfused together.
  }
}


Explicit model, good in theory, but bad in its lack of visual knowledge, to it the perceptual difference does not mean anything. Symbolic approaches need to be grounded with visual information.
Blackbox model, good at some fancy prototype, yet lack the precise detail. Neural approaches need to also be able to take the explicit constraints into consideration.

Font Design is about rational consistency and visual delusions.
None of the two approach alone can capture them both.

Rational consistency: the font is designed in a rational way, there are rules to enforce, basic unit, and the hierarchy of constraints.

Visual delusion: the dark art of designer, not always describable by language alone. While in theory when we want to make something be equal space, the designers deliberately design it inequally, so that visually it will be equal to human's eye.
When we want to a shape to be centered in the midpoint, the designers deliberately design it not in the exact midpoint so to make it visually so.
When we want to make a shape look smooth, we need to design the curve such that is actually not smooth

This is about the art of consistency and delusion.

Neither purely symbolic nor statistical approach can make it work. And that is why for decades people tried yet fail.

This problem is serious in all visual design, yet Even more so in fonttype design:
because it is so subtle, layman ignores; but fontype is used everywhere to render text, the tiniest subtlty becomes noticable when layman stares at a whole paragraph of rendered text.

Getting the AI to do design is hard:
1. symbolic approaches, good at specifying the constraints, rules and exceptions, good at case based reasoning. It is hard to induce such constriants from data. (constraint learning/acquisition). Besides, what human consdier to be a rule over shapes must have a visual perception prossing, and this is where it break, symbolic approaches cannot handle perception
(todo: explain it

)
2. neural approaches, impressive result recent years, good discovery (CNN actually approximates visual processing, deep image prior). Yet difficult to enforce consistent generalization and compositional generalization
(todo: explain it
This is important when you need to model the relationship, just like in recommendation systems you always need to use context (collaborative filtering) to give a very precise result, otherwise just use features solely about the user but without the important context is bound to fail.

That being said, sueprvised prediction or reinforcement learning did not consider the consistency problem very thoroughly. It can be used in this way, yet it still have to implement some symbolic check, as in the case of neural guided search in program synthesis

Another reason is poor modelling, the application actually gives us rich information, yet just a predictive model is just not going to fully utilize such information
)
	

A toolkit for assistance of font design.

includnig analysis, autocomplete, version control/conflict handling.Steps
◊items{
◊item{DaType generation tool}
◊item{Commit single change}
◊item{}}
Good old things◊items{
◊item{DaType}}
New things◊items{
◊item{Fonttool}
◊item{Glyphs 3}}
lalalaaldsdsa◊margin-note{this is a margin note}lalalaaldsdsa◊note{this is a numbered note}
