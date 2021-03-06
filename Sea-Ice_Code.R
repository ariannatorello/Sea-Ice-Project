# First, we need to import our data from the "Environment" window by navigating the following steps:

# Click "Import Dataset"
  # Click "From Text (readr)"
    # Then browse and find our dataset, "SeaIceMaster.csv"

# The above steps eliminate the need to open our .csv data through code in the command window.

# Next, we need to import these packages in order to execute the entirety of our analysis.
library(tidyr)
library(dplyr)
library(lubridate)
library(ggplot2)

# Now, we want to run a few preemptive lines of code to organize our data for use in our plots.
# We want to label our imported data set, "SeaIceMaster", as "df", so it is easier to work with during coding.
df <- SeaIceMaster 

# The following code creates an identity, "avg_area" which calculates the average area of sea ice.
avg_area <- mean(df$area)

# The code below takes the "year" and "month" columns from our data set and joins them into one date column.
df$date <- with(df, sprintf("%d-%02d", year, mo))

# Now, we want to make "month" a character value in the data frame using this code:
mymonths <- c("Jan","Feb","Mar",
              "Apr","May","Jun",
              "Jul","Aug","Sep",
              "Oct","Nov","Dec")
df$month <- mymonths[ df$mo ]

# Now, we can start to plot our figures!

# Figure I. Dot plot for Sea Ice Extent vs. Year with dot size representing area
ggplot(df, aes(x = year, y = extent, size = area, color = year)) +
  geom_point()

# The above code is sending instructions to ggplot to create a plot using data from "df" with the x axis values from "year", y axis values from "extent", the size of each dot to represent the magnitude from "area". and the color gradient of the dots to correlate to the "year".

# Now we want to create an identity, "Fig1", which will print the plot upon execution.
Fig1 <- ggplot(df, aes(x = year, y = extent, size = area, color = year)) +
  geom_point()

# Now, we can see that executing "Fig1" prints the plot of Figure 1.
Fig1


# Figure II. Line plot for Sea Ice Extent and Area vs. Year
ggplot(df)+
  geom_smooth(aes(x=year, y=extent))+
  geom_smooth(aes(x=year, y=area, color="red" ,fill="red"))+
  expand_limits(y=0)+
  theme_bw() +
  labs(x = "Year",y='Extent (blue) / Area (red) ('~km^2~x10^6*')')+
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "none"
  )

# The above code is sending instructions to ggplot to create a plot using data from "df" to portray both "extent" and "area" (x axis) vs. "year" (y axis). Using the function "geom_smooth" smooth creates this graph of ice area over the years, showing the overall trends.

# Now we want to create an identity, "Fig2", which will print the plot upon execution.
Fig2 <- ggplot(df)+
  geom_smooth(aes(x=year, y=extent))+
  geom_smooth(aes(x=year, y=area, color="red" ,fill="red"))+
  expand_limits(y=0)+
  theme_bw() +
  labs(x = "Year",y='Extent (blue) / Area (red) ('~km^2~x10^6*')')+
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "none"
  )

# Now, we can see that executing "Fig2" prints the plot of Figure 2.
Fig2


# Figure III. Line plot of Area vs. Months, with each year in the data represented by individual lines in a color gradient.
# First, we want to execute a line of a code which makes "year" a factor so they can be individual lines.
df$year <- as.factor(df$year)

# Now, we can create the plot itself. The code below is sending information to ggplot to create a line graph using data from "df" of "area" (x axis) vs. "months" (y axis), with each line representing a different year.
ggplot(df, aes(x=mo, y=area, color=year))+
  expand_limits(y=0)+
  coord_cartesian(xlim = c(1,12))+
  labs(x = "Month", y='Area ('~km^2~x10^6*')', color="Year")+
  theme_classic()+
  geom_line()

# Now we want to create an identity, "Fig3", which will print the plot upon execution.
Fig3 <- ggplot(df, aes(x=mo, y=area, color=year))+
  expand_limits(y=0)+
  coord_cartesian(xlim = c(1,12))+
  labs(x = "Month", y='Area ('~km^2~x10^6*')', color="Year")+
  theme_classic()+
  geom_line()

# Now, we can see that executing "Fig3" prints the plot of Figure 3.
Fig3


# Figure IV. Difference between average and actual values of sea ice area.
# This code sends information to ggplot to create a circle/snowflake graph using data from "df" showing difference between average and actual values of sea ice area.
ggplot(df)+
  geom_bar(aes(x=date, y=area-avg_area, fill = area-avg_area), stat = "identity")+
  scale_fill_gradientn(colours = colorRampPalette(brewer.pal(11, "RdBu"))(11))+
  theme_minimal() + 
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
  )+
  scale_y_discrete(name='Area ('~km^2~x10^6*')', limits=c(-7, 0, 5))+
  labs(title = "Area Difference of Arctic Sea Ice over time (1978-2019)", fill = 'Area ('~km^2~x10^6*')')+
  coord_polar(theta = "x")

# Now we want to create an identity, "Fig4", which will print the plot upon execution.
Fig4 <- ggplot(df)+
  geom_bar(aes(x=date, y=area-avg_area, fill = area-avg_area), stat = "identity")+
  scale_fill_gradientn(colours = colorRampPalette(brewer.pal(11, "RdBu"))(11))+
  theme_minimal() + 
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
  )+
  scale_y_discrete(name='Area ('~km^2~x10^6*')', limits=c(-7, 0, 5))+
  labs(title = "Area Difference of Arctic Sea Ice over time (1978-2019)", fill = 'Area ('~km^2~x10^6*')')+
  coord_polar(theta = "x")

# Now, we can see that executing "Fig4" prints the plot of Figure 4.
Fig4

# These plots are unique and fun ways to visual changes in Sea Ice extent and area over time. We hope you've enjoyed coding with us, and have learned a bit more about plotting in RStudio! Acknowledgments: Thanks to the National Snow and Ice Data Center for collecting the Sea Ice Index data, which we utilized in this program.
