
# Realistic stage-structured models alter the outcome of classic ecological life history trade offs.

Karthik Ram and Perry de Valpine.

Environmental Science, Policy & Management.
University of California, Berkeley. Berkeley, CA 94720

-------
__Introduction__

Analysis of life histories provide useful information about the evolutionary trajectory of an organism. Theoretical analysis also provides a way to predict the population trajectory of a species. Life history analysis have long been used to understand variation in vital rates of organisms, both within, and between species and to understand the role of environmental influence on such traits. More context of why analyzing life history trade offs is important in the context of ecology, evolution, and conservation biology but also as a purely theoretical exercise.  

Mathematical models provide a useful, flexible, and powerful way to understand the importance of vital rates, and how trade offs between rates alter the evolutionary trajectory of a species. Matrix population models, in particular, have proved extremeley useful both in a theoretical and applied context. This is really useful for most organisms, especially insects, that tend to mature through distinct stages. The same class of models can also be applied to organisms that mature through distinct size classes, which can be treated abstractly as stages.[@Caswell2009]

Matrix models have been used in a variety of contexts for half a century [@Caswell2001].  Matrix population models are however quite simplistic and do not accurately capture the complexity of variation that exists. One of the bigger flaws is that there is a single flow rate, and variation wihtin. While computational challenges in the past have strifled more nuanced analyses, we are now at a point where these are quite tractable. [@Fred from TAMU], for example describe a way to do this with phase structured models. Here, we use a powerful R package, called `varDev` [@deValpine2009], to reassess classic ecological trade offs between maturation (both adult and juvenile) and growth rate. For the sake of simplicty, we stick to linear tradeoffs and only work with a density independent case. We re-examine all trad offs starting with a simple matrix model with a single flow rate, and then increase the complexity to the level of incorporating variation within stages (either a single stage or multiple stages), followed by correlation among stages. To maintain a simple story, we also restrict our efforts to a two-stage model (juveniles and adults), although our analyses could easily be exteded to larger number of classes. 

In this paper, we revisit classic life history trade offs and analyze the outcome with varying levels of compelxity, from the simple matrix case all the way to incorporating variation in development time within stages and correlation between stages.[@Takada1995]

$m = C - T$

# Literature Cited
