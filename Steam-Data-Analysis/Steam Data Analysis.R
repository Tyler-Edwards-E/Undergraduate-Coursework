
# Tyler Edwards
# 5 - 2 - 2020
# Steam Data Analysis Project

steam = read.csv("steam.csv")

# Initial analysis of data to check if it's clean, etc.

steam$name[duplicated(steam$name) == TRUE]
steam$name[duplicated(steam$appid) == TRUE]
# Some games have the same name but they have different appIDs since they're from
#     different developers / publishers

str(steam)
# Datatypes look good

# Changing developer to all lowers because I found some cases where it affect later analysis
steam$developer = tolower(steam$developer)

summary(steam)
# Some interesting base info.

# Creating new columns
steam$total_ratings = steam$positive_ratings + steam$negative_ratings
summary(steam$total_ratings)
qqnorm(steam$total_ratings)
# Distribution is not normal

steam$percent_pos_ratings = steam$positive_ratings / steam$total_ratings
summary(steam$percent_pos_ratings)
qqnorm(steam$percent_pos_ratings)
# Distribution is normal

# Visuals of the distributions
hist(steam$percent_pos_ratings, col="gray", labels = TRUE,
     xlab = "% Positive Ratings", main = "% Positive Reviews for Steam Games")
# Left skewed distributon
# It's difficult for most games to have more negative reviews than positive
# It's also difficult for games to have entirely positive reviews which is apparent with the large dropoff at 1.0

hist(steam$total_ratings, col="gray", labels = TRUE,
     xlab = "Total Ratings", main = "Total Ratings on Steam Games")
# The distribution is difficult to graph because some games have millions of reviews

hist(steam$total_ratings[steam$total_ratings < 30000], col="gray", labels = TRUE,
     xlab = "Total Ratings", main = "Total Ratings on Steam Games")
# Even with a lower maximum value the distribution is still left skewed
# This is becaues some games are just extremely popular and get more reviews than unpopular games



# ---------------------------------------------------------
# -------------------------- ANOVA ------------------------
# ---------------------------------------------------------

# Can't run because list is too large
# aov(percent_pos_ratings ~ developer, data = steam)


# Count of ratings all devs have on all of their games
dev.total.rats = aggregate(steam$total_ratings, by = list(steam$developer), FUN = sum)
colnames(dev.total.rats) = c("developer", "total_rating")
str(dev.total.rats)
summary(dev.total.rats$total_rating)

# Dropping developers who have less total ratings than the mean(not popular at all)
dev.total.rats.trim = dev.total.rats[dev.total.rats$total_rating >= mean(dev.total.rats$total_rating, na.rm = TRUE),]
# 17018 Rows down to 1373

# Dropping games from the main dataset who don't have developers in the list above
steam.trim = steam[steam$developer %in% dev.total.rats.trim$developer,]

# Dropping games with less than 50 ratings
steam.trim = steam.trim[steam.trim$total_ratings >= 50,]

# One-Way Anova
steam.aov1 = aov(percent_pos_ratings ~ developer, data = steam.trim)
anova(steam.aov1)
# Significant difference between the means of the rating percentages for each developer
# "Not all developers get equally positive reviews"

# Pairwise Comparison
# steam.tk1 = TukeyHSD(steam.aov1)
# steam.tk1.results = as.data.frame(steam.tk1[1:1])


# Visuals of the distributions of trimmed dataset
hist(steam.trim$percent_pos_ratings, col="gray", labels = TRUE,
     xlab = "Average % Positive Ratings", main = "Avg. % Positive Reviews for Steam Games (Trimmed)")
# Left skewed distributon
# It's difficult for most games to have more negative reviews than positive
# It's also difficult for games to have entirely positive reviews which is apparent with the large dropoff at 1.0

hist(steam.trim$total_ratings, col="gray", labels = TRUE,
     xlab = "Total Ratings", main = "Total Ratings on Steam Games (Trimmed)")
# The distribution is difficult to graph because some games have millions of reviews

hist(steam.trim$total_ratings[steam.trim$total_ratings < 30000], col="gray", labels = TRUE,
     xlab = "Total Ratings", main = "Total Ratings on Steam Games (Trimmed)")
# Even with a lower maximum value the distribution is still left skewed
# This is becaues some games are just extremely popular and get more reviews than unpopular games

# This takes too much computing power and the results aren't too meaningful
#     because there are a lot of random developers on Steam, so comparing
#     each and everyone of them to each other doesn't create meaningful results.




# Putting sum ratings dataframe in descending order by total ratings
dev.total.rats.trim = dev.total.rats.trim[order(-dev.total.rats.trim$total_rating),]

# Creating dataframe with developers with the top 250 highest number of ratings (popular devs)
steam250 = steam[steam$developer %in% dev.total.rats.trim$developer[1:250],]
# Cleaning out games with ratings less than 50 again
steam250.trim = steam250[steam250$total_ratings >= 50,]

# Another One-Way Anove with the trimmed data
steam.aov2 = aov(percent_pos_ratings ~ developer, data = steam250.trim)
anova(steam.aov2)
# Different developrs are still significantly different from each other amongst popular developers






# Creating list of games per dev
steam250.dev.games = as.data.frame(table(steam250.trim$developer))
sum(steam250.dev.games$Freq)
# 974 is hte number of popular games the developers in this list have

# Creating list of total reviews per dev
steam250.dev.total.ratings = aggregate(steam250.trim$total_ratings, by = list(steam250.trim$developer), FUN = sum)

# Final dataframe with the top 250 developers their average positive review percentage and their number of games
steam250.avg.percent = aggregate(steam250.trim$percent_pos_ratings, by = list(steam250.trim$developer), FUN = mean)
steam250.avg.percent$total_ratings = steam250.dev.total.ratings$x
steam250.avg.percent$games = steam250.dev.games$Freq
colnames(steam250.avg.percent) = c("developer", "avg_pos_rating_percent", "total_ratings", "games")

t.test(steam250.avg.percent$avg_pos_rating_percent)
# 95% CI: [.80, .83]

# Graphs visualizing distributions
hist(steam250.avg.percent$avg_pos_rating_percent, col="gray", labels = TRUE,
     xlab = "Average % Positive Ratings", main = "Average % Positive Ratings on Steam Games")
hist(steam250.avg.percent$games, col="gray", labels = TRUE,
     xlab = "Games", main = "# of Games Popular Developers Have on Steam")
# Distributions are similar to the one of the full dataset

# Showing the best in worst in this group
head(steam250.avg.percent[order(-steam250.avg.percent$avg_pos_rating_percent),])
tail(steam250.avg.percent[order(-steam250.avg.percent$avg_pos_rating_percent),])


# Valve has the most total ratings on the games, and also the game with the most
#     reviews on Steam, Counter Strike: Global Offensive, with 3,000,000 reviews
# PUBG has the 3rd highest totl ratings but the 7th lowest rating



# --------------------------------------------------------------
# -------------------------- REGRESSION ------------------------
# --------------------------------------------------------------

# Analyzing the relationship between variables

# % Positive ratings and price
cor(steam$percent_pos_ratings, steam$price)
# Low correlation

plot(steam$percent_pos_ratings, steam$price, ylab = "Price ($)", xlab = "% Positive Ratings",
                  main = "% Positive Ratings & Price")
pos_ratings.price.mod = lm(steam$percent_pos_ratings ~ steam$price)
summary(pos_ratings.price.mod)
# Price is very significant but a bad predictors

# Positive ratings and average playtime
cor(steam$percent_pos_ratings, steam$average_playtime)
# Low correlation

plot(steam$percent_pos_ratings, steam$average_playtime, ylab = "Average Playtime", xlab = "% Positive Ratings",
     main = "% Positive Ratings & Average Playtime")
pos_ratings.avgPlay.mod = lm(steam$percent_pos_ratings ~ steam$average_playtime)
summary(pos_ratings.avgPlay.mod)
# Very significant but a bad predictors

# % Positive ratings and achievements
cor(steam$percent_pos_ratings, steam$achievements)
# Low negativecorrelation
plot(steam$percent_pos_ratings, steam$achievements, ylab = "Achievements", xlab = "% Positive Ratings",
     main = "% Positive Ratings & Achievements")
pos_ratings.achiev.mod = lm(steam$percent_pos_ratings ~ steam$achievements)
summary(pos_ratings.achiev.mod)
# Very significant but a bad predictors


pos.ratings.full.mod = lm(steam$percent_pos_ratings ~ steam$price + steam$average_playtime +
                    steam$achievements)
summary(pos.ratings.full.mod)
# Factors are significant, but are bad predictors



# Regression with 250 list
cor(steam250.avg.percent$avg_pos_rating_percent, steam250.avg.percent$total_ratings)
# low correlation
steam250.mod = lm(steam250.avg.percent$avg_pos_rating_percent ~ steam250.avg.percent$total_ratings)
summary(steam250.mod)
# Total ratings is not a significant factors

plot(steam250.avg.percent$avg_pos_rating_percent, steam250.avg.percent$total_ratings)
plot(steam250.trim$percent_pos_ratings, steam250.trim$average_playtime)

# Dropping extremly high values
plot(steam250.avg.percent$avg_pos_rating_percent[steam250.avg.percent$total_ratings < 100000], 
     steam250.avg.percent$total_ratings[steam250.avg.percent$total_ratings < 100000])




