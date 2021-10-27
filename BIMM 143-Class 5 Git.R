# Week 4 Data visualization Lab

# Section 5: Install the package ggplot2
# install.packages("ggplot2")

# Anytime I want to use this 
# package I need to load it
library(ggplot2)

# A quick base R plot - this is not a ggplot
plot(cars)

# Our first ggplot
# We need data + aes + geoms
p <- ggplot(data=cars) +
  aes(x=speed, y=dist) +
  geom_point()

# Finish this plot
p +
  labs(title="Speed and Stopping Distances of Cars",
       x = "Speed (MPH)",
       y = "Stopping Distance (ft)",
       subtitle = "by BIMM 143 Class 5 Mi Tran",
       caption = "Dataset: 'cars'") +
  geom_smooth(method="lm", se=FALSE) +
  theme_bw()

# Section 5 (Cont): Read in our drug expression data
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)
View(genes)

# How many genes are there in this dataset?
nrow(genes)

# How many columns are there?
ncol(genes)

# What are the names of the columns?
colnames(genes, do.NULL=TRUE, prefix="col")

# How many 'up' regulated genes are there?
table(genes$State)

# What fraction of total genes is up-regulated?
prec <- table(genes$State)/nrow(genes)*100
round(prec, 2)

# First plot attempt with Condition 1, Condition 2
ggplot(data=genes) +
  aes(x=Condition1, y=Condition2) +
  geom_point()

# Second plot attempt with State as column
a <- ggplot(data=genes) +
  aes(x=Condition1, y=Condition2, col=State) +
  geom_point()

# Change up the colors
a + scale_color_manual(values=c("blue","gray","red"))

# Add some plot annotations 
a + scale_color_manual(values=c("blue","gray","red")) +
  labs(title="Gene Expresion Changes Upon Drug Treatment",
       x="Control (no drug)",
       y="Drug Treatment")

# Section 9: Combining Plots 
# install.packages("patchwork)
library(patchwork)

# Setup some example plots 
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# Use patchwork to combine them here:
(p1 | p2 | p3) / p4
