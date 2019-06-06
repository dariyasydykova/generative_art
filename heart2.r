# load packages needed to run this code
library(ggplot2)
library(dplyr)
library(tidyr)
library(cowplot)
library(gganimate)

# code used from this page on stackoverflow:
# https://stackoverflow.com/questions/8082429/plot-a-heart-in-r
# I cleaned it up

# generate coordinates for a heart
df <- data.frame(t = seq(0, 2 * pi, by = 0.01))

heart1 <-
  df %>%
  mutate(
    x = 16 * sin(t)^3,
    y = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t),
  )

heart2 <-
  df %>%
  mutate(
    x = 16 * sin(t)^3,
    y = (13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t)) + 25,
  )

heart3 <-
  df %>%
  mutate(
    x = 16 * sin(t)^3,
    y = (13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t)) + 50,
  )


p_heart <-
  ggplot() +
  geom_polygon(data = heart1, aes(x = x, y = y), fill = "#90007f") +
  geom_polygon(data = heart2, aes(x = x, y = y), fill = "#d52484") +
  geom_polygon(data = heart3, aes(x = x, y = y), fill = "#f185b3") +
  annotate("text", label = "I love you", x = 0, y = 60, color = "white", size = 12) +
  theme_void() +
  scale_y_continuous(limits = c(-15, 80)) +
  scale_x_continuous(limits = c(-18, 18)) +
  transition_reveal(y)

# animate
animate(p_heart, 
        device = "png",
        width = 400, 
        height = 800)

# save as gif
anim_save("heart2.gif")


  
