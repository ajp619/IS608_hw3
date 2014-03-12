library(googleVis)
library(plyr)


# Load data
mortality.data <- read.csv("../../Data/cleaned-cdc-mortality-1999-2010.csv")

# Drop the following columns:
# No information in Notes, the rest are redundant
drop <- c("X", "ICD.Chapter.Code", "State.Code", "Year.Code", "Notes")
mortality.data <- mortality.data[,!(names(mortality.data) %in% drop)]


# Need to create National Average Information
national.avg <- ddply(mortality.data, c("Year", "ICD.Chapter"), summarize,
                      Deaths = sum(Deaths),
                      Population = sum(Population))
# The national population should be the max calculated pop for each year.
# ***It seems to me that the correct weighting to use here is debateable.
# ***I chose this insead of just doing a weighted sum because of the note at the
# ***end of the raw data file saying that because of confidentiality, deaths under
# ***10 were not reported. But this could be understating the results if the values
# ***are really NA and possible significant.
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


# Create some variables here to populate the controls
disease.types <- levels(mortality.data$ICD.Chapter)
states <- levels(mortality.data$State)