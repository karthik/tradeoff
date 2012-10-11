
# Individual heterogeneity in development time alter the optimal expectation of classic life-history trade offs.

Karthik Ram and Perry de Valpine.

Environmental Science, Policy & Management.
University of California, Berkeley. Berkeley, CA 94720

karthik.ram@berkeley.edu

-------


## Introduction

Organisms are inevitably constrained by selection pressures from various sources resulting in tradeoffs between processes such as growth, survival and reproduction [@Grime1977]. Trade offs between such vital rates allow organisms, especially ones with complex life histories, to choose an optimal strategy that maximizes their reproductive fitness under a range of environmental conditions [@Houssard1991; @Stearns1989]. From its origins with very simple models, life history theory has been extended to consider increasingly realistic models.  These have included environmental stochasticity, individual behavior, density-dependence, and frequency-dependence, among other processes.  Some of these considerations can strongly change the optimal life history strategy, and the question remains what other factors are essential for obtaining realistic predictions of life history traits.

## 0. Importance of individual variation

Individual heterogeneity in demographic traits can impact population growth rate, species interactions, and nonlinear population dynamics [@Gonzalez-suarez2011; @Bolnick2003]. Population growth rate is equivalent to the fitness of a life history strategy under density-independence or if density-dependence impacts all individuals.  Therefore, if the effect of individual variation on population growth rate is different for different life history strategies, then individual variation could change the outcome of life history evolution.  [Here the issue of exactly what other people have shown about individual heterogeneity on life history evolution will be key to how to frame our argument].  An additional but less explored question is how correlations among heterogeneous life history traits could impact life history evolution.

Here we show that individual stochasticity in development time, with realistic developmental delays, as well as correlations between development time and adult longevity, can have a major impact on optimization of development rate under tradeoffs with survival or reproduction.  Variation in development time is very common, yet is rarely modeled realistically.  Matrix models treat every individual as having a constant rate of maturing in each time step, and such models have been used to examine optimal maturation rate.  While such models can be derived as transition rates at the stable stage distribution resulting from a more realistic development process [@Caswell2011], they are often taken literally as the starting point for considering population dynamics and evolution [@Barfield2011].  Taken literally, a matrix model with maturation rate m says there is a geometric distribution of the development time (time until maturation) with mean `1/m`, which is not very realistic. On the other hand, delay-differential equation models include a realistic developmental delay, but in their simplest form they omit any variation in development time.  Thus, common life history models of development rate are unrealistic for purposes of life history theory.

Although there are various methods to understand tradeoffs, mathematical models provide a particularly versatile and powerful way to examine the importance of vital rates, and how trade offs between rates alter the evolutionary trajectory of a species. Matrix population models, especially, have proved extremeley useful both in a theoretical and applied context [@Caswell2001]. These models can be applied to a variety of organisms such as plants and insects that transition through distinct development stages, but can also be applied to organisms that mature through distinct size classes, which can be treated abstractly as stages [@Caswell2009]. Matrix models have been provided numerous insights into conservation issues [@Morris2002, @Heppell1998] and evolutionary ecology [@Lande1982], the popularity driven primarily by its simplicity and ease of interpretation.  

Despite its popularity, matrix population models fail to incorporate an adequate level biological realism that characteize most populations in nature. For example, matrix models fail to capture variation in development time among individuals both within and between stages [@deValpine2009]. Stage structured models typically assume that time spent in a stage is geometrically distributed, an assumption that is not realistic for most organisms. Therefore, ecologists looking to incorporate more realism must look beyond simple matrix models [@deValpine2009]. Several authors have provided modifications to the matrix model to overcome such limitations [@Caswell2001] althogh not all have been widely adopted [@deValpine2009]. Integral projection models provide a way to incorporate such compexity [@Ellner2006; @Easterling2000b].
These new methods and implementation techniques provide an easy-way to incorporate variable development into matrix models and revisit ecological theory. In particular, this new technique provides an opportunity to reexamine classic life history trade offs, such as the one between growth rate and survival, or fecundity and maturation rate, under more complex assumptions.  Here we reassess classic ecological trade offs between maturation (both adult and juvenile) and growth rate [@Takada1995]. 

The matrix model approach has been the basis for evaluating tradeoffs in life history analysis [@Takada1992]  (although the caveat here is that the consider this in the context of evolution of perrrenial plants with density-dependent dynamics).

## 1. Trade off between juvenile growth and juvenile survival

Growth rate is an important vital rate since it is one of the few life history variables that has the strongest influence on fitness [@Hutchings2006]. Individuals with fast growth rates, also achieve largers sizes and are likely to produce more off-spring [@Roff2002]. Faster growing individuals may also have higher adult survival rates, since larger bodied individuals are better defended than smaller ones [@Hutchins1994].

## 2. Trade off between juvenile growth and fecundity



Since stage is a much better predictor for individual quality than age [@Knight2004], there is a need for a more general framework for incorporating individual heterogeneity in stage structured populations [@Barfield2011]. Several recent models have extended stage-structured matrix models to incorporate individual heterogeneity in development.  The method described in [@deValpine2009] allows specification of a distribution for the time spent in each stage, and for the possibility of these distributions to be correlated.  Time spent in the final stage corresponds to adult longevity.  In this framework, an exponential time in a stage corresponds (when time is discretized) to the geometric distribution of a matrix model.  At the other extreme, a development time distribution with very small variance corresponds to a delay-differential equation model.  Thus our approach allows us to consider the full spectrum between matrix models and delay-differential equation models. Several other approaches also exist along the same lines.   
There are several other similar approaches along these lines. One of those ways by which variable development time can be included in a model is by using the "linear chain trick" [@MacDonald1978] which provides a way to reformulate integro differential equations as ODEs wherein each stage is broken into a series of smaller stages connected by constant flow rates [@deValpine2009]. However, this approach is still not suitable enough to incorporate flexible assumptions [@deValpine2009]. [@Caswell2001] also presents two extensions to incorporate realistic development times, one for populations at stable stage distribution and another, a negative binomial stage model for when they more general mean and variance in development times. This approach was further extended by [@Birt2009], who propose a discretized version of phase-type models building upon the framework proposed by [@Caswell2001].


Despite the fact that we know that vital rates are stage depenedent, we have had a particular lack of a framework in which to incorpororate work with SS data and assess its implications for evolutionary questions.

Thus, the existing frameworks are a little too complex in terms of their implementation to be of use to evolutionary biologists [@Barfield2011]. The broad framework proposed by Barfield et al, extends earlier work and allows for incorporation of variation even in populations that have not reached SSD and can also project trajectories for specific stages or an entire population.

The need for better SS models has been echoed by many authors, such as [@Barfield2011].

[@Videnes2008] also studied the implications of variation in life history traits and finds their effect on population dynamics to be context dependent. 




[@Gonzalez-suarez2011] explore specific mechanisms that generate individual variation and then explore its impacts on realized individual life histories.

The consequences of individual variation on the outcome of life history trade offs are still poorly understood, due to the lack of appropirate models. 

A significant conclusion of previous attempts at incorporating individual variation in development time has been ...

[@Birt2009] "This paper describes some mathematical foundations
that enable matrix population models to accurately represent intrapopulation variability in the development rates of organisms."
""



## FINAL PARAGRAPH.

In this paper, we investigate how incorporating additional complexity into classic tradeoff analyses, such as more realistic assumptions about time spent in a stage, and correlation between stages, alters the optimum of life history tradeoffs. In particular, we use the stochastic development model of [@deValpine2009] to ask how different distributions of development time and correlations between development time and adult longevity impact life history evolution.  We take a simple optimization approach, and consider tradeoffs between development rate and juvenile survival and between development rate and adult fecundity. For the sake of simplicity, we restrict our efforts to a two-stage model (juveniles and adults) in a density-independent case, although our analyses could easily be extended to more complex scenarios. We analyze the outcome of models with varying levels of compelxity, from the simple matrix case all the way to incorporating variation in development time within stages to correlation between stages. We then compare how the optimal trade off strategy shifts as a result of these new assumptions.

----


# New Introduction sound bites

Life history tradeoffs have long been important in ecology. The prevailing idea has been that organisms cannot invest large amounts of energy in growth but also have sufficient energy left for survival. These trade offs have been considered in the classic sense. However, the assumptions used are often a little too simplistic with no conisderation of variation in development time despite the fact that the importance is acknowldged.

The importance of individual variation really took off with Bolnick et al. There are some papers, such as the one by Manuel-Rodriguez, that have considered the physiological tradeoff between growth and survival but these are not common. 

The second challenge has been that we don’t have the sophisticated statsitical techniques to do the complex stuff. Birt et al have one approach but it is a little too complex to implement. 


An important shortcoming of previous approaches to modeling tradeoffs is that they do not account for differences among individuals, despite the fact such differences have signficant efforts on vital rates [@Caswell2009].

The importance of tradeoffs among key life history traits and its effects on the evolution of organisms has long been an important area of research in ecology and evolution. 


In this paper, we demonstrate how incorporating some of these previously acknowledged important criteria such as variation in development and the fact that these traits might be correlated between stages, alters the optimal value of a trade off. We consider two classic life history trade offs, the trade off between juvenile growth and survival and one between juveline growth and fecunity. Using a novel method, we compare the outcome of these trade offs under several different assumptions from the simple matrix case all the way to ones that incorporate variation in development time with additional correlation among stages.

High quality theory on evolution are the ones that do explicitly take into account this type of individial variability (Lande 1982). 

Although stage structured models have been a huge improvement towards explaining the dynamics of organisms that pass through distinct life stages, it still does not discount the idea that within each stage, there might be a mix of individuals of different ages. 

Thus, examining trade offs without incorporating individual variability can bias/misrepresent the outcome of the trade off. With this motivating factor, and taking advantange of the fact that we now have the tools and technology to incorporate.

Until now, complexities surrounding the implementation of individual variability in trade offs have prevented a more realistic exploration. Although other ways have been proposed [@Birt], they remain mathematically too complex to be of any use to the averge ecologist.

Using a general set of tools, we approach this problem...

Matrix models have long been popular in ecology because of their structural simplicity and ease of interpretation [@Eastering2000]. Model that contain too classes, may end up sacrificing biological realism due to the variation in organisms within a particular stage class.


This paper illustrates how analysis of well-known classic life history tradeoffs with additional complexity can provide more realistic optimums for various trade offs. and accurate results compared to a matrix model approach with unrealistic assumptions.

Adding such an additional level of complexity may alter the nature of the trade-off entirely by shifting the optimum.



It is critical to understand the shape of the trade off curve and the optimum because it is the only way to understand the consequences of life history variation [@Calvo1990]. 


Ecologists have long sought to understand how various environmental factors favor different life histories and influence life history evolution.

Note: vital rate = survival, growth, and reproduction.

The mathematical framework described by [@Birt2009] is a litle too complicated for it to be tractable by most scientists. Their technique, to generalise a modeling framework to incorporate different distributions for development time. However, the complexity of the model makes it rather difficult to be useful or tractable to all but a few highly specialized mathematicians. 

Previous efforts to understand lifehistory tradeoffs between key vital rates have ignored the importance of individual variability. For example, [@Takada1995]

In any tradeoff analysis, the shape of the curve is critical in determining which life history strategy would be favored [@Schaffer1975]. Therefore, models incorporating realistic distributions of time spent will help determine the right strategy.

## Literature Cited
