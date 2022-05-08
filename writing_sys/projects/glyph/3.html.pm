#lang pollen

◊(define-meta title            "Technical Part 1: The implicit knowledge and how to get it")
◊(define-meta doc-publish-date "2022-04-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")



◊section{Approach}

Review some works, check the prior wor ksection


1
A Tutorial on Energy-Based Learning, Yann LeCun 2006 tutorial

Why EBM instead of 
EBM are better robustness, calibration of uncertainty
YOUR CLASSIFIER IS SECRETLY AN ENERGY BASED MODEL AND YOU SHOULD TREAT IT LIKE ONE

In this paper we talk about what is the ideal way to use ML to do font kerning.

We lists some good things that we wish to obtain, and then figure out an approach to check all the boxes.




Naive way:
1. train the EBM
2. sample.

This is not good, the sampling process is complicated and not good (domain-shift).

A simple solution:

1. variational distribution used.
2. the variational distribution helps as the noise distribution.
3. Train the net and the latent parameters together by gradient. 
    Stops if all observation and the synthesized has score of zero.

◊subsection{Improvement}
separate training and sampling.
And for it we discuss:
1. how to do one step
    1. just the target value
    2. Using auto-Decoder like. Variational inference.
    3. Training by unrolling
    4. By implicit layer, using deep equilibrium model-like
            Joint inference and input optimization in equilibrium networks
            Deep Equilibrium Architectures for Inverse Problems in Imaging
2. how to do a schedule: 
    Patchwise Generative ConvNet: Training Energy-Based Models from a Single Natural Image for Internal Learning
3. how to do inference

option 1.a.
We can also just update the latent parameter together with the neural network parameters.

◊subsection{Option 2}
Joint training

like in <A Theory of Generative ConvNet> <Synthesizing Dynamic Patterns by Spatial-Temporal Generative ConvNet>
In each step, use a fixed step of Langevin dynamics to update

◊subsection{Option 3}

