
# Individual heterogeneity in development time alter the optimal expectation of classic life-history trade offs.

Karthik Ram and Perry de Valpine.

Environmental Science, Policy & Management.
University of California, Berkeley. Berkeley, CA 94720

karthik.ram@berkeley.edu

-------


## Introduction

Components of the life history of an organism, such as the time it takes to reach maturity, stage-specific survival rate etc. are of considerable interest to both theoretical and applied ecologists alike. Trade offs between such traits allow organisms, especially ones with complex life histories, to choose an optimal strategy that maximizes their reproductive fitness over a range of environmental conditions [@Houssard1991]. The diversity of strategies observed in nature are in large part the result of of such tradeoffs between vital traits [@Law1979]. Understanding trade offs has been fundamental to understanding conditions that favor the evolution of iteroparity versus semelarity [@Cole1954; @Stearns1989; @Gadgil1970]. Ecologists have examined trade-offs to solve applied problems such as the spread of infectious diseases and pests under global change [@Woodhams2008].

Organisms inevitably face tradeoffs between processes such as growth, survival and reproduction.  Life history theory attempts to predict the outcome of natural selection on life history traits under different tradeoffs.  From its origins with very simple models, life history theory has been extended to consider increasingly realistic models.  These have included environmental stochasticity, individual behavior, density-dependence, and frequency-dependence, among other processes.  Some of these considerations can strongly change the optimal life history strategy, and the question remains what other factors are essential for obtaining realistic predictions of life history traits.

Although there are various methods to understand tradeoffs, mathematical models provide a particularly versatile and powerful way to examine the importance of vital rates, and how trade offs between rates alter the evolutionary trajectory of a species. Matrix population models, especially, have proved extremeley useful both in a theoretical and applied context [@Caswell2001]. These models can be applied to a variety of organisms such as plants and insects that transition through distinct development stages, but can also be applied to organisms that mature through distinct size classes, which can be treated abstractly as stages [@Caswell2009]. Matrix models have been provided numerous insights into conservation issues [@Morris2002, @Heppell1998] and evolutionary ecology [@Lande1982], the popularity driven primarily by its simplicity and ease of interpretation.  

Despite its popularity, matrix population models fail to incorporate an adequate level biological realism that characteize most populations in nature. For example, matrix models fail to capture variation in development time among individuals both within and between stages [@deValpine2009]. Stage structured models typically assume that time spent in a stage is geometrically distributed, an assumption that is not realistic for most organisms. Therefore, ecologists looking to incorporate more realism must look beyond simple matrix models [@deValpine2009]. Several authors have provided modifications to the matrix model to overcome such limitations [@Caswell2001] althogh not all have been widely adopted [@deValpine2009]. Integral projection models provide a way to incorporate such compexity [@Ellner2006; @Easterling2000a] (Need to include a fleshed out section describing the IPM generalization of the matrix model). 
 
These new methods and implementation techniques provide an easy-way to incorporate variable development into matrix models and revisit ecological theory. In particular, this new technique provides an opportunity to reexamine classic life history trade offs, such as the one between growth rate and survival, or fecundity and maturation rate, under more complex assumptions.  Here we reassess classic ecological trade offs between maturation (both adult and juvenile) and growth rate [@Takada1995]. 

In this paper, we investigate the how incorporating additional complexity in matrix population models, such as more realistic assumptions about time spent in a stage, and correlation between stages alters the optimum of ecological trade offs. We used the Lefkovitch matrix model to describe stage structured population models with reproduction and survival. To maintain a simple story, we also restrict our efforts to a two-stage model (juveniles and adults) in a density-independent case, although our analyses could easily be extended to larger number of classes. 
 We analyze the outcome with varying levels of compelxity, from the simple matrix case all the way to incorporating variation in development time within stages and correlation between stages. We then compare how the optimal trade off strategy shifts as a result of these new assumptions.


## Model Description

$\left[ \begin{matrix} J(t+1)\\ A(t+1) \end{matrix} \right] = \left[ \begin{matrix} (1-m) \mu J& F\\ m \mu J&\mu A \end{matrix} \right] \left[ \begin{matrix} J(t)\\ A(t) \end{matrix} \right]$

Where $\mu J(t)$ and $\mu A(t)$ represent juvenile and adult mortality, `m` is the maturation rate and $J(t)$ and $A(t)$ are the juveniles and adults.

## Perry's outline

# Individual heterogeneity in development changes life history optimization

Karthik Ram and Perry de Valpine

Environmental Science, Policy, & Management, University of California, Berkeley, Berkeley CA. USA.

karthik.ram@berkeley.edu

# Introduction


[Some of the text in your draft, especially the first paragraph, could fit well in this.]

Organisms inevitably face tradeoffs between processes such as growth, survival and reproduction.  Life history theory attempts to predict the outcome of natural selection on life history traits under different tradeoffs.  From its origins with very simple models, life history theory has been extended to consider increasingly realistic models.  These have included environmental stochasticity, individual behavior, density-dependence, and frequency-dependence, among other processes.  Some of these considerations can strongly change the optimal life history strategy, and the question remains what other factors are essential for obtaining realistic predictions of life history traits.

Individual heterogeneity in demographic traits can impact population growth rate, species interactions, and nonlinear population dynamics.   Population growth rate is equivalent to the fitness of a life history strategy under density-independence or if density-dependence impacts all individuals.  Therefore, if the effect of individual variation on population growth rate is different for different life history strategies, then individual variation could change the outcome of life history evolution.  [Here the issue of exactly what other people have shown about individual heterogeneity on life history evolution will be key to how to frame our argument.]  An additional but less explored question is how correlations among heterogeneous life history traits could impact life history evolution.

Here we show that individual stochasticity in development time, with realistic developmental delays, as well as correlations between development time and adult longevity, can have a major impact on optimization of development rate under tradeoffs with survival or reproduction.  Variation in development time is very common, yet is rarely modeled realistically.  Matrix models treat every individual as having a constant rate of maturing in each time step, and such models have been used to examine optimal maturation rate.  While such models can be derived as transition rates at the stable stage distribution resulting from a more realistic development process (Caswell), they are often taken literally as the starting point for considering population dynamics and evolution (Barfield et al.).  Taken literally, a matrix model with maturation rate m says there is a geometric distribution of the development time (time until maturation) with mean 1/m, which is not very realistic.   On the other hand, delay-differential equation models include a realistic developmental delay, but in their simplest form they omit any variation in development time.  Thus, common life history models of development rate are unrealistic for purposes of life history theory.

Several recent models have extended stage-structured matrix models to incorporate individual heterogeneity in development.  The method of [@deValpine2009] allows specification of a distribution for the time spent in each stage, and for these distributions to be correlated.  Time spent in the last stage corresponds to adult longevity.  In this framework, an exponential time in a stage corresponds (when time is discretized) to the geometric distribution of a matrix model.  At the other extreme, a development time distribution with very small variance corresponds to a delay-differential equation model.  Thus this framework allows a spectrum between matrix models and delay-differential equation models.  Other approaches include... [Mention a phrase each about Caswell, Birt, Vindenes, and the linear chain trick].

Using the stochastic development model of [@deValpine2009], we ask how different distributions of development time and correlations between development time and adult longevity impact life history evolution.  We take a simple optimization approach, and we consider tradeoffs between development rate and juvenile survival and between development rate and adult fecundity.





## Literature Cited
