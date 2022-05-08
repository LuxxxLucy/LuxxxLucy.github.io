#lang pollen

◊(define-meta title            "The Glyph Project")
◊(define-meta doc-publish-date "2022-04-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "A whole lot of issues regarding font")

This is a project about font◊note{I will not distinguish ◊em{font}, ◊em{type} and ◊em{typeface} in the following posts.} glyph generation, with a special focus on Chinese fonts. 
To be specific, I want to leverage provide modern computation to aid the font design process, and in order to do that several new computational tools needs to be developed.
It is a relatively huge project and I do not think I can complete everything soon, so this is not completed yet.

◊horizontal

The project first started as back in 2017 Summer, when I was an undergraduate doing a summer exchange at HKU. I failed miserably, mainly because I under-estimate the problem and had a premature belief of the hype of deep learning. I reviewed the failure in ◊link["https://luxxxlucy.github.io/projects/2020_glyph/index.html"]{this post} ◊note{◊link["https://luxxxlucy.github.io/projects/2020_glyph/index.html"]{A Review of Failure - Deep Generative Model for Chinese Fonts}}.
 -->
After that when I became more experienced during my master, I gradually start to lean myself in hybrid neural symbolic approaches, and also started to learn program synthesis. After I graduated and started working in industry, I resumed working on this project at night.◊note{Honestly, also sometimes during daytime, sorry Huawei}

The main insipration of the new approach are some excellent yet relatively old and under-appreciated papers, as well as some recent advances in machine learning including differentiable rendering and energy-based model; they all contribute to make the current proposal a feasible approach.

It is a long way, and so I divided into smaller posts.

◊h2{Content}

◊numbered-items{
    ◊item{ ◊link["./projects/glyph/0.html"]{◊strong{The problem: how we end up in reality}}}
    "Why we need computational aid for font design."

    ◊item{ ◊link["./projects/glyph/1.html"]{◊strong{The difficulty for computation: the nuance of typographic design}}}
    "here I also talked about why the problem is hard, and why existing approaches are not producing satisfactory result."

    ◊item{ ◊link["./projects/glyph/2.html"]{◊strong{Approach: Overview}}}
    "here I provide the general description of the approach. It is designed to be flexible and extensible.
    And also solves some of the main methodological problem I saw in neuro-symbolic model.
    1. Neural module often fails because of it lacks a simple meaning and intended function, and a lot of times is very blackbox.
    -> So I decide to be simple, single-purpose, and make it to be interpretable as possible (as a assumed human designer).
    2. it is difficult to extend a precise symbolic method to handle approximate inference, but it is easier to extend approximate inference to handle hard constraints and precise solutions. 
    so here 

    describe a general approach to handle implicit and explicit knowledge and intention.

    ◊item{ ◊link["./projects"]{◊strong{Simplest Demo: Kerning}}}


    ◊item{ ◊link["./projects/glyph/3.html"]{◊strong{Approach Part 1: The implicit knowledge and how to get it}}}
    ◊item{ ◊link["./projects/glyph/4.html"]{◊strong{Approach Part 2: The explicit knowledge and how to get it}}}
}