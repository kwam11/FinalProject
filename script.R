#RUN CODE FOR DATA ANALYSIS
penguindata <- read.csv(url("https://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter17/chap17q24PenguinTreadmill.csv"))
head(penguindata)
meanslope <- tapply(penguindata$slope, penguindata$group, mean)
sdevslope <- tapply(penguindata$slope, penguindata$group, sd)
n <- tapply(penguindata$slope, penguindata$group, length)
data.frame(mean = meanslope, std.dev = sdevslope, n = n)
write.csv(penguindata, file = ".../data/penguindata.csv")

#Create &Save Strip Chart
pdf(file = "results/plot.pdf")
stripchart(slope ~ group, 
           data = penguindata, 
           main = "Metabolic Rate Proxy of Penguins by Group",
           xlab = "Group",
           ylab = "Metabolic Rate Proxy (slope)",
           col = "brown3",
           group.names = c("Breeding Females", "Breeding Males", "Molting Females"),
           vertical = TRUE,
           pch = 16)
dev.off()

#Run One-Way ANOVA & Save Results
penguinAnova <- lm(slope ~ group, data = penguindata)
anova(penguinAnova)
cat("Results", out, file="results/summary.txt", sep="\n", append=FALSE)
