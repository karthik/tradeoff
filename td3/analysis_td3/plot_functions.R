
theme_tradeoff <- function(ticks=TRUE) {
    ret <- theme_bw() +
        theme(panel.border = element_blank(),
              panel.background = element_rect(fill=NA, linetype=0),
              axis.line = element_line(size = 1, colour="black"),
              legend.background = element_rect(fill=NA, linetype=0),
              legend.key = element_rect(fill=NA, linetype=0),
              panel.grid = element_blank(),
              axis.text = element_text(family = 'Consolas', size = 12),
              axis.text.x = element_text(family = 'Consolas', size = 12),
              axis.text.y = element_text(family = 'Consolas', size = 12),
              plot.title = element_text(family = 'Proxima Nova', size=rel(1.2)),
              legend.key=element_rect(fill="white"),
              plot.background = element_rect(fill="white", linetype=0))
    if (!ticks) {
        ret <- ret + theme(axis.ticks = element_blank())
    }
    ret
}




df <- data.frame(m=1:100, d1=rpois(100, lambda=.5), d2 =rpois(100, lambda=.7), d3=rpois(100, lambda=.9))
df <- melt(df, id.vars=1)
ggplot(df, aes(m,value, group=variable, colour=variable)) + geom_line(size=1.4) + scale_color_manual(values=c("#1a68a0","#a1323a","#edb14a"))  + theme_tradeoff()


Color palette for visualization.
Blue: #1a68a0
Red: 
Black: #455860
Gold: 
