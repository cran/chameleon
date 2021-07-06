## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse=TRUE, comment="#>")

## -----------------------------------------------------------------------------
library(chameleon)
seatbelts <- matrix(as.numeric(Seatbelts), nrow=nrow(Seatbelts), ncol=ncol(Seatbelts))
colnames(seatbelts) <- colnames(Seatbelts)
dim(seatbelts)
head(seatbelts, 4)

## ---- fig.show='hold'---------------------------------------------------------
colors <- data_colors(seatbelts)

library(umap)
layout <- umap(seatbelts, min_dist=0.99, random_state=123456)$layout

plot(layout, asp=1, col=colors, pch=19, cex=1)

## -----------------------------------------------------------------------------
years <- floor(time(Seatbelts))
unique(years)

## ---- fig.show='hold'---------------------------------------------------------
year_colors <- data_colors(seatbelts, group=years)

plot(layout, asp=1, col=year_colors[as.character(years)], pch=19, cex=1)
legend('bottomleft', legend=names(year_colors), col=year_colors, lty=1, lwd=3, cex=0.75)

## -----------------------------------------------------------------------------
data(pbmc)

## -----------------------------------------------------------------------------
fractions <- pbmc$umis / rowSums(pbmc$umis)
log_fractions <- log2(fractions + 1e-5)
type_colors <- data_colors(log_fractions, group=pbmc$types)

## ---- fig.show='hold'---------------------------------------------------------
library(ggplot2)
frame <- as.data.frame(pbmc$umap)
frame$type <- pbmc$types
ggplot(frame, aes(x=xs, y=ys, color=type)) +
    geom_point(size=0.75) +
    scale_color_manual(values=type_colors) +
    theme_light() +
    guides(color=guide_legend(override.aes=list(size=3))) +
    theme(legend.text=element_text(size=12), legend.key.height=unit(14, 'pt'))

## -----------------------------------------------------------------------------
distinct_colors(8)

## ---- fig.show='hold'---------------------------------------------------------
ggplot(frame, aes(x=xs, y=ys, color=type)) +
    geom_point(size=0.75) +
    scale_color_chameleon() +
    theme_light() +
    guides(color=guide_legend(override.aes=list(size=3))) +
    theme(legend.text=element_text(size=12), legend.key.height=unit(14, 'pt'))

## ---- fig.show='hold'---------------------------------------------------------
ggplot(frame, aes(x=xs, y=ys, fill=type)) +
    geom_point(shape=21, size=2, stroke=0.2, color="black") +
    scale_fill_chameleon() +
    theme_light() +
    theme(legend.text=element_text(size=12), legend.key.height=unit(14, 'pt'))

