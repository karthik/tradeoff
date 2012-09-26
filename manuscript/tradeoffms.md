
# Realistic stage-structured models alter the optimum expectation of classic life-history trade offs.

Karthik Ram and Perry de Valpine.

Environmental Science, Policy & Management.
University of California, Berkeley. Berkeley, CA 94720

karthik.ram@berkeley.edu

-------


## Introduction

Components of the life history of an organism, such as the time it takes to reach maturity, stage-specific survival rate etc. are of considerable interest to both theoretical and applied ecologists alike. Trade offs between such traits allow organisms, especially ones with complex life histories, to choose an optimal strategy that maximizes their reproductive fitness over a range of environmental conditions [@Houssard1991]. The diversity of strategies observed in nature are in large part the result of of such tradeoffs between vital traits [@Law1979]. Understanding trade offs has been fundamental to understanding conditions that favor the evolution of iteroparity versus semelarity [@Cole1954; @Stearns1989; @Gadgil1970]. Ecologists have examined trade-offs to solve applied problems such as the spread of infectious diseases and pests under global change [@Woodhams2008].

Although there are various methods to understand tradeoffs, mathematical models provide a particularly versatile and powerful way to examine the importance of vital rates, and how trade offs between rates alter the evolutionary trajectory of a species. Matrix population models, especially, have proved extremeley useful both in a theoretical and applied context [@Caswell2001]. These models can be applied to a variety of organisms such as plants and insects that transition through distinct development stages, but can also be applied to organisms that mature through distinct size classes, which can be treated abstractly as stages [@Caswell2009]. Matrix models have been provided numerous insights into conservation issues [@Morris2002, @Heppell1998] and evolutionary ecology [@Lande1982], the popularity driven primarily by its simplicity and ease of interpretation.  

Despite its popularity, matrix population models fail to incorporate an adequate level biological realism that characteize most populations in nature. For example, matrix models fail to capture variation in development time among individuals both within and between stages [@deValpine2009]. Stage structured models typically assume that time spent in a stage is geometrically distributed, an assumption that is not realistic for most organisms. Therefore, ecologists looking to incorporate more realism must look beyond simple matrix models [@deValpine2009]. Several authors have provided modifications to the matrix model to overcome such limitations [@Caswell2001] althogh not all have been widely adopted [@deValpine2009]. Integral projection models provide a way to incorporate such compexity [@Ellner2006; @Easterling2000a] (Need to include a fleshed out section describing the IPM generalization of the matrix model). 
 
These new methods and implementation techniques provide an easy-way to incorporate variable development into matrix models and revisit ecological theory. In particular, this new technique provides an opportunity to reexamine classic life history trade offs, such as the one between growth rate and survival, or fecundity and maturation rate, under more complex assumptions.  Here we reassess classic ecological trade offs between maturation (both adult and juvenile) and growth rate [@Takada1995]. 

In this paper, we investigate the how incorporating additional complexity in matrix population models, such as more realistic assumptions about time spent in a stage, and correlation between stages alters the optimum of ecological trade offs. We used the Lefkovitch matrix model to describe stage structured population models with reproduction and survival. To maintain a simple story, we also restrict our efforts to a two-stage model (juveniles and adults) in a density-independent case, although our analyses could easily be extended to larger number of classes. 
 We analyze the outcome with varying levels of compelxity, from the simple matrix case all the way to incorporating variation in development time within stages and correlation between stages. We then compare how the optimal trade off strategy shifts as a result of these new assumptions.


## Model Description

$\left[ \begin{matrix} J(t+1)\\ A(t+1) \end{matrix} \right] = \left[ \begin{matrix} (1-m) \mu J& F\\ m \mu J&\mu A \end{matrix} \right] \left[ \begin{matrix} J(t)\\ A(t) \end{matrix} \right]$

Where $\mu J(t)$ and $\mu A(t)$ represent juvenile and adult mortality, `m` is the maturation rate and $J(t)$ and $A(t)$ are the juveniles and adults.


## Literature Cited
