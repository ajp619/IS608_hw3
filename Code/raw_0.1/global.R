library(googleVis)


# Create some variables here to populate the controls
mortality.data <- read.csv("../../Data/cleaned-cdc-mortality-1999-2010.csv")
disease.types <- levels(mortality.data$ICD.Chapter)

# Drop the following columns:
# No information in Notes, the rest are redundant
drop <- c("X", "ICD.Chapter.Code", "State.Code", "Year.Code", "Notes")
mortality.data <- mortality.data[,!(names(mortality.data) %in% drop)]


# Need to create National Average Information
national.avg <- ddply(mortality.data, c("Year", "ICD.Chapter"), summarize,
                      Deaths = sum(Deaths),
                      Population = sum(Population))
# The national population should be the max calculated pop for each year.
# This assumes I'm getting at least one condition each year that includes all States.
# (Seems like a safe assumption)
# Use this number for the national population for each year for each condition
for (y in unique(national.avg$Year)){
  max.pop <- max(national.avg$Population[national.avg$Year == y])
  national.avg$Population[national.avg$Year == y] <- max.pop
}
# Now need to add in data to match columns of original data frame
# State will be "National Average" and Crude.Rate will be calculated:
#     Crude.Rate = Deaths / Population * 100000
national.avg$State = "National Average"
national.avg$Crude.Rate <- national.avg$Deaths / national.avg$Population * 1e5
# Now add this back into the original data set
mortality.data <- rbind(mortality.data, national.avg)