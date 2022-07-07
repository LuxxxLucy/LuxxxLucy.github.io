#lang pollen

◊(define-meta title            "Technical Part 1: The implicit knowledge and how to get it")
◊(define-meta doc-publish-date "2022-04-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")


◊section{overview}

The basic approach is as follows

1. compile and load as a graph

2. train and learning
step A. sample first from the graph relevant terminal nodes, then sample for these terminal nodes, 
Step B. update the Energy
step C. update the target parameter distribution

3. get the optimal parameter from the target parameter distribution.

◊mermaid{
  graph BT
        Y[Y] -->|render| Y_[Y_] -->|f| Y__["E(Y)"]
        X1[X_1] -->|render| X1_[X1_] -->|f| X1__["E(X)"]
        Y__ --> aggregate(("$prod$"))
        X1__ --> aggregate
        aggregate --> P["P(X,Y)"]
}

◊section{Approach}

Getting a forward model should be described in the parameterization section.

certain assumption in this work:
1. the incompleteness of the data graph is a huge problem. A simple train/test procedure is not enough.
2. the graph is also a highly compositional graph. Two terminal nodes do not exhibits linear relationships.
2. the capacity and precision of the learned Energy is limited.
    Because of  the compositional nature, out of distribution problem can not be neglected. So the precision/accuracy is hard to improve
    Because of the compositional nature, the capacity of the Energy is limited. The terminal nodes can grow expoentially w.r.t to non-terimal.
    Because of the compositional nature, the data samples is actually very heterogenous. It is hard to train such an model.

◊section{Step A}

Autofocused oracles for model-based design.

The network is limited in its capacity. So it might be unstable and in-accurate if train in a simple way.

Also is about out-of-distribution problem, 

◊section{Step B}
Review some works, check the prior wor ksection
A Tutorial on Energy-Based Learning, Yann LeCun 2006 tutorial

Why EBM instead of other models?
-> 1. more flexible. 
& accounts for better visual inductive bias as the human visual system
YOUR CLASSIFIER IS SECRETLY AN ENERGY BASED MODEL AND YOU SHOULD TREAT IT LIKE ONE

Why is our EBM different?

Based on the partial order chain.

1. reason: it works, it is precise and make it work well on certain properties: local-monotonicity, local-smoothness, local-convexity.
2. implicitly make the model stable, robust to adversarial perturbation.
3. reject 


A Method for Learning from Hints
    Monotonicity Hints
Augmenting Neural Networks with Priors on Function Values
perhaps using equilibrium model/optimization layers to better train perturbation?
    Deep Declarative Networks: A New Hope
    Optimization Induced Deep Equilibrium Networks

◊section{Step C}

Naive way would be train the EBM and then sampling as inference. That is, training and inference separately, which perhaps is not that good.
-> domain shift? too

Treat the parameter using <Variational Auto-Decoder: A Method for Neural Generative Modeling from Incomplete Data>
like in <A Theory of Generative ConvNet> <Synthesizing Dynamic Patterns by Spatial-Temporal Generative ConvNet>
In each step, use a fixed step of Langevin dynamics to update


◊section{why not the other approach?}

Deep Equilibrium networks are tempting approaches. But the main problem is that this restrict us from using other approaches. (composing and using new energies, incorporating explicit constraints, etc)

◊section{problems to investigage}
Compare and measure:
1. generalization (how to measure the performance about generalization?)
2. memorization. (how to make sure it is not about memorization?) (Read paper <Solving Quantitative Reasoning Problems With Language Models> about one section about this)