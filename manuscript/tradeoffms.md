
# Individual heterogeneity in development time alter the optimal expectation of classic life-history trade offs.

Karthik Ram and Perry de Valpine.

Environmental Science, Policy & Management.
University of California, Berkeley. Berkeley, CA 94720

karthik.ram@berkeley.edu

-------


## Introduction

Species are inevitably constrained by selection pressures from various sources resulting in tradeoffs between processes such as growth, survival and reproduction [@Grime1977]. Trade offs between such vital rates allow organisms, especially ones with complex life histories, to choose an optimal strategy that maximizes their reproductive fitness under a range of environmental conditions [@Houssard1991; @Stearns1989]. From its origins with very simple models, life history theory has been extended to consider increasingly realistic models.  These have included environmental stochasticity, individual behavior, density-dependence, and frequency-dependence, among other processes.  Some of these considerations can strongly change the optimal life history strategy, and the question remains as to what other factors are essential for obtaining realistic predictions of life history traits [@Calvo1990]. 

Individual heterogeneity in demographic traits can impact population growth rate, extinction risk [@FOX2006], species interactions, and nonlinear population dynamics [@Gonzalez-suarez2011; @Bolnick2003]. Population growth rate is equivalent to the fitness of a life history strategy under density-independence or if density-dependence impacts all individuals.  Therefore, if the effect of individual variation on population growth rate is different for different life history strategies, then individual variation could alter the outcome of life history evolution.

{section on individual heterogeneity currently in progress} 

[@Videnes2008a] also studied the implications of variation in life history traits and finds their effect on population dynamics to be highly context dependent. A significant conclusion of previous attempts at incorporating individual variation in development time has been ...


An additional but less explored question is how correlations among heterogeneous life history traits could impact life history evolution. Here we show that individual stochasticity in development time, with realistic developmental delays, as well as correlations between development time and adult longevity, can have a major impact on optimization of development rate under tradeoffs with survival or reproduction.  Variation in development time is very common, yet is rarely modeled realistically. Despite its popularity, matrix population models fail to incorporate an adequate level biological realism that characteize most populations in nature.  Matrix models treat every individual as having a constant rate of maturing in each time step, and such models have been used to examine optimal maturation rate.  While such models can be derived as transition rates at the stable stage distribution resulting from a more realistic development process [@Caswell2011], they are often taken literally as the starting point for considering population dynamics and evolution [@Barfield2011].  Taken literally, a matrix model with maturation rate m says there is a geometric distribution of the development time (time until maturation) with mean `1/m`, which is not very realistic. On the other hand, delay-differential equation models include a realistic developmental delay, but in their simplest form they omit any variation in development time.  Thus, common life history models of development rate are unrealistic for purposes of life history theory.

The matrix model approach has been the basis for evaluating tradeoffs in life history analysis [@Takada1992]  (although the caveat here is that the consider this in the context of evolution of perrrenial plants with density-dependent dynamics).

## 1. Trade off between juvenile growth and juvenile survival

Growth rate is an important vital rate since it is one of the few life history variables that has the strongest influence on fitness [@Hutchings2006]. Individuals with fast growth rates, also achieve largers sizes and are likely to produce more off-spring [@Roff2002]. Faster growing individuals may also have higher adult survival rates, since larger bodied individuals are better defended than smaller ones [@Hutchins1994]. Previous efforts to understand lifehistory tradeoffs between key vital rates have ignored the importance of individual variability. [Incomplete section]


## 2. Trade off between juvenile growth and fecundity
[Incomplete section]

Since stage is a much better predictor for individual quality than age [@Knight2004], there is a need for a more general framework for incorporating individual heterogeneity in stage structured populations [@Barfield2011]. Several recent models have extended stage-structured matrix models to incorporate individual heterogeneity in development.  The method described in [@deValpine2009] allows specification of a distribution for the time spent in each stage, and for the possibility of these distributions to be correlated.  Time spent in the final stage corresponds to adult longevity.  In this framework, an exponential time in a stage corresponds (when time is discretized) to the geometric distribution of a matrix model.  At the other extreme, a development time distribution with very small variance corresponds to a delay-differential equation model.  Thus our approach allows us to consider the full spectrum between matrix models and delay-differential equation models. Several other approaches also exist along the same lines.   
There are several other similar approaches along these lines. One of those ways by which variable development time can be included in a model is by using the "linear chain trick" [@MacDonald1978] which provides a way to reformulate integro differential equations as ODEs wherein each stage is broken into a series of smaller stages connected by constant flow rates [@deValpine2009]. However, this approach is still not suitable enough to incorporate flexible assumptions [@deValpine2009]. [@Caswell2001] also presents two extensions to incorporate realistic development times, one for populations at stable stage distribution and another, a negative binomial stage model for when they more general mean and variance in development times. This approach was further extended by [@Birt2009], who propose a discretized version of phase-type models building upon the framework proposed by [@Caswell2001]. The mathematical framework described by [@Birt2009] is a litle too complicated for it to be tractable by most biologists. Their technique, to generalise a modeling framework to incorporate different distributions for development time. However, the complexity of the model makes it rather difficult to be useful or tractable to all but a few highly specialized mathematicians.These new methods and implementation techniques provide an easy-way to incorporate variable development into matrix models and revisit ecological theory. 

In this paper, we investigate how incorporating additional complexity into classic tradeoff analyses, such as more realistic assumptions about time spent in a stage, and correlation between stages, alters the optimum of life history tradeoffs. In any tradeoff analysis, the shape of the curve is critical in determining which life history strategy would be favored [@Schaffer1975]. Therefore, models incorporating realistic distributions of time spent will help determine the right strategy. Here, we use the stochastic development model of [@deValpine2009] to ask how different distributions of development time and correlations between development time and adult longevity impact life history evolution. We take a simple optimization approach, and consider tradeoffs between development rate and juvenile survival and between development rate and adult fecundity. For the sake of simplicity, we restrict our efforts to a two-stage model (juveniles and adults) in a density-independent case, although our analyses could easily be extended to more complex scenarios. We analyze the outcome of models with varying levels of compelxity, from the simple matrix case all the way to incorporating variation in development time within stages to correlation between stages. We then compare how the optimal trade off strategy shifts as a result of these new assumptions.



## Literature Cited
